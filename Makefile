ASPIS=/home/buoffio/SCUDO/aspis.sh
CONF=/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project/Tools/LLVMEmbeddedToolchainForArm-15.0.2-Linux-x86_64/bin/config.cfg
LLVM_BIN=Tools/llvm
EXCLUDE_F=excluded_files.txt

SCOPE?=0

out_all:
	@for data_p in eddi fdsc seddi ; do \
        for cfg_p in cfcss rasm inter-rasm ; do \
			$(ASPIS) -DSCOPE=$(SCOPE) --config $(CONF) --llvm-bin $(LLVM_BIN) --exclude $(EXCLUDE_F) --asmfiles asmfiles.txt --$${cfg_p} --$${data_p} -o out_$${data_p}_$${cfg_p}_$(SCOPE).elf `find Core/Src -type f -iname *.c` `ls FreeRTOS/Source/*.c`; \
		done; \
    done
