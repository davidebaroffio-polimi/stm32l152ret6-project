#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/Metadata.h"
#include "llvm/Support/Debug.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include <map>
#include <list>
#include <unordered_set>
#include <queue>
#include <iostream>
#include <fstream>
using namespace llvm;

#define DEBUG_TYPE "eddi_verification"

namespace {
struct EDDIVerification : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  EDDIVerification() : ModulePass(ID) { }

  private:

    static bool IsNotAPHINode (Use &U){return !isa<PHINode>(U.getUser());}
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
                      //errs() << "Annotation found: " << AS << "\n";
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
     * @param I is the operand that we want to check whether is used by store
     * @param Use is the instruction that has I as operand
    */
    int is_used_by_store(Instruction &I, Instruction &Use) {
      BasicBlock *BB = I.getParent();
      /* get I users and check whether the BB of I is in the successors of the user */
      for (User *U : I.users()) {
        if (isa<StoreInst>(U) && U != &Use) {
          Instruction *U_st = cast<StoreInst>(U);
          // find BB in U_st successors
          std::unordered_set<BasicBlock *> reachable;
          std::queue<BasicBlock *> worklist;
          worklist.push(U_st->getParent());
          while (!worklist.empty()) {
            BasicBlock *front = worklist.front();
            if (front == BB) return 1;
            worklist.pop();
            for (BasicBlock *succ : successors(front)) {
              if (reachable.count(succ) == 0) {
                /// We need the check here to ensure that we don't run 
                /// infinitely if the CFG has a loop in it
                /// i.e. the BB reaches itself directly or indirectly
                worklist.push(succ);
                reachable.insert(succ);
              }
            }
          }
        }
      }
      return 0;
    }

    void persist_compiled_functions(Module &Md, std::map<Function*, StringRef> &FuncAnnotations) {
      std::ofstream file;
      //llvm::raw_fd_ostream file("compiled_functions.csv", std::error_code(), llvm::sys::fs::OF_Append); // CHECK IF THIS WORK
      file.open("compiled_eddi_functions.csv");
      file << "fn_name\n";
      for (Function &Fn : Md) {
        if (!Fn.isDeclarationForLinker() && !(*FuncAnnotations.find(&Fn)).second.startswith("exclude")) {
          file << Fn.getName().str() << "\n";
        }
      }
      file.close();
    }

    void duplicateInstruction(Instruction &I, std::map<Instruction *, Instruction *> &DuplicatedInstructionMap, BasicBlock &ErrBB) {
      // if the instruction is an alloca instruction we need to duplicate it
      if (isa<AllocaInst>(I)) {
        // Do nothing lol
        LLVM_DEBUG(dbgs() << "Duplicating instruction: " << I << "\n");
        Instruction *IClone = I.clone();
        IClone->insertAfter(&I);
        DuplicatedInstructionMap.insert(std::pair<Instruction *, Instruction *>(&I, IClone));
      }
      // if the instruction is a binary/unary instruction we need to duplicate it checking for its operands
      else if (isa<BinaryOperator, UnaryInstruction, LoadInst, GetElementPtrInst, CmpInst, PHINode>(I)) {
        LLVM_DEBUG(dbgs() << "Duplicating instruction: " << I << "\n");
        Instruction *IClone = I.clone();
        IClone->insertAfter(&I);
        DuplicatedInstructionMap.insert(std::pair<Instruction *, Instruction *>(&I, IClone));
        int J = 0;
        // iterate over the operands and switch them with their duplicates in the duplicated instructions
        for (Value *V : I.operand_values()) {
          LLVM_DEBUG(dbgs() << "Found operand: " << V << "\n\tisa<Instruction>: " << isa<Instruction>(V) << "\n");
          if (isa<Instruction>(V)) { // if V is coming from an instruction we need to duplicate it
            Instruction *Operand = cast<Instruction>(V);
            // if the operand has not been duplicated we need to duplicate it
            if (!isValueDuplicated(DuplicatedInstructionMap, *Operand)) {
              duplicateInstruction(*Operand, DuplicatedInstructionMap, ErrBB);
            }
            auto Duplicate = DuplicatedInstructionMap.find(Operand);
            if (Duplicate != DuplicatedInstructionMap.end())
              IClone->setOperand(J, Duplicate->second); // set the J-th operand with the duplicate value
          }
          J++;
        }
      }
      // if the value is a store instruction we need to duplicate its operands (if not duplicated already) and add consistency checks
      else if (isa<StoreInst>(I)) {
        LLVM_DEBUG(dbgs() << "Working on store instruction: " << I << "\n");
        I.getParent()->splitBasicBlockBefore(&I);
        Instruction *Operand = cast<Instruction>(I.getOperand(0));
        auto Duplicate = DuplicatedInstructionMap.find(Operand);
        // if the operand has not been duplicated we need to duplicate it
        if (!isValueDuplicated(DuplicatedInstructionMap, *Operand)) {
          duplicateInstruction(*Operand, DuplicatedInstructionMap, ErrBB);
          Duplicate = DuplicatedInstructionMap.find(Operand);
        }
        // if the operand has been duplicated we add the consistency check
        if (Duplicate != DuplicatedInstructionMap.end()) {
          Instruction *Original = Duplicate->first;
          Instruction *Copy = Duplicate->second;

          BasicBlock *VerificationBB = BasicBlock::Create(I.getContext(), "VerificationBB", I.getParent()->getParent(), I.getParent());
          //I.getParent()->replaceAllUsesWith(VerificationBB); // put all outgoing branches from the original branch to the clone
          I.getParent()->replaceUsesWithIf(VerificationBB, IsNotAPHINode);
          IRBuilder<> B(VerificationBB);

          // check whether the duplicated instruction is a pointer and eventually add the compare between their pointed value
          if (Original->getType()->isPointerTy()) {
            int isUsedByStore = 0;
            for (User *U : Original->users()) {
              if (isa<StoreInst>(U) && U != Operand) {
                isUsedByStore = 1;
                break;
              }
            }
            if (is_used_by_store(*Operand, *Original)) {
              Original = B.CreateLoad(Original->getType(), Original);
              Copy = B.CreateLoad(Copy->getType(), Copy);
              Value *Cond = B.CreateCmp(llvm::CmpInst::ICMP_EQ, Original, Copy);
              B.CreateCondBr(Cond, I.getParent(), &ErrBB);
            }
            else {
              B.CreateBr(I.getParent());
            }
/* 
            IRBuilder<> B1(I.getParent());
            B1.SetInsertPoint(I.getNextNonDebugInstruction());
            auto *TmpLoad = B1.CreateLoad(Original->getType(), Original);
            auto *TmpStore = B1.CreateStore(TmpLoad, Copy); */
            //DuplicatedInstructionMap.insert(std::pair<Instruction *, Instruction *>(TmpLoad, TmpStore));
          }
          else {
            Value *Cond = B.CreateCmp(llvm::CmpInst::ICMP_EQ, Original, Copy);
            B.CreateCondBr(Cond, I.getParent(), &ErrBB);
          }
        }
        // duplicate the store
        LLVM_DEBUG(dbgs() << "Duplicating instruction: " << I << "\n");
        Instruction *IClone = I.clone();
        IClone->insertAfter(&I);
        DuplicatedInstructionMap.insert(std::pair<Instruction *, Instruction *>(&I, IClone));
        // get the operand's duplicate, if they exist
        int J = 0;
        for (auto Op : I.operand_values()) {
          if (isa<Instruction>(Op)) {
            Duplicate = DuplicatedInstructionMap.find(cast<Instruction>(Op));
            if (Duplicate != DuplicatedInstructionMap.end()) {
              IClone->setOperand(J, Duplicate->second);
            }
          }
          J++;
        }
        // it may happen that I duplicate a store but don't change its operands, if that happens I just remove the duplicate
        if (IClone->isIdenticalTo(&I)) {
          IClone->eraseFromParent();
          DuplicatedInstructionMap.erase(DuplicatedInstructionMap.find(&I));
        }
      }
      else if(isa<BranchInst, SwitchInst, ReturnInst, CallBase>(I)) {
        I.getParent()->splitBasicBlockBefore(&I);
        // iterate over the operands and switch them with their duplicates in the duplicated instructions
        for (Value *V : I.operand_values()) {
          LLVM_DEBUG(dbgs() << "Found operand: " << V << "\n\tisa<Instruction>: " << isa<Instruction>(V) << "\n");
          if (isa<Instruction>(V)) { // if V is coming from an instruction we need to duplicate it
            Instruction *Operand = cast<Instruction>(V);
            auto Duplicate = DuplicatedInstructionMap.find(Operand);
            // if the operand has not been duplicated we need to duplicate it
            if (!isValueDuplicated(DuplicatedInstructionMap, *Operand)) {
              duplicateInstruction(*Operand, DuplicatedInstructionMap, ErrBB);
              Duplicate = DuplicatedInstructionMap.find(Operand);
            }
            // if the operand has been duplicated we add the consistency check
            if (Duplicate != DuplicatedInstructionMap.end()) {
              Instruction *Original = Duplicate->first;
              Instruction *Copy = Duplicate->second;

              // check whether the duplicated instruction is a pointer and eventually add the compare between their pointed value
              if (Original->getType()->isPointerTy()) {
                int isUsedByStore = 0;
                for (User *U : Original->users()) {
                  if (isa<StoreInst>(U) && U != V) {
                    isUsedByStore = 1;
                    break;
                  }
                }
                if (is_used_by_store(*Operand, *Original)) {
                  BasicBlock *VerificationBB = BasicBlock::Create(I.getContext(), "VerificationBB", I.getParent()->getParent(), I.getParent());
                  I.getParent()->replaceUsesWithIf(VerificationBB, IsNotAPHINode);
                  IRBuilder<> B(VerificationBB);
                  auto *LOriginal = B.CreateLoad(Original->getType(), Original);
                  auto *LCopy = B.CreateLoad(Copy->getType(), Copy);
                  Value *Cond = B.CreateCmp(llvm::CmpInst::ICMP_EQ, LOriginal, LCopy);
                  B.CreateCondBr(Cond, I.getParent(), &ErrBB);
                }
                if (isa<CallBase>(I)) { // add instructions at the end to account for function modifications
                  IRBuilder<> B1(I.getParent());
                  B1.SetInsertPoint(I.getNextNode());
                  Instruction *TmpLoad = B1.CreateLoad(Original->getType(), Original);
                  Instruction *TmpStore = B1.CreateStore(TmpLoad, Copy);
                  DuplicatedInstructionMap.insert(std::pair<Instruction *, Instruction *>(TmpLoad, TmpLoad));
                  DuplicatedInstructionMap.insert(std::pair<Instruction *, Instruction *>(TmpStore, TmpStore));
                }
              }
              else {
                BasicBlock *VerificationBB = BasicBlock::Create(I.getContext(), "VerificationBB", I.getParent()->getParent(), I.getParent());
                I.getParent()->replaceUsesWithIf(VerificationBB, IsNotAPHINode);
                IRBuilder<> B(VerificationBB);
                Value *Cond = B.CreateCmp(llvm::CmpInst::ICMP_EQ, Original, Copy);
                B.CreateCondBr(Cond, I.getParent(), &ErrBB);
              }
            }
          }
        }
      }
    }

    bool isValueDuplicated(std::map<Instruction *, Instruction *> &DuplicatedInstructionMap, Instruction &V) {
      for (auto Elem : DuplicatedInstructionMap) {
        if (Elem.first == &V || Elem.second == &V) {
          return true;
        }
      }
      return false;
    }

  public:
    /**
     * I have to duplicate all instructions except function calls and branches
     * @param Md
     * @return
     */
    bool runOnModule(Module &Md) override {
      std::map<Function*, StringRef> FuncAnnotations;
      getFuncAnnotations(Md, FuncAnnotations);

      for (Function &Fn : Md) {
        if (!Fn.isDeclarationForLinker() && !(*FuncAnnotations.find(&Fn)).second.startswith("exclude")) {
        //if (!Fn.isDeclarationForLinker() && ((*FuncAnnotations.find(&Fn)).second.startswith("include") || (*FuncAnnotations.find(&Fn)).second.startswith("task"))) {
          LLVM_DEBUG(dbgs() << Fn.getName() << "\n");
          std::map<Instruction *, Instruction *>
              DuplicatedInstructionMap; // is a map containing the instructions
                                        // and their duplicates
          BasicBlock *ErrBB = BasicBlock::Create(Fn.getContext(), "ErrBB", &Fn);
          for (BasicBlock &BB : Fn) {
            for (Instruction &I : BB) {
              if (!isValueDuplicated(DuplicatedInstructionMap, I)) {
                duplicateInstruction(I, DuplicatedInstructionMap, *ErrBB);
              }
            }
          }
          IRBuilder<> ErrB(ErrBB);
          auto CalleeF = ErrBB->getModule()->getOrInsertFunction(
              "DataCorruption_Handler", FunctionType::getVoidTy(Md.getContext()));
          ErrB.CreateCall(CalleeF)->setDebugLoc(ErrB.getCurrentDebugLocation());
          ErrB.CreateBr(ErrBB);
        }
        if (Fn.getName().equals("TIM_TI1_SetConfig")) {
          errs() << Fn;
        }
      }
      //errs() << Md;

      persist_compiled_functions(Md, FuncAnnotations);
      return true;
    }
};
} // namespace

char EDDIVerification::ID = 0;
static RegisterPass<EDDIVerification> X("eddi_verify", "LLVM implementation of EDDI");