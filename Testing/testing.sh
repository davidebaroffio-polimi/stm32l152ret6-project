#!/usr/bin/bash

python3 testing.py registers compiled_outputs/out_eddi_rasm.elf
python3 testing.py memory compiled_outputs/out_eddi_rasm.elf
