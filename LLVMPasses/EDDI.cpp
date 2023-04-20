/**
 * ************************************************************************************************
 * @brief  LLVM pass implementing Error Detection by Duplicate Instructions (EDDI).
 *         Original algorithm by Oh et Al. (DOI: 10.1109/24.994913)
 * 
 * @author Davide Baroffio, Politecnico di Milano, Italy (dav.baroffio@mail.polimi.it)
 * ************************************************************************************************
*/

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
#include <array>
#include <unordered_set>
#include <queue>
#include <iostream>
#include <fstream>
using namespace llvm;

#define DEBUG_TYPE "eddi_verification"

/**
 * - 0: EDDI (Add checks at every basic block)
 * - 1: FDSC (Add checks only at basic blocks with more than one predecessor)  
 */
#define SELECTIVE_CHECKING 0

namespace {
struct EDDI : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  EDDI() : ModulePass(ID) { }

  private:

    // Given a Use U, it returns true if the instruction is a PHI instruction
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
     * Determines whether a instruction &I is used by store instructions different than &Use
     * @param I is the operand that we want to check whether is used by store
     * @param Use is the instruction that has I as operand
    */
    int isUsedByStore(Instruction &I, Instruction &Use) {
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

    std::set<Function*> CompiledFuncs;
    // Inserts the names of the compiled functions into a csv file
    void persistCompiledFunctions() {
      std::ofstream file;
      file.open("compiled_eddi_functions.csv");
      file << "fn_name\n";
      for (Function *Fn : CompiledFuncs) {
        file << Fn->getName().str() << "\n";
      }
      file.close();
    }

    /**
     * Clones instruction `I` and adds the pair <I, IClone> to DuplicatedInstructionMap, 
     * inserting the clone right after the original.
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
        // It may happen that we have a GEP as inline operand of a instruction. The operands
        // of the GEP are not duplicated leading to errors, so we manually clone of the GEP 
        // for the clone of the original instruction.
        else if (isa<GEPOperator>(V) && isa<ConstantExpr>(V)) {
          if (IClone != NULL) {
            GEPOperator *GEPOperand = cast<GEPOperator>(IClone->getOperand(J));
            Value *PtrOperand = GEPOperand->getPointerOperand();
            // update the duplicate GEP operator using the duplicate of the pointer operand
            if (DuplicatedInstructionMap.find(PtrOperand) != DuplicatedInstructionMap.end()) {
              std::vector<Value*> indices;
              for (auto &Idx : GEPOperand->indices()) {
                indices.push_back(Idx);
              }
              Constant *CloneGEPOperand = cast<ConstantExpr>(GEPOperand)->getInBoundsGetElementPtr(GEPOperand->getSourceElementType(), cast<Constant>(DuplicatedInstructionMap.find(PtrOperand)->second), ArrayRef<Value*>(indices));
              IClone->setOperand(J, CloneGEPOperand);
            }
          }
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

    // recursively follow store instructions to find the pointer final value, 
    // if the value cannot be found (e.g. when the pointer is passed as function argument)
    // we return NULL.
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

    // Follows the pointers V1 and V2 using getPtrFinalValue() and adds a compare instruction
    // using the IRBuilder B.
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
      
      // add a comparison for each operand
      for (Value *V : I.operand_values()) {
        // we compare the operands if they are instructions
        if (isa<Instruction>(V)) { 
          // get the duplicate of the operand
          Instruction *Operand = cast<Instruction>(V);

          // If the operand is a pointer and is not used by any store, we skip the operand
          if (Operand->getType()->isPointerTy() && !isUsedByStore(*Operand, I)) {
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

      // if in the end we have a set of compare instructions, we check that all of them are true
      if(!CmpInstructions.empty()) {
        // all comparisons must be true
        Value *AndInstr = B.CreateAnd(CmpInstructions);
        B.CreateCondBr(AndInstr, I.getParent(), &ErrBB);
      }

      if(VerificationBB->size() == 0) {
        B.CreateBr(I.getParent());
      }
    }

    // Given an instruction, loads and stores the pointers passed to the instruction.
    // This is useful in the case I is a CallBase, since the function called might not
    // be in the compilation unit, and the function called may modify the content of the 
    // pointer passed as argument. 
    // This function has the objective of synchronize pointers after some non-duplicated
    // instruction execution.
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

    // Given Fn, it returns the version of the function with duplicated arguments, or the 
    // function Fn itself if it is already the version with duplicated arguments
    Function *getFunctionDuplicate(Function *Fn) {
      // If Fn ends with "_dup" we have already the duplicated function.
      // If Fn is NULL, it means that we don't have a duplicate
      if (Fn == NULL || Fn->getName().endswith("_dup")){
        return Fn;
      }

      // Otherwise, we try to get the "_dup" version or the "_ret_dup" version
      Function *FnDup = Fn->getParent()->getFunction(Fn->getName().str() + "_dup");
      if (FnDup == NULL) {
        FnDup = Fn->getParent()->getFunction(Fn->getName().str() + "_ret_dup");
      }
      return FnDup;
    }

    void duplicateGlobals (Module &Md, std::map<Value *, Value *> &DuplicatedInstructionMap) {
      for (GlobalVariable &GV : Md.globals()) {
        /**
         * The global variable is duplicated if all the following hold:
         * - It is not a function
         * - It is not constant (i.e. read only)
         * - It is not a struct
         * - Doesn't end with "_dup" (i.e. has already been duplicated)
         * - Has internal linkage and either:
         *        a) It is not an array
         *        b) It is an array but its elements are neither structs nor arrays
        */
       bool isFunction = GV.getType()->isFunctionTy();
       bool isConstant = GV.isConstant();
       bool isStruct = GV.getValueType()->isStructTy();
       bool isArray = GV.getValueType()->isArrayTy();
       bool isPointer = GV.getValueType()->isOpaquePointerTy();
       bool endsWithDup = GV.getName().endswith("_dup");
       bool hasInternalLinkage = GV.hasInternalLinkage();

        if (! (isFunction || isConstant || isStruct || endsWithDup) // is not function, constant, struct and does not end with _dup
            && ((hasInternalLinkage && (!isArray || (isArray && !cast<ArrayType>(GV.getValueType())->getArrayElementType()->isAggregateType() ))) // has internal linkage and is not an array, or is an array but the element type is not aggregate
                || !(isArray || isPointer)) // if it does not have internal linkage, it is not an array or a pointer
            ) {
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
          // Save the duplicated global so that the duplicate can be used as operand
          // of other duplicated instructions
          DuplicatedInstructionMap.insert(std::pair<Value*, Value*>(&GV, GVCopy));
        }
      }
    }

    /**
     * Performs a duplication of the instruction I. Performing the following operations
     * depending on the class of I:
     * - Clone the instruction;
     * - Duplicate the instruction operands;
     * - Add consistency checks on the operands (if I is a synchronization point).
     * @returns 1 if the cloned instruction has to be removed, 0 otherwise
    */
    int duplicateInstruction (Instruction &I, std::map<Value *, Value *> &DuplicatedInstructionMap, BasicBlock &ErrBB) {
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
        #if (SELECTIVE_CHECKING == 1)
        if (I.getParent()->hasNPredecessorsOrMore(2)) 
        #endif
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
        #if (SELECTIVE_CHECKING == 1)
        if (I.getParent()->hasNPredecessorsOrMore(2)) 
        #endif
          addConsistencyChecks(I, DuplicatedInstructionMap, ErrBB);
      }

      // if the istruction is a call, we duplicate the operands and add consistency checks
      else if(isa<CallBase>(I)) {
        CallBase *CInstr = cast<CallBase>(&I);
        // there are some instructions that can be annotated with "to_duplicate" in order to tell the pass
        // to duplicate the function call.
        if ((FuncAnnotations.find(CInstr->getCalledFunction()) != FuncAnnotations.end() && (*FuncAnnotations.find(CInstr->getCalledFunction())).second.startswith("to_duplicate"))) {
          // duplicate the instruction
          cloneInstr(*CInstr, DuplicatedInstructionMap);
          
          // duplicate the operands
          duplicateOperands(I, DuplicatedInstructionMap, ErrBB);

          // add consistency checks on I
          #if (SELECTIVE_CHECKING == 1)
          if (I.getParent()->hasNPredecessorsOrMore(2)) 
          #endif
            addConsistencyChecks(I, DuplicatedInstructionMap, ErrBB);
        }
        else {
          // duplicate the operands
          duplicateOperands(I, DuplicatedInstructionMap, ErrBB);

          // add consistency checks on I
          #if (SELECTIVE_CHECKING == 1)
          if (I.getParent()->hasNPredecessorsOrMore(2)) 
          #endif
            addConsistencyChecks(I, DuplicatedInstructionMap, ErrBB);

          // get the function with the duplicated signature, if it exists
          IRBuilder<> B(I.getNextNonDebugInstruction());
          Function *Fn = getFunctionDuplicate(CInstr->getCalledFunction());
          // if the _dup function exists, we substitute the call instruction with a call to the function with duplicated arguments
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

    /**
     * @returns True if the value V is present in the DuplicatedInstructionMap either as a key or as value
    */
    bool isValueDuplicated(std::map<Value *, Value *> &DuplicatedInstructionMap, Instruction &V) {
      for (auto Elem : DuplicatedInstructionMap) {
        if (Elem.first == &V || Elem.second == &V) {
          return true;
        }
      }
      return false;
    }

    // TODO (optimization) duplicate the arguments in a different way: (arg1, arg1_dup, arg2, arg2_dup) -> (arg1, arg2, arg1_dup, arg2_dup)
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

      // first store the instructions to compile in the current module
      for (Function &Fn : Md) {
        if (!Fn.getBasicBlockList().empty() && (FuncAnnotations.find(&Fn) == FuncAnnotations.end() || !(*FuncAnnotations.find(&Fn)).second.startswith("exclude"))) {
          FnList.push_back(&Fn);
        }
      }
      // then duplicate the function arguments using FnList populated earlier
      for (Function *Fn : FnList) {
          Function *newFn = duplicateFnArgs(*Fn, Md, DuplicatedInstructionMap);
          DuplicatedFns.insert(newFn);
      }

      // list of duplicated instructions to remove since they are equal to the original
      std::list<Instruction*> InstructionsToRemove;

      for (Function &Fn : Md) {
        if (!Fn.getBasicBlockList().empty() && (FuncAnnotations.find(&Fn) == FuncAnnotations.end() || !(*FuncAnnotations.find(&Fn)).second.startswith("exclude"))) {
          CompiledFuncs.insert(&Fn);
          BasicBlock *ErrBB = BasicBlock::Create(Fn.getContext(), "ErrBB", &Fn);
 
          // If the function is a duplicated one, we need to 
          // iterate over the function arguments and duplicate 
          // them in order to access them during the instruction 
          // duplication phase
          if (DuplicatedFns.find(&Fn) != DuplicatedFns.end()) {

            // save the function arguments and their duplicates
            for (int i=0; i < Fn.arg_size(); i=i+2) {
              Value *Arg = Fn.getArg(i);
              Value *ArgClone = Fn.getArg(i+1);
              DuplicatedInstructionMap.insert(std::pair<Value*, Value*>(Arg, ArgClone));
            }

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
      
          // Iterate over the basic blocks of the function duplicating the instructions
          for (BasicBlock &BB : Fn) {
            for (Instruction &I : BB) {
              if (!isValueDuplicated(DuplicatedInstructionMap, I)) {
                // perform the duplication
                int shouldDelete = duplicateInstruction(I, DuplicatedInstructionMap, *ErrBB);
                // the instruction duplicated may be equal to the original, so we return shouldDelete in order to drop the duplicates
                if (shouldDelete) {
                  InstructionsToRemove.push_back(&I);
                }
              }
            }
          }
          // insert the code for jumping to the error basic block in case of a mismatch
          IRBuilder<> ErrB(ErrBB);
          auto CalleeF = ErrBB->getModule()->getOrInsertFunction(
              "DataCorruption_Handler", FunctionType::getVoidTy(Md.getContext()));
          ErrB.CreateCall(CalleeF)->setDebugLoc(ErrB.getCurrentDebugLocation());
          ErrB.CreateUnreachable();
        }
      }

      // Drop the instructions that have been marked for removal earlier
      for (Instruction *I2rm : InstructionsToRemove) {
        I2rm->eraseFromParent();
      }

      persistCompiledFunctions();
      
      return true;
    }
};
} // namespace

char EDDI::ID = 0;
static RegisterPass<EDDI> X("eddi_verify", "LLVM implementation of EDDI");