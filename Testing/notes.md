# TODO
- [x] Fix static global variables (fixed only pointers and non-nested arrays)

- [ ] Implement RASM

- [ ] Implement "An Improved Data Error Detection Technique for Dependable Embedded Software" (8639681)

# Benchmarks
The benchmarks have been performed executing some benchmarks a number of subsequent times. The `time` results are measured in FreeRTOS ticks.
The pass increases the execution time as follows:

| Benchmark           | Time w/o Pass | Time w/ pass | Increase |
|---------------------|---------------|--------------|----------|
| MatMult (250 times) | 3215          | 14077        | x4.3785  |
| DES (1000 times)    | 4347          | 17933        | x4.1254  |

Then we checked the size of the code (i.e. the `text` section of the elf output file) both with and without pass considering only the core FreeRTOS.

| w/o SIHFT | w/ SIHFT | Overhead |
|-----------|----------|----------|
| 0x3AE8    | 0xADE4   | 2.952x   |