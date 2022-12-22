#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Metadata.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include <list>
#include <map>
using namespace llvm;

#define DEBUG_TYPE "cfg_verification"

namespace {
struct CFGVerification : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  CFGVerification() : ModulePass(ID) { }

  private:
    /**
     * TODO This function supports only one annotation for each function, multiple annotations are discarded, perhaps I can fix this lol
     * @param Md The module where to look for the annotations
     * @param FuncAnnotations A map of Function and StringRef where to put the annotations for each Function
     */
    void getFuncAnnotations(Module &Md, std::map<Function*, StringRef> &FuncAnnotations) {
      if(GlobalVariable* GA = Md.getGlobalVariable("llvm.global.annotations")) {
        // the first operand holds the metadata
        for (Value *AOp : GA->operands()) {
          // all metadata are stored in an array of struct of metadata
          if (ConstantArray *CA = dyn_cast<ConstantArray>(AOp)) {
            // so iterate over the operands
            for (Value *CAOp : CA->operands()) {
              // get the struct, which holds a pointer to the annotated function
              // as first field, and the annotation as second field
              if (ConstantStruct *CS = dyn_cast<ConstantStruct>(CAOp)) {
                if (CS->getNumOperands() >= 2) {
                  Function* AnnotatedFunction = cast<Function>(CS->getOperand(0)/*->getOperand(0)*/);
                  // the second field is a pointer to a global constant Array that holds the string
                  if (GlobalVariable *GAnn =
                          dyn_cast<GlobalVariable>(CS->getOperand(1)/*->getOperand(0)*/)) {
                    if (ConstantDataArray *A =
                            dyn_cast<ConstantDataArray>(GAnn->getOperand(0))) {
                      // we have the annotation!
                      StringRef AS = A->getAsString();
                      errs() << "Annotation found: " << AS << "\n";
                      FuncAnnotations.insert(std::pair<Function*, StringRef>(AnnotatedFunction, AS));                      // if the function is new, add it to the annotated functions
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    /**
     * Navigates the module's (not declared for linker and not externally linked) functions,
     * for each one of them find the uniquely defined entry point. The compilation aborts if
     * a function with multiple entry points is found.
     * @param Md The module to navigate
     * @param Res Map of functions and their entry point functions
     */
     void getFunctionsEntryPts(Module &Md, std::map<Function*, Function*> &Res) {
      for (Function &Fn : Md) {
        if (!Fn.isDeclarationForLinker() && !Fn.hasExternalLinkage() && !Fn.hasNUses(0)) {
          Function *Entry = getEntryPt(Fn, Md, std::set<Function*>());
          if (Entry) {
            Res.insert(std::pair<Function*, Function*>(&Fn, Entry));
          }
          else {
            errs() << "FATAL: No entry pt. found for " << Fn.getName() << "(). Aborting compilation...\n";
            exit(1);
          }
        }
      }
    }

    /**
     * Recursive Depth-First Search of the first entry point between the callers
     * of function Fn in module Md.
     * @param Fn The function from which to start searching
     * @param Md The module in which to search
     * @param Visited The list of functions already visited (to avoid loops)
     * @return The first entry point found for the
     */
    Function* getEntryPt(Function &Fn, Module &Md, std::set<Function*> Visited) {
      // iterate over all the function's users, find the ones that have no users
      for (User *U : Fn.users()) {
        // if the user is an instruction (i.e. the function is called by some instruction U) get the caller function
        if (isa<Instruction>(U)) {
          Function *Caller = cast<Instruction>(U)->getParent()->getParent();
          if (Caller->hasNUses(0)) { // the caller is an entry point
            return Caller;
          }
          if (Visited.find(Caller) ==
              Visited.end()) { // the caller has not been visited -> recursively find EntryPt in Caller
            Visited.insert(&Fn);
            return getEntryPt(*Caller, Md, Visited);
          }
        }
      }
      return NULL;
    }

    /**
     * Navigates the module's (not declared for linker and not externally linked) functions.
     * For each such function, split all the basic blocks calling it before the
     * call instruction.
     * @param Md The module for which to perform the split.
     * @param BBCalls Map of basic blocks, one entry for every split BasicBlock.
     * Each entry is a pair [ParentBB, ChildBB] in which ParentBB is the
     * BasicBlock before the call, ChildBB is the first BasicBlock of the called
     * function.
     */
    void splitBBsAtCalls(Module &Md, std::map<BasicBlock*, BasicBlock*> &BBCalls) {
      for (Function &Fn : Md) {
        // we target only functions defined in the module (i.e. not the ones that
        // have to be linked because they are not in the scope of this compilation
        // instance), also external functions with external linkage are not considered
        if (!Fn.isDeclarationForLinker() && !Fn.hasExternalLinkage() && !Fn.hasNUses(0)) {
          for (User *U : Fn.users()) {
            if (isa<Instruction>(U)) {
              Instruction *Caller = cast<Instruction>(U);
              Instruction *SplitInstr = Caller->getNextNonDebugInstruction();
              BasicBlock *ParentBB =
                  Caller->getParent()->splitBasicBlockBefore(SplitInstr);
              BasicBlock *ChildBB = &Fn.front();
              BBCalls.insert(
                  std::pair<BasicBlock *, BasicBlock *>(ParentBB, ChildBB));
            }
          }
        }
      }
    }

    /**
     * @param Md The module for which the basic block's signatures have to be computed
     * @param BBSigs an associative map containing Md's basic blocks associated with their signatures
     */
    void initializeBlocksSignatures(Module &Md, std::map<BasicBlock*, int> &BBSigs) {
      int Counter = 1;
      for (Function &Fn : Md) {
        if (!Fn.isDeclarationForLinker()) {
          for (BasicBlock &BB : Fn) {
            BBSigs.insert(std::pair<BasicBlock *, int>(&BB, Counter));
            Counter++;
          }
        }
      }
    }

    /**
     * For each function in Md:
     * If the function is not declared for linker (i.e. is not an imported function)
     * and either one of those condition holds:
     * 1) The function is declared as external (non-static)
     * 2) Is an entry point of the program.
     * Insert G and D alloca instruction at the beginning of the functions
     * @param Md
     */
    void initializeEntryFunctions(Module &Md, const std::map<BasicBlock *, int> &BBSigs, const std::map<BasicBlock*, BasicBlock*> &BBCalls, Value* G, Value *D, std::map<Function*, StringRef> &FuncAnnotations) {
      auto *IntType = llvm::Type::getInt32Ty(Md.getContext());
      for (Function &Fn : Md) {
        if (!Fn.isDeclarationForLinker() && (*FuncAnnotations.find(&Fn)).second.startswith("task") /*&&
            (Fn.hasExternalLinkage() || Fn.hasNUses(0))*/) {
          int CurSig = BBSigs.find(&Fn.front())->second;

          // create IRBuilder
          IRBuilder<> B(Md.getContext());
          B.SetInsertPoint(&*Fn.front().getFirstInsertionPt());

          // backup and update G and D as Fn is an entry function
          Value *OldG = B.CreateLoad(IntType, G, "BackupG");
          Value *OldD = B.CreateLoad(IntType, D, "BackupD");
          Value *InstrG = llvm::ConstantInt::get(IntType, CurSig);
          B.CreateStore(InstrG, G, false);

          // if the Fn's first BasicBlock has a neighbor, it means that we have to compute D
          int NeighborSig = getNeighborSig(Fn.front(), BBSigs, BBCalls);
          if (NeighborSig != -1) {
            Value *InstrD =
                llvm::ConstantInt::get(IntType, CurSig ^ NeighborSig);
            B.CreateStore(InstrD, D);
          }

          // add the restore of G and D at each function return instruction
          for (BasicBlock &BB : Fn) {
            Instruction *Terminator = BB.getTerminator();
            if (isa<ReturnInst>(Terminator)) {
              B.SetInsertPoint(Terminator);
              B.CreateStore(OldG, G);
              B.CreateStore(OldD, D);
            }
          }
        }
      }
    }

    /**
     * @param BB
     * @return True if the BasicBlock BB has a return as terminator, False otherwise.
     */
    bool isReturnBB(BasicBlock &BB) {
      return isa<ReturnInst>(BB.getTerminator());
    }

    /**
     * @param BB The basic block for which the first predecessor is required
     * @param BBSigs The basic block list of signatures, so that the BB is found
     * between the ones that existed before the compilation
     * @param BBCalls The map of parent/child basic blocks of the module
     * @return The first predecessor of BB, if the BB is in BBCalls it returns
     * the first basic block calling it. NULL otherwise.
     */
    BasicBlock*getFirstPredecessor(BasicBlock &BB,
                                    const std::map<BasicBlock*, int> &BBSigs,
                                    const std::map<BasicBlock*, BasicBlock*> &BBCalls) {
      //If the block before BB is a caller => the predecessor is the first of the called functions' return blocks
      if (BBCalls.find(BB.getSinglePredecessor()) != BBCalls.end()) {
        Function *Called = BBCalls.find(BB.getSinglePredecessor())->second->getParent();
        for (BasicBlock &CalledBB : *Called) {
          if(isReturnBB(CalledBB)) {
            return &CalledBB;
          }
        }
      }

      /* check between the basic blocks that called BB:
       * - if the caller is the first basic block of an entry function, return it
       * - otherwise return the first caller found
       */
      BasicBlock *Res = NULL;
      for (auto Elem : BBCalls) {
        if (Elem.second == &BB) {
          if (!Res) {
            Res = Elem.first;
          }
          if (Elem.first == &Elem.first->getParent()->front() && Elem.first->getParent()->hasNUses(0)) {
            return Elem.first;
          }
        }
      }
      if (Res) {
        return Res;
      }

      // check between the basic block actual predecessors
      for (auto *Pred : predecessors(&BB)) {
        if (BBSigs.find(Pred) != BBSigs.end()) {
          return Pred;
        }
      }
      return NULL;
    }

    /**
     * @param BB
     * @param BBSigs
     * @param BBCalls
     * @return The signature of the BB's first neighbor (i.e. a basic block in BBSigs
     * that has one successor in common with BB). Returns -1 if the number of
     * neighbors is less than N=2.
     */
    int getNeighborSig(BasicBlock &BB, const std::map<BasicBlock*, int> &BBSigs,
                       const std::map<BasicBlock*, BasicBlock*> &BBCalls) {
      int N = 2;
      std::set<BasicBlock*> Successors;

      // if BB is in BBCalls, add the called BB to the list of successors to check
      if (BBCalls.find(&BB) != BBCalls.end()) {
        Successors.insert(BBCalls.find(&BB)->second);
      }
      Successors.insert(successors(&BB).begin(), successors(&BB).end());

      // check if the BB has a return instruction, if it does get the function callers and add them to the successors list
      if (isReturnBB(BB)) {
        for (User *U : BB.getParent()->users()) {
          if (isa<Instruction>(U)) {
            Instruction *Caller = cast<Instruction>(U);
            Successors.insert(Caller->getParent()->getSingleSuccessor());
          }
        }
      }

      // For each successor count the number of predecessors. If the number of predecessors is 2
      // return the signature of the successor's first predecessor (i.e. the first neighbor signature).
      for (auto *Succ : Successors) {
        if (BBSigs.find(Succ) != BBSigs.end()) {
          if (hasNPredecessorsOrMore(*Succ, N, BBSigs, BBCalls)) {
            BasicBlock *Neigh = getFirstPredecessor(*Succ, BBSigs, BBCalls);
            return BBSigs.find(Neigh)->second;
          }
        }
      }

      return -1;
    }

    bool hasNPredecessorsOrMore(BasicBlock &BB, int N, const std::map<BasicBlock*, int> &BBSigs,
                                const std::map<BasicBlock*, BasicBlock*> &BBCalls) {
      int Count = 0;
      // Count the BB actual predecessors
      for (auto *Pred : predecessors(&BB)) {
        if (BBSigs.find(Pred) != BBSigs.end()) {
          Count++;
        }
        if(Count == N) {
          return true;
        }
      }
      // Count the times the BB is called
      for (auto Pair : BBCalls) {
        if (Pair.second == &BB) {
          Count++;
        }
        if(Count == N) {
          return true;
        }
      }
      return false;
    }

    /**
     *
     * @param BBSigs
     * @param NewBBs
     * For each basic block BB in the original set of basic blocks (BBSigs), find
     * the CFGVerificationBB created into NewBBs and put it into the function in the
     * correct position such that NewBB is
     */
    void sortBasicBlocks(const std::map<BasicBlock *, int> &BBSigs, const std::map<int, BasicBlock *> &NewBBs) {
      for (auto Pair : BBSigs) { // for each element in the original set of blocks
        int BBSig = Pair.second;
        auto *BB = Pair.first;
        if (NewBBs.find(BBSig) != NewBBs.end()) { // check if a new basic block has been created for the signature
          auto *CFGVerificationBB = NewBBs.find(BBSig)->second;
          // re-insert the CFGVerificationBB into the function in the right position
          CFGVerificationBB->removeFromParent();
          CFGVerificationBB->insertInto(BB->getParent(), Pair.first);

          // move all the phi instructions from the next BB into the CFGVerificationBB
          while (isa<PHINode>(BB->front())) {
            Instruction &PHIInst = BB->front();
            PHIInst.removeFromParent();
            PHIInst.insertBefore(&CFGVerificationBB->front());
          }

          // update each predecessor Pred of BB replacing their successors BB with CFGVerificationBB
          for (auto Inner : BBSigs) {
            auto *Pred = Inner.first;
            auto *I = Pred->getTerminator();
            I->replaceSuccessorWith(BB, CFGVerificationBB);
          }
        }
      }
    }

    /**
     * Creates a new basic block for the CFG verification of basic block BB.
     * Such basic block is added to the map NewBBs setting the signature of BB as key.
     * @param BB
     * @param BBSigs
     * @param BBCalls
     * @param NewBBs
     * @param ErrBB
     * @param G
     * @param D
     */
    void createCFGVerificationBB (BasicBlock &BB,
                                 const std::map<BasicBlock *, int> &BBSigs,
                                 const std::map<BasicBlock*, BasicBlock*> &BBCalls,
                                 std::map<int, BasicBlock *> *NewBBs,
                                 BasicBlock &ErrBB,
                                 Value *G, Value *D) {
      // local variables
      int CurSig = BBSigs.find(&BB)->second; // current signature
      LLVMContext &C = BB.getModule()->getContext(); // the module context
      IntegerType *IntType = llvm::Type::getInt32Ty(C); // integer type
      BasicBlock *Predecessor = getFirstPredecessor(BB, BBSigs, BBCalls);
      int PredSig = 0;

      // if the block has a predecessor we use its signature, otherwise the sig = 0
      if (BBSigs.find(Predecessor) != BBSigs.end()) {
        PredSig = BBSigs.find(Predecessor)->second;
      }

      // initialize new basic block, add it to the NewBBs and initialize the builder
      BasicBlock *CFGVerificationBB = BasicBlock::Create(C, "CFGVerificationBB_"+std::to_string(CurSig), BB.getParent());
      NewBBs->insert(std::pair<int, BasicBlock*>(CurSig, CFGVerificationBB));
      IRBuilder<> B(C);
      B.SetInsertPoint(CFGVerificationBB);

      // create the body of the CFG verification
      Value *InstrG = B.CreateLoad(IntType, G, "LoadG"); // load InstrG from memory
      Value *InstrDLower =
          llvm::ConstantInt::get(IntType, CurSig ^ PredSig);
      Value *InstrCurSig = llvm::ConstantInt::get(IntType, CurSig);
      Value *XorRes;

      if(hasNPredecessorsOrMore(BB, 2, BBSigs, BBCalls)) {
        // if we have multiple predecessors we compute the result as d ^ G ^ D
        Value *InstrD = B.CreateLoad(IntType, D, "LoadD");
        XorRes = B.CreateXor(InstrDLower, B.CreateXor(InstrG, InstrD), "RunTimeG");
      }
      else {
        // otherwise the result is just d ^ G
        XorRes = B.CreateXor(InstrDLower, InstrG);
      }
      B.CreateStore(XorRes, G, false);

      // if the BB has a neighbor, it means that we have to compute D
      int NeighborSig = getNeighborSig(BB, BBSigs, BBCalls);
      if (NeighborSig != -1) {
        Value *InstrD =
            llvm::ConstantInt::get(IntType, CurSig ^ NeighborSig);
        B.CreateStore(InstrD, D);
      }

      // compare if the new run-time signature (stored in XorRes) is equal to the signature of the block
      Value *Cond = B.CreateCmp(llvm::CmpInst::ICMP_EQ, XorRes, InstrCurSig);
      B.CreateCondBr(Cond, &BB, &ErrBB);

    }

  public:
    bool runOnModule(Module &Md) override {
      std::map<Function*, StringRef> FuncAnnotations;
      getFuncAnnotations(Md, FuncAnnotations);

      // get the list of entry points for each function
      std::map<Function*, Function*> FunctionEntryPts;
      //getFunctionsEntryPts(Md, FunctionEntryPts);

      // split the basic blocks at each call of a module function. BBCalls = map of caller/callee basic blocks
      std::map<BasicBlock*, BasicBlock*> BBCalls;
      //splitBBsAtCalls(Md, BBCalls);

      // assign a signature to each BB. BBSigs = map of basic blocks and their signatures
      std::map<BasicBlock *, int> BBSigs;
      initializeBlocksSignatures(Md, BBSigs);

      // in each entry function initialize the code for the first G
      //initializeEntryFunctions(Md, BBSigs, BBCalls, G, D, FuncAnnotations);

      // map of signatures of basic blocks and their CFG-verification basic blocks
      std::map<int, BasicBlock *> NewBBs;

      for (Function &Fn : Md) {
        if (!Fn.isDeclarationForLinker() && !(*FuncAnnotations.find(&Fn)).second.startswith("exclude")) {
        //if (!Fn.isDeclarationForLinker() && ((*FuncAnnotations.find(&Fn)).second.startswith("include") || (*FuncAnnotations.find(&Fn)).second.startswith("task"))) {
          // initialize global variables
          auto *IntType = llvm::Type::getInt32Ty(Md.getContext());
          Value *G = new llvm::GlobalVariable(Md, llvm::Type::getInt32Ty(Md.getContext()), false, llvm::GlobalValue::WeakAnyLinkage, llvm::ConstantInt::get(IntType, 0), "G");
          Value *D = new llvm::GlobalVariable(Md, llvm::Type::getInt32Ty(Md.getContext()), false, llvm::GlobalValue::WeakAnyLinkage, llvm::ConstantInt::get(IntType, 0), "D");

          int CurSig = BBSigs.find(&Fn.front())->second;

          // create IRBuilder
          IRBuilder<> B(Md.getContext());
          B.SetInsertPoint(&*Fn.front().getFirstInsertionPt());

          // backup and update G and D as Fn is an entry function
          Value *OldG = B.CreateLoad(IntType, G, "BackupG");
          Value *OldD = B.CreateLoad(IntType, D, "BackupD");
          Value *InstrG = llvm::ConstantInt::get(IntType, CurSig);
          B.CreateStore(InstrG, G, false);

          // if the Fn's first BasicBlock has a neighbor, it means that we have to compute D
          int NeighborSig = getNeighborSig(Fn.front(), BBSigs, BBCalls);
          if (NeighborSig != -1) {
            Value *InstrD =
                llvm::ConstantInt::get(IntType, CurSig ^ NeighborSig);
            B.CreateStore(InstrD, D);
          }

          // add the restore of G and D at each function return instruction
          for (BasicBlock &BB : Fn) {
            Instruction *Terminator = BB.getTerminator();
            if (isa<ReturnInst>(Terminator)) {
              B.SetInsertPoint(Terminator);
              B.CreateStore(OldG, G);
              B.CreateStore(OldD, D);
            }
          }

          // add the error basic block to jump to in case of error
          BasicBlock *ErrBB = BasicBlock::Create(Fn.getContext(), "ErrBB", &Fn);
          for (auto &Elem : BBSigs) {
            BasicBlock *BB = Elem.first;
            if (BB->getParent() == &Fn && BB != &Fn.front()) {
              createCFGVerificationBB(*BB, BBSigs, BBCalls, &NewBBs, *ErrBB, G, D);
            }
          }
          IRBuilder<> ErrB(ErrBB);
          auto CalleeF = ErrBB->getModule()->getOrInsertFunction(
              "Error_Handler", FunctionType::getVoidTy(Md.getContext()));
          ErrB.CreateCall(CalleeF)->setDebugLoc(ErrB.getCurrentDebugLocation());
          ErrB.CreateBr(ErrBB);
        }
      }

      // reorder the basic blocks, fixing predecessors and successors.
      sortBasicBlocks(BBSigs, NewBBs);
      return true;
    }
};
} // namespace

char CFGVerification::ID = 0;
static RegisterPass<CFGVerification> X("verify_cfg", "CFG Verification Pass");