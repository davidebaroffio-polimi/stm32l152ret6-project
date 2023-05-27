#!/usr/bin/bash

python3 testing.py registers compiled_outputs/out_seddi_cfcss.elf
python3 testing.py memory compiled_outputs/out_seddi_cfcss.elf
