INC=		-ICore/Inc \
			-IDrivers/CMSIS/Device/ST/STM32L1xx/Include \
			-IDrivers/CMSIS/Include \
			-IDrivers/STM32L1xx_HAL_Driver/Inc \
			-IFreeRTOS/Source/include \
			-IFreeRTOS/Source/portable/GCC/ARM_CM3

CLANG= 		/home/buoffio/Downloads/LLVMEmbeddedToolchainForArm-15.0.2-Linux-x86_64/bin/clang
LLVMLINK= 	/home/buoffio/Documents/cot/llvm-project-main/build/bin/llvm-link
OPT= 		/home/buoffio/Documents/cot/llvm-project-main/build/bin/opt
OPT_PARAMS= --enable-new-pm=0 -S -load ~/Documents/cot/llvm-project-main/build/lib/CFGVerification.so
CONFG=	 	/home/buoffio/Downloads/LLVMEmbeddedToolchainForArm-15.0.2-Linux-x86_64/bin/armv7m_soft_nofp.cfg
LD= 		-T"/home/buoffio/STM32CubeIDE/workspace_1.10.1/prova-new/STM32L152RETX_FLASH.ld"
STARTUP= 	Core/Startup/startup_stm32l152retx.s

all:
	$(CLANG) --config $(CONFG) -mcpu=cortex-m3 -DUSE_HAL_DRIVER -DSTM32L152xE -std=gnu11 `find . -type f -iname *.c -print` $(STARTUP) -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage $(INC) --specs=nosys.specs -static --specs=nano.specs -mfloat-abi=soft -mthumb -emit-llvm -S 
#-Xclang -disable-O0-optnone

	$(LLVMLINK) -S `find . -type f -iname "*.ll" -print` -o out.ll
	$(OPT) -S -strip-debug out.ll -o out.ll
	$(OPT) $(OPT_PARAMS) -S -eddi_verify out.ll -o out_new.ll

	$(CLANG) --config $(CONFG) -mcpu=cortex-m3 -DUSE_HAL_DRIVER -DSTM32L152xE -std=gnu11 out_new.ll $(STARTUP) -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage $(INC) $(LD) --specs=nosys.specs -Wl,-Map="prova-new.map" -Wl,--gc-sections -static --specs=nano.specs -mfloat-abi=soft -mthumb -Wl,--start-group -lc -lm -Wl,--end-group -o out.elf

	@echo 'Finished building target: out.elf'
	@echo ' '

all_new: 
#1st pass
	$(CLANG) --config $(CONFG) -mcpu=cortex-m3 -DUSE_HAL_DRIVER -DSTM32L152xE -std=gnu11 `ls Core/Src/*.c` `ls FreeRTOS/Source/*.c` -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage $(INC) --specs=nosys.specs -static --specs=nano.specs -mfloat-abi=soft -mthumb -emit-llvm -S -Xclang -disable-O0-optnone

	$(LLVMLINK) -S `find . -type f -iname "*.ll" -print` -o out.ll
	$(OPT) -strip-debug out.ll -o out.ll
	$(OPT) $(OPT_PARAMS) -eddi_verify out.ll -o out.ll
	$(OPT) -simplifycfg out.ll -o out.ll -S
	$(OPT) $(OPT_PARAMS) -verify_cfg out.ll -o out.ll 

	$(CLANG) --config $(CONFG) -mcpu=cortex-m3 -DUSE_HAL_DRIVER -DSTM32L152xE -std=gnu11 `find Drivers -type f -iname *.c` `find FreeRTOS/Source/portable -type f -iname *.c` out.ll $(STARTUP) -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage $(INC) $(LD) --specs=nosys.specs -Wl,-Map="prova-new.map" -Wl,--gc-sections -static --specs=nano.specs -mfloat-abi=soft -mthumb -Wl,--start-group -lc -lm -Wl,--end-group -o out.elf

	@echo 'Finished building target: out.elf'
	@echo ' '

clean: 
	@rm *.ll
