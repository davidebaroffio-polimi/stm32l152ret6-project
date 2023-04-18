/**
 * ************************************************************************************************
 * @brief  LLVM ModulePass that transforms the functions with a return value to void functions
 *         where a pointer is passed as parameter to store the return value.
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
using namespace llvm;


#define DEBUG_TYPE "func_ret_to_ref"


namespace {
struct FuncRetToRef : public ModulePass {
    static char ID; // Pass identification, replacement for typeid
    FuncRetToRef() : ModulePass(ID) { }

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
 * @param Fn the function for which we want to add the return value as a parameter
 * @param Md the module
 * 
 * @returns 
 * NULL if the function has VoidTy as return type. 
 * Else it returns a clone of the function with: 
 *  - void return type 
 *  - a ptr to the old return type as a function argument
*/
Function* updateFnSignature(Function &Fn, Module &Md) {
    Type *RetType = Fn.getReturnType();
    if (RetType->isVoidTy()) {
        return NULL;
    }
    FunctionType *FnType = Fn.getFunctionType();
    
    // create the param type list adding the return param type
    std::vector<Type*> paramTypeList;
    for (Type *ParamType : FnType->params()) {
        paramTypeList.push_back(ParamType);
    }

    paramTypeList.push_back(RetType->getPointerTo()); // we "return" a pointer to the return type

    // set the returntype to void
    FunctionType *NewFnType = FnType->get(Type::getVoidTy(Md.getContext()), // returntype
                                            paramTypeList,                    // params
                                            FnType->isVarArg());              // vararg
    
    // create the function and clone the old one
    Function *ClonedFunc = Fn.Create(NewFnType, Fn.getLinkage(), Fn.getName() + "_ret", Md);
    ValueToValueMapTy Params;
    for (int i=0; i < Fn.arg_size(); i++) {
        Params[Fn.getArg(i)] = ClonedFunc->getArg(i);
    }
    SmallVector<ReturnInst*, 8> returns;
    CloneFunctionInto(ClonedFunc, &Fn, Params, CloneFunctionChangeType::LocalChangesOnly, returns);

    // we may have a zeroext ret attribute and we remove it as we have no return
    if(ClonedFunc->hasRetAttribute(Attribute::ZExt)) {
        ClonedFunc->removeRetAttr(Attribute::ZExt);
    }

    //errs() << *ClonedFunc << "\n";
    updateRetInstructions(*ClonedFunc);

    return ClonedFunc;
}

/**
 * Substitutes all the return instructions of a function with void return instructions and
 * add store instructions of the return param
*/
void updateRetInstructions(Function &Fn) {
    for (BasicBlock &BB : Fn) {
        Instruction *I = BB.getTerminator();
        if (isa<ReturnInst>(I)) {
            // get the return value from the instruction
            Value *ReturnValue = cast<ReturnInst>(*I).getReturnValue();

            IRBuilder<> B(I);

            // Get the return pointer from the function signature (the last arg)
            Value *ReturnPtr = Fn.getArg(Fn.arg_size()-1); // the last argument is the return ptr

            // Store the returnvalue in the returnptr
            B.CreateStore(ReturnValue, ReturnPtr);

            // create a ret instruction
            B.CreateRetVoid();

            // delete the return instruction
            I->eraseFromParent();
        }
    }
}

/** 
 * Gets all the uses of the function and replaces them with the clone function
*/
void updateFunctionCalls(Function &Fn, Function &NewFn) {
    std::list<Instruction*> ListInstrToRemove;
    
    // for each place in which the function has been called, we replace it with the _ret version
    for (User *U : Fn.users()) {
        if (isa<CallBase>(U)) {
            CallBase *CInstr = cast<CallBase>(U); // this is the instruction that called the function
            
            // duplicate all the args of the original instruction and add a new arg for the ret value
            std::vector<Value*> args;
            for (Value *V : CInstr->args()) {
                args.push_back(V);
            }

            IRBuilder<> B(CInstr);
            
            // The function return value can be used immediately by a store instruction, 
            // so we try to get the pointer operand of the store instruction and use it as a return value
            int found = 0;
            for (User *UC : CInstr->users()) {
                // if the user is a store instruction and the stored value is the output of the call instr
                if (isa<StoreInst>(UC) && cast<StoreInst>(UC)->getValueOperand() == CInstr) {
                    StoreInst *SI = cast<StoreInst>(UC);

                    // get the pointer
                    Value *CandidateAlloca = SI->getPointerOperand();
                    if (isa<AllocaInst>(CandidateAlloca)) {
                        found = 1;
                        args.push_back(SI->getPointerOperand());
                         // remove the store from the basic block as the operation is performed in the called fun
                        SI->eraseFromParent();
                        
                        // do the call
                        B.CreateCall(NewFn.getFunctionType(), &NewFn, args);
            
                        break;
                    }
                }
            }

            // if the return is not used by a store but is used by other instructions,
            // we allocate the memory for return value in the caller function
            if (!found) {
                IRBuilder<> BInit(&(CInstr->getParent()->getParent()->front().front()));
                Instruction *TmpAlloca = BInit.CreateAlloca(CInstr->getType());
                args.push_back(TmpAlloca);
                // do the call
                B.CreateCall(NewFn.getFunctionType(), &NewFn, args);
                // use the load on the return value instead of the previous function output
                Instruction *TmpLoad = B.CreateLoad(CInstr->getType(), TmpAlloca);
                CInstr->replaceNonMetadataUsesWith(TmpLoad);
            }
            ListInstrToRemove.push_back(CInstr);
        }
    }

    // remove all the older call instructions
    for (Instruction *InstToRemove : ListInstrToRemove) {
        InstToRemove->eraseFromParent();
    }
}

public:
    bool runOnModule(Module &Md) override {
        std::map<Function*, StringRef> FuncAnnotations;
        getFuncAnnotations(Md, FuncAnnotations);

        // store the functions that are currently in the module
        std::list<Function*> FnList;

        for (Function &Fn : Md) {
            if (Fn.getBasicBlockList().size() != 0 && !(*FuncAnnotations.find(&Fn)).second.startswith("exclude")) {
                FnList.push_back(&Fn);
            }
        }

        for (Function *Fn : FnList) {
            Function *newFn = updateFnSignature(*Fn, Md);
            if (newFn != NULL) {
                updateFunctionCalls(*Fn, *newFn); 
            }
        }
        return 1;
    }
};
} // namespace

char FuncRetToRef::ID = 0;
static RegisterPass<FuncRetToRef> X("func_ret_to_ref", "Transform return values of a function into references in the function signature");