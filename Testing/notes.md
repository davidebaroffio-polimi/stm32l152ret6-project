# TODO
- [x] Fix static global variables (fixed only pointers and non-nested arrays)
- [x] Implement RASM
- [x] Implement "An Improved Data Error Detection Technique for Dependable Embedded Software" (paper 8639681)
---
### **2023/13/04**
- [ ] Fix global structs
- [ ] Add intra-function CFC
  - [x] Modify FreeRTOS context switch for runtime sigs backup/restore between context switches
  - [ ] Add annotation to Global runtime signatures
  - [ ] Think about how to find the program's entry point
- [ ] Implement selective checking on DFG (Data Flow Graph) rather than CFG. In particular, try to insert consistency checks only before A) branches, B) calls and C) returns.

# Benchmarks
The benchmarks have been performed executing some benchmarks a number of subsequent times. The `time` results are measured in FreeRTOS ticks.
The pass increases the execution time as follows:

| Benchmark            | MatMult (250 times) | Increase | DES (1000 times) | Increase |
|----------------------|---------------------|----------|------------------|----------|
| Time w/o SIHFT       | 3215                | x1.0000  | 4347             | x1.0000  |
| Time w/ EDDI + CFCSS | 14077               | x4.3785  | 17933            | x4.1254  |
| Time w/ FDSC + CFCSS | 9710                | x3.0202  | 11598            | x2.6680  |
| Time w/ EDDI + RASM  | 16536               | x5.1434  | CRASHED          | -        |
| Time w/ FDSC + RASM  | 11232               | x3.4936  | 13280            | x3.0550  |

Then we checked the size of the code (i.e. the `text` section of the elf output file) both with and without pass considering only the core FreeRTOS.

| w/o SIHFT | w/ SIHFT | Overhead |
|-----------|----------|----------|
| 0x3AE8    | 0xADE4   | 2.952x   |