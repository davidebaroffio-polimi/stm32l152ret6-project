/**
 * @file test_task.c
 * 
 * Functions tested from `task.h`:
xTaskCreate                         [x] // in main.c
xTaskCreateStatic                   [x]
xTaskCreateRestrictedStatic         [-] portUSING_MPU_WRAPPERS is 0
vTaskDelete                         [x]
vTaskDelay                          [x] // in multiple files
vTaskDelayUntil                     [x] // vTaskDelayUntil is a wrapper of xTaskDelayUntil
xTaskDelayUntil                     [x] // in test_queue.c
uxTaskPriorityGet                   [x]
vTaskPrioritySet                    [x]
vTaskSuspend                        [x]
vTaskResume                         [x]
xTaskResumeFromISR                  [ ]
xTaskAbortDelay                     [-] // INCLUDE_xTaskAbortDelay is 0
uxTaskGetSystemState                [ ]*
vTaskGetInfo                        [ ]*
xTaskGetCurrentTaskHandle           [ ] // INCLUDE_xTaskGetCurrentTaskHandle is 0
xTaskGetIdleTaskHandle              [ ] // INCLUDE_xTaskGetIdleTaskHandle is 0
uxTaskGetStackHighWaterMark         [x]
eTaskGetState                       [x]
pcTaskGetName                       [x]
xTaskGetHandle                      [x]
xTaskGetTickCount                   [x] // in test_queue.c
xTaskGetTickCountFromISR            [ ]
xTaskGetSchedulerState              [x]
uxTaskGetNumberOfTasks              [x]
vTaskList                           [ ]*
vTaskStartTrace                     [ ] // deprecated
ulTaskEndTrace                      [ ] // deprecated
vTaskGetRunTimeStats                [ ]*
vTaskGetIdleRunTimeCounter          [ ]
vTaskSetApplicationTaskTag          [ ] // not used by kernel
xTaskGetApplicationTaskTag          [ ] // not used by kernel
xTaskCallApplicationTaskHook        [ ] // not used by kernel
pvTaskGetThreadLocalStoragePointer  [ ]
vTaskSetThreadLocalStoragePointer   [ ]
vTaskSetTimeOutState                [ ]
xTaskCheckForTimeOut                [x] // used by queue.c

(*) functions intended for debugging purposes only
 */
#include "FreeRTOS.h"
#include "queue.h"
#include "main.h"
#include "test.h"
#include "task.h"

StackType_t xStack[ configMINIMAL_STACK_SIZE ];
StaticTask_t xTaskBuffer;

void vTaskUseless( void * pvParameters ) {
    
    for ( ;; ) {
        vTaskDelay(5);
    }
}

void fnTest1() {
    // create static task
    TaskHandle_t xHandle = xTaskCreateStatic(vTaskUseless,      // function
                                             "uselessTask\0",   // task name
                                             configMINIMAL_STACK_SIZE,               // stack size
                                             NULL,              // params
                                             tskIDLE_PRIORITY,  // priority
                                             xStack,            // task stack array
                                             &xTaskBuffer);     // task data structure
    // set priority
    vTaskPrioritySet(xHandle, tskIDLE_PRIORITY+1);
    // suspend
    vTaskSuspend(xHandle);
    // get priority and check if task is suspended
    if( uxTaskPriorityGet( xHandle ) != tskIDLE_PRIORITY+1 && 
        eTaskGetState( xHandle ) != eSuspended ) {
        Incorrect_Result();
    }
    // resume
    vTaskResume(xHandle);
    // delete
    vTaskDelete(xHandle);
}

void fnTest2() {
    char * name = "createdTask\0";

    int numTasks = uxTaskGetNumberOfTasks();
    TaskHandle_t xHandle = NULL;
    
    xTaskCreate(vTaskUseless, name, configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY, NULL);
    if (uxTaskGetNumberOfTasks() != numTasks +1 || 
        xTaskGetSchedulerState() != taskSCHEDULER_RUNNING ||
        uxTaskGetStackHighWaterMark(xHandle) <= 0) {
        Incorrect_Result();
    }
    
    vTaskDelete(xHandle);
}

void vTaskTaskTest ( void * pvParameters ) {

    void (*functions[1])() = {fnTest1};

    int i = 0;
    for ( ;; ) {
        vBackupRestoreCallVoidFunction(functions[i%1]);
        i++;
        vTaskDelay(5);
    }
}