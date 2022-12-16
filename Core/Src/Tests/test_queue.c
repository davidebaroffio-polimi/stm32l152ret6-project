/**
 * @file test_queue.c
 * 
 * Functions tested from `queue.h`:
xQueueCreate                   [x]                           
xQueueCreateStatic             [x]                           
vQueueDelete                   [x]                           
xQueueSend                     [x]                           
xQueueSendFromISR              [ ]                           
xQueueSendToBack               [x]                           
xQueueSendToBackFromISR        [ ]                           
xQueueSendToFront              [x]                           
xQueueSendToFrontFromISR       [ ]                           
xQueueReceive                  [x]                           
xQueueReceiveFromISR           [ ]                           
uxQueueMessagesWaiting         [x]                           
uxQueueMessagesWaitingFromISR  [ ]                           
uxQueueSpacesAvailable         [x]                           
xQueueReset                    [x]                           
xQueuePeek                     [x]                           
xQueuePeekFromISR              [ ]                           
vQueueAddToRegistry            [x]                           
pcQueueGetName                 [x]                           
vQueueUnregisterQueue          [x]                           
xQueueIsQueueEmptyFromISR      [ ]                           
xQueueIsQueueFullFromISR       [ ]                           
xQueueOverwrite                [x]                           
xQueueOverwriteFromISR         [ ]   

 * Coverage: all functions except functions "fromISR"
 */
#include "FreeRTOS.h"
#include "queue.h"
#include "main.h"
#include "test.h"

#define QUEUE_LENGTH    10
#define ITEM_SIZE       sizeof( uint64_t )

xQueueHandle globalQueuehandle = 0;
static StaticQueue_t xStaticQueue;

void vTaskQueueTest1( void * pvParameters ) {
    /* The parameter value is expected to be 1 as 1 is passed in the
    pvParameters value in the call to xTaskCreate() below. */
    configASSERT( ( ( uint32_t ) pvParameters ) == 1 );
    globalQueuehandle = xQueueCreate(2, ITEM_SIZE);

    TickType_t xLastWakeTime;
    const TickType_t xFrequency = 100;
    BaseType_t xWasDelayed;

    // Initialise the xLastWakeTime variable with the current time.
    xLastWakeTime = xTaskGetTickCount ();
    for( ;; )
    {
        // Delay
        xWasDelayed = xTaskDelayUntil( &xLastWakeTime, xFrequency );
        
        // Send number on the queue
        int i = 1;
        xQueueSend(globalQueuehandle, &i, 0);
        HAL_GPIO_WritePin(LD2_GPIO_Port, LD2_Pin, GPIO_PIN_SET);
        //HAL_GPIO_TogglePin(LD2_GPIO_Port, LD2_Pin);

    }
}

void vTaskQueueTest2( void * pvParameters ) {
    /* The parameter value is expected to be 1 as 1 is passed in the
    pvParameters value in the call to xTaskCreate() below. */
    configASSERT( ( ( uint32_t ) pvParameters ) == 1 );

    TickType_t xLastWakeTime;
    const TickType_t xFrequency = 250;

    xLastWakeTime = xTaskGetTickCount ();
    for( ;; )
    {
        int i;
        int res = xQueueReceive(globalQueuehandle, &i, 200);
        if (i == 1 && res == pdTRUE) { // we have received the value and it is indeed 1
            xTaskDelayUntil( &xLastWakeTime, xFrequency );
            done();
        }
        else {
            Incorrect_Result();
        }
        HAL_GPIO_WritePin(LD2_GPIO_Port, LD2_Pin, GPIO_PIN_RESET);
    }
}

void vTaskQueueTest3( void * pvParameters ) {
    /* The parameter value is expected to be 1 as 1 is passed in the
    pvParameters value in the call to xTaskCreate() below. */
    configASSERT( ( ( uint32_t ) pvParameters ) == 1 );

    uint8_t ucQueueStorageArea[ QUEUE_LENGTH * ITEM_SIZE ];
    QueueHandle_t xQueue;

    /* Create a queue capable of containing 10 uint64_t values. */
    xQueue = xQueueCreateStatic( QUEUE_LENGTH,
                                 ITEM_SIZE,
                                 ucQueueStorageArea,
                                 &xStaticQueue );
    for( ;; )
    {
        int i1 = 1;
        int i2 = 2;
        vTaskDelay(20);
        for (int i = 0; i<5; i++) {
            xQueueSendToBack(xQueue, &i2, 0); // send 2
            xQueueSendToFront(xQueue, &i1, 0); // send 1
        }
        // now the queue should be (front)[1, 1, 1, 1, 1, 2, 2, 2, 2, 2](back)
        int iOut;
        for (int i = 0; i<5; i++) {
            xQueueReceive(xQueue, &iOut, 20);
        }
        int iOutPeekd;
        xQueuePeek(xQueue, &iOutPeekd, 20);
        if (uxQueueMessagesWaiting(xQueue) == 5) {
            xQueueReset(xQueue);
        }
        if(uxQueueSpacesAvailable(xQueue) == 10 && iOut == 1 && iOutPeekd == 2) {
            HAL_GPIO_TogglePin(LD2_GPIO_Port, LD2_Pin);
        }
        else {
            Incorrect_Result();
        }
    }
}

void vTaskQueueTest4( void *pvParameters ) {
    /* The parameter value is expected to be 1 as 1 is passed in the
    pvParameters value in the call to xTaskCreate() below. */
    configASSERT( ( ( uint32_t ) pvParameters ) == 1 );

    xQueueHandle queuehandle = 0;

    for ( ;; ) {
        queuehandle = xQueueCreate(1, ITEM_SIZE);

        vQueueAddToRegistry(queuehandle, "testQueue\0");
        vTaskDelay(25);

        int i1 = 1;
        xQueueSend(queuehandle, &i1, 0);

        char* name = pcQueueGetName(queuehandle);

        if (strncmp("testQueue", name, 9) != 0) {
            Incorrect_Result();
        }

        int i2 = 2;
        xQueueOverwrite(queuehandle, &i2);

        vTaskDelay(35);

        vQueueUnregisterQueue(queuehandle);
        vQueueDelete(queuehandle);

        vTaskDelay(110);
    }
}