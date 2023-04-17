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

#define DEBUG_TYPE "rasm_verify"

/**
 * - 0: Disabled
 * - 1: Enabled
*/
#define INTRA_FUNCTION_CFC 0
#define INIT_SIGNATURE -0xDEAD // The same value has to be used as initializer for the signatures in the code

/**
 * - 0: Disabled
 * - 1: Enabled
*/
#define LOG_COMPILED_FUNCS 1

namespace {
struct RASM : public ModulePass {

  static char ID; // Pass identification, replacement for typeid
  RASM() : ModulePass(ID) { }

  private:
    std::map<Function*, StringRef> FuncAnnotations;
    std::map<BasicBlock*, BasicBlock*> NewBBs;

    #if (LOG_COMPILED_FUNCS == 1)
    std::set<Function*> CompiledFuncs;
    // Inserts the names of the compiled functions into a csv file
    void persistCompiledFunctions() {
      std::ofstream file;
      file.open("compiled_rasm_functions.csv");
      file << "fn_name\n";
      for (Function *Fn : CompiledFuncs) {
        file << Fn->getName().str() << "\n";
      }
      file.close();
    }
    #endif

    /**
     * TODO This function supports only one annotation for each function, multiple annotations are discarded, perhaps I can fix this lol
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

    void initializeBlocksSignatures(Module &Md, std::map<BasicBlock*, int> &RandomNumberBBs, std::map<BasicBlock*, int> &SubRanPrevVals) {
        int i = 0;
        for (Function &Fn : Md) {
            if (!Fn.isDeclarationForLinker()) {
                for (BasicBlock &BB : Fn) {
                    if (!BB.getName().equals_insensitive("errbb")) {
                        RandomNumberBBs.insert(std::pair<BasicBlock*, int>(&BB, i));
                        SubRanPrevVals.insert(std::pair<BasicBlock*, int>(&BB, 1));
                        i=i+2;
                    }
                }
            }
        }
        return;
    }

    /**
     * Navigates the module's (not declared for linker and not externally linked) functions.
     * For each such function, split all the basic blocks calling it before the
     * call instruction.
     * @param Md The module for which to perform the split.
     */
    void splitBBsAtCalls(Module &Md) {
      for (Function &Fn : Md) {
        // we target only functions defined in the module (i.e. not the ones that
        // have to be linked because they are not in the scope of this compilation
        // instance)
        if (!Fn.isDeclarationForLinker()) {
          for (User *U : Fn.users()) {
            if (isa<Instruction>(U)) {
                Instruction *Caller = cast<Instruction>(U);
                Instruction *SplitInstr = Caller->getNextNonDebugInstruction();
                Caller->getParent()->splitBasicBlockBefore(SplitInstr);
            }
          }
        }
      }
    }

    bool isCallBB (BasicBlock &BB) {
      return isa<BranchInst>(BB.getTerminator()) 
        && cast<BranchInst>(BB.getTerminator())->isUnconditional() 
        && BB.getTerminator()->getPrevNonDebugInstruction() != nullptr
        && isa<CallBase>(BB.getTerminator()->getPrevNonDebugInstruction());
    }

    Value *getCondition(Instruction &I) {
      if (isa<BranchInst>(I) && cast<BranchInst>(I).isConditional()) {
        if (!cast<BranchInst>(I).isConditional()) {
          return nullptr;
        }
        else {
          return cast<BranchInst>(I).getCondition();
        }
      }
      else if (isa<SwitchInst>(I)) {
        return cast<SwitchInst>(I).getCondition();
      }
      else {
        assert(false && "Tried to get a condition on a function that is not a branch or a switch");
      }
    }

    void createCFGVerificationBB (  BasicBlock &BB, 
                                    std::map<BasicBlock*, int> &RandomNumberBBs, 
                                    std::map<BasicBlock*, int> &SubRanPrevVals, 
                                    Value &RuntimeSig, 
                                    Value &RetSig,
                                    BasicBlock &ErrBB) {

        auto *IntType = llvm::Type::getInt32Ty(BB.getContext());

        int randomNumberBB = RandomNumberBBs.find(&BB)->second;
        int subRanPrevVal = SubRanPrevVals.find(&BB)->second;
        // in this case BB is not the first Basic Block of the function, so it has to update RuntimeSig and check it
        if (!BB.isEntryBlock()) {
            BasicBlock *NewBB = BasicBlock::Create(BB.getContext(), "RASM_Verification_BB", BB.getParent(), &BB);
            IRBuilder<> BChecker(NewBB);

            // add instructions for the first runtime signature update
            Value *InstrRuntimeSig = BChecker.CreateLoad(IntType, &RuntimeSig);

            Value *RuntimeSignatureVal = BChecker.CreateSub(InstrRuntimeSig, llvm::ConstantInt::get(IntType, subRanPrevVal));
            BChecker.CreateStore(RuntimeSignatureVal, &RuntimeSig);

            // update phi placing them in the new block
            while (isa<PHINode>(&BB.front())) {
              Instruction *PhiInst = &BB.front();
              PhiInst->removeFromParent();
              PhiInst->insertBefore(&NewBB->front());
            }

            // replace the uses of BB with NewBB
            for (BasicBlock &BB_ : *BB.getParent()) {
              if (&BB_ != NewBB) {
                BB_.getTerminator()->replaceSuccessorWith(&BB, NewBB);
              }
            }

            // add instructions for checking the runtime signature
            Value *CmpVal = BChecker.CreateCmp(llvm::CmpInst::ICMP_EQ, RuntimeSignatureVal, llvm::ConstantInt::get(IntType, randomNumberBB));
            BChecker.CreateCondBr(CmpVal, &BB, &ErrBB);

            // add NewBB and BB into the NewBBs map
            NewBBs.insert(std::pair<BasicBlock*, BasicBlock*>(NewBB, &BB));
        }

        // Add instructions for the second runtime signature update.
        // There are three cases:
        /**
         * A) the basic block ends with a call instruction
         * B) the basic block ends with a return instruction
         * C) all the other cases
        */

        #if (INTRA_FUNCTION_CFC == 1) 
        // Case A, we need to update the RetSig
        if (isCallBB(BB)) {
          BasicBlock *SuccBB = cast<BranchInst>(BB.getTerminator())->getSuccessor(0); // note: since we have a call, we only have one successor
          int randomNumberSuccBB = RandomNumberBBs.find(SuccBB)->second;
          int subRanPrevValSuccBB = SubRanPrevVals.find(SuccBB)->second;
          int retSig = randomNumberSuccBB + subRanPrevValSuccBB;

          CallBase *CallIn = cast<CallBase>(BB.getTerminator()->getPrevNonDebugInstruction());
          if (CallIn->getCalledFunction() != NULL && CallIn->getCalledFunction()->getBasicBlockList().size() != 0 
              && (FuncAnnotations.find(CallIn->getCalledFunction()) == FuncAnnotations.end() || 
              !FuncAnnotations.find(CallIn->getCalledFunction())->second.startswith("exclude"))) {
            BasicBlock *CalledBB = &CallIn->getCalledFunction()->front();
            if (RandomNumberBBs.find(CalledBB) == RandomNumberBBs.end()) {
              CalledBB = CalledBB->getNextNode();
            }
            if (RandomNumberBBs.find(CalledBB) != RandomNumberBBs.end() && CalledBB != nullptr) { 
              int randomNumberCalledBB = RandomNumberBBs.find(CalledBB)->second;
              int subRanPrevValCalledBB = SubRanPrevVals.find(CalledBB)->second;
              IRBuilder<> B(BB.getTerminator()->getPrevNonDebugInstruction());
              B.CreateStore(llvm::ConstantInt::get(IntType, randomNumberCalledBB+subRanPrevValCalledBB), &RuntimeSig);
              B.CreateStore(llvm::ConstantInt::get(IntType, retSig), &RetSig);
            }
          }
        }
        else
        #endif
        // Case B, we need to add a check on the RetSig and update the RuntimeSig
        if (isa<ReturnInst>(BB.getTerminator())) {
          // add a control basic block before the return instruction
          BasicBlock *PrevBB = BB.splitBasicBlockBefore(BB.getTerminator());
          BasicBlock *NewBB = BasicBlock::Create(BB.getContext(), "RASM_ret_Verification_BB", BB.getParent(), &BB);
          int primeNum = randomNumberBB - subRanPrevVal;

          // compute the adjustment value as AdjVal = primeNum+SubRanPrevVal-RetSig = randomNumberBB-subRanPrevVal+SubRanPrevVal-RetSig = randomNumberBB-RetSig
          IRBuilder<> B(NewBB);
          Value *InstrRetSig = B.CreateLoad(IntType, &RetSig);
          Value* AdjVal = B.CreateSub(llvm::ConstantInt::get(IntType, randomNumberBB), InstrRetSig);

          // update the signature
          Value *InstrRuntimeSig = B.CreateLoad(IntType, &RuntimeSig);
          Value* NewSig = B.CreateSub(InstrRuntimeSig, AdjVal);
          B.CreateStore(NewSig, &RuntimeSig);

          // compare the new signature with RetSig
          Value *CmpValRet = B.CreateCmp(llvm::CmpInst::ICMP_EQ, NewSig, InstrRetSig);
          B.CreateCondBr(CmpValRet, &BB, &ErrBB);
        }
        // Case C, we need to update the signature depending on the target basic block
        else {
          IRBuilder<> B(BB.getTerminator());
          Instruction *Terminator = BB.getTerminator();
          
          /**
           * We have three cases:
           * 1) one successor -> the branch is unconditional, so we use one single successor
           * 2) two successors -> the branch is conditional, so we use a `select` instruction
           * 3) more than three successors -> we have a switch: impossible since we lower switches in a previous pass
          */
          int numSuccessors = Terminator->getNumSuccessors();
          switch (numSuccessors)
          {
            case 1: {
              BasicBlock *Successor = Terminator->getSuccessor(0);
              if (NewBBs.find(Successor) != NewBBs.end()) { // we want to find the correct successor, i.e. if Successor is in NewBBs, it means that it has been added now so it doesn't have a signature... Therefore we take the successor's successor
                Successor = NewBBs.find(Successor)->second;
              }
              int succRandomNumberBB = RandomNumberBBs.find(Successor)->second;
              int succSubRanPrevVal = SubRanPrevVals.find(Successor)->second;
              int adjVal = randomNumberBB - (succRandomNumberBB + succSubRanPrevVal);

              Value *InstrRuntimeSig = B.CreateLoad(IntType, &RuntimeSig);
              Value *NewSig = B.CreateSub(InstrRuntimeSig, llvm::ConstantInt::get(IntType, adjVal));
              B.CreateStore(NewSig, &RuntimeSig);
              break;
            }
            case 2: {
              BasicBlock *Successor_1 = Terminator->getSuccessor(0);
              if (NewBBs.find(Successor_1) != NewBBs.end()) {
                Successor_1 = NewBBs.find(Successor_1)->second;
              }
              int succRandomNumberBB_1 = RandomNumberBBs.find(Successor_1)->second;
              int succSubRanPrevVal_1 = SubRanPrevVals.find(Successor_1)->second;
              int adjVal_1 = randomNumberBB - (succRandomNumberBB_1 + succSubRanPrevVal_1);

              BasicBlock *Successor_2 = Terminator->getSuccessor(1);
              if (NewBBs.find(Successor_2) != NewBBs.end()) {
                Successor_2 = NewBBs.find(Successor_2)->second;
              }
              int succRandomNumberBB_2 = RandomNumberBBs.find(Successor_2)->second;
              int succSubRanPrevVal_2 = SubRanPrevVals.find(Successor_2)->second;
              int adjVal_2 = randomNumberBB - (succRandomNumberBB_2 + succSubRanPrevVal_2);

              Value *BrCondition = getCondition(*Terminator);

              Value *AdjustValue = B.CreateSelect(BrCondition, llvm::ConstantInt::get(IntType, adjVal_1)
                                        , llvm::ConstantInt::get(IntType, adjVal_2));
              Value *InstrRuntimeSig = B.CreateLoad(IntType, &RuntimeSig);
              Value *NewSig = B.CreateSub(InstrRuntimeSig, AdjustValue);
              B.CreateStore(NewSig, &RuntimeSig);
              break;
            }
            
            default:{ 
              break;
            }
          }
        }
    }

  public:

    bool runOnModule(Module &Md) override {
        getFuncAnnotations(Md);
        std::map<BasicBlock*, int> RandomNumberBBs;
        std::map<BasicBlock*, int> SubRanPrevVals;

        std::map<Function*, BasicBlock*> ErrBBs;

        // initialize global variables
        auto *IntType = llvm::Type::getInt32Ty(Md.getContext());

        #if (INTRA_FUNCTION_CFC == 1)
          splitBBsAtCalls(Md);
          GlobalVariable *RuntimeSig;
          GlobalVariable *RetSig;
          // find the global variables required for the runtime signatures
          for (GlobalVariable &GV : Md.globals()) {
            if (!isa<Function>(GV) && FuncAnnotations.find(cast<Function>(&GV)) != FuncAnnotations.end()) {
              if ((FuncAnnotations.find(cast<Function>(&GV)))->second.startswith("runtime_sig")) {
                RuntimeSig = &GV;
              }
              else if ((FuncAnnotations.find(cast<Function>(&GV)))->second.startswith("run_adj_sig")) {
                RetSig = &GV;
              }
            }
          } 
        #endif

        initializeBlocksSignatures(Md, RandomNumberBBs, SubRanPrevVals);

        for (Function &Fn : Md) {
          if (Fn.getBasicBlockList().size() != 0 && !(*FuncAnnotations.find(&Fn)).second.startswith("exclude")) {
            #if (LOG_COMPILED_FUNCS == 1)
              CompiledFuncs.insert(&Fn);
            #endif
            int currSig = RandomNumberBBs.find(&Fn.front())->second;
            #if (INTRA_FUNCTION_CFC == 0)
              IRBuilder<> B(&*(Fn.front().getFirstInsertionPt()));
              // initialize the runtime signature for the first basic block of the function
              Value *RuntimeSig = B.CreateAlloca(IntType);
              Value *RetSig = B.CreateAlloca(IntType);
              B.CreateStore(llvm::ConstantInt::get(IntType, currSig), RuntimeSig);
              B.CreateStore(llvm::ConstantInt::get(IntType, RandomNumberBBs.size() + currSig), RetSig);
            #elif (INTRA_FUNCTION_CFC == 1)
              int subCurrSig = SubRanPrevVals.find(&Fn.front())->second;
              // add instructions for initializing the runtime signatures in case they have not been initialized
              
              // put this computation inside a basic block at the beginning of the function
              BasicBlock *FrontBB = &Fn.front();
              BasicBlock *NewBB = BasicBlock::Create(Fn.getContext(), "RASM_prequel_BB", &Fn, FrontBB);
              IRBuilder<> B(NewBB);
              
              // load the runtime signatures
              Value* RuntimeSigInstr = B.CreateLoad(IntType, RuntimeSig);
              Value* RetSigInstr = B.CreateLoad(IntType, RetSig);

              // compare them with their initialization value INIT_SIGNATURE
              Value* Cond1 = B.CreateCmp(llvm::CmpInst::ICMP_EQ, RuntimeSigInstr, RetSigInstr);
              Value* Cond2 = B.CreateCmp(llvm::CmpInst::ICMP_EQ, RuntimeSigInstr, llvm::ConstantInt::get(IntType, INIT_SIGNATURE));
              Value* CondAnd = B.CreateAnd(Cond1, Cond2);

              // if they contain the initialization values, update them using sig and num_bbs+sig
              Value* NewRuntimeSig = B.CreateSelect(CondAnd, llvm::ConstantInt::get(IntType, currSig + subCurrSig), RuntimeSigInstr);
              Value* NewRetSig = B.CreateSelect(CondAnd, llvm::ConstantInt::get(IntType, RandomNumberBBs.size() + currSig), RetSigInstr);
              B.CreateStore(NewRuntimeSig, RuntimeSig);
              B.CreateStore(NewRetSig, RetSig);

              // add the branch to the previous frontBB
              B.CreateBr(FrontBB);
            #endif
            // create the ErrBB
            BasicBlock *ErrBB = BasicBlock::Create(Fn.getContext(), "ErrBB", &Fn);
            IRBuilder<> ErrB(ErrBB);
            auto CalleeF = ErrBB->getModule()->getOrInsertFunction(
                "SigMismatch_Handler", FunctionType::getVoidTy(Md.getContext()));
            ErrB.CreateCall(CalleeF)->setDebugLoc(ErrB.getCurrentDebugLocation());
            ErrB.CreateUnreachable();

            for (auto &Elem : RandomNumberBBs) {
              BasicBlock *BB = Elem.first;
              if (BB->getParent() == &Fn) {
                  createCFGVerificationBB(*BB, RandomNumberBBs, SubRanPrevVals, *RuntimeSig, *RetSig, *ErrBB);
              }
            }
          }
        }

        #if (LOG_COMPILED_FUNCS == 1)
          persistCompiledFunctions();
        #endif

        return true;
    }
};
} // namespace

char RASM::ID = 0;
static RegisterPass<RASM> X("rasm_verify", "CFG Verification Pass based on RASM");