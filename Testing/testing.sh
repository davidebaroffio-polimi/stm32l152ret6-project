#!/usr/bin/bash

python3 testing.py registers compiled_outputs/out_fdsc_cfcss.elf
python3 testing.py memory compiled_outputs/out_fdsc_cfcss.elf
