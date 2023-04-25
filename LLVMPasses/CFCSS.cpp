/**
 * ************************************************************************************************
 * @brief  LLVM pass implementing Control Flow Checking by Software Signatures (CFCSS).
 *         Original algorithm by Oh et Al. (DOI: 10.1109/24.994926)
 * 
 * @author Davide Baroffio, Politecnico di Milano, Italy (dav.baroffio@mail.polimi.it)
 * ************************************************************************************************
*/
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
#include <iostream>
#include <fstream>
using namespace llvm;

#define DEBUG_TYPE "cfg_verification"

/**
 * - 0: Disabled
 * - 1: Enabled
*/
#define LOG_COMPILED_FUNCS 1

namespace {
struct CFCSS : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  CFCSS() : ModulePass(ID) { }

  private:
    std::map<Function*, StringRef> FuncAnnotations;
    
    #if (LOG_COMPILED_FUNCS == 1)
    std::set<Function*> CompiledFuncs;
    // Inserts the names of the compiled functions into a csv file
    void persistCompiledFunctions() {
      std::ofstream file;
      file.open("compiled_cfcss_functions.csv");
      file << "fn_name\n";
      for (Function *Fn : CompiledFuncs) {
        file << Fn->getName().str() << "\n";
      }
      file.close();
    }
    #endif

    /**
     * This function specifies whether the function Fn should be compiled.
    */
    bool shouldCompile(Function &Fn) {
      return &Fn != nullptr && Fn.getBasicBlockList().size() != 0 
            && (FuncAnnotations.find(&Fn) == FuncAnnotations.end() || 
            !FuncAnnotations.find(&Fn)->second.startswith("exclude"));
    }

    /**
     * WARNING: This function supports only one annotation for each function, multiple annotations are discarded
     * @param Md The module where to look for the annotations
     * @param FuncAnnotations A map of Function and StringRef where to put the annotations for each Function
     */
    void getFuncAnnotations(Module &Md) {
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
     * Assigns a signature to each basic block BB of the current CFG, storing the couple <BB, signature> into BBSigs
     * @param Md The module for which the basic block's signatures have to be computed
     * @param BBSigs an associative map containing Md's basic blocks associated with their signatures
     */
    void initializeBlocksSignatures(Module &Md, std::map<BasicBlock*, int> &BBSigs) {
      int Counter = 1;
      for (Function &Fn : Md) {
        if (shouldCompile(Fn)) {
          for (BasicBlock &BB : Fn) {
            if (!BB.getName().equals_insensitive("errbb")) // we skip this since "errbb" Basic Blocks are generated by EDDI
              BBSigs.insert(std::pair<BasicBlock *, int>(&BB, Counter));
            Counter++;
          }
        }
      }
    }

    /**
     * @param BB The basic block for which the first predecessor is required
     * @param BBSigs The basic block list of signatures, so that the BB is found
     * between the ones that existed before the compilation
     * @return The first predecessor of BB
     */
    BasicBlock*getFirstPredecessor(BasicBlock &BB,
                                    const std::map<BasicBlock*, int> &BBSigs) {
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
     * @return The signature of the BB's first neighbor (i.e. a basic block in BBSigs
     * that has one successor in common with BB). Returns -1 if the number of
     * neighbors is less than N=2.
     */
    int getNeighborSig(BasicBlock &BB, const std::map<BasicBlock*, int> &BBSigs) {
      std::set<BasicBlock*> Todo;
      std::set<BasicBlock*> Candidates;

      Todo.insert(&BB);
      Candidates.insert(&BB);
      while (Todo.size() != 0) {
        BasicBlock *Elem = *Todo.begin(); // get the first element
        for (auto *Succ : successors(Elem)) {
          if (BBSigs.find(Succ) != BBSigs.end()) {
            for (auto *Pred : predecessors(Succ)) {
              if (BBSigs.find(Pred) != BBSigs.end() && Candidates.find(Pred) == Candidates.end()){
                Todo.insert(Pred);
                Candidates.insert(Pred);
              }
            }
          }
        }
        Todo.erase(Elem);
      }
      if (Candidates.size() > 1) {
        return BBSigs.find(*Candidates.begin())->second;
      }

      return -1;
    }

    bool hasNPredecessorsOrMore(BasicBlock &BB, int N, const std::map<BasicBlock*, int> &BBSigs) {
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
      return false;
    }

    /**
     *
     * @param BBSigs
     * @param NewBBs
     * 
     */
    void sortBasicBlocks(const std::map<BasicBlock *, int> &BBSigs, const std::map<int, BasicBlock *> &NewBBs, const std::map<Function*, BasicBlock*> &FuncErrBBs) {
      for (auto Pair : BBSigs) { // for each element in the original set of blocks
        int BBSig = Pair.second;
        auto *BB = Pair.first;
        if (NewBBs.find(BBSig) != NewBBs.end()) { // check if a new basic block has been created for the signature
          auto *CFGVerificationBB = NewBBs.find(BBSig)->second;
          // re-insert the CFGVerificationBB into the function in the right position
          CFGVerificationBB->removeFromParent();
          CFGVerificationBB->insertInto(BB->getParent(), Pair.first);

          IRBuilder<> B(CFGVerificationBB);
          Value *Cond = &CFGVerificationBB->getInstList().back();
          B.CreateCondBr(Cond, BB, FuncErrBBs.find(BB->getParent())->second);

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
     * @param NewBBs
     * @param ErrBB
     * @param G
     * @param D
     */
    void createCFGVerificationBB (BasicBlock &BB,
                                 const std::map<BasicBlock *, int> &BBSigs,
                                 std::map<int, BasicBlock *> *NewBBs,
                                 BasicBlock &ErrBB,
                                 Value *G, Value *D) {
      // local variables
      int CurSig = BBSigs.find(&BB)->second; // current signature
      LLVMContext &C = BB.getModule()->getContext(); // the module context
      IntegerType *IntType = llvm::Type::getInt32Ty(C); // integer type
      BasicBlock *Predecessor = getFirstPredecessor(BB, BBSigs);
      int PredSig = 0;

      // if the block has a predecessor we use its signature, otherwise the sig = 0
      if (BBSigs.find(Predecessor) != BBSigs.end()) {
        if(hasNPredecessorsOrMore(BB, 2, BBSigs)) {
          PredSig = getNeighborSig(*Predecessor, BBSigs);
        }
        else PredSig = BBSigs.find(Predecessor)->second;
      }

      // initialize new basic block, add it to the NewBBs and initialize the builder
      BasicBlock *CFGVerificationBB = BasicBlock::Create(C, "CFGVerificationBB_"+std::to_string(CurSig), BB.getParent());
      NewBBs->insert(std::pair<int, BasicBlock*>(CurSig, CFGVerificationBB));
      IRBuilder<> B(C);
      B.SetInsertPoint(CFGVerificationBB);

      // create the body of the CFG verification basic block
      Value *InstrG = B.CreateLoad(IntType, G, "LoadG"); // load InstrG from memory
      Value *InstrDLower =
          llvm::ConstantInt::get(IntType, CurSig ^ PredSig);
      Value *InstrCurSig = llvm::ConstantInt::get(IntType, CurSig);
      Value *XorRes;

      if(hasNPredecessorsOrMore(BB, 2, BBSigs)) {
        // if we have multiple predecessors we compute the result as d ^ G ^ D
        Value *InstrD = B.CreateLoad(IntType, D, "LoadD");
        XorRes = B.CreateXor(InstrDLower, B.CreateXor(InstrG, InstrD), "RunTimeG");
      }
      else {
        // otherwise the result is just d ^ G
        XorRes = B.CreateXor(InstrDLower, InstrG);
      }
      B.CreateStore(XorRes, G, false);

      // if the BB has a neighbor, it means that we also have to compute D
      int NeighborSig = getNeighborSig(BB, BBSigs);
      if (NeighborSig != -1) {
        Value *InstrD =
            llvm::ConstantInt::get(IntType, CurSig ^ NeighborSig);
        B.CreateStore(InstrD, D);
      }

      // compare the new run-time signature (stored in XorRes) with the signature of the block
      Value *Cond = B.CreateCmp(llvm::CmpInst::ICMP_EQ, XorRes, InstrCurSig);

      // the Branch instruction is inserted later in the function sortBasicBlocks()
    }

  public:
    bool runOnModule(Module &Md) override {
      getFuncAnnotations(Md);

      // assign a signature to each BB. BBSigs = map of basic blocks and their signatures
      std::map<BasicBlock *, int> BBSigs;
      initializeBlocksSignatures(Md, BBSigs);

      // map of signatures of basic blocks and their CFG-verification basic blocks
      std::map<int, BasicBlock *> NewBBs;

      // collection of Error Basic Blocks for each function
      std::map<Function*, BasicBlock*> ErrBBs;
      
      for (Function &Fn : Md) {
        if (shouldCompile(Fn)) {
          #if (LOG_COMPILED_FUNCS == 1)
            CompiledFuncs.insert(&Fn);
          #endif

          auto *IntType = llvm::Type::getInt32Ty(Md.getContext());

          int CurSig = BBSigs.find(&Fn.front())->second;

          // create IRBuilder
          IRBuilder<> B(Md.getContext());
          B.SetInsertPoint(&*Fn.front().getFirstInsertionPt());

          // Create G and D at the function prologue
          Value *G = B.CreateAlloca(IntType, (llvm::Value *)nullptr, "G");
          Value *D = B.CreateAlloca(IntType, (llvm::Value *)nullptr, "D");
          Value *InstrG = llvm::ConstantInt::get(IntType, CurSig);
          B.CreateStore(InstrG, G, false);

          // if the Fn's first BasicBlock has a neighbor, it means that we have to compute D
          int NeighborSig = getNeighborSig(Fn.front(), BBSigs);
          if (NeighborSig != -1) {
            Value *InstrD =
                llvm::ConstantInt::get(IntType, CurSig ^ NeighborSig);
            B.CreateStore(InstrD, D);
          }

          // add the error basic block to jump to in case of error
          BasicBlock *ErrBB = BasicBlock::Create(Fn.getContext(), "ErrBB", &Fn);

          // insert the actual cfg verification basic blocks in the function
          for (auto &Elem : BBSigs) {
            BasicBlock *BB = Elem.first;
            if (BB->isEntryBlock()) {
              createCFGVerificationBB(*BB, BBSigs, &NewBBs, *ErrBB, G, D);
            }
          }
          IRBuilder<> ErrB(ErrBB);
          auto CalleeF = ErrBB->getModule()->getOrInsertFunction(
              "SigMismatch_Handler", FunctionType::getVoidTy(Md.getContext()));
          ErrB.CreateCall(CalleeF)->setDebugLoc(ErrB.getCurrentDebugLocation());
          ErrB.CreateUnreachable();
          ErrBBs.insert(std::pair<Function*, BasicBlock*>(&Fn, ErrBB));
        }
      }

      // reorder the basic blocks, fixing predecessors and successors.
      sortBasicBlocks(BBSigs, NewBBs, ErrBBs);

      #if (LOG_COMPILED_FUNCS == 1)
      persistCompiledFunctions();
      #endif

      return true;
    }
};
} // namespace

char CFCSS::ID = 0;
static RegisterPass<CFCSS> X("cfcss_verify", "CFG Verification Pass");