/**
 * ************************************************************************************************
 * @brief  LLVM pass implementing globals duplication for EDDI (see EDDI.cpp).
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
#include <unordered_set>
#include <queue>
#include <iostream>
#include <fstream>
using namespace llvm;

#define DEBUG_TYPE "eddi_verification"

namespace {
struct DuplicateGlobals : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  DuplicateGlobals() : ModulePass(ID) { }

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
   * Reads the file `Filename` and populates the set with the entries of the file.
   * They represent the names of the functions for which we don't want to perform the duplication
  */
  void getFunctionsToNotModify(std::string Filename, std::set<std::string> &FunctionsToNotModify) {
    std::string line;
    std::ifstream file;
    file.open(Filename);
    if (file.is_open()) {
      while ( getline (file,line) ) {
        FunctionsToNotModify.insert(line);
      }
      file.close();
    }
  }

  public:
    /**
     * @param Md
     * @return
     */
    bool runOnModule(Module &Md) override {

      // we find the functions not to modify between the ones we already compiled with EDDI
      std::set<std::string> FunctionsToNotModify;
      getFunctionsToNotModify("compiled_eddi_functions.csv", FunctionsToNotModify);
      
      for (GlobalVariable &GV : Md.globals()) {
        // we don't care if the global is constant as it should not change at runtime
        // if the global is a struct or an array we cannot just duplicate the stores
        if (! (GV.getType()->isFunctionTy() || GV.isConstant() || GV.getValueType()->isStructTy() || GV.getValueType()->isArrayTy() || GV.getValueType()->isOpaquePointerTy())
            && ! GV.getName().endswith("_dup")) {
          
          // see if the global variable has already been cloned
          GlobalVariable *GVCopy = Md.getGlobalVariable((GV.getName() + "_dup").str(), true);
          if (GVCopy == NULL) { // if the duplicate does not exist
            Constant *Initializer = NULL;
            if (GV.hasInitializer()) {
              Initializer = GV.getInitializer();
            }
            // get a copy of the global variable
            GVCopy = new GlobalVariable(
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
          }

          // clone all the stores performed on GV
          for (User *U : GV.users()) {
            // the user has to be a store of a excluded function writing the global 
            if (isa<StoreInst>(U) && 
                cast<StoreInst>(U)->getPointerOperand() == &GV && 
                FunctionsToNotModify.find(cast<Instruction>(U)->getParent()->getParent()->getName().str()) == FunctionsToNotModify.end()) {
              // duplicate the store!
              StoreInst *I = cast<StoreInst>(U);
              StoreInst *IClone = cast<StoreInst>(I->clone());
              IClone->insertAfter(I);

              // change the operand
              IClone->setOperand(IClone->getPointerOperandIndex(), GVCopy);
            }
          }
        }
      }
      
      return true;
    }
};
} // namespace

char DuplicateGlobals::ID = 0;
static RegisterPass<DuplicateGlobals> X("duplicate_globals", "Duplicate Global variables");