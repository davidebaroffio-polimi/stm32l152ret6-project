/*
TODO
- Task notificaitons    (used by stream and message buffers)
- Stream buffers        (used by message buffers)
- Message buffers
- Event groups          (not required)
- Timers
x Queue sets            (DISABLED)
x 
*/
#include "FreeRTOS.h"
#include "queue.h"
#include "main.h"
#include "test.h"
#include "task.h"
#include "message_buffer.h"

// BUFFERS
MessageBufferHandle_t xMessageBuffer = NULL;
/**
 * Creates a MessageBuffer, performs a
 * blocking write and deletes the buffer
 * at completion.
*/
void vTaskBufferTestSend ( void * pvParameters ) {
    /* The parameter value is expected to be 1 as 1 is passed in the
    pvParameters value in the call to xTaskCreate() below. */
    configASSERT( ( ( uint32_t ) pvParameters ) == 1 );

    for ( ;; ) {
        // When a message is written to the message buffer an additional sizeof( size_t ) bytes are also written to store the message's length. sizeof( size_t ) is typically 4 bytes on a 32-bit architecture, so on most 32-bit architectures a 10 byte message will take up 14 bytes of message buffer space.
        vTaskDelay(200);
        xMessageBuffer = xMessageBufferCreate(8); // we allow space for an int and the size_t 
        int spaceAvailable = xMessageBufferSpacesAvailable(xMessageBuffer);
        int isEmpty = xMessageBufferIsEmpty(xMessageBuffer); // should be pdTRUE

        xMessageBufferSend(xMessageBuffer, &spaceAvailable, sizeof(int), 0);

        while (xMessageBufferIsFull(xMessageBuffer) == pdTRUE) { // wait for the other task to read the buffer
            vTaskDelay(200);
        }

        vMessageBufferDelete(xMessageBuffer);
    }
}

// BUFFERS
void vTaskBufferTestReceive ( void * pvParameters ) {
    /* The parameter value is expected to be 1 as 1 is passed in the
    pvParameters value in the call to xTaskCreate() below. */
    configASSERT( ( ( uint32_t ) pvParameters ) == 1 );

    for ( ;; ) {
        while (xMessageBuffer == NULL) {
            vTaskDelay(200);
        }

        int data;
        xMessageBufferReceive(xMessageBuffer, &data, sizeof(int), pdMS_TO_TICKS(1000));

        //xMessageBufferReset(xMessageBuffer);
        while (xMessageBuffer != NULL) { // wait for the other task to delete it
            vTaskDelay(200);
        }
    }
}