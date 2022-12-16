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
uxTaskGetSystemState                [ ]
vTaskGetInfo                        [ ]
xTaskGetCurrentTaskHandle           [ ]
xTaskGetIdleTaskHandle              [ ]
uxTaskGetStackHighWaterMark         [ ]
eTaskGetState                       [x]
pcTaskGetName                       [x]
xTaskGetHandle                      [ ]
xTaskGetTickCount                   [ ]
xTaskGetTickCountFromISR            [ ]
xTaskGetSchedulerState              [ ]
uxTaskGetNumberOfTasks              [ ]
vTaskList                           [ ]
vTaskStartTrace                     [ ] // deprecated
ulTaskEndTrace                      [ ] // deprecated
vTaskGetRunTimeStats                [ ]
vTaskGetIdleRunTimeCounter          [ ]
vTaskSetApplicationTaskTag          [ ]
xTaskGetApplicationTaskTag          [ ]
xTaskCallApplicationTaskHook        [ ]
pvTaskGetThreadLocalStoragePointer  [ ]
vTaskSetThreadLocalStoragePointer   [ ]
vTaskSetTimeOutState                [ ]
xTaskCheckForTimeOut                [ ]
 */
#include "FreeRTOS.h"
#include "queue.h"
#include "main.h"
#include "test.h"
#include "task.h"

StackType_t xStack[ 128 ];
StaticTask_t xTaskBuffer;

void vTaskUseless( void * pvParameters ) {
    /* The parameter value is expected to be 1 as 1 is passed in the
    pvParameters value in the call to xTaskCreate() below. */
    configASSERT( ( ( uint32_t ) pvParameters ) == 1 );
    
    for ( ;; ) {
        vTaskDelay(100);
    }
}

void fnTest1() {
    // create static task
    TaskHandle_t xHandle = xTaskCreateStatic(vTaskUseless,      // function
                                             "uselessTask\0",   // task name
                                             128,               // stack size
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

void vTaskTaskTest ( void * pvParameters ) {
    /* The parameter value is expected to be 1 as 1 is passed in the
    pvParameters value in the call to xTaskCreate() below. */
    configASSERT( ( ( uint32_t ) pvParameters ) == 1 );

    void (*functions[1])() = {fnTest1};

    int i = 0;
    for ( ;; ) {
        functions[i%1]();
        i++;
        vTaskDelay(50);
    }
}