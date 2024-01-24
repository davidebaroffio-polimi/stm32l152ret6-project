ASPIS=/home/buoffio/aspis_demo/ASPIS/aspis.sh
CONF=/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project/Tools/LLVMEmbeddedToolchainForArm-15.0.2-Linux-x86_64/bin/config.cfg
LLVM_BIN=/home/buoffio/llvm-project-llvmorg-16.0.6/build/bin/
EXCLUDE_F=excluded_files.txt

SCOPE?=0

out_all:
	#@for SCOPE in 1 2 3 4 5 6; do
	@for data_p in eddi fdsc seddi ; do \
		for cfg_p in rasm inter-rasm cfcss ; do \
			$(ASPIS) -DSCOPE=$${SCOPE} --config $(CONF) --llvm-bin $(LLVM_BIN) --exclude $(EXCLUDE_F) --asmfiles asmfiles.txt --$${cfg_p} --$${data_p} -o out_$${data_p}_$${cfg_p}_$${SCOPE}.elf `find Core/Src -type f -iname *.c` `ls FreeRTOS/Source/*.c`; \
		done; \
	done;
	#done

nopass:
	@for SCOPE in 1 2 3 4 5 6; do \
		$(LLVM_BIN)/clang --config $(CONF) -DSCOPE=$${SCOPE} -mcpu=cortex-m3 -DUSE_HAL_DRIVER -DSTM32L152xE -std=gnu11 `find Core Drivers FreeRTOS -type f -iname *.c` Core/Startup/startup_stm32l152retx.s -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage --specs=nosys.specs -Wl,-Map="prova-new.map" -Wl,--gc-sections -static --specs=nano.specs -mfloat-abi=soft -mthumb -Wl,--start-group -lc -lm -Wl,--end-group -o out_nopass.elf; \
		exit 0; \
	done