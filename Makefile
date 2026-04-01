ASPIS=/home/buoffio/Projects/ASPIS/aspis.sh
#CONF=/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project/Tools/LLVMEmbeddedToolchainForArm-15.0.2-Linux-x86_64/bin/config.cfg
LLVM_BIN=/home/buoffio/Projects/llvm-project-21.1.8.src/build/bin/
LLVM_BIN=/home/buoffio/Downloads/ATfE-21.1.1-Linux-x86_64/bin/
EXCLUDE_F=excluded_files.txt

INCLUDE_FLAGS=-ICore/Inc/ -IDrivers/STM32L1xx_HAL_Driver/Inc/ -IDrivers/CMSIS/Device/ST/STM32L1xx/Include/ -IFreeRTOS/Source/include/ -IFreeRTOS/Source/portable/GCC/ARM_CM3/ -IDrivers/CMSIS/Include/ -I/usr/lib/arm-none-eabi/include/

OTHER_FLAGS=-DSTM32L152xE --target=armv7m-none-eabi -mfpu=none -fno-rtti -TDrivers/STM32L152RETX_FLASH.ld -L/home/buoffio/Downloads/ATfE-21.1.1-Linux-x86_64/lib/clang-runtimes/arm-none-eabi/armv7m_soft_nofp_size/lib/ -lcrt0-semihost -lsemihost 

SCOPE?=0

out_all:
	#@for SCOPE in 1 2 3 4 5 6; do
	@for data_p in eddi fdsc seddi ; do \
		for cfg_p in rasm inter-rasm cfcss ; do \
			$(ASPIS) -DSCOPE=1 --llvm-bin $(LLVM_BIN) --exclude $(EXCLUDE_F) --asmfiles asmfiles.txt --$${cfg_p} --$${data_p} -o out_$${data_p}_$${cfg_p}_$${SCOPE}.elf `find Core/Src -type f -iname *.c` `ls FreeRTOS/Source/*.c` $(INCLUDE_FLAGS) $(OTHER_FLAGS); \
			exit 0; \
		done; \
	done;
	#done

nopass:
	@for SCOPE in 1 2 3 4 5 6; do \
		$(LLVM_BIN)/clang --config $(CONF) -DSCOPE=$${SCOPE} -mcpu=cortex-m3 -DUSE_HAL_DRIVER -DSTM32L152xE -std=gnu11 `find Core Drivers FreeRTOS -type f -iname *.c` Core/Startup/startup_stm32l152retx.s -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage --specs=nosys.specs -Wl,-Map="prova-new.map" -Wl,--gc-sections -static --specs=nano.specs -mfloat-abi=soft -mthumb -Wl,--start-group -lc -lm -Wl,--end-group -o out_nopass.elf; \
		exit 0; \
	done