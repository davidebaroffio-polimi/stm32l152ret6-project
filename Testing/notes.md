# Scope of the testing
We are going to perform testing in memory and registers with the following configurations:

- Standard FreeRTOS
EDDI
- EDDI + CFCSS                                  x
- EDDI + RASM                                   x
- EDDI + RASM intra-function                    
FDSC (Full Duplication with Selective Checking)
- FDSC + CFCSS                                  x
- FDSC + RASM                                   x
- FDSC + RASM intra-function
SEDDI (Selective-EDDI checking only branch and call instructions)
- SEDDI + CFCSS
- SEDDI + RASM
- SEDDI + RASM intra-function

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

# TODO
- [x] Fix static global variables (fixed only pointers and non-nested arrays)
- [x] Implement RASM
- [x] Implement "An Improved Data Error Detection Technique for Dependable Embedded Software" (paper 8639681)
---
### **2023/13/04**
- [x] Fix global structs
- [x] Add intra-function CFC
  - [x] Modify FreeRTOS context switch for runtime sigs backup/restore between context switches
  - [x] Add annotation to Global runtime signatures
  - [x] Think about how to find the program's entry point
  - [x] Solve SigMismatch at vTaskSwitchContext. There are strange things happening in assembly that prevent us from calling the backup/reset/restore signature functions. Take a look at it.
  - [x] Fix tasks suffering the overflow
  - [x] Test the compilation with both rasm and eddi
- [x] Implement selective checking on DFG (Data Flow Graph) rather than CFG. In particular, try to insert consistency checks only before A) branches, B) calls and C) returns.
---
### **2023/25/04**
- [x] CFCSS does not compile now, fix it

### **2023/26/04**
I am having an overflow in `Tmr Svc` when duplicating the following global structs:
- xStaticQueue_dup   
- xTaskBuffer_dup   
- icd_dup   
- Timer_TCB_dup   
- xActiveTimerList1_dup   
- xActiveTimerList2_dup   
- prvCheckForValidListAndQueue.xStaticTimerQueue_dup   
- Idle_TCB_dup   
- xTasksWaitingTermination_dup   
- xSuspendedTaskList_dup   
- xPendingReadyList_dup   
- xDelayedTaskList1_dup   
- xDelayedTaskList2_dup    

One of the main problems is that I need to duplicate both global TCBs and global structs such as `xTasksWaitingTermination`. This leads me to the overflow described earlier but, on top of that, FreeRTOS uses `malloc` and `free` also on global TCBs, causing problems when creating and destroying tasks. 

### **2023/06/05**
Il problema delle structs (non contiamo l'overflow dei timer, non ci interessa al momento) è che quando aggiungo una task alla lista delle delayed tasks (tramite vTaskDelay per esempio) il codice prende la current task, che non è duplicata omegalul. Quindi viene spostata solo una delle due task nella delayed list... 
Dato che entrambe le delayed lists contengono la stessa task come prima delayata, entrambe punteranno alla stessa task ma dalla task vedrò solo la seconda lista come quella di appartenenza.

xDelayedTaskList ---> task <--- xDelayedTaskList_dup
                        L----------------^

Questo causa dei problemi quando rimuoviamo la task dalla lista a cui appartiene, ovvero xDelayedTaskList_dup, questo avviene poichè il codice non sa che l'elemento nella struct è una globale che ha un duplicato, quindi lo rimuove solo da una. Il codice aggiunge poi la task rimossa ad una ReadyList.

Però la xDelayedTaskList non è stata modificata, quindi quando vado a prendermi l'oggetto in prima posizione dovrei avere la task, che però ha xReadyTaskList come lista di appartenenza.

xDelayedTaskList ---> task <--- xReadyTaskList
                        L----------------^

Invece l'oggetto in prima posizione della lista duplicata sarà diverso dalla nostra task poiché è stato rimosso. 

### 13/05/2023
Ora riesco a duplicare tutte le globali, sia interne che esterne... 
- [x] Ho dei problemi sulla timer task, in particolare ho un mismatch quando vado a leggere il valore all'interno della CommandQueue nella funzione prvProcessReceivedCommands(). Risolvi...


### 15/05/2023
Finish!!!!
