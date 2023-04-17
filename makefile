INC=		-ICore/Inc \
			-IDrivers/CMSIS/Device/ST/STM32L1xx/Include \
			-IDrivers/CMSIS/Include \
			-IDrivers/STM32L1xx_HAL_Driver/Inc \
			-IFreeRTOS/Source/include \
			-IFreeRTOS/Source/portable/GCC/ARM_CM3

CLANG= 		Tools/LLVMEmbeddedToolchainForArm-15.0.2-Linux-x86_64/bin/clang
LLVMLINK= 	Tools/llvm/llvm-link
OPT= 		Tools/llvm/opt
OPT_PARAMS= --enable-new-pm=0 -S -load Tools/llvm/SIHFT.so
CONFG=	 	Tools/LLVMEmbeddedToolchainForArm-15.0.2-Linux-x86_64/bin/armv7m_soft_nofp.cfg
LD= 		-T"Drivers/STM32L152RETX_FLASH.ld"
STARTUP= 	Core/Startup/startup_stm32l152retx.s

all_nopass:
	$(CLANG) --config $(CONFG) -mcpu=cortex-m3 -DUSE_HAL_DRIVER -DSTM32L152xE -std=gnu11 `find Core Drivers FreeRTOS -type f -iname *.c` $(STARTUP) -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage $(INC) $(LD) --specs=nosys.specs -Wl,-Map="prova-new.map" -Wl,--gc-sections -static --specs=nano.specs -mfloat-abi=soft -mthumb -Wl,--start-group -lc -lm -Wl,--end-group -o out_nopass.elf

	@echo 'Finished building target: out_nopass.elf'
	@echo ' '

all_cfcss: 
	$(CLANG) --config $(CONFG) -mcpu=cortex-m3 -DUSE_HAL_DRIVER -DSTM32L152xE -std=gnu11 `find Core/Src -type f -iname *.c` `ls FreeRTOS/Source/*.c` -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage $(INC) --specs=nosys.specs -static --specs=nano.specs -mfloat-abi=soft -mthumb -emit-llvm -S -Xclang -disable-O0-optnone

	$(LLVMLINK) -S `find . -type f -iname "*.ll" -print` -o out.ll
	$(OPT) -strip-debug out.ll -o out.ll
	$(OPT) $(OPT_PARAMS) -func_ret_to_ref out.ll -o out.ll
	$(OPT) $(OPT_PARAMS) -eddi_verify out.ll -o out.ll
	$(OPT) -passes=simplifycfg out.ll -o out.ll -S
	$(OPT) $(OPT_PARAMS) -cfcss_verify out.ll -o out.ll 

	mv out.ll out
	rm *.ll
	mv out out.ll
	$(CLANG) --config $(CONFG) -mcpu=cortex-m3 -DUSE_HAL_DRIVER -DSTM32L152xE -std=gnu11 `find Drivers -type f -iname *.c` `find FreeRTOS/Source/portable -type f -iname *.c` out.ll -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage $(INC) --specs=nosys.specs -static --specs=nano.specs -mfloat-abi=soft -mthumb -emit-llvm -S -Xclang -disable-O0-optnone
	$(LLVMLINK) -S `find . -type f -iname "*.ll" -print` -o out.ll
	$(OPT) $(OPT_PARAMS) -duplicate_globals out.ll -o out.ll

	$(CLANG) --config $(CONFG) -mcpu=cortex-m3 -DUSE_HAL_DRIVER -DSTM32L152xE -std=gnu11 out.ll $(STARTUP) -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage $(INC) $(LD) --specs=nosys.specs -Wl,-Map="prova-new.map" -Wl,--gc-sections -static --specs=nano.specs -mfloat-abi=soft -mthumb -Wl,--start-group -lc -lm -Wl,--end-group -o out.elf

	#@rm *.ll

	@echo 'Finished building target: out.elf'
	@echo ' '

all_rasm:
	$(CLANG) --config $(CONFG) -mcpu=cortex-m3 -DUSE_HAL_DRIVER -DSTM32L152xE -std=gnu11 `find Core/Src -type f -iname *.c` `ls FreeRTOS/Source/*.c` -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage $(INC) --specs=nosys.specs -static --specs=nano.specs -mfloat-abi=soft -mthumb -emit-llvm -S -Xclang -disable-O0-optnone

	$(LLVMLINK) -S `find . -type f -iname "*.ll" -print` -o out.ll
	$(OPT) -lowerswitch out.ll -o out.ll
	$(OPT) -strip-debug out.ll -o out.ll
	$(OPT) $(OPT_PARAMS) -func_ret_to_ref out.ll -o out.ll
	$(OPT) $(OPT_PARAMS) -eddi_verify out.ll -o out.ll
	$(OPT) -passes=simplifycfg out.ll -o out.ll -S
	$(OPT) $(OPT_PARAMS) -rasm_verify out.ll -o out.ll 

	mv out.ll out
	rm *.ll
	mv out out.ll
	$(CLANG) --config $(CONFG) -mcpu=cortex-m3 -DUSE_HAL_DRIVER -DSTM32L152xE -std=gnu11 `find Drivers -type f -iname *.c` `find FreeRTOS/Source/portable -type f -iname *.c` out.ll -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage $(INC) --specs=nosys.specs -static --specs=nano.specs -mfloat-abi=soft -mthumb -emit-llvm -S -Xclang -disable-O0-optnone
	$(LLVMLINK) -S `find . -type f -iname "*.ll" -print` -o out.ll
	$(OPT) $(OPT_PARAMS) -duplicate_globals out.ll -o out.ll

	$(CLANG) --config $(CONFG) -mcpu=cortex-m3 -DUSE_HAL_DRIVER -DSTM32L152xE -std=gnu11 out.ll $(STARTUP) -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage $(INC) $(LD) --specs=nosys.specs -Wl,-Map="prova-new.map" -Wl,--gc-sections -static --specs=nano.specs -mfloat-abi=soft -mthumb -Wl,--start-group -lc -lm -Wl,--end-group -o out.elf

	#@rm *.ll

	@echo 'Finished building target: out.elf'
	@echo ' '

only_out:
	$(CLANG) --config $(CONFG) -mcpu=cortex-m3 -DUSE_HAL_DRIVER -DSTM32L152xE -std=gnu11 `find Drivers -type f -iname *.c` `find FreeRTOS/Source/portable -type f -iname *.c` out.ll $(STARTUP) -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage $(INC) $(LD) --specs=nosys.specs -Wl,-Map="prova-new.map" -Wl,--gc-sections -static --specs=nano.specs -mfloat-abi=soft -mthumb -Wl,--start-group -lc -lm -Wl,--end-group -o out.elf

	#@rm *.ll

	@echo 'Finished building target: out.elf'
	@echo ' '

clean: 
	@rm *.ll
