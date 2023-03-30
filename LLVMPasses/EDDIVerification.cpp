#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/Metadata.h"
#include "llvm/Support/Debug.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/Cloning.h"
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

    /**
     * Clones instruction `I` and adds the pair <I, IClone> to DuplicatedInstructionMap
    */
    Instruction* cloneInstr(Instruction &I, std::map<Value *, Value *> &DuplicatedInstructionMap) {
      Instruction *IClone = I.clone();
      IClone->insertAfter(&I);
      DuplicatedInstructionMap.insert(std::pair<Instruction *, Instruction *>(&I, IClone));
      return IClone;
    }

    /**
     * Takes instruction I and duplicates its operands. Then substitutes each duplicated operand in the duplicated
     * instruction IClone.
     * 
     * @param DuplicatedInstructionMap is the map of duplicated instructions, needed for the recursive duplicateInstruction call
     * @param ErrBB is the error basic block to jump to in case of error needed for the recursive duplicateInstruction call 
    */
    void duplicateOperands (Instruction &I, std::map<Value *, Value *> &DuplicatedInstructionMap, BasicBlock &ErrBB) {
      Instruction *IClone = NULL;
      // see if I has a clone
      if (DuplicatedInstructionMap.find(&I) != DuplicatedInstructionMap.end()) {
        Value *VClone = DuplicatedInstructionMap.find(&I)->second;
        if (isa<Instruction>(VClone)) {
          IClone = cast<Instruction>(VClone);
        }
      }

      int J = 0;
      // iterate over the operands and switch them with their duplicates in the duplicated instructions
      for (Value *V : I.operand_values()) {
        LLVM_DEBUG(dbgs() << "Found operand: " << V << "\n\tisa<Instruction>: " << isa<Instruction>(V) << "\n");


        // if the operand has not been duplicated we need to duplicate it

        if (isa<Instruction>(V)) {
          Instruction *Operand = cast<Instruction>(V);
          if(!isValueDuplicated(DuplicatedInstructionMap, *Operand))
            duplicateInstruction(*Operand, DuplicatedInstructionMap, ErrBB);
        }

        if (IClone != NULL) {
          // use the duplicated instruction as operand of IClone
          auto Duplicate = DuplicatedInstructionMap.find(V);
          if (Duplicate != DuplicatedInstructionMap.end()) 
            IClone->setOperand(J, Duplicate->second); // set the J-th operand with the duplicate value
        }
        J++;
      }
    }

    Value* getPtrFinalValue(Value &V) {
      Value *res = NULL;

      if (V.getType()->isPointerTy()) {
        // find the store using V as ptr
        for (User *U : V.users()) {
          if (isa<StoreInst>(U)) {
            StoreInst *SI = cast<StoreInst>(U);
            if (SI->getPointerOperand() == &V) { // we found the store

              // if the store saves a pointer we work recursively to find the original value
              if (SI->getValueOperand()->getType()->isPointerTy()) {
                return getPtrFinalValue(*(SI->getValueOperand()));
              }
              else {
                return &V;
              }
            }
          }
        }
      }
      
      return res;
    }

    Value* comparePtrs(Value &V1, Value &V2, IRBuilder<> &B) {
      /**
       * synthax `store val, ptr`
       * 
       * There is the following case:
       * store a, b
       * store b, c
       * 
       * If I have c, I need to perform 2 loads: one load for finding b and one load for finding a
       * _b = load c
       * _a = load _b
      */

      Value *F1 = getPtrFinalValue(V1);
      Value *F2 = getPtrFinalValue(V2);

      if (F1 != NULL && F2 != NULL) {
        Instruction *L1 = B.CreateLoad(F1->getType(), F1);
        Instruction *L2 = B.CreateLoad(F2->getType(), F2);
        return B.CreateCmp(CmpInst::ICMP_EQ, L1, L2);
      }
      return NULL;
    }

    /**
     * Adds a consistency check on the instruction I
    */
    void addConsistencyChecks(Instruction &I, std::map<Value *, Value *> &DuplicatedInstructionMap, BasicBlock &ErrBB) {
      std::vector<Value*> CmpInstructions;
      
      // split and add the verification BB
      I.getParent()->splitBasicBlockBefore(&I);
      BasicBlock *VerificationBB = BasicBlock::Create(I.getContext(), "VerificationBB", I.getParent()->getParent(), I.getParent());
      I.getParent()->replaceUsesWithIf(VerificationBB, IsNotAPHINode);
      IRBuilder<> B(VerificationBB);

      int num_NotUsedByStore = 0;
      
      // add compare for each operand
      for (Value *V : I.operand_values()) {
        if (isa<Instruction>(V)) { 

          // get the duplicate of the operand
          Instruction *Operand = cast<Instruction>(V);
          if (Operand->getType()->isPointerTy() && !is_used_by_store(*Operand, I)) {
            num_NotUsedByStore++;
            continue;
          }
          auto Duplicate = DuplicatedInstructionMap.find(Operand);

          // if the duplicate exists we perform a compare
          if (Duplicate != DuplicatedInstructionMap.end()) {
            Value *Original = Duplicate->first;
            Value *Copy = Duplicate->second;

            // if the operand is a pointer we try to get a compare on pointers
            if (Original->getType()->isPointerTy()) {
              Value *CmpInstr = comparePtrs(*Original, *Copy, B);
              if (CmpInstr != NULL) {
                CmpInstructions.push_back(CmpInstr);
              }
            }
            // if the operand is an array we have to compare all its elements
            else if (Original->getType()->isArrayTy()) {
              
              int arraysize = Original->getType()->getArrayNumElements();

              int addressSpace;
              if (isa<AllocaInst>(Original)) {
                addressSpace = cast<AllocaInst>(Original)->getAddressSpace();
              }
              else if (isa<LoadInst>(Original)) {
                addressSpace = cast<AllocaInst>(cast<LoadInst>(Original)->getPointerOperand())->getAddressSpace();
              }

              for (int i=0; i<arraysize; i++) {
                Value *OriginalElem = B.CreateExtractValue(Original, i);
                Value *CopyElem = B.CreateExtractValue(Copy, i);
                DuplicatedInstructionMap.insert(std::pair<Value*, Value*>(OriginalElem, CopyElem));
                
                if (OriginalElem->getType()->isPointerTy()) {
                  Value *CmpInstr = comparePtrs(*OriginalElem, *CopyElem, B);
                  if (CmpInstr != NULL) {
                    CmpInstructions.push_back(CmpInstr);
                  }
                }
                else {
                  CmpInstructions.push_back(B.CreateCmp(CmpInst::ICMP_EQ, OriginalElem, CopyElem));
                }
              }
            }
            // else we just add a compare
            else {
              CmpInstructions.push_back(B.CreateCmp(CmpInst::ICMP_EQ, Original, Copy));
            }
          }
        }
      }

      if(!CmpInstructions.empty()) {
        // all comparisons must be true
        Value *AndInstr = B.CreateAnd(CmpInstructions);
        B.CreateCondBr(AndInstr, I.getParent(), &ErrBB);
      }

      if(VerificationBB->size() == 0) {
        B.CreateBr(I.getParent());
      }
    }

    void fixFuncValsPassedByReference(Instruction &I, std::map<Value *, Value *> &DuplicatedInstructionMap, IRBuilder<> &B) {
      int numOps = I.getNumOperands();
      for (int i = 0; i<numOps; i++) {
        Value *V = I.getOperand(i);
        if (isa<Instruction>(V) && V->getType()->isPointerTy()) { 
          Instruction *Operand = cast<Instruction>(V);
          auto Duplicate = DuplicatedInstructionMap.find(Operand);
          if (Duplicate != DuplicatedInstructionMap.end()) {
            Value *Original = Duplicate->first;
            Value *Copy = Duplicate->second;

            Type *OriginalType = Original->getType();
            Instruction *TmpLoad = B.CreateLoad(OriginalType, Original);
            Instruction *TmpStore = B.CreateStore(TmpLoad, Copy);
            DuplicatedInstructionMap.insert(std::pair<Instruction *, Instruction *>(TmpLoad, TmpLoad));
            DuplicatedInstructionMap.insert(std::pair<Instruction *, Instruction *>(TmpStore, TmpStore));
          }
        }
      }
    }

    Function *getFunctionDuplicate(Function *Fn) {
      if (Fn == NULL || Fn->getName().endswith("_dup")){
        return Fn;
      }

      Function *FnDup = Fn->getParent()->getFunction(Fn->getName().str() + "_dup");
      if (FnDup == NULL) {
        FnDup = Fn->getParent()->getFunction(Fn->getName().str() + "_ret_dup");
      }
      return FnDup;
    }

    bool hasGlobalOperand (Instruction &I) {
      Value *Op = NULL;
      if (isa<StoreInst>(I)) {
        Op = cast<StoreInst>(I).getPointerOperand();
      }
      else if (isa<AtomicRMWInst>(I)) {
        Op = cast<AtomicRMWInst>(I).getPointerOperand();
      }
      else if (isa<AtomicCmpXchgInst>(I)) {
        Op = cast<AtomicCmpXchgInst>(I).getPointerOperand();
      }
      return Op != NULL && isa<GlobalVariable>(Op);
    }

    void duplicateGlobals (Module &Md, std::map<Value *, Value *> &DuplicatedInstructionMap) {
      for (GlobalVariable &GV : Md.globals()) {
        if (! (GV.getType()->isFunctionTy() || GV.isConstant() || GV.getValueType()->isStructTy() || GV.getValueType()->isArrayTy() || GV.getValueType()->isOpaquePointerTy())
            && ! GV.getName().endswith("_dup")) {
              
          Constant *Initializer = NULL;
          if (GV.hasInitializer()) {
            Initializer = GV.getInitializer();
          }
          // get a copy of the global variable
          GlobalVariable *GVCopy = new GlobalVariable(
                                        Md,
                                        GV.getValueType(), 
                                        false,
                                        GV.getLinkage(),
                                        Initializer,
                                        GV.getName()+"_dup",
                                        &GV,
                                        GV.getThreadLocalMode(),
                                        GV.getAddressSpace(),
                                        GV.isExternallyInitialized()
                                        );
          GVCopy->setAlignment(GV.getAlign());
          DuplicatedInstructionMap.insert(std::pair<Value*, Value*>(&GV, GVCopy));
        }
      }
    }

    /**
     * @returns 1 if the instruction has to be removed, 0 otherwise
    */
    int duplicateInstruction (Instruction &I, std::map<Value *, Value *> &DuplicatedInstructionMap, BasicBlock &ErrBB) {
      //errs() << I << "\n";
      if (isValueDuplicated(DuplicatedInstructionMap, I)) {
        return 0;
      }
      
      int res = 0;
      
      // if the instruction is an alloca instruction we need to duplicate it
      if (isa<AllocaInst>(I)) {
        cloneInstr(I, DuplicatedInstructionMap);
      }

      // if the instruction is a binary/unary instruction we need to duplicate it checking for its operands
      else if (isa<BinaryOperator, UnaryInstruction, LoadInst, GetElementPtrInst, CmpInst, PHINode, SelectInst>(I)) {
        // duplicate the instruction
        cloneInstr(I, DuplicatedInstructionMap);

        // duplicate the operands
        duplicateOperands(I, DuplicatedInstructionMap, ErrBB);
      }

      // if the instruction is a store instruction we need to duplicate it and its operands (if not duplicated already) and add consistency checks
      else if (isa<StoreInst, AtomicRMWInst, AtomicCmpXchgInst>(I)) {
        Instruction *IClone = cloneInstr(I, DuplicatedInstructionMap);

        // duplicate the operands
        duplicateOperands(I, DuplicatedInstructionMap, ErrBB);

        // add consistency checks on I
        addConsistencyChecks(I, DuplicatedInstructionMap, ErrBB);

        // it may happen that I duplicate a store but don't change its operands, if that happens I just remove the duplicate
        if (IClone->isIdenticalTo(&I)) {
          IClone->eraseFromParent();
          DuplicatedInstructionMap.erase(DuplicatedInstructionMap.find(&I));
        }
      }

      // if the instruction is a branch/switch/return instruction, we need to duplicate its operands (if not duplicated already) and add consistency checks
      else if(isa<BranchInst, SwitchInst, ReturnInst, IndirectBrInst>(I)) {
        // duplicate the operands
        duplicateOperands(I, DuplicatedInstructionMap, ErrBB);

        // add consistency checks on I
        addConsistencyChecks(I, DuplicatedInstructionMap, ErrBB);
      }

      else if(isa<CallBase>(I)) {
        CallBase *CInstr = cast<CallBase>(&I);
        if ((FuncAnnotations.find(CInstr->getCalledFunction()))->second.startswith("to_duplicate")) {
        //if ((*FuncAnnotations.find(&CInstr->getCalledFunction())).second.startswith("to_duplicate")) {  
          cloneInstr(*CInstr, DuplicatedInstructionMap);
          
          // duplicate the operands
          duplicateOperands(I, DuplicatedInstructionMap, ErrBB);

          // add consistency checks on I
          addConsistencyChecks(I, DuplicatedInstructionMap, ErrBB);
        }
        else {
          // duplicate the operands
          duplicateOperands(I, DuplicatedInstructionMap, ErrBB);

          // add consistency checks on I
          addConsistencyChecks(I, DuplicatedInstructionMap, ErrBB);

          // get the function with the duplicated signature, if it exists
          IRBuilder<> B(I.getNextNonDebugInstruction());
          Function *Fn = getFunctionDuplicate(CInstr->getCalledFunction());
          if (Fn != NULL) {
            std::vector<Value*> args;
            for (Value *Original : CInstr->args()) {
              Value *Copy = Original;
              // see if Original has a copy
              if (DuplicatedInstructionMap.find(cast<Instruction>(Original)) != DuplicatedInstructionMap.end()) {
                Copy = DuplicatedInstructionMap.find(cast<Instruction>(Original))->second;
              }
              args.push_back(Original);
              args.push_back(Copy);
            }
            
            if (Fn != CInstr->getCalledFunction()){
              Instruction *NewCInstr = B.CreateCall(Fn->getFunctionType(), Fn, args);
              res = 1;
              //fixFuncValsPassedByReference(*NewCInstr, DuplicatedInstructionMap, B);
              CInstr->replaceNonMetadataUsesWith(NewCInstr);
            }
          }
          else {
            fixFuncValsPassedByReference(*CInstr, DuplicatedInstructionMap, B);
          }
        }
      }
      return res;
    }

    bool isValueDuplicated(std::map<Value *, Value *> &DuplicatedInstructionMap, Instruction &V) {
      for (auto Elem : DuplicatedInstructionMap) {
        if (Elem.first == &V || Elem.second == &V) {
          return true;
        }
      }
      return false;
    }

    // TODO duplicate the arguments in a different way: (arg1, arg1_dup, arg2, arg2_dup) -> (arg1, arg2, arg1_dup, arg2_dup)
    Function *duplicateFnArgs(Function &Fn, Module &Md, std::map<Value *, Value *> &DuplicatedInstructionMap) {
      Type *RetType = Fn.getReturnType();
      FunctionType *FnType = Fn.getFunctionType();

      // create the param type list
      std::vector<Type*> paramTypeList;
      for (Type *ParamType : FnType->params()) {
          paramTypeList.push_back(ParamType);
          paramTypeList.push_back(ParamType); // two times
      }

      // update the function type adding the duplicated args
      FunctionType *NewFnType = FnType->get(RetType,              // returntype
                                          paramTypeList,          // params
                                          FnType->isVarArg());    // vararg
      
      // create the function and clone the old one
      Function *ClonedFunc = Fn.Create(NewFnType, Fn.getLinkage(), Fn.getName() + "_dup", Fn.getParent());
      ValueToValueMapTy Params;
      for (int i=0; i < Fn.arg_size(); i++) {
          Params[Fn.getArg(i)] = ClonedFunc->getArg(i*2);
      }
      SmallVector<ReturnInst*, 8> returns;
      CloneFunctionInto(ClonedFunc, &Fn, Params, CloneFunctionChangeType::GlobalChanges, returns);

      return ClonedFunc;
    }

  public:
    std::map<Function*, StringRef> FuncAnnotations;
    /**
     * I have to duplicate all instructions except function calls and branches
     * @param Md
     * @return
     */
    bool runOnModule(Module &Md) override {
      getFuncAnnotations(Md, FuncAnnotations);
      std::map<Value *, Value *>
              DuplicatedInstructionMap; // is a map containing the instructions
                                        // and their duplicates

      duplicateGlobals(Md, DuplicatedInstructionMap);

      // store the functions that are currently in the module
      std::list<Function*> FnList;
      std::set<Function*> DuplicatedFns;

      for (Function &Fn : Md) {
          if (!Fn.isDeclarationForLinker() && !(*FuncAnnotations.find(&Fn)).second.startswith("exclude")) {
            FnList.push_back(&Fn);
          }
      }

      for (Function *Fn : FnList) {
          Function *newFn = duplicateFnArgs(*Fn, Md, DuplicatedInstructionMap);
          DuplicatedFns.insert(newFn);
      }

      std::list<Instruction*> InstructionsToRemove;

      for (Function &Fn : Md) {
        if (!Fn.isDeclarationForLinker() && !(*FuncAnnotations.find(&Fn)).second.startswith("exclude")) {
          LLVM_DEBUG(dbgs() << Fn.getName() << "\n");
          BasicBlock *ErrBB = BasicBlock::Create(Fn.getContext(), "ErrBB", &Fn);

          // if the function is a duplicated one
          if (DuplicatedFns.find(&Fn) != DuplicatedFns.end()) {

            // store the function arguments and their duplicates
            for (int i=0; i < Fn.arg_size(); i=i+2) {
              Value *Arg = Fn.getArg(i);
              Value *ArgClone = Fn.getArg(i+1);
              DuplicatedInstructionMap.insert(std::pair<Value*, Value*>(Arg, ArgClone));
            }

            // duplicate the users of each argument
            for (int i=0; i < Fn.arg_size(); i=i+2) {
              Value *Arg = Fn.getArg(i);
              for (User *U : Arg->users()) {
                if (isa<Instruction>(U)) {
                  // duplicate the uses of each argument
                  duplicateInstruction(cast<Instruction>(*U), DuplicatedInstructionMap, *ErrBB);
                }
              }
            }
          }
      
          for (BasicBlock &BB : Fn) {
            for (Instruction &I : BB) {
              if (!isValueDuplicated(DuplicatedInstructionMap, I)) {
                int shouldDelete = duplicateInstruction(I, DuplicatedInstructionMap, *ErrBB);
                if (shouldDelete) {
                  InstructionsToRemove.push_back(&I);
                }
              }
            }
          }
          IRBuilder<> ErrB(ErrBB);
          auto CalleeF = ErrBB->getModule()->getOrInsertFunction(
              "DataCorruption_Handler", FunctionType::getVoidTy(Md.getContext()));
          ErrB.CreateCall(CalleeF)->setDebugLoc(ErrB.getCurrentDebugLocation());
          ErrB.CreateUnreachable();
        }
      }

      for (Instruction *I2rm : InstructionsToRemove) {
        I2rm->eraseFromParent();
      }
      
      return true;
    }
};
} // namespace

char EDDIVerification::ID = 0;
static RegisterPass<EDDIVerification> X("eddi_verify", "LLVM implementation of EDDI");