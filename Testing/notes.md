# Benchmarks
The benchmarks have been performed executing some benchmarks a number of subsequent times. The `time` results are measured in FreeRTOS ticks.

`TODO vogliamo anche misurare l'overhead in termini di spazio?`

## Results
The pass increases the execution time as follows:

| Benchmark        | Time w/o Pass | Time w/ pass | Increase |
|------------------|---------------|--------------|----------|
| DES (1000 times) | 4347          | 17933        | 4.125x   |