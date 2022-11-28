; ModuleID = 'FreeRTOS/Source/tasks.c'
source_filename = "FreeRTOS/Source/tasks.c"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-unknown-eabi"

%struct.xSTATIC_TCB = type { ptr, [2 x %struct.xSTATIC_LIST_ITEM], i32, ptr, [16 x i8], [2 x i32], [2 x i32], [1 x i32], [1 x i8], i8 }
%struct.xSTATIC_LIST_ITEM = type { i32, [4 x ptr] }
%struct.xLIST = type { i32, ptr, %struct.xMINI_LIST_ITEM }
%struct.xMINI_LIST_ITEM = type { i32, ptr, ptr }
%struct.tskTaskControlBlock = type { ptr, %struct.xLIST_ITEM, %struct.xLIST_ITEM, i32, ptr, [16 x i8], i32, i32, i32, i32, [1 x i32], [1 x i8], i8 }
%struct.xLIST_ITEM = type { i32, ptr, ptr, ptr, ptr }
%struct.xTASK_STATUS = type { ptr, ptr, i32, i32, i32, i32, i32, ptr, i16 }
%struct.xTIME_OUT = type { i32, i32 }

@pxCurrentTCB = dso_local global ptr null, align 4
@uxTopUsedPriority = dso_local constant i32 55, align 4
@Idle_TCB = internal global %struct.xSTATIC_TCB zeroinitializer, align 4
@Idle_Stack = internal global [128 x i32] zeroinitializer, align 4
@.str = private unnamed_addr constant [8 x i8] c"include\00", section "llvm.metadata"
@.str.1 = private unnamed_addr constant [24 x i8] c"FreeRTOS/Source/tasks.c\00", section "llvm.metadata"
@uxTaskNumber = internal global i32 0, align 4
@xTasksWaitingTermination = internal global %struct.xLIST zeroinitializer, align 4
@uxDeletedTasksWaitingCleanUp = internal global i32 0, align 4
@uxCurrentNumberOfTasks = internal global i32 0, align 4
@xSchedulerRunning = internal global i32 0, align 4
@xTickCount = internal global i32 0, align 4
@.str.2 = private unnamed_addr constant [8 x i8] c"exclude\00", section "llvm.metadata"
@pxDelayedTaskList = internal global ptr null, align 4
@pxOverflowDelayedTaskList = internal global ptr null, align 4
@xSuspendedTaskList = internal global %struct.xLIST zeroinitializer, align 4
@pxReadyTasksLists = internal global [56 x %struct.xLIST] zeroinitializer, align 4
@uxTopReadyPriority = internal global i32 0, align 4
@uxSchedulerSuspended = internal global i32 0, align 4
@xYieldPending = internal global i32 0, align 4
@xPendingReadyList = internal global %struct.xLIST zeroinitializer, align 4
@.str.3 = private unnamed_addr constant [5 x i8] c"IDLE\00", align 1
@xIdleTaskHandle = internal global ptr null, align 4
@xNextTaskUnblockTime = internal global i32 0, align 4
@xPendedTicks = internal global i32 0, align 4
@xNumOfOverflows = internal global i32 0, align 4
@xDelayedTaskList1 = internal global %struct.xLIST zeroinitializer, align 4
@xDelayedTaskList2 = internal global %struct.xLIST zeroinitializer, align 4
@llvm.global.annotations = appending global [63 x { ptr, ptr, ptr, i32, ptr }] [{ ptr, ptr, ptr, i32, ptr } { ptr @vApplicationGetIdleTaskMemory, ptr @.str, ptr @.str.1, i32 582, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskCreateStatic, ptr @.str, ptr @.str.1, i32 588, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskCreate, ptr @.str, ptr @.str.1, i32 741, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskDelete, ptr @.str, ptr @.str.1, i32 1170, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskDelayUntil, ptr @.str.2, ptr @.str.1, i32 1272, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskDelay, ptr @.str, ptr @.str.1, i32 1359, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @eTaskGetState, ptr @.str, ptr @.str.1, i32 1404, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @uxTaskPriorityGet, ptr @.str, ptr @.str.1, i32 1501, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @uxTaskPriorityGetFromISR, ptr @.str, ptr @.str.1, i32 1523, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskPrioritySet, ptr @.str, ptr @.str.1, i32 1563, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskSuspend, ptr @.str, ptr @.str.1, i32 1729, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskResume, ptr @.str, ptr @.str.1, i32 1881, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskResumeFromISR, ptr @.str, ptr @.str.1, i32 1935, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskStartScheduler, ptr @.str, ptr @.str.1, i32 2010, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskEndScheduler, ptr @.str, ptr @.str.1, i32 2138, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskSuspendAll, ptr @.str, ptr @.str.1, i32 2149, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskResumeAll, ptr @.str.2, ptr @.str.1, i32 2233, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskGetTickCount, ptr @.str, ptr @.str.1, i32 2345, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskGetTickCountFromISR, ptr @.str, ptr @.str.1, i32 2360, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @uxTaskGetNumberOfTasks, ptr @.str, ptr @.str.1, i32 2391, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @pcTaskGetName, ptr @.str, ptr @.str.1, i32 2399, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @uxTaskGetSystemState, ptr @.str, ptr @.str.1, i32 2546, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskCatchUpTicks, ptr @.str, ptr @.str.1, i32 2651, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskIncrementTick, ptr @.str.2, ptr @.str.1, i32 2749, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskSwitchContext, ptr @.str, ptr @.str.1, i32 3034, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskPlaceOnEventList, ptr @.str, ptr @.str.1, i32 3110, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskPlaceOnUnorderedEventList, ptr @.str, ptr @.str.1, i32 3135, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskPlaceOnEventListRestricted, ptr @.str, ptr @.str.1, i32 3163, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskRemoveFromEventList, ptr @.str, ptr @.str.1, i32 3196, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskRemoveFromUnorderedEventList, ptr @.str, ptr @.str.1, i32 3264, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskSetTimeOutState, ptr @.str, ptr @.str.1, i32 3313, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskInternalSetTimeOutState, ptr @.str, ptr @.str.1, i32 3325, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskCheckForTimeOut, ptr @.str, ptr @.str.1, i32 3333, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskMissedYield, ptr @.str, ptr @.str.1, i32 3398, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @uxTaskGetTaskNumber, ptr @.str, ptr @.str.1, i32 3406, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskSetTaskNumber, ptr @.str, ptr @.str.1, i32 3429, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskGetInfo, ptr @.str, ptr @.str.1, i32 3741, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @uxTaskGetStackHighWaterMark, ptr @.str, ptr @.str.1, i32 3935, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskGetCurrentTaskHandle, ptr @.str, ptr @.str.1, i32 4042, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskGetSchedulerState, ptr @.str, ptr @.str.1, i32 4059, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskPriorityInherit, ptr @.str, ptr @.str.1, i32 4087, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskPriorityDisinherit, ptr @.str, ptr @.str.1, i32 4177, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskPriorityDisinheritAfterTimeout, ptr @.str, ptr @.str.1, i32 4257, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @uxTaskResetEventItemValue, ptr @.str, ptr @.str.1, i32 4684, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @pvTaskIncrementMutexHeldCount, ptr @.str, ptr @.str.1, i32 4700, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @ulTaskGenericNotifyTake, ptr @.str, ptr @.str.1, i32 4717, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskGenericNotifyWait, ptr @.str, ptr @.str.1, i32 4789, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskGenericNotify, ptr @.str, ptr @.str.1, i32 4875, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskGenericNotifyFromISR, ptr @.str, ptr @.str.1, i32 4998, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskGenericNotifyGiveFromISR, ptr @.str, ptr @.str.1, i32 5137, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @xTaskGenericNotifyStateClear, ptr @.str, ptr @.str.1, i32 5226, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @ulTaskGenericNotifyValueClear, ptr @.str, ptr @.str.1, i32 5260, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @prvInitialiseNewTask, ptr @.str, ptr @.str.1, i32 832, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @prvAddNewTaskToReadyList, ptr @.str, ptr @.str.1, i32 1084, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @prvInitialiseTaskLists, ptr @.str, ptr @.str.1, i32 3679, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @prvTaskIsTaskSuspended, ptr @.str, ptr @.str.1, i32 1835, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @prvIdleTask, ptr @.str, ptr @.str.1, i32 3454, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @prvCheckTasksWaitingTermination, ptr @.str, ptr @.str.1, i32 3711, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @prvListTasksWithinSingleList, ptr @.str, ptr @.str.1, i32 3840, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @prvTaskCheckFreeStackSpace, ptr @.str, ptr @.str.1, i32 3875, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @prvDeleteTCB, ptr @.str, ptr @.str.1, i32 3963, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @prvResetNextTaskUnblockTime, ptr @.str, ptr @.str.1, i32 4019, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @prvAddCurrentTaskToDelayedList, ptr @.str, ptr @.str.1, i32 5323, ptr null }], section "llvm.metadata"
@llvm.compiler.used = appending global [1 x ptr] [ptr @vTaskSwitchContext], section "llvm.metadata"

; Function Attrs: noinline nounwind
define dso_local void @vApplicationGetIdleTaskMemory(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 !dbg !7 {
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  store ptr %0, ptr %4, align 4
  store ptr %1, ptr %5, align 4
  store ptr %2, ptr %6, align 4
  %7 = load ptr, ptr %4, align 4, !dbg !10
  store ptr @Idle_TCB, ptr %7, align 4, !dbg !11
  %8 = load ptr, ptr %5, align 4, !dbg !12
  store ptr @Idle_Stack, ptr %8, align 4, !dbg !13
  %9 = load ptr, ptr %6, align 4, !dbg !14
  store i32 128, ptr %9, align 4, !dbg !15
  ret void, !dbg !16
}

; Function Attrs: noinline nounwind
define dso_local ptr @xTaskCreateStatic(ptr noundef %0, ptr noundef %1, i32 noundef %2, ptr noundef %3, i32 noundef %4, ptr noundef %5, ptr noundef %6) #0 !dbg !17 {
  %8 = alloca ptr, align 4
  %9 = alloca ptr, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 4
  %12 = alloca i32, align 4
  %13 = alloca ptr, align 4
  %14 = alloca ptr, align 4
  %15 = alloca ptr, align 4
  %16 = alloca ptr, align 4
  store ptr %0, ptr %8, align 4
  store ptr %1, ptr %9, align 4
  store i32 %2, ptr %10, align 4
  store ptr %3, ptr %11, align 4
  store i32 %4, ptr %12, align 4
  store ptr %5, ptr %13, align 4
  store ptr %6, ptr %14, align 4
  %17 = load ptr, ptr %14, align 4, !dbg !18
  %18 = icmp ne ptr %17, null, !dbg !19
  br i1 %18, label %19, label %36, !dbg !20

19:                                               ; preds = %7
  %20 = load ptr, ptr %13, align 4, !dbg !21
  %21 = icmp ne ptr %20, null, !dbg !22
  br i1 %21, label %22, label %36, !dbg !23

22:                                               ; preds = %19
  %23 = load ptr, ptr %14, align 4, !dbg !24
  store ptr %23, ptr %15, align 4, !dbg !25
  %24 = load ptr, ptr %13, align 4, !dbg !26
  %25 = load ptr, ptr %15, align 4, !dbg !27
  %26 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %25, i32 0, i32 4, !dbg !28
  store ptr %24, ptr %26, align 4, !dbg !29
  %27 = load ptr, ptr %15, align 4, !dbg !30
  %28 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %27, i32 0, i32 12, !dbg !31
  store i8 2, ptr %28, align 1, !dbg !32
  %29 = load ptr, ptr %8, align 4, !dbg !33
  %30 = load ptr, ptr %9, align 4, !dbg !34
  %31 = load i32, ptr %10, align 4, !dbg !35
  %32 = load ptr, ptr %11, align 4, !dbg !36
  %33 = load i32, ptr %12, align 4, !dbg !37
  %34 = load ptr, ptr %15, align 4, !dbg !38
  call void @prvInitialiseNewTask(ptr noundef %29, ptr noundef %30, i32 noundef %31, ptr noundef %32, i32 noundef %33, ptr noundef %16, ptr noundef %34, ptr noundef null), !dbg !39
  %35 = load ptr, ptr %15, align 4, !dbg !40
  call void @prvAddNewTaskToReadyList(ptr noundef %35), !dbg !41
  br label %37, !dbg !42

36:                                               ; preds = %19, %7
  store ptr null, ptr %16, align 4, !dbg !43
  br label %37

37:                                               ; preds = %36, %22
  %38 = load ptr, ptr %16, align 4, !dbg !44
  ret ptr %38, !dbg !45
}

; Function Attrs: noinline nounwind
define internal void @prvInitialiseNewTask(ptr noundef %0, ptr noundef %1, i32 noundef %2, ptr noundef %3, i32 noundef %4, ptr noundef %5, ptr noundef %6, ptr noundef %7) #0 !dbg !46 {
  %9 = alloca ptr, align 4
  %10 = alloca ptr, align 4
  %11 = alloca i32, align 4
  %12 = alloca ptr, align 4
  %13 = alloca i32, align 4
  %14 = alloca ptr, align 4
  %15 = alloca ptr, align 4
  %16 = alloca ptr, align 4
  %17 = alloca ptr, align 4
  %18 = alloca i32, align 4
  store ptr %0, ptr %9, align 4
  store ptr %1, ptr %10, align 4
  store i32 %2, ptr %11, align 4
  store ptr %3, ptr %12, align 4
  store i32 %4, ptr %13, align 4
  store ptr %5, ptr %14, align 4
  store ptr %6, ptr %15, align 4
  store ptr %7, ptr %16, align 4
  %19 = load ptr, ptr %15, align 4, !dbg !47
  %20 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %19, i32 0, i32 4, !dbg !48
  %21 = load ptr, ptr %20, align 4, !dbg !48
  %22 = load i32, ptr %11, align 4, !dbg !49
  %23 = mul i32 %22, 4, !dbg !50
  call void @llvm.memset.p0.i32(ptr align 4 %21, i8 -91, i32 %23, i1 false), !dbg !51
  %24 = load ptr, ptr %15, align 4, !dbg !52
  %25 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %24, i32 0, i32 4, !dbg !53
  %26 = load ptr, ptr %25, align 4, !dbg !53
  %27 = load i32, ptr %11, align 4, !dbg !54
  %28 = sub i32 %27, 1, !dbg !55
  %29 = getelementptr inbounds i32, ptr %26, i32 %28, !dbg !52
  store ptr %29, ptr %17, align 4, !dbg !56
  %30 = load ptr, ptr %17, align 4, !dbg !57
  %31 = ptrtoint ptr %30 to i32, !dbg !58
  %32 = and i32 %31, -8, !dbg !59
  %33 = inttoptr i32 %32 to ptr, !dbg !60
  store ptr %33, ptr %17, align 4, !dbg !61
  %34 = load ptr, ptr %10, align 4, !dbg !62
  %35 = icmp ne ptr %34, null, !dbg !63
  br i1 %35, label %36, label %65, !dbg !62

36:                                               ; preds = %8
  store i32 0, ptr %18, align 4, !dbg !64
  br label %37, !dbg !65

37:                                               ; preds = %58, %36
  %38 = load i32, ptr %18, align 4, !dbg !66
  %39 = icmp ult i32 %38, 16, !dbg !67
  br i1 %39, label %40, label %61, !dbg !68

40:                                               ; preds = %37
  %41 = load ptr, ptr %10, align 4, !dbg !69
  %42 = load i32, ptr %18, align 4, !dbg !70
  %43 = getelementptr inbounds i8, ptr %41, i32 %42, !dbg !69
  %44 = load i8, ptr %43, align 1, !dbg !69
  %45 = load ptr, ptr %15, align 4, !dbg !71
  %46 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %45, i32 0, i32 5, !dbg !72
  %47 = load i32, ptr %18, align 4, !dbg !73
  %48 = getelementptr inbounds [16 x i8], ptr %46, i32 0, i32 %47, !dbg !71
  store i8 %44, ptr %48, align 1, !dbg !74
  %49 = load ptr, ptr %10, align 4, !dbg !75
  %50 = load i32, ptr %18, align 4, !dbg !76
  %51 = getelementptr inbounds i8, ptr %49, i32 %50, !dbg !75
  %52 = load i8, ptr %51, align 1, !dbg !75
  %53 = zext i8 %52 to i32, !dbg !75
  %54 = icmp eq i32 %53, 0, !dbg !77
  br i1 %54, label %55, label %56, !dbg !75

55:                                               ; preds = %40
  br label %61, !dbg !78

56:                                               ; preds = %40
  br label %57

57:                                               ; preds = %56
  br label %58, !dbg !79

58:                                               ; preds = %57
  %59 = load i32, ptr %18, align 4, !dbg !80
  %60 = add i32 %59, 1, !dbg !80
  store i32 %60, ptr %18, align 4, !dbg !80
  br label %37, !dbg !68, !llvm.loop !81

61:                                               ; preds = %55, %37
  %62 = load ptr, ptr %15, align 4, !dbg !83
  %63 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %62, i32 0, i32 5, !dbg !84
  %64 = getelementptr inbounds [16 x i8], ptr %63, i32 0, i32 15, !dbg !83
  store i8 0, ptr %64, align 1, !dbg !85
  br label %69, !dbg !86

65:                                               ; preds = %8
  %66 = load ptr, ptr %15, align 4, !dbg !87
  %67 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %66, i32 0, i32 5, !dbg !88
  %68 = getelementptr inbounds [16 x i8], ptr %67, i32 0, i32 0, !dbg !87
  store i8 0, ptr %68, align 4, !dbg !89
  br label %69

69:                                               ; preds = %65, %61
  %70 = load i32, ptr %13, align 4, !dbg !90
  %71 = icmp uge i32 %70, 56, !dbg !91
  br i1 %71, label %72, label %73, !dbg !90

72:                                               ; preds = %69
  store i32 55, ptr %13, align 4, !dbg !92
  br label %74, !dbg !93

73:                                               ; preds = %69
  br label %74

74:                                               ; preds = %73, %72
  %75 = load i32, ptr %13, align 4, !dbg !94
  %76 = load ptr, ptr %15, align 4, !dbg !95
  %77 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %76, i32 0, i32 3, !dbg !96
  store i32 %75, ptr %77, align 4, !dbg !97
  %78 = load i32, ptr %13, align 4, !dbg !98
  %79 = load ptr, ptr %15, align 4, !dbg !99
  %80 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %79, i32 0, i32 8, !dbg !100
  store i32 %78, ptr %80, align 4, !dbg !101
  %81 = load ptr, ptr %15, align 4, !dbg !102
  %82 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %81, i32 0, i32 9, !dbg !103
  store i32 0, ptr %82, align 4, !dbg !104
  %83 = load ptr, ptr %15, align 4, !dbg !105
  %84 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %83, i32 0, i32 1, !dbg !106
  call void @vListInitialiseItem(ptr noundef %84), !dbg !107
  %85 = load ptr, ptr %15, align 4, !dbg !108
  %86 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %85, i32 0, i32 2, !dbg !109
  call void @vListInitialiseItem(ptr noundef %86), !dbg !110
  %87 = load ptr, ptr %15, align 4, !dbg !111
  %88 = load ptr, ptr %15, align 4, !dbg !111
  %89 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %88, i32 0, i32 1, !dbg !111
  %90 = getelementptr inbounds %struct.xLIST_ITEM, ptr %89, i32 0, i32 3, !dbg !111
  store ptr %87, ptr %90, align 4, !dbg !111
  %91 = load i32, ptr %13, align 4, !dbg !112
  %92 = sub i32 56, %91, !dbg !112
  %93 = load ptr, ptr %15, align 4, !dbg !112
  %94 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %93, i32 0, i32 2, !dbg !112
  %95 = getelementptr inbounds %struct.xLIST_ITEM, ptr %94, i32 0, i32 0, !dbg !112
  store i32 %92, ptr %95, align 4, !dbg !112
  %96 = load ptr, ptr %15, align 4, !dbg !113
  %97 = load ptr, ptr %15, align 4, !dbg !113
  %98 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %97, i32 0, i32 2, !dbg !113
  %99 = getelementptr inbounds %struct.xLIST_ITEM, ptr %98, i32 0, i32 3, !dbg !113
  store ptr %96, ptr %99, align 4, !dbg !113
  %100 = load ptr, ptr %16, align 4, !dbg !114
  %101 = load ptr, ptr %15, align 4, !dbg !115
  %102 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %101, i32 0, i32 10, !dbg !116
  %103 = getelementptr inbounds [1 x i32], ptr %102, i32 0, i32 0, !dbg !115
  call void @llvm.memset.p0.i32(ptr align 4 %103, i8 0, i32 4, i1 false), !dbg !117
  %104 = load ptr, ptr %15, align 4, !dbg !118
  %105 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %104, i32 0, i32 11, !dbg !119
  %106 = getelementptr inbounds [1 x i8], ptr %105, i32 0, i32 0, !dbg !118
  call void @llvm.memset.p0.i32(ptr align 4 %106, i8 0, i32 1, i1 false), !dbg !120
  %107 = load ptr, ptr %17, align 4, !dbg !121
  %108 = load ptr, ptr %9, align 4, !dbg !122
  %109 = load ptr, ptr %12, align 4, !dbg !123
  %110 = call ptr @pxPortInitialiseStack(ptr noundef %107, ptr noundef %108, ptr noundef %109), !dbg !124
  %111 = load ptr, ptr %15, align 4, !dbg !125
  %112 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %111, i32 0, i32 0, !dbg !126
  store ptr %110, ptr %112, align 4, !dbg !127
  %113 = load ptr, ptr %14, align 4, !dbg !128
  %114 = icmp ne ptr %113, null, !dbg !129
  br i1 %114, label %115, label %118, !dbg !128

115:                                              ; preds = %74
  %116 = load ptr, ptr %15, align 4, !dbg !130
  %117 = load ptr, ptr %14, align 4, !dbg !131
  store ptr %116, ptr %117, align 4, !dbg !132
  br label %119, !dbg !133

118:                                              ; preds = %74
  br label %119

119:                                              ; preds = %118, %115
  ret void, !dbg !134
}

; Function Attrs: noinline nounwind
define internal void @prvAddNewTaskToReadyList(ptr noundef %0) #0 !dbg !135 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  call void @vPortEnterCritical(), !dbg !136
  %4 = load volatile i32, ptr @uxCurrentNumberOfTasks, align 4, !dbg !137
  %5 = add i32 %4, 1, !dbg !137
  store volatile i32 %5, ptr @uxCurrentNumberOfTasks, align 4, !dbg !137
  %6 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !138
  %7 = icmp eq ptr %6, null, !dbg !139
  br i1 %7, label %8, label %15, !dbg !138

8:                                                ; preds = %1
  %9 = load ptr, ptr %2, align 4, !dbg !140
  store volatile ptr %9, ptr @pxCurrentTCB, align 4, !dbg !141
  %10 = load volatile i32, ptr @uxCurrentNumberOfTasks, align 4, !dbg !142
  %11 = icmp eq i32 %10, 1, !dbg !143
  br i1 %11, label %12, label %13, !dbg !142

12:                                               ; preds = %8
  call void @prvInitialiseTaskLists(), !dbg !144
  br label %14, !dbg !145

13:                                               ; preds = %8
  br label %14

14:                                               ; preds = %13, %12
  br label %32, !dbg !146

15:                                               ; preds = %1
  %16 = load volatile i32, ptr @xSchedulerRunning, align 4, !dbg !147
  %17 = icmp eq i32 %16, 0, !dbg !148
  br i1 %17, label %18, label %30, !dbg !147

18:                                               ; preds = %15
  %19 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !149
  %20 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %19, i32 0, i32 3, !dbg !150
  %21 = load i32, ptr %20, align 4, !dbg !150
  %22 = load ptr, ptr %2, align 4, !dbg !151
  %23 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %22, i32 0, i32 3, !dbg !152
  %24 = load i32, ptr %23, align 4, !dbg !152
  %25 = icmp ule i32 %21, %24, !dbg !153
  br i1 %25, label %26, label %28, !dbg !149

26:                                               ; preds = %18
  %27 = load ptr, ptr %2, align 4, !dbg !154
  store volatile ptr %27, ptr @pxCurrentTCB, align 4, !dbg !155
  br label %29, !dbg !156

28:                                               ; preds = %18
  br label %29

29:                                               ; preds = %28, %26
  br label %31, !dbg !157

30:                                               ; preds = %15
  br label %31

31:                                               ; preds = %30, %29
  br label %32

32:                                               ; preds = %31, %14
  %33 = load i32, ptr @uxTaskNumber, align 4, !dbg !158
  %34 = add i32 %33, 1, !dbg !158
  store i32 %34, ptr @uxTaskNumber, align 4, !dbg !158
  %35 = load i32, ptr @uxTaskNumber, align 4, !dbg !159
  %36 = load ptr, ptr %2, align 4, !dbg !160
  %37 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %36, i32 0, i32 6, !dbg !161
  store i32 %35, ptr %37, align 4, !dbg !162
  %38 = load ptr, ptr %2, align 4, !dbg !163
  %39 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %38, i32 0, i32 3, !dbg !163
  %40 = load i32, ptr %39, align 4, !dbg !163
  %41 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !163
  %42 = icmp ugt i32 %40, %41, !dbg !163
  br i1 %42, label %43, label %47, !dbg !163

43:                                               ; preds = %32
  %44 = load ptr, ptr %2, align 4, !dbg !163
  %45 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %44, i32 0, i32 3, !dbg !163
  %46 = load i32, ptr %45, align 4, !dbg !163
  store volatile i32 %46, ptr @uxTopReadyPriority, align 4, !dbg !163
  br label %47, !dbg !163

47:                                               ; preds = %43, %32
  %48 = load ptr, ptr %2, align 4, !dbg !163
  %49 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %48, i32 0, i32 3, !dbg !163
  %50 = load i32, ptr %49, align 4, !dbg !163
  %51 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %50, !dbg !163
  %52 = getelementptr inbounds %struct.xLIST, ptr %51, i32 0, i32 1, !dbg !163
  %53 = load ptr, ptr %52, align 4, !dbg !163
  store ptr %53, ptr %3, align 4, !dbg !163
  %54 = load ptr, ptr %3, align 4, !dbg !163
  %55 = load ptr, ptr %2, align 4, !dbg !163
  %56 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %55, i32 0, i32 1, !dbg !163
  %57 = getelementptr inbounds %struct.xLIST_ITEM, ptr %56, i32 0, i32 1, !dbg !163
  store ptr %54, ptr %57, align 4, !dbg !163
  %58 = load ptr, ptr %3, align 4, !dbg !163
  %59 = getelementptr inbounds %struct.xLIST_ITEM, ptr %58, i32 0, i32 2, !dbg !163
  %60 = load ptr, ptr %59, align 4, !dbg !163
  %61 = load ptr, ptr %2, align 4, !dbg !163
  %62 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %61, i32 0, i32 1, !dbg !163
  %63 = getelementptr inbounds %struct.xLIST_ITEM, ptr %62, i32 0, i32 2, !dbg !163
  store ptr %60, ptr %63, align 4, !dbg !163
  %64 = load ptr, ptr %2, align 4, !dbg !163
  %65 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %64, i32 0, i32 1, !dbg !163
  %66 = load ptr, ptr %3, align 4, !dbg !163
  %67 = getelementptr inbounds %struct.xLIST_ITEM, ptr %66, i32 0, i32 2, !dbg !163
  %68 = load ptr, ptr %67, align 4, !dbg !163
  %69 = getelementptr inbounds %struct.xLIST_ITEM, ptr %68, i32 0, i32 1, !dbg !163
  store ptr %65, ptr %69, align 4, !dbg !163
  %70 = load ptr, ptr %2, align 4, !dbg !163
  %71 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %70, i32 0, i32 1, !dbg !163
  %72 = load ptr, ptr %3, align 4, !dbg !163
  %73 = getelementptr inbounds %struct.xLIST_ITEM, ptr %72, i32 0, i32 2, !dbg !163
  store ptr %71, ptr %73, align 4, !dbg !163
  %74 = load ptr, ptr %2, align 4, !dbg !163
  %75 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %74, i32 0, i32 3, !dbg !163
  %76 = load i32, ptr %75, align 4, !dbg !163
  %77 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %76, !dbg !163
  %78 = load ptr, ptr %2, align 4, !dbg !163
  %79 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %78, i32 0, i32 1, !dbg !163
  %80 = getelementptr inbounds %struct.xLIST_ITEM, ptr %79, i32 0, i32 4, !dbg !163
  store ptr %77, ptr %80, align 4, !dbg !163
  %81 = load ptr, ptr %2, align 4, !dbg !163
  %82 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %81, i32 0, i32 3, !dbg !163
  %83 = load i32, ptr %82, align 4, !dbg !163
  %84 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %83, !dbg !163
  %85 = getelementptr inbounds %struct.xLIST, ptr %84, i32 0, i32 0, !dbg !163
  %86 = load volatile i32, ptr %85, align 4, !dbg !163
  %87 = add i32 %86, 1, !dbg !163
  store volatile i32 %87, ptr %85, align 4, !dbg !163
  %88 = load ptr, ptr %2, align 4, !dbg !164
  call void @vPortExitCritical(), !dbg !165
  %89 = load volatile i32, ptr @xSchedulerRunning, align 4, !dbg !166
  %90 = icmp ne i32 %89, 0, !dbg !167
  br i1 %90, label %91, label %102, !dbg !166

91:                                               ; preds = %47
  %92 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !168
  %93 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %92, i32 0, i32 3, !dbg !169
  %94 = load i32, ptr %93, align 4, !dbg !169
  %95 = load ptr, ptr %2, align 4, !dbg !170
  %96 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %95, i32 0, i32 3, !dbg !171
  %97 = load i32, ptr %96, align 4, !dbg !171
  %98 = icmp ult i32 %94, %97, !dbg !172
  br i1 %98, label %99, label %100, !dbg !168

99:                                               ; preds = %91
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !173
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !173, !srcloc !174
  call void asm sideeffect "isb", ""() #3, !dbg !173, !srcloc !175
  br label %101, !dbg !176

100:                                              ; preds = %91
  br label %101

101:                                              ; preds = %100, %99
  br label %103, !dbg !177

102:                                              ; preds = %47
  br label %103

103:                                              ; preds = %102, %101
  ret void, !dbg !178
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskCreate(ptr noundef %0, ptr noundef %1, i16 noundef zeroext %2, ptr noundef %3, i32 noundef %4, ptr noundef %5) #0 !dbg !179 {
  %7 = alloca ptr, align 4
  %8 = alloca ptr, align 4
  %9 = alloca i16, align 2
  %10 = alloca ptr, align 4
  %11 = alloca i32, align 4
  %12 = alloca ptr, align 4
  %13 = alloca ptr, align 4
  %14 = alloca i32, align 4
  %15 = alloca ptr, align 4
  store ptr %0, ptr %7, align 4
  store ptr %1, ptr %8, align 4
  store i16 %2, ptr %9, align 2
  store ptr %3, ptr %10, align 4
  store i32 %4, ptr %11, align 4
  store ptr %5, ptr %12, align 4
  %16 = load i16, ptr %9, align 2, !dbg !180
  %17 = zext i16 %16 to i32, !dbg !181
  %18 = mul i32 %17, 4, !dbg !182
  %19 = call ptr @pvPortMalloc(i32 noundef %18), !dbg !183
  store ptr %19, ptr %15, align 4, !dbg !184
  %20 = load ptr, ptr %15, align 4, !dbg !185
  %21 = icmp ne ptr %20, null, !dbg !186
  br i1 %21, label %22, label %33, !dbg !185

22:                                               ; preds = %6
  %23 = call ptr @pvPortMalloc(i32 noundef 92), !dbg !187
  store ptr %23, ptr %13, align 4, !dbg !188
  %24 = load ptr, ptr %13, align 4, !dbg !189
  %25 = icmp ne ptr %24, null, !dbg !190
  br i1 %25, label %26, label %30, !dbg !189

26:                                               ; preds = %22
  %27 = load ptr, ptr %15, align 4, !dbg !191
  %28 = load ptr, ptr %13, align 4, !dbg !192
  %29 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %28, i32 0, i32 4, !dbg !193
  store ptr %27, ptr %29, align 4, !dbg !194
  br label %32, !dbg !195

30:                                               ; preds = %22
  %31 = load ptr, ptr %15, align 4, !dbg !196
  call void @vPortFree(ptr noundef %31), !dbg !197
  br label %32

32:                                               ; preds = %30, %26
  br label %34, !dbg !198

33:                                               ; preds = %6
  store ptr null, ptr %13, align 4, !dbg !199
  br label %34

34:                                               ; preds = %33, %32
  %35 = load ptr, ptr %13, align 4, !dbg !200
  %36 = icmp ne ptr %35, null, !dbg !201
  br i1 %36, label %37, label %49, !dbg !200

37:                                               ; preds = %34
  %38 = load ptr, ptr %13, align 4, !dbg !202
  %39 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %38, i32 0, i32 12, !dbg !203
  store i8 0, ptr %39, align 1, !dbg !204
  %40 = load ptr, ptr %7, align 4, !dbg !205
  %41 = load ptr, ptr %8, align 4, !dbg !206
  %42 = load i16, ptr %9, align 2, !dbg !207
  %43 = zext i16 %42 to i32, !dbg !208
  %44 = load ptr, ptr %10, align 4, !dbg !209
  %45 = load i32, ptr %11, align 4, !dbg !210
  %46 = load ptr, ptr %12, align 4, !dbg !211
  %47 = load ptr, ptr %13, align 4, !dbg !212
  call void @prvInitialiseNewTask(ptr noundef %40, ptr noundef %41, i32 noundef %43, ptr noundef %44, i32 noundef %45, ptr noundef %46, ptr noundef %47, ptr noundef null), !dbg !213
  %48 = load ptr, ptr %13, align 4, !dbg !214
  call void @prvAddNewTaskToReadyList(ptr noundef %48), !dbg !215
  store i32 1, ptr %14, align 4, !dbg !216
  br label %50, !dbg !217

49:                                               ; preds = %34
  store i32 -1, ptr %14, align 4, !dbg !218
  br label %50

50:                                               ; preds = %49, %37
  %51 = load i32, ptr %14, align 4, !dbg !219
  ret i32 %51, !dbg !220
}

declare dso_local ptr @pvPortMalloc(i32 noundef) #1

declare dso_local void @vPortFree(ptr noundef) #1

; Function Attrs: noinline nounwind
define dso_local void @vTaskDelete(ptr noundef %0) #0 !dbg !221 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  call void @vPortEnterCritical(), !dbg !222
  %4 = load ptr, ptr %2, align 4, !dbg !223
  %5 = icmp eq ptr %4, null, !dbg !223
  br i1 %5, label %6, label %8, !dbg !223

6:                                                ; preds = %1
  %7 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !223
  br label %10, !dbg !223

8:                                                ; preds = %1
  %9 = load ptr, ptr %2, align 4, !dbg !223
  br label %10, !dbg !223

10:                                               ; preds = %8, %6
  %11 = phi ptr [ %7, %6 ], [ %9, %8 ], !dbg !223
  store ptr %11, ptr %3, align 4, !dbg !224
  %12 = load ptr, ptr %3, align 4, !dbg !225
  %13 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %12, i32 0, i32 1, !dbg !226
  %14 = call i32 @uxListRemove(ptr noundef %13), !dbg !227
  %15 = icmp eq i32 %14, 0, !dbg !228
  br i1 %15, label %16, label %17, !dbg !227

16:                                               ; preds = %10
  br label %18, !dbg !229

17:                                               ; preds = %10
  br label %18

18:                                               ; preds = %17, %16
  %19 = load ptr, ptr %3, align 4, !dbg !230
  %20 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %19, i32 0, i32 2, !dbg !230
  %21 = getelementptr inbounds %struct.xLIST_ITEM, ptr %20, i32 0, i32 4, !dbg !230
  %22 = load ptr, ptr %21, align 4, !dbg !230
  %23 = icmp ne ptr %22, null, !dbg !231
  br i1 %23, label %24, label %28, !dbg !230

24:                                               ; preds = %18
  %25 = load ptr, ptr %3, align 4, !dbg !232
  %26 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %25, i32 0, i32 2, !dbg !233
  %27 = call i32 @uxListRemove(ptr noundef %26), !dbg !234
  br label %29, !dbg !235

28:                                               ; preds = %18
  br label %29

29:                                               ; preds = %28, %24
  %30 = load i32, ptr @uxTaskNumber, align 4, !dbg !236
  %31 = add i32 %30, 1, !dbg !236
  store i32 %31, ptr @uxTaskNumber, align 4, !dbg !236
  %32 = load ptr, ptr %3, align 4, !dbg !237
  %33 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !238
  %34 = icmp eq ptr %32, %33, !dbg !239
  br i1 %34, label %35, label %40, !dbg !237

35:                                               ; preds = %29
  %36 = load ptr, ptr %3, align 4, !dbg !240
  %37 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %36, i32 0, i32 1, !dbg !241
  call void @vListInsertEnd(ptr noundef @xTasksWaitingTermination, ptr noundef %37), !dbg !242
  %38 = load volatile i32, ptr @uxDeletedTasksWaitingCleanUp, align 4, !dbg !243
  %39 = add i32 %38, 1, !dbg !243
  store volatile i32 %39, ptr @uxDeletedTasksWaitingCleanUp, align 4, !dbg !243
  br label %43, !dbg !244

40:                                               ; preds = %29
  %41 = load volatile i32, ptr @uxCurrentNumberOfTasks, align 4, !dbg !245
  %42 = add i32 %41, -1, !dbg !245
  store volatile i32 %42, ptr @uxCurrentNumberOfTasks, align 4, !dbg !245
  call void @prvResetNextTaskUnblockTime(), !dbg !246
  br label %43

43:                                               ; preds = %40, %35
  call void @vPortExitCritical(), !dbg !247
  %44 = load ptr, ptr %3, align 4, !dbg !248
  %45 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !249
  %46 = icmp ne ptr %44, %45, !dbg !250
  br i1 %46, label %47, label %49, !dbg !248

47:                                               ; preds = %43
  %48 = load ptr, ptr %3, align 4, !dbg !251
  call void @prvDeleteTCB(ptr noundef %48), !dbg !252
  br label %49, !dbg !253

49:                                               ; preds = %47, %43
  %50 = load volatile i32, ptr @xSchedulerRunning, align 4, !dbg !254
  %51 = icmp ne i32 %50, 0, !dbg !255
  br i1 %51, label %52, label %59, !dbg !254

52:                                               ; preds = %49
  %53 = load ptr, ptr %3, align 4, !dbg !256
  %54 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !257
  %55 = icmp eq ptr %53, %54, !dbg !258
  br i1 %55, label %56, label %57, !dbg !256

56:                                               ; preds = %52
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !259
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !259, !srcloc !260
  call void asm sideeffect "isb", ""() #3, !dbg !259, !srcloc !261
  br label %58, !dbg !262

57:                                               ; preds = %52
  br label %58

58:                                               ; preds = %57, %56
  br label %59, !dbg !263

59:                                               ; preds = %58, %49
  ret void, !dbg !264
}

declare dso_local void @vPortEnterCritical() #1

declare dso_local i32 @uxListRemove(ptr noundef) #1

declare dso_local void @vListInsertEnd(ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind
define internal void @prvResetNextTaskUnblockTime() #0 !dbg !265 {
  %1 = load volatile ptr, ptr @pxDelayedTaskList, align 4, !dbg !266
  %2 = getelementptr inbounds %struct.xLIST, ptr %1, i32 0, i32 0, !dbg !266
  %3 = load volatile i32, ptr %2, align 4, !dbg !266
  %4 = icmp eq i32 %3, 0, !dbg !266
  %5 = zext i1 %4 to i64, !dbg !266
  %6 = select i1 %4, i32 1, i32 0, !dbg !266
  %7 = icmp ne i32 %6, 0, !dbg !267
  br i1 %7, label %8, label %9, !dbg !266

8:                                                ; preds = %0
  store volatile i32 -1, ptr @xNextTaskUnblockTime, align 4, !dbg !268
  br label %16, !dbg !269

9:                                                ; preds = %0
  %10 = load volatile ptr, ptr @pxDelayedTaskList, align 4, !dbg !270
  %11 = getelementptr inbounds %struct.xLIST, ptr %10, i32 0, i32 2, !dbg !270
  %12 = getelementptr inbounds %struct.xMINI_LIST_ITEM, ptr %11, i32 0, i32 1, !dbg !270
  %13 = load ptr, ptr %12, align 4, !dbg !270
  %14 = getelementptr inbounds %struct.xLIST_ITEM, ptr %13, i32 0, i32 0, !dbg !270
  %15 = load i32, ptr %14, align 4, !dbg !270
  store volatile i32 %15, ptr @xNextTaskUnblockTime, align 4, !dbg !271
  br label %16

16:                                               ; preds = %9, %8
  ret void, !dbg !272
}

declare dso_local void @vPortExitCritical() #1

; Function Attrs: noinline nounwind
define internal void @prvDeleteTCB(ptr noundef %0) #0 !dbg !273 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %3 = load ptr, ptr %2, align 4, !dbg !274
  %4 = load ptr, ptr %2, align 4, !dbg !275
  %5 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %4, i32 0, i32 12, !dbg !276
  %6 = load i8, ptr %5, align 1, !dbg !276
  %7 = zext i8 %6 to i32, !dbg !275
  %8 = icmp eq i32 %7, 0, !dbg !277
  br i1 %8, label %9, label %14, !dbg !275

9:                                                ; preds = %1
  %10 = load ptr, ptr %2, align 4, !dbg !278
  %11 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %10, i32 0, i32 4, !dbg !279
  %12 = load ptr, ptr %11, align 4, !dbg !279
  call void @vPortFree(ptr noundef %12), !dbg !280
  %13 = load ptr, ptr %2, align 4, !dbg !281
  call void @vPortFree(ptr noundef %13), !dbg !282
  br label %24, !dbg !283

14:                                               ; preds = %1
  %15 = load ptr, ptr %2, align 4, !dbg !284
  %16 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %15, i32 0, i32 12, !dbg !285
  %17 = load i8, ptr %16, align 1, !dbg !285
  %18 = zext i8 %17 to i32, !dbg !284
  %19 = icmp eq i32 %18, 1, !dbg !286
  br i1 %19, label %20, label %22, !dbg !284

20:                                               ; preds = %14
  %21 = load ptr, ptr %2, align 4, !dbg !287
  call void @vPortFree(ptr noundef %21), !dbg !288
  br label %23, !dbg !289

22:                                               ; preds = %14
  br label %23

23:                                               ; preds = %22, %20
  br label %24

24:                                               ; preds = %23, %9
  ret void, !dbg !290
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskDelayUntil(ptr noundef %0, i32 noundef %1) #0 !dbg !291 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %7, align 4, !dbg !292
  call void @vTaskSuspendAll(), !dbg !293
  %9 = load volatile i32, ptr @xTickCount, align 4, !dbg !294
  store i32 %9, ptr %8, align 4, !dbg !295
  %10 = load ptr, ptr %3, align 4, !dbg !296
  %11 = load i32, ptr %10, align 4, !dbg !297
  %12 = load i32, ptr %4, align 4, !dbg !298
  %13 = add i32 %11, %12, !dbg !299
  store i32 %13, ptr %5, align 4, !dbg !300
  %14 = load i32, ptr %8, align 4, !dbg !301
  %15 = load ptr, ptr %3, align 4, !dbg !302
  %16 = load i32, ptr %15, align 4, !dbg !303
  %17 = icmp ult i32 %14, %16, !dbg !304
  br i1 %17, label %18, label %30, !dbg !301

18:                                               ; preds = %2
  %19 = load i32, ptr %5, align 4, !dbg !305
  %20 = load ptr, ptr %3, align 4, !dbg !306
  %21 = load i32, ptr %20, align 4, !dbg !307
  %22 = icmp ult i32 %19, %21, !dbg !308
  br i1 %22, label %23, label %28, !dbg !309

23:                                               ; preds = %18
  %24 = load i32, ptr %5, align 4, !dbg !310
  %25 = load i32, ptr %8, align 4, !dbg !311
  %26 = icmp ugt i32 %24, %25, !dbg !312
  br i1 %26, label %27, label %28, !dbg !313

27:                                               ; preds = %23
  store i32 1, ptr %7, align 4, !dbg !314
  br label %29, !dbg !315

28:                                               ; preds = %23, %18
  br label %29

29:                                               ; preds = %28, %27
  br label %42, !dbg !316

30:                                               ; preds = %2
  %31 = load i32, ptr %5, align 4, !dbg !317
  %32 = load ptr, ptr %3, align 4, !dbg !318
  %33 = load i32, ptr %32, align 4, !dbg !319
  %34 = icmp ult i32 %31, %33, !dbg !320
  br i1 %34, label %39, label %35, !dbg !321

35:                                               ; preds = %30
  %36 = load i32, ptr %5, align 4, !dbg !322
  %37 = load i32, ptr %8, align 4, !dbg !323
  %38 = icmp ugt i32 %36, %37, !dbg !324
  br i1 %38, label %39, label %40, !dbg !325

39:                                               ; preds = %35, %30
  store i32 1, ptr %7, align 4, !dbg !326
  br label %41, !dbg !327

40:                                               ; preds = %35
  br label %41

41:                                               ; preds = %40, %39
  br label %42

42:                                               ; preds = %41, %29
  %43 = load i32, ptr %5, align 4, !dbg !328
  %44 = load ptr, ptr %3, align 4, !dbg !329
  store i32 %43, ptr %44, align 4, !dbg !330
  %45 = load i32, ptr %7, align 4, !dbg !331
  %46 = icmp ne i32 %45, 0, !dbg !332
  br i1 %46, label %47, label %51, !dbg !331

47:                                               ; preds = %42
  %48 = load i32, ptr %5, align 4, !dbg !333
  %49 = load i32, ptr %8, align 4, !dbg !334
  %50 = sub i32 %48, %49, !dbg !335
  call void @prvAddCurrentTaskToDelayedList(i32 noundef %50, i32 noundef 0), !dbg !336
  br label %52, !dbg !337

51:                                               ; preds = %42
  br label %52

52:                                               ; preds = %51, %47
  %53 = call i32 @xTaskResumeAll(), !dbg !338
  store i32 %53, ptr %6, align 4, !dbg !339
  %54 = load i32, ptr %6, align 4, !dbg !340
  %55 = icmp eq i32 %54, 0, !dbg !341
  br i1 %55, label %56, label %57, !dbg !340

56:                                               ; preds = %52
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !342
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !342, !srcloc !343
  call void asm sideeffect "isb", ""() #3, !dbg !342, !srcloc !344
  br label %58, !dbg !345

57:                                               ; preds = %52
  br label %58

58:                                               ; preds = %57, %56
  %59 = load i32, ptr %7, align 4, !dbg !346
  ret i32 %59, !dbg !347
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskSuspendAll() #0 !dbg !348 {
  %1 = load volatile i32, ptr @uxSchedulerSuspended, align 4, !dbg !349
  %2 = add i32 %1, 1, !dbg !349
  store volatile i32 %2, ptr @uxSchedulerSuspended, align 4, !dbg !349
  call void asm sideeffect "", "~{memory}"() #3, !dbg !350, !srcloc !351
  ret void, !dbg !352
}

; Function Attrs: noinline nounwind
define internal void @prvAddCurrentTaskToDelayedList(i32 noundef %0, i32 noundef %1) #0 !dbg !353 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %8 = load volatile i32, ptr @xTickCount, align 4, !dbg !354
  store i32 %8, ptr %6, align 4, !dbg !355
  %9 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !356
  %10 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %9, i32 0, i32 1, !dbg !357
  %11 = call i32 @uxListRemove(ptr noundef %10), !dbg !358
  %12 = icmp eq i32 %11, 0, !dbg !359
  br i1 %12, label %13, label %14, !dbg !358

13:                                               ; preds = %2
  br label %15, !dbg !360

14:                                               ; preds = %2
  br label %15

15:                                               ; preds = %14, %13
  %16 = load i32, ptr %3, align 4, !dbg !361
  %17 = icmp eq i32 %16, -1, !dbg !362
  br i1 %17, label %18, label %48, !dbg !363

18:                                               ; preds = %15
  %19 = load i32, ptr %4, align 4, !dbg !364
  %20 = icmp ne i32 %19, 0, !dbg !365
  br i1 %20, label %21, label %48, !dbg !366

21:                                               ; preds = %18
  %22 = load ptr, ptr getelementptr inbounds (%struct.xLIST, ptr @xSuspendedTaskList, i32 0, i32 1), align 4, !dbg !367
  store ptr %22, ptr %7, align 4, !dbg !367
  %23 = load ptr, ptr %7, align 4, !dbg !367
  %24 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !367
  %25 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %24, i32 0, i32 1, !dbg !367
  %26 = getelementptr inbounds %struct.xLIST_ITEM, ptr %25, i32 0, i32 1, !dbg !367
  store ptr %23, ptr %26, align 4, !dbg !367
  %27 = load ptr, ptr %7, align 4, !dbg !367
  %28 = getelementptr inbounds %struct.xLIST_ITEM, ptr %27, i32 0, i32 2, !dbg !367
  %29 = load ptr, ptr %28, align 4, !dbg !367
  %30 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !367
  %31 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %30, i32 0, i32 1, !dbg !367
  %32 = getelementptr inbounds %struct.xLIST_ITEM, ptr %31, i32 0, i32 2, !dbg !367
  store ptr %29, ptr %32, align 4, !dbg !367
  %33 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !367
  %34 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %33, i32 0, i32 1, !dbg !367
  %35 = load ptr, ptr %7, align 4, !dbg !367
  %36 = getelementptr inbounds %struct.xLIST_ITEM, ptr %35, i32 0, i32 2, !dbg !367
  %37 = load ptr, ptr %36, align 4, !dbg !367
  %38 = getelementptr inbounds %struct.xLIST_ITEM, ptr %37, i32 0, i32 1, !dbg !367
  store ptr %34, ptr %38, align 4, !dbg !367
  %39 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !367
  %40 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %39, i32 0, i32 1, !dbg !367
  %41 = load ptr, ptr %7, align 4, !dbg !367
  %42 = getelementptr inbounds %struct.xLIST_ITEM, ptr %41, i32 0, i32 2, !dbg !367
  store ptr %40, ptr %42, align 4, !dbg !367
  %43 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !367
  %44 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %43, i32 0, i32 1, !dbg !367
  %45 = getelementptr inbounds %struct.xLIST_ITEM, ptr %44, i32 0, i32 4, !dbg !367
  store ptr @xSuspendedTaskList, ptr %45, align 4, !dbg !367
  %46 = load volatile i32, ptr @xSuspendedTaskList, align 4, !dbg !367
  %47 = add i32 %46, 1, !dbg !367
  store volatile i32 %47, ptr @xSuspendedTaskList, align 4, !dbg !367
  br label %75, !dbg !368

48:                                               ; preds = %18, %15
  %49 = load i32, ptr %6, align 4, !dbg !369
  %50 = load i32, ptr %3, align 4, !dbg !370
  %51 = add i32 %49, %50, !dbg !371
  store i32 %51, ptr %5, align 4, !dbg !372
  %52 = load i32, ptr %5, align 4, !dbg !373
  %53 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !373
  %54 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %53, i32 0, i32 1, !dbg !373
  %55 = getelementptr inbounds %struct.xLIST_ITEM, ptr %54, i32 0, i32 0, !dbg !373
  store i32 %52, ptr %55, align 4, !dbg !373
  %56 = load i32, ptr %5, align 4, !dbg !374
  %57 = load i32, ptr %6, align 4, !dbg !375
  %58 = icmp ult i32 %56, %57, !dbg !376
  br i1 %58, label %59, label %63, !dbg !374

59:                                               ; preds = %48
  %60 = load volatile ptr, ptr @pxOverflowDelayedTaskList, align 4, !dbg !377
  %61 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !378
  %62 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %61, i32 0, i32 1, !dbg !379
  call void @vListInsert(ptr noundef %60, ptr noundef %62), !dbg !380
  br label %74, !dbg !381

63:                                               ; preds = %48
  %64 = load volatile ptr, ptr @pxDelayedTaskList, align 4, !dbg !382
  %65 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !383
  %66 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %65, i32 0, i32 1, !dbg !384
  call void @vListInsert(ptr noundef %64, ptr noundef %66), !dbg !385
  %67 = load i32, ptr %5, align 4, !dbg !386
  %68 = load volatile i32, ptr @xNextTaskUnblockTime, align 4, !dbg !387
  %69 = icmp ult i32 %67, %68, !dbg !388
  br i1 %69, label %70, label %72, !dbg !386

70:                                               ; preds = %63
  %71 = load i32, ptr %5, align 4, !dbg !389
  store volatile i32 %71, ptr @xNextTaskUnblockTime, align 4, !dbg !390
  br label %73, !dbg !391

72:                                               ; preds = %63
  br label %73

73:                                               ; preds = %72, %70
  br label %74

74:                                               ; preds = %73, %59
  br label %75

75:                                               ; preds = %74, %21
  ret void, !dbg !392
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskResumeAll() #0 !dbg !393 {
  %1 = alloca ptr, align 4
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  store ptr null, ptr %1, align 4, !dbg !394
  store i32 0, ptr %2, align 4, !dbg !395
  call void @vPortEnterCritical(), !dbg !396
  %7 = load volatile i32, ptr @uxSchedulerSuspended, align 4, !dbg !397
  %8 = add i32 %7, -1, !dbg !397
  store volatile i32 %8, ptr @uxSchedulerSuspended, align 4, !dbg !397
  %9 = load volatile i32, ptr @uxSchedulerSuspended, align 4, !dbg !398
  %10 = icmp eq i32 %9, 0, !dbg !399
  br i1 %10, label %11, label %200, !dbg !398

11:                                               ; preds = %0
  %12 = load volatile i32, ptr @uxCurrentNumberOfTasks, align 4, !dbg !400
  %13 = icmp ugt i32 %12, 0, !dbg !401
  br i1 %13, label %14, label %199, !dbg !400

14:                                               ; preds = %11
  br label %15, !dbg !402

15:                                               ; preds = %170, %14
  %16 = load volatile i32, ptr @xPendingReadyList, align 4, !dbg !403
  %17 = icmp eq i32 %16, 0, !dbg !403
  %18 = zext i1 %17 to i64, !dbg !403
  %19 = select i1 %17, i32 1, i32 0, !dbg !403
  %20 = icmp eq i32 %19, 0, !dbg !404
  br i1 %20, label %21, label %171, !dbg !402

21:                                               ; preds = %15
  %22 = load ptr, ptr getelementptr inbounds (%struct.xLIST, ptr @xPendingReadyList, i32 0, i32 2, i32 1), align 4, !dbg !405
  %23 = getelementptr inbounds %struct.xLIST_ITEM, ptr %22, i32 0, i32 3, !dbg !405
  %24 = load ptr, ptr %23, align 4, !dbg !405
  store ptr %24, ptr %1, align 4, !dbg !406
  %25 = load ptr, ptr %1, align 4, !dbg !407
  %26 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %25, i32 0, i32 2, !dbg !407
  %27 = getelementptr inbounds %struct.xLIST_ITEM, ptr %26, i32 0, i32 4, !dbg !407
  %28 = load ptr, ptr %27, align 4, !dbg !407
  store ptr %28, ptr %3, align 4, !dbg !407
  %29 = load ptr, ptr %1, align 4, !dbg !407
  %30 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %29, i32 0, i32 2, !dbg !407
  %31 = getelementptr inbounds %struct.xLIST_ITEM, ptr %30, i32 0, i32 2, !dbg !407
  %32 = load ptr, ptr %31, align 4, !dbg !407
  %33 = load ptr, ptr %1, align 4, !dbg !407
  %34 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %33, i32 0, i32 2, !dbg !407
  %35 = getelementptr inbounds %struct.xLIST_ITEM, ptr %34, i32 0, i32 1, !dbg !407
  %36 = load ptr, ptr %35, align 4, !dbg !407
  %37 = getelementptr inbounds %struct.xLIST_ITEM, ptr %36, i32 0, i32 2, !dbg !407
  store ptr %32, ptr %37, align 4, !dbg !407
  %38 = load ptr, ptr %1, align 4, !dbg !407
  %39 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %38, i32 0, i32 2, !dbg !407
  %40 = getelementptr inbounds %struct.xLIST_ITEM, ptr %39, i32 0, i32 1, !dbg !407
  %41 = load ptr, ptr %40, align 4, !dbg !407
  %42 = load ptr, ptr %1, align 4, !dbg !407
  %43 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %42, i32 0, i32 2, !dbg !407
  %44 = getelementptr inbounds %struct.xLIST_ITEM, ptr %43, i32 0, i32 2, !dbg !407
  %45 = load ptr, ptr %44, align 4, !dbg !407
  %46 = getelementptr inbounds %struct.xLIST_ITEM, ptr %45, i32 0, i32 1, !dbg !407
  store ptr %41, ptr %46, align 4, !dbg !407
  %47 = load ptr, ptr %3, align 4, !dbg !407
  %48 = getelementptr inbounds %struct.xLIST, ptr %47, i32 0, i32 1, !dbg !407
  %49 = load ptr, ptr %48, align 4, !dbg !407
  %50 = load ptr, ptr %1, align 4, !dbg !407
  %51 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %50, i32 0, i32 2, !dbg !407
  %52 = icmp eq ptr %49, %51, !dbg !407
  br i1 %52, label %53, label %60, !dbg !407

53:                                               ; preds = %21
  %54 = load ptr, ptr %1, align 4, !dbg !407
  %55 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %54, i32 0, i32 2, !dbg !407
  %56 = getelementptr inbounds %struct.xLIST_ITEM, ptr %55, i32 0, i32 2, !dbg !407
  %57 = load ptr, ptr %56, align 4, !dbg !407
  %58 = load ptr, ptr %3, align 4, !dbg !407
  %59 = getelementptr inbounds %struct.xLIST, ptr %58, i32 0, i32 1, !dbg !407
  store ptr %57, ptr %59, align 4, !dbg !407
  br label %60, !dbg !407

60:                                               ; preds = %53, %21
  %61 = load ptr, ptr %1, align 4, !dbg !407
  %62 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %61, i32 0, i32 2, !dbg !407
  %63 = getelementptr inbounds %struct.xLIST_ITEM, ptr %62, i32 0, i32 4, !dbg !407
  store ptr null, ptr %63, align 4, !dbg !407
  %64 = load ptr, ptr %3, align 4, !dbg !407
  %65 = getelementptr inbounds %struct.xLIST, ptr %64, i32 0, i32 0, !dbg !407
  %66 = load volatile i32, ptr %65, align 4, !dbg !407
  %67 = add i32 %66, -1, !dbg !407
  store volatile i32 %67, ptr %65, align 4, !dbg !407
  call void asm sideeffect "", "~{memory}"() #3, !dbg !408, !srcloc !409
  %68 = load ptr, ptr %1, align 4, !dbg !410
  %69 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %68, i32 0, i32 1, !dbg !410
  %70 = getelementptr inbounds %struct.xLIST_ITEM, ptr %69, i32 0, i32 4, !dbg !410
  %71 = load ptr, ptr %70, align 4, !dbg !410
  store ptr %71, ptr %4, align 4, !dbg !410
  %72 = load ptr, ptr %1, align 4, !dbg !410
  %73 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %72, i32 0, i32 1, !dbg !410
  %74 = getelementptr inbounds %struct.xLIST_ITEM, ptr %73, i32 0, i32 2, !dbg !410
  %75 = load ptr, ptr %74, align 4, !dbg !410
  %76 = load ptr, ptr %1, align 4, !dbg !410
  %77 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %76, i32 0, i32 1, !dbg !410
  %78 = getelementptr inbounds %struct.xLIST_ITEM, ptr %77, i32 0, i32 1, !dbg !410
  %79 = load ptr, ptr %78, align 4, !dbg !410
  %80 = getelementptr inbounds %struct.xLIST_ITEM, ptr %79, i32 0, i32 2, !dbg !410
  store ptr %75, ptr %80, align 4, !dbg !410
  %81 = load ptr, ptr %1, align 4, !dbg !410
  %82 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %81, i32 0, i32 1, !dbg !410
  %83 = getelementptr inbounds %struct.xLIST_ITEM, ptr %82, i32 0, i32 1, !dbg !410
  %84 = load ptr, ptr %83, align 4, !dbg !410
  %85 = load ptr, ptr %1, align 4, !dbg !410
  %86 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %85, i32 0, i32 1, !dbg !410
  %87 = getelementptr inbounds %struct.xLIST_ITEM, ptr %86, i32 0, i32 2, !dbg !410
  %88 = load ptr, ptr %87, align 4, !dbg !410
  %89 = getelementptr inbounds %struct.xLIST_ITEM, ptr %88, i32 0, i32 1, !dbg !410
  store ptr %84, ptr %89, align 4, !dbg !410
  %90 = load ptr, ptr %4, align 4, !dbg !410
  %91 = getelementptr inbounds %struct.xLIST, ptr %90, i32 0, i32 1, !dbg !410
  %92 = load ptr, ptr %91, align 4, !dbg !410
  %93 = load ptr, ptr %1, align 4, !dbg !410
  %94 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %93, i32 0, i32 1, !dbg !410
  %95 = icmp eq ptr %92, %94, !dbg !410
  br i1 %95, label %96, label %103, !dbg !410

96:                                               ; preds = %60
  %97 = load ptr, ptr %1, align 4, !dbg !410
  %98 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %97, i32 0, i32 1, !dbg !410
  %99 = getelementptr inbounds %struct.xLIST_ITEM, ptr %98, i32 0, i32 2, !dbg !410
  %100 = load ptr, ptr %99, align 4, !dbg !410
  %101 = load ptr, ptr %4, align 4, !dbg !410
  %102 = getelementptr inbounds %struct.xLIST, ptr %101, i32 0, i32 1, !dbg !410
  store ptr %100, ptr %102, align 4, !dbg !410
  br label %103, !dbg !410

103:                                              ; preds = %96, %60
  %104 = load ptr, ptr %1, align 4, !dbg !410
  %105 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %104, i32 0, i32 1, !dbg !410
  %106 = getelementptr inbounds %struct.xLIST_ITEM, ptr %105, i32 0, i32 4, !dbg !410
  store ptr null, ptr %106, align 4, !dbg !410
  %107 = load ptr, ptr %4, align 4, !dbg !410
  %108 = getelementptr inbounds %struct.xLIST, ptr %107, i32 0, i32 0, !dbg !410
  %109 = load volatile i32, ptr %108, align 4, !dbg !410
  %110 = add i32 %109, -1, !dbg !410
  store volatile i32 %110, ptr %108, align 4, !dbg !410
  %111 = load ptr, ptr %1, align 4, !dbg !411
  %112 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %111, i32 0, i32 3, !dbg !411
  %113 = load i32, ptr %112, align 4, !dbg !411
  %114 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !411
  %115 = icmp ugt i32 %113, %114, !dbg !411
  br i1 %115, label %116, label %120, !dbg !411

116:                                              ; preds = %103
  %117 = load ptr, ptr %1, align 4, !dbg !411
  %118 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %117, i32 0, i32 3, !dbg !411
  %119 = load i32, ptr %118, align 4, !dbg !411
  store volatile i32 %119, ptr @uxTopReadyPriority, align 4, !dbg !411
  br label %120, !dbg !411

120:                                              ; preds = %116, %103
  %121 = load ptr, ptr %1, align 4, !dbg !411
  %122 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %121, i32 0, i32 3, !dbg !411
  %123 = load i32, ptr %122, align 4, !dbg !411
  %124 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %123, !dbg !411
  %125 = getelementptr inbounds %struct.xLIST, ptr %124, i32 0, i32 1, !dbg !411
  %126 = load ptr, ptr %125, align 4, !dbg !411
  store ptr %126, ptr %5, align 4, !dbg !411
  %127 = load ptr, ptr %5, align 4, !dbg !411
  %128 = load ptr, ptr %1, align 4, !dbg !411
  %129 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %128, i32 0, i32 1, !dbg !411
  %130 = getelementptr inbounds %struct.xLIST_ITEM, ptr %129, i32 0, i32 1, !dbg !411
  store ptr %127, ptr %130, align 4, !dbg !411
  %131 = load ptr, ptr %5, align 4, !dbg !411
  %132 = getelementptr inbounds %struct.xLIST_ITEM, ptr %131, i32 0, i32 2, !dbg !411
  %133 = load ptr, ptr %132, align 4, !dbg !411
  %134 = load ptr, ptr %1, align 4, !dbg !411
  %135 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %134, i32 0, i32 1, !dbg !411
  %136 = getelementptr inbounds %struct.xLIST_ITEM, ptr %135, i32 0, i32 2, !dbg !411
  store ptr %133, ptr %136, align 4, !dbg !411
  %137 = load ptr, ptr %1, align 4, !dbg !411
  %138 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %137, i32 0, i32 1, !dbg !411
  %139 = load ptr, ptr %5, align 4, !dbg !411
  %140 = getelementptr inbounds %struct.xLIST_ITEM, ptr %139, i32 0, i32 2, !dbg !411
  %141 = load ptr, ptr %140, align 4, !dbg !411
  %142 = getelementptr inbounds %struct.xLIST_ITEM, ptr %141, i32 0, i32 1, !dbg !411
  store ptr %138, ptr %142, align 4, !dbg !411
  %143 = load ptr, ptr %1, align 4, !dbg !411
  %144 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %143, i32 0, i32 1, !dbg !411
  %145 = load ptr, ptr %5, align 4, !dbg !411
  %146 = getelementptr inbounds %struct.xLIST_ITEM, ptr %145, i32 0, i32 2, !dbg !411
  store ptr %144, ptr %146, align 4, !dbg !411
  %147 = load ptr, ptr %1, align 4, !dbg !411
  %148 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %147, i32 0, i32 3, !dbg !411
  %149 = load i32, ptr %148, align 4, !dbg !411
  %150 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %149, !dbg !411
  %151 = load ptr, ptr %1, align 4, !dbg !411
  %152 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %151, i32 0, i32 1, !dbg !411
  %153 = getelementptr inbounds %struct.xLIST_ITEM, ptr %152, i32 0, i32 4, !dbg !411
  store ptr %150, ptr %153, align 4, !dbg !411
  %154 = load ptr, ptr %1, align 4, !dbg !411
  %155 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %154, i32 0, i32 3, !dbg !411
  %156 = load i32, ptr %155, align 4, !dbg !411
  %157 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %156, !dbg !411
  %158 = getelementptr inbounds %struct.xLIST, ptr %157, i32 0, i32 0, !dbg !411
  %159 = load volatile i32, ptr %158, align 4, !dbg !411
  %160 = add i32 %159, 1, !dbg !411
  store volatile i32 %160, ptr %158, align 4, !dbg !411
  %161 = load ptr, ptr %1, align 4, !dbg !412
  %162 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %161, i32 0, i32 3, !dbg !413
  %163 = load i32, ptr %162, align 4, !dbg !413
  %164 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !414
  %165 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %164, i32 0, i32 3, !dbg !415
  %166 = load i32, ptr %165, align 4, !dbg !415
  %167 = icmp uge i32 %163, %166, !dbg !416
  br i1 %167, label %168, label %169, !dbg !412

168:                                              ; preds = %120
  store volatile i32 1, ptr @xYieldPending, align 4, !dbg !417
  br label %170, !dbg !418

169:                                              ; preds = %120
  br label %170

170:                                              ; preds = %169, %168
  br label %15, !dbg !402, !llvm.loop !419

171:                                              ; preds = %15
  %172 = load ptr, ptr %1, align 4, !dbg !421
  %173 = icmp ne ptr %172, null, !dbg !422
  br i1 %173, label %174, label %175, !dbg !421

174:                                              ; preds = %171
  call void @prvResetNextTaskUnblockTime(), !dbg !423
  br label %175, !dbg !424

175:                                              ; preds = %174, %171
  %176 = load volatile i32, ptr @xPendedTicks, align 4, !dbg !425
  store i32 %176, ptr %6, align 4, !dbg !426
  %177 = load i32, ptr %6, align 4, !dbg !427
  %178 = icmp ugt i32 %177, 0, !dbg !428
  br i1 %178, label %179, label %192, !dbg !427

179:                                              ; preds = %175
  br label %180, !dbg !429

180:                                              ; preds = %188, %179
  %181 = call i32 @xTaskIncrementTick(), !dbg !430
  %182 = icmp ne i32 %181, 0, !dbg !431
  br i1 %182, label %183, label %184, !dbg !430

183:                                              ; preds = %180
  store volatile i32 1, ptr @xYieldPending, align 4, !dbg !432
  br label %185, !dbg !433

184:                                              ; preds = %180
  br label %185

185:                                              ; preds = %184, %183
  %186 = load i32, ptr %6, align 4, !dbg !434
  %187 = add i32 %186, -1, !dbg !434
  store i32 %187, ptr %6, align 4, !dbg !434
  br label %188, !dbg !435

188:                                              ; preds = %185
  %189 = load i32, ptr %6, align 4, !dbg !436
  %190 = icmp ugt i32 %189, 0, !dbg !437
  br i1 %190, label %180, label %191, !dbg !435, !llvm.loop !438

191:                                              ; preds = %188
  store volatile i32 0, ptr @xPendedTicks, align 4, !dbg !440
  br label %193, !dbg !441

192:                                              ; preds = %175
  br label %193

193:                                              ; preds = %192, %191
  %194 = load volatile i32, ptr @xYieldPending, align 4, !dbg !442
  %195 = icmp ne i32 %194, 0, !dbg !443
  br i1 %195, label %196, label %197, !dbg !442

196:                                              ; preds = %193
  store i32 1, ptr %2, align 4, !dbg !444
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !445
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !445, !srcloc !446
  call void asm sideeffect "isb", ""() #3, !dbg !445, !srcloc !447
  br label %198, !dbg !448

197:                                              ; preds = %193
  br label %198

198:                                              ; preds = %197, %196
  br label %199, !dbg !449

199:                                              ; preds = %198, %11
  br label %201, !dbg !450

200:                                              ; preds = %0
  br label %201

201:                                              ; preds = %200, %199
  call void @vPortExitCritical(), !dbg !451
  %202 = load i32, ptr %2, align 4, !dbg !452
  ret i32 %202, !dbg !453
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskDelay(i32 noundef %0) #0 !dbg !454 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4, !dbg !455
  %4 = load i32, ptr %2, align 4, !dbg !456
  %5 = icmp ugt i32 %4, 0, !dbg !457
  br i1 %5, label %6, label %9, !dbg !456

6:                                                ; preds = %1
  call void @vTaskSuspendAll(), !dbg !458
  %7 = load i32, ptr %2, align 4, !dbg !459
  call void @prvAddCurrentTaskToDelayedList(i32 noundef %7, i32 noundef 0), !dbg !460
  %8 = call i32 @xTaskResumeAll(), !dbg !461
  store i32 %8, ptr %3, align 4, !dbg !462
  br label %10, !dbg !463

9:                                                ; preds = %1
  br label %10

10:                                               ; preds = %9, %6
  %11 = load i32, ptr %3, align 4, !dbg !464
  %12 = icmp eq i32 %11, 0, !dbg !465
  br i1 %12, label %13, label %14, !dbg !464

13:                                               ; preds = %10
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !466
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !466, !srcloc !467
  call void asm sideeffect "isb", ""() #3, !dbg !466, !srcloc !468
  br label %15, !dbg !469

14:                                               ; preds = %10
  br label %15

15:                                               ; preds = %14, %13
  ret void, !dbg !470
}

; Function Attrs: noinline nounwind
define dso_local i32 @eTaskGetState(ptr noundef %0) #0 !dbg !471 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca ptr, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  %9 = load ptr, ptr %2, align 4, !dbg !472
  store ptr %9, ptr %7, align 4, !dbg !473
  %10 = load ptr, ptr %7, align 4, !dbg !474
  %11 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !475
  %12 = icmp eq ptr %10, %11, !dbg !476
  br i1 %12, label %13, label %14, !dbg !474

13:                                               ; preds = %1
  store i32 0, ptr %3, align 4, !dbg !477
  br label %69, !dbg !478

14:                                               ; preds = %1
  call void @vPortEnterCritical(), !dbg !479
  %15 = load ptr, ptr %7, align 4, !dbg !480
  %16 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %15, i32 0, i32 1, !dbg !480
  %17 = getelementptr inbounds %struct.xLIST_ITEM, ptr %16, i32 0, i32 4, !dbg !480
  %18 = load ptr, ptr %17, align 4, !dbg !480
  store ptr %18, ptr %4, align 4, !dbg !481
  %19 = load volatile ptr, ptr @pxDelayedTaskList, align 4, !dbg !482
  store ptr %19, ptr %5, align 4, !dbg !483
  %20 = load volatile ptr, ptr @pxOverflowDelayedTaskList, align 4, !dbg !484
  store ptr %20, ptr %6, align 4, !dbg !485
  call void @vPortExitCritical(), !dbg !486
  %21 = load ptr, ptr %4, align 4, !dbg !487
  %22 = load ptr, ptr %5, align 4, !dbg !488
  %23 = icmp eq ptr %21, %22, !dbg !489
  br i1 %23, label %28, label %24, !dbg !490

24:                                               ; preds = %14
  %25 = load ptr, ptr %4, align 4, !dbg !491
  %26 = load ptr, ptr %6, align 4, !dbg !492
  %27 = icmp eq ptr %25, %26, !dbg !493
  br i1 %27, label %28, label %29, !dbg !494

28:                                               ; preds = %24, %14
  store i32 2, ptr %3, align 4, !dbg !495
  br label %68, !dbg !496

29:                                               ; preds = %24
  %30 = load ptr, ptr %4, align 4, !dbg !497
  %31 = icmp eq ptr %30, @xSuspendedTaskList, !dbg !498
  br i1 %31, label %32, label %58, !dbg !497

32:                                               ; preds = %29
  %33 = load ptr, ptr %7, align 4, !dbg !499
  %34 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %33, i32 0, i32 2, !dbg !499
  %35 = getelementptr inbounds %struct.xLIST_ITEM, ptr %34, i32 0, i32 4, !dbg !499
  %36 = load ptr, ptr %35, align 4, !dbg !499
  %37 = icmp eq ptr %36, null, !dbg !500
  br i1 %37, label %38, label %56, !dbg !499

38:                                               ; preds = %32
  store i32 3, ptr %3, align 4, !dbg !501
  store i32 0, ptr %8, align 4, !dbg !502
  br label %39, !dbg !503

39:                                               ; preds = %52, %38
  %40 = load i32, ptr %8, align 4, !dbg !504
  %41 = icmp slt i32 %40, 1, !dbg !505
  br i1 %41, label %42, label %55, !dbg !506

42:                                               ; preds = %39
  %43 = load ptr, ptr %7, align 4, !dbg !507
  %44 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %43, i32 0, i32 11, !dbg !508
  %45 = load i32, ptr %8, align 4, !dbg !509
  %46 = getelementptr inbounds [1 x i8], ptr %44, i32 0, i32 %45, !dbg !507
  %47 = load volatile i8, ptr %46, align 1, !dbg !507
  %48 = zext i8 %47 to i32, !dbg !507
  %49 = icmp eq i32 %48, 1, !dbg !510
  br i1 %49, label %50, label %51, !dbg !507

50:                                               ; preds = %42
  store i32 2, ptr %3, align 4, !dbg !511
  br label %55, !dbg !512

51:                                               ; preds = %42
  br label %52, !dbg !513

52:                                               ; preds = %51
  %53 = load i32, ptr %8, align 4, !dbg !514
  %54 = add nsw i32 %53, 1, !dbg !514
  store i32 %54, ptr %8, align 4, !dbg !514
  br label %39, !dbg !506, !llvm.loop !515

55:                                               ; preds = %50, %39
  br label %57, !dbg !516

56:                                               ; preds = %32
  store i32 2, ptr %3, align 4, !dbg !517
  br label %57

57:                                               ; preds = %56, %55
  br label %67, !dbg !518

58:                                               ; preds = %29
  %59 = load ptr, ptr %4, align 4, !dbg !519
  %60 = icmp eq ptr %59, @xTasksWaitingTermination, !dbg !520
  br i1 %60, label %64, label %61, !dbg !521

61:                                               ; preds = %58
  %62 = load ptr, ptr %4, align 4, !dbg !522
  %63 = icmp eq ptr %62, null, !dbg !523
  br i1 %63, label %64, label %65, !dbg !524

64:                                               ; preds = %61, %58
  store i32 4, ptr %3, align 4, !dbg !525
  br label %66, !dbg !526

65:                                               ; preds = %61
  store i32 1, ptr %3, align 4, !dbg !527
  br label %66

66:                                               ; preds = %65, %64
  br label %67

67:                                               ; preds = %66, %57
  br label %68

68:                                               ; preds = %67, %28
  br label %69

69:                                               ; preds = %68, %13
  %70 = load i32, ptr %3, align 4, !dbg !528
  ret i32 %70, !dbg !529
}

; Function Attrs: noinline nounwind
define dso_local i32 @uxTaskPriorityGet(ptr noundef %0) #0 !dbg !530 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  call void @vPortEnterCritical(), !dbg !531
  %5 = load ptr, ptr %2, align 4, !dbg !532
  %6 = icmp eq ptr %5, null, !dbg !532
  br i1 %6, label %7, label %9, !dbg !532

7:                                                ; preds = %1
  %8 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !532
  br label %11, !dbg !532

9:                                                ; preds = %1
  %10 = load ptr, ptr %2, align 4, !dbg !532
  br label %11, !dbg !532

11:                                               ; preds = %9, %7
  %12 = phi ptr [ %8, %7 ], [ %10, %9 ], !dbg !532
  store ptr %12, ptr %3, align 4, !dbg !533
  %13 = load ptr, ptr %3, align 4, !dbg !534
  %14 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %13, i32 0, i32 3, !dbg !535
  %15 = load i32, ptr %14, align 4, !dbg !535
  store i32 %15, ptr %4, align 4, !dbg !536
  call void @vPortExitCritical(), !dbg !537
  %16 = load i32, ptr %4, align 4, !dbg !538
  ret i32 %16, !dbg !539
}

; Function Attrs: noinline nounwind
define dso_local i32 @uxTaskPriorityGetFromISR(ptr noundef %0) #0 !dbg !540 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %5, align 4
  %9 = call { i32, i32 } asm sideeffect "\09mrs $0, basepri\09\09\09\09\09\09\09\09\09\09\09\0A\09mov $1, $2\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $1\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,=r,i,~{memory}"(i32 80) #3, !dbg !541, !srcloc !545
  %10 = extractvalue { i32, i32 } %9, 0, !dbg !541
  %11 = extractvalue { i32, i32 } %9, 1, !dbg !541
  store i32 %10, ptr %3, align 4, !dbg !541
  store i32 %11, ptr %4, align 4, !dbg !541
  %12 = load i32, ptr %3, align 4, !dbg !546
  store i32 %12, ptr %8, align 4, !dbg !547
  %13 = load ptr, ptr %5, align 4, !dbg !548
  %14 = icmp eq ptr %13, null, !dbg !548
  br i1 %14, label %15, label %17, !dbg !548

15:                                               ; preds = %1
  %16 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !548
  br label %19, !dbg !548

17:                                               ; preds = %1
  %18 = load ptr, ptr %5, align 4, !dbg !548
  br label %19, !dbg !548

19:                                               ; preds = %17, %15
  %20 = phi ptr [ %16, %15 ], [ %18, %17 ], !dbg !548
  store ptr %20, ptr %6, align 4, !dbg !549
  %21 = load ptr, ptr %6, align 4, !dbg !550
  %22 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %21, i32 0, i32 3, !dbg !551
  %23 = load i32, ptr %22, align 4, !dbg !551
  store i32 %23, ptr %7, align 4, !dbg !552
  %24 = load i32, ptr %8, align 4, !dbg !553
  store i32 %24, ptr %2, align 4
  %25 = load i32, ptr %2, align 4, !dbg !554
  call void asm sideeffect "\09msr basepri, $0\09", "r,~{memory}"(i32 %25) #3, !dbg !557, !srcloc !558
  %26 = load i32, ptr %7, align 4, !dbg !559
  ret i32 %26, !dbg !560
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskPrioritySet(ptr noundef %0, i32 noundef %1) #0 !dbg !561 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %8, align 4, !dbg !562
  %10 = load i32, ptr %4, align 4, !dbg !563
  %11 = icmp uge i32 %10, 56, !dbg !564
  br i1 %11, label %12, label %13, !dbg !563

12:                                               ; preds = %2
  store i32 55, ptr %4, align 4, !dbg !565
  br label %14, !dbg !566

13:                                               ; preds = %2
  br label %14

14:                                               ; preds = %13, %12
  call void @vPortEnterCritical(), !dbg !567
  %15 = load ptr, ptr %3, align 4, !dbg !568
  %16 = icmp eq ptr %15, null, !dbg !568
  br i1 %16, label %17, label %19, !dbg !568

17:                                               ; preds = %14
  %18 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !568
  br label %21, !dbg !568

19:                                               ; preds = %14
  %20 = load ptr, ptr %3, align 4, !dbg !568
  br label %21, !dbg !568

21:                                               ; preds = %19, %17
  %22 = phi ptr [ %18, %17 ], [ %20, %19 ], !dbg !568
  store ptr %22, ptr %5, align 4, !dbg !569
  %23 = load ptr, ptr %5, align 4, !dbg !570
  %24 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %23, i32 0, i32 8, !dbg !571
  %25 = load i32, ptr %24, align 4, !dbg !571
  store i32 %25, ptr %6, align 4, !dbg !572
  %26 = load i32, ptr %6, align 4, !dbg !573
  %27 = load i32, ptr %4, align 4, !dbg !574
  %28 = icmp ne i32 %26, %27, !dbg !575
  br i1 %28, label %29, label %165, !dbg !573

29:                                               ; preds = %21
  %30 = load i32, ptr %4, align 4, !dbg !576
  %31 = load i32, ptr %6, align 4, !dbg !577
  %32 = icmp ugt i32 %30, %31, !dbg !578
  br i1 %32, label %33, label %48, !dbg !576

33:                                               ; preds = %29
  %34 = load ptr, ptr %5, align 4, !dbg !579
  %35 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !580
  %36 = icmp ne ptr %34, %35, !dbg !581
  br i1 %36, label %37, label %46, !dbg !579

37:                                               ; preds = %33
  %38 = load i32, ptr %4, align 4, !dbg !582
  %39 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !583
  %40 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %39, i32 0, i32 3, !dbg !584
  %41 = load i32, ptr %40, align 4, !dbg !584
  %42 = icmp uge i32 %38, %41, !dbg !585
  br i1 %42, label %43, label %44, !dbg !582

43:                                               ; preds = %37
  store i32 1, ptr %8, align 4, !dbg !586
  br label %45, !dbg !587

44:                                               ; preds = %37
  br label %45

45:                                               ; preds = %44, %43
  br label %47, !dbg !588

46:                                               ; preds = %33
  br label %47

47:                                               ; preds = %46, %45
  br label %55, !dbg !589

48:                                               ; preds = %29
  %49 = load ptr, ptr %5, align 4, !dbg !590
  %50 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !591
  %51 = icmp eq ptr %49, %50, !dbg !592
  br i1 %51, label %52, label %53, !dbg !590

52:                                               ; preds = %48
  store i32 1, ptr %8, align 4, !dbg !593
  br label %54, !dbg !594

53:                                               ; preds = %48
  br label %54

54:                                               ; preds = %53, %52
  br label %55

55:                                               ; preds = %54, %47
  %56 = load ptr, ptr %5, align 4, !dbg !595
  %57 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %56, i32 0, i32 3, !dbg !596
  %58 = load i32, ptr %57, align 4, !dbg !596
  store i32 %58, ptr %7, align 4, !dbg !597
  %59 = load ptr, ptr %5, align 4, !dbg !598
  %60 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %59, i32 0, i32 8, !dbg !599
  %61 = load i32, ptr %60, align 4, !dbg !599
  %62 = load ptr, ptr %5, align 4, !dbg !600
  %63 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %62, i32 0, i32 3, !dbg !601
  %64 = load i32, ptr %63, align 4, !dbg !601
  %65 = icmp eq i32 %61, %64, !dbg !602
  br i1 %65, label %66, label %70, !dbg !598

66:                                               ; preds = %55
  %67 = load i32, ptr %4, align 4, !dbg !603
  %68 = load ptr, ptr %5, align 4, !dbg !604
  %69 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %68, i32 0, i32 3, !dbg !605
  store i32 %67, ptr %69, align 4, !dbg !606
  br label %71, !dbg !607

70:                                               ; preds = %55
  br label %71

71:                                               ; preds = %70, %66
  %72 = load i32, ptr %4, align 4, !dbg !608
  %73 = load ptr, ptr %5, align 4, !dbg !609
  %74 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %73, i32 0, i32 8, !dbg !610
  store i32 %72, ptr %74, align 4, !dbg !611
  %75 = load ptr, ptr %5, align 4, !dbg !612
  %76 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %75, i32 0, i32 2, !dbg !612
  %77 = getelementptr inbounds %struct.xLIST_ITEM, ptr %76, i32 0, i32 0, !dbg !612
  %78 = load i32, ptr %77, align 4, !dbg !612
  %79 = and i32 %78, -2147483648, !dbg !613
  %80 = icmp eq i32 %79, 0, !dbg !614
  br i1 %80, label %81, label %87, !dbg !615

81:                                               ; preds = %71
  %82 = load i32, ptr %4, align 4, !dbg !616
  %83 = sub i32 56, %82, !dbg !616
  %84 = load ptr, ptr %5, align 4, !dbg !616
  %85 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %84, i32 0, i32 2, !dbg !616
  %86 = getelementptr inbounds %struct.xLIST_ITEM, ptr %85, i32 0, i32 0, !dbg !616
  store i32 %83, ptr %86, align 4, !dbg !616
  br label %88, !dbg !617

87:                                               ; preds = %71
  br label %88

88:                                               ; preds = %87, %81
  %89 = load ptr, ptr %5, align 4, !dbg !618
  %90 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %89, i32 0, i32 1, !dbg !618
  %91 = getelementptr inbounds %struct.xLIST_ITEM, ptr %90, i32 0, i32 4, !dbg !618
  %92 = load ptr, ptr %91, align 4, !dbg !618
  %93 = load i32, ptr %7, align 4, !dbg !618
  %94 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %93, !dbg !618
  %95 = icmp eq ptr %92, %94, !dbg !618
  %96 = zext i1 %95 to i64, !dbg !618
  %97 = select i1 %95, i32 1, i32 0, !dbg !618
  %98 = icmp ne i32 %97, 0, !dbg !619
  br i1 %98, label %99, label %157, !dbg !618

99:                                               ; preds = %88
  %100 = load ptr, ptr %5, align 4, !dbg !620
  %101 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %100, i32 0, i32 1, !dbg !621
  %102 = call i32 @uxListRemove(ptr noundef %101), !dbg !622
  %103 = icmp eq i32 %102, 0, !dbg !623
  br i1 %103, label %104, label %105, !dbg !622

104:                                              ; preds = %99
  br label %106, !dbg !624

105:                                              ; preds = %99
  br label %106

106:                                              ; preds = %105, %104
  %107 = load ptr, ptr %5, align 4, !dbg !625
  %108 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %107, i32 0, i32 3, !dbg !625
  %109 = load i32, ptr %108, align 4, !dbg !625
  %110 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !625
  %111 = icmp ugt i32 %109, %110, !dbg !625
  br i1 %111, label %112, label %116, !dbg !625

112:                                              ; preds = %106
  %113 = load ptr, ptr %5, align 4, !dbg !625
  %114 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %113, i32 0, i32 3, !dbg !625
  %115 = load i32, ptr %114, align 4, !dbg !625
  store volatile i32 %115, ptr @uxTopReadyPriority, align 4, !dbg !625
  br label %116, !dbg !625

116:                                              ; preds = %112, %106
  %117 = load ptr, ptr %5, align 4, !dbg !625
  %118 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %117, i32 0, i32 3, !dbg !625
  %119 = load i32, ptr %118, align 4, !dbg !625
  %120 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %119, !dbg !625
  %121 = getelementptr inbounds %struct.xLIST, ptr %120, i32 0, i32 1, !dbg !625
  %122 = load ptr, ptr %121, align 4, !dbg !625
  store ptr %122, ptr %9, align 4, !dbg !625
  %123 = load ptr, ptr %9, align 4, !dbg !625
  %124 = load ptr, ptr %5, align 4, !dbg !625
  %125 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %124, i32 0, i32 1, !dbg !625
  %126 = getelementptr inbounds %struct.xLIST_ITEM, ptr %125, i32 0, i32 1, !dbg !625
  store ptr %123, ptr %126, align 4, !dbg !625
  %127 = load ptr, ptr %9, align 4, !dbg !625
  %128 = getelementptr inbounds %struct.xLIST_ITEM, ptr %127, i32 0, i32 2, !dbg !625
  %129 = load ptr, ptr %128, align 4, !dbg !625
  %130 = load ptr, ptr %5, align 4, !dbg !625
  %131 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %130, i32 0, i32 1, !dbg !625
  %132 = getelementptr inbounds %struct.xLIST_ITEM, ptr %131, i32 0, i32 2, !dbg !625
  store ptr %129, ptr %132, align 4, !dbg !625
  %133 = load ptr, ptr %5, align 4, !dbg !625
  %134 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %133, i32 0, i32 1, !dbg !625
  %135 = load ptr, ptr %9, align 4, !dbg !625
  %136 = getelementptr inbounds %struct.xLIST_ITEM, ptr %135, i32 0, i32 2, !dbg !625
  %137 = load ptr, ptr %136, align 4, !dbg !625
  %138 = getelementptr inbounds %struct.xLIST_ITEM, ptr %137, i32 0, i32 1, !dbg !625
  store ptr %134, ptr %138, align 4, !dbg !625
  %139 = load ptr, ptr %5, align 4, !dbg !625
  %140 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %139, i32 0, i32 1, !dbg !625
  %141 = load ptr, ptr %9, align 4, !dbg !625
  %142 = getelementptr inbounds %struct.xLIST_ITEM, ptr %141, i32 0, i32 2, !dbg !625
  store ptr %140, ptr %142, align 4, !dbg !625
  %143 = load ptr, ptr %5, align 4, !dbg !625
  %144 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %143, i32 0, i32 3, !dbg !625
  %145 = load i32, ptr %144, align 4, !dbg !625
  %146 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %145, !dbg !625
  %147 = load ptr, ptr %5, align 4, !dbg !625
  %148 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %147, i32 0, i32 1, !dbg !625
  %149 = getelementptr inbounds %struct.xLIST_ITEM, ptr %148, i32 0, i32 4, !dbg !625
  store ptr %146, ptr %149, align 4, !dbg !625
  %150 = load ptr, ptr %5, align 4, !dbg !625
  %151 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %150, i32 0, i32 3, !dbg !625
  %152 = load i32, ptr %151, align 4, !dbg !625
  %153 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %152, !dbg !625
  %154 = getelementptr inbounds %struct.xLIST, ptr %153, i32 0, i32 0, !dbg !625
  %155 = load volatile i32, ptr %154, align 4, !dbg !625
  %156 = add i32 %155, 1, !dbg !625
  store volatile i32 %156, ptr %154, align 4, !dbg !625
  br label %158, !dbg !626

157:                                              ; preds = %88
  br label %158

158:                                              ; preds = %157, %116
  %159 = load i32, ptr %8, align 4, !dbg !627
  %160 = icmp ne i32 %159, 0, !dbg !628
  br i1 %160, label %161, label %162, !dbg !627

161:                                              ; preds = %158
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !629
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !629, !srcloc !630
  call void asm sideeffect "isb", ""() #3, !dbg !629, !srcloc !631
  br label %163, !dbg !632

162:                                              ; preds = %158
  br label %163

163:                                              ; preds = %162, %161
  %164 = load i32, ptr %7, align 4, !dbg !633
  br label %165, !dbg !634

165:                                              ; preds = %163, %21
  call void @vPortExitCritical(), !dbg !635
  ret void, !dbg !636
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskSuspend(ptr noundef %0) #0 !dbg !637 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  call void @vPortEnterCritical(), !dbg !638
  %5 = load ptr, ptr %2, align 4, !dbg !639
  %6 = icmp eq ptr %5, null, !dbg !639
  br i1 %6, label %7, label %9, !dbg !639

7:                                                ; preds = %1
  %8 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !639
  br label %11, !dbg !639

9:                                                ; preds = %1
  %10 = load ptr, ptr %2, align 4, !dbg !639
  br label %11, !dbg !639

11:                                               ; preds = %9, %7
  %12 = phi ptr [ %8, %7 ], [ %10, %9 ], !dbg !639
  store ptr %12, ptr %3, align 4, !dbg !640
  %13 = load ptr, ptr %3, align 4, !dbg !641
  %14 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %13, i32 0, i32 1, !dbg !642
  %15 = call i32 @uxListRemove(ptr noundef %14), !dbg !643
  %16 = icmp eq i32 %15, 0, !dbg !644
  br i1 %16, label %17, label %18, !dbg !643

17:                                               ; preds = %11
  br label %19, !dbg !645

18:                                               ; preds = %11
  br label %19

19:                                               ; preds = %18, %17
  %20 = load ptr, ptr %3, align 4, !dbg !646
  %21 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %20, i32 0, i32 2, !dbg !646
  %22 = getelementptr inbounds %struct.xLIST_ITEM, ptr %21, i32 0, i32 4, !dbg !646
  %23 = load ptr, ptr %22, align 4, !dbg !646
  %24 = icmp ne ptr %23, null, !dbg !647
  br i1 %24, label %25, label %29, !dbg !646

25:                                               ; preds = %19
  %26 = load ptr, ptr %3, align 4, !dbg !648
  %27 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %26, i32 0, i32 2, !dbg !649
  %28 = call i32 @uxListRemove(ptr noundef %27), !dbg !650
  br label %30, !dbg !651

29:                                               ; preds = %19
  br label %30

30:                                               ; preds = %29, %25
  %31 = load ptr, ptr %3, align 4, !dbg !652
  %32 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %31, i32 0, i32 1, !dbg !653
  call void @vListInsertEnd(ptr noundef @xSuspendedTaskList, ptr noundef %32), !dbg !654
  store i32 0, ptr %4, align 4, !dbg !655
  br label %33, !dbg !656

33:                                               ; preds = %50, %30
  %34 = load i32, ptr %4, align 4, !dbg !657
  %35 = icmp slt i32 %34, 1, !dbg !658
  br i1 %35, label %36, label %53, !dbg !659

36:                                               ; preds = %33
  %37 = load ptr, ptr %3, align 4, !dbg !660
  %38 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %37, i32 0, i32 11, !dbg !661
  %39 = load i32, ptr %4, align 4, !dbg !662
  %40 = getelementptr inbounds [1 x i8], ptr %38, i32 0, i32 %39, !dbg !660
  %41 = load volatile i8, ptr %40, align 1, !dbg !660
  %42 = zext i8 %41 to i32, !dbg !660
  %43 = icmp eq i32 %42, 1, !dbg !663
  br i1 %43, label %44, label %49, !dbg !660

44:                                               ; preds = %36
  %45 = load ptr, ptr %3, align 4, !dbg !664
  %46 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %45, i32 0, i32 11, !dbg !665
  %47 = load i32, ptr %4, align 4, !dbg !666
  %48 = getelementptr inbounds [1 x i8], ptr %46, i32 0, i32 %47, !dbg !664
  store volatile i8 0, ptr %48, align 1, !dbg !667
  br label %49, !dbg !668

49:                                               ; preds = %44, %36
  br label %50, !dbg !669

50:                                               ; preds = %49
  %51 = load i32, ptr %4, align 4, !dbg !670
  %52 = add nsw i32 %51, 1, !dbg !670
  store i32 %52, ptr %4, align 4, !dbg !670
  br label %33, !dbg !659, !llvm.loop !671

53:                                               ; preds = %33
  call void @vPortExitCritical(), !dbg !672
  %54 = load volatile i32, ptr @xSchedulerRunning, align 4, !dbg !673
  %55 = icmp ne i32 %54, 0, !dbg !674
  br i1 %55, label %56, label %57, !dbg !673

56:                                               ; preds = %53
  call void @vPortEnterCritical(), !dbg !675
  call void @prvResetNextTaskUnblockTime(), !dbg !676
  call void @vPortExitCritical(), !dbg !677
  br label %58, !dbg !678

57:                                               ; preds = %53
  br label %58

58:                                               ; preds = %57, %56
  %59 = load ptr, ptr %3, align 4, !dbg !679
  %60 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !680
  %61 = icmp eq ptr %59, %60, !dbg !681
  br i1 %61, label %62, label %74, !dbg !679

62:                                               ; preds = %58
  %63 = load volatile i32, ptr @xSchedulerRunning, align 4, !dbg !682
  %64 = icmp ne i32 %63, 0, !dbg !683
  br i1 %64, label %65, label %66, !dbg !682

65:                                               ; preds = %62
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !684
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !684, !srcloc !685
  call void asm sideeffect "isb", ""() #3, !dbg !684, !srcloc !686
  br label %73, !dbg !687

66:                                               ; preds = %62
  %67 = load volatile i32, ptr @xSuspendedTaskList, align 4, !dbg !688
  %68 = load volatile i32, ptr @uxCurrentNumberOfTasks, align 4, !dbg !689
  %69 = icmp eq i32 %67, %68, !dbg !690
  br i1 %69, label %70, label %71, !dbg !688

70:                                               ; preds = %66
  store volatile ptr null, ptr @pxCurrentTCB, align 4, !dbg !691
  br label %72, !dbg !692

71:                                               ; preds = %66
  call void @vTaskSwitchContext(), !dbg !693
  br label %72

72:                                               ; preds = %71, %70
  br label %73

73:                                               ; preds = %72, %65
  br label %75, !dbg !694

74:                                               ; preds = %58
  br label %75

75:                                               ; preds = %74, %73
  ret void, !dbg !695
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskSwitchContext() #0 !dbg !696 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 4
  %3 = load volatile i32, ptr @uxSchedulerSuspended, align 4, !dbg !697
  %4 = icmp ne i32 %3, 0, !dbg !698
  br i1 %4, label %5, label %6, !dbg !697

5:                                                ; preds = %0
  store volatile i32 1, ptr @xYieldPending, align 4, !dbg !699
  br label %51, !dbg !700

6:                                                ; preds = %0
  store volatile i32 0, ptr @xYieldPending, align 4, !dbg !701
  %7 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !702
  store i32 %7, ptr %1, align 4, !dbg !702
  br label %8, !dbg !702

8:                                                ; preds = %17, %6
  %9 = load i32, ptr %1, align 4, !dbg !702
  %10 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %9, !dbg !702
  %11 = getelementptr inbounds %struct.xLIST, ptr %10, i32 0, i32 0, !dbg !702
  %12 = load volatile i32, ptr %11, align 4, !dbg !702
  %13 = icmp eq i32 %12, 0, !dbg !702
  %14 = zext i1 %13 to i64, !dbg !702
  %15 = select i1 %13, i32 1, i32 0, !dbg !702
  %16 = icmp ne i32 %15, 0, !dbg !702
  br i1 %16, label %17, label %20, !dbg !702

17:                                               ; preds = %8
  %18 = load i32, ptr %1, align 4, !dbg !702
  %19 = add i32 %18, -1, !dbg !702
  store i32 %19, ptr %1, align 4, !dbg !702
  br label %8, !dbg !702, !llvm.loop !703

20:                                               ; preds = %8
  %21 = load i32, ptr %1, align 4, !dbg !702
  %22 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %21, !dbg !702
  store ptr %22, ptr %2, align 4, !dbg !702
  %23 = load ptr, ptr %2, align 4, !dbg !702
  %24 = getelementptr inbounds %struct.xLIST, ptr %23, i32 0, i32 1, !dbg !702
  %25 = load ptr, ptr %24, align 4, !dbg !702
  %26 = getelementptr inbounds %struct.xLIST_ITEM, ptr %25, i32 0, i32 1, !dbg !702
  %27 = load ptr, ptr %26, align 4, !dbg !702
  %28 = load ptr, ptr %2, align 4, !dbg !702
  %29 = getelementptr inbounds %struct.xLIST, ptr %28, i32 0, i32 1, !dbg !702
  store ptr %27, ptr %29, align 4, !dbg !702
  %30 = load ptr, ptr %2, align 4, !dbg !702
  %31 = getelementptr inbounds %struct.xLIST, ptr %30, i32 0, i32 1, !dbg !702
  %32 = load ptr, ptr %31, align 4, !dbg !702
  %33 = load ptr, ptr %2, align 4, !dbg !702
  %34 = getelementptr inbounds %struct.xLIST, ptr %33, i32 0, i32 2, !dbg !702
  %35 = icmp eq ptr %32, %34, !dbg !702
  br i1 %35, label %36, label %44, !dbg !702

36:                                               ; preds = %20
  %37 = load ptr, ptr %2, align 4, !dbg !702
  %38 = getelementptr inbounds %struct.xLIST, ptr %37, i32 0, i32 1, !dbg !702
  %39 = load ptr, ptr %38, align 4, !dbg !702
  %40 = getelementptr inbounds %struct.xLIST_ITEM, ptr %39, i32 0, i32 1, !dbg !702
  %41 = load ptr, ptr %40, align 4, !dbg !702
  %42 = load ptr, ptr %2, align 4, !dbg !702
  %43 = getelementptr inbounds %struct.xLIST, ptr %42, i32 0, i32 1, !dbg !702
  store ptr %41, ptr %43, align 4, !dbg !702
  br label %44, !dbg !702

44:                                               ; preds = %36, %20
  %45 = load ptr, ptr %2, align 4, !dbg !702
  %46 = getelementptr inbounds %struct.xLIST, ptr %45, i32 0, i32 1, !dbg !702
  %47 = load ptr, ptr %46, align 4, !dbg !702
  %48 = getelementptr inbounds %struct.xLIST_ITEM, ptr %47, i32 0, i32 3, !dbg !702
  %49 = load ptr, ptr %48, align 4, !dbg !702
  store volatile ptr %49, ptr @pxCurrentTCB, align 4, !dbg !702
  %50 = load i32, ptr %1, align 4, !dbg !702
  store volatile i32 %50, ptr @uxTopReadyPriority, align 4, !dbg !702
  br label %51

51:                                               ; preds = %44, %5
  ret void, !dbg !704
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskResume(ptr noundef %0) #0 !dbg !705 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !706
  store ptr %5, ptr %3, align 4, !dbg !707
  %6 = load ptr, ptr %3, align 4, !dbg !708
  %7 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !709
  %8 = icmp ne ptr %6, %7, !dbg !710
  br i1 %8, label %9, label %82, !dbg !711

9:                                                ; preds = %1
  %10 = load ptr, ptr %3, align 4, !dbg !712
  %11 = icmp ne ptr %10, null, !dbg !713
  br i1 %11, label %12, label %82, !dbg !714

12:                                               ; preds = %9
  call void @vPortEnterCritical(), !dbg !715
  %13 = load ptr, ptr %3, align 4, !dbg !716
  %14 = call i32 @prvTaskIsTaskSuspended(ptr noundef %13), !dbg !717
  %15 = icmp ne i32 %14, 0, !dbg !718
  br i1 %15, label %16, label %80, !dbg !717

16:                                               ; preds = %12
  %17 = load ptr, ptr %3, align 4, !dbg !719
  %18 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %17, i32 0, i32 1, !dbg !720
  %19 = call i32 @uxListRemove(ptr noundef %18), !dbg !721
  %20 = load ptr, ptr %3, align 4, !dbg !722
  %21 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %20, i32 0, i32 3, !dbg !722
  %22 = load i32, ptr %21, align 4, !dbg !722
  %23 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !722
  %24 = icmp ugt i32 %22, %23, !dbg !722
  br i1 %24, label %25, label %29, !dbg !722

25:                                               ; preds = %16
  %26 = load ptr, ptr %3, align 4, !dbg !722
  %27 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %26, i32 0, i32 3, !dbg !722
  %28 = load i32, ptr %27, align 4, !dbg !722
  store volatile i32 %28, ptr @uxTopReadyPriority, align 4, !dbg !722
  br label %29, !dbg !722

29:                                               ; preds = %25, %16
  %30 = load ptr, ptr %3, align 4, !dbg !722
  %31 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %30, i32 0, i32 3, !dbg !722
  %32 = load i32, ptr %31, align 4, !dbg !722
  %33 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %32, !dbg !722
  %34 = getelementptr inbounds %struct.xLIST, ptr %33, i32 0, i32 1, !dbg !722
  %35 = load ptr, ptr %34, align 4, !dbg !722
  store ptr %35, ptr %4, align 4, !dbg !722
  %36 = load ptr, ptr %4, align 4, !dbg !722
  %37 = load ptr, ptr %3, align 4, !dbg !722
  %38 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %37, i32 0, i32 1, !dbg !722
  %39 = getelementptr inbounds %struct.xLIST_ITEM, ptr %38, i32 0, i32 1, !dbg !722
  store ptr %36, ptr %39, align 4, !dbg !722
  %40 = load ptr, ptr %4, align 4, !dbg !722
  %41 = getelementptr inbounds %struct.xLIST_ITEM, ptr %40, i32 0, i32 2, !dbg !722
  %42 = load ptr, ptr %41, align 4, !dbg !722
  %43 = load ptr, ptr %3, align 4, !dbg !722
  %44 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %43, i32 0, i32 1, !dbg !722
  %45 = getelementptr inbounds %struct.xLIST_ITEM, ptr %44, i32 0, i32 2, !dbg !722
  store ptr %42, ptr %45, align 4, !dbg !722
  %46 = load ptr, ptr %3, align 4, !dbg !722
  %47 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %46, i32 0, i32 1, !dbg !722
  %48 = load ptr, ptr %4, align 4, !dbg !722
  %49 = getelementptr inbounds %struct.xLIST_ITEM, ptr %48, i32 0, i32 2, !dbg !722
  %50 = load ptr, ptr %49, align 4, !dbg !722
  %51 = getelementptr inbounds %struct.xLIST_ITEM, ptr %50, i32 0, i32 1, !dbg !722
  store ptr %47, ptr %51, align 4, !dbg !722
  %52 = load ptr, ptr %3, align 4, !dbg !722
  %53 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %52, i32 0, i32 1, !dbg !722
  %54 = load ptr, ptr %4, align 4, !dbg !722
  %55 = getelementptr inbounds %struct.xLIST_ITEM, ptr %54, i32 0, i32 2, !dbg !722
  store ptr %53, ptr %55, align 4, !dbg !722
  %56 = load ptr, ptr %3, align 4, !dbg !722
  %57 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %56, i32 0, i32 3, !dbg !722
  %58 = load i32, ptr %57, align 4, !dbg !722
  %59 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %58, !dbg !722
  %60 = load ptr, ptr %3, align 4, !dbg !722
  %61 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %60, i32 0, i32 1, !dbg !722
  %62 = getelementptr inbounds %struct.xLIST_ITEM, ptr %61, i32 0, i32 4, !dbg !722
  store ptr %59, ptr %62, align 4, !dbg !722
  %63 = load ptr, ptr %3, align 4, !dbg !722
  %64 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %63, i32 0, i32 3, !dbg !722
  %65 = load i32, ptr %64, align 4, !dbg !722
  %66 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %65, !dbg !722
  %67 = getelementptr inbounds %struct.xLIST, ptr %66, i32 0, i32 0, !dbg !722
  %68 = load volatile i32, ptr %67, align 4, !dbg !722
  %69 = add i32 %68, 1, !dbg !722
  store volatile i32 %69, ptr %67, align 4, !dbg !722
  %70 = load ptr, ptr %3, align 4, !dbg !723
  %71 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %70, i32 0, i32 3, !dbg !724
  %72 = load i32, ptr %71, align 4, !dbg !724
  %73 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !725
  %74 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %73, i32 0, i32 3, !dbg !726
  %75 = load i32, ptr %74, align 4, !dbg !726
  %76 = icmp uge i32 %72, %75, !dbg !727
  br i1 %76, label %77, label %78, !dbg !723

77:                                               ; preds = %29
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !728
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !728, !srcloc !729
  call void asm sideeffect "isb", ""() #3, !dbg !728, !srcloc !730
  br label %79, !dbg !731

78:                                               ; preds = %29
  br label %79

79:                                               ; preds = %78, %77
  br label %81, !dbg !732

80:                                               ; preds = %12
  br label %81

81:                                               ; preds = %80, %79
  call void @vPortExitCritical(), !dbg !733
  br label %83, !dbg !734

82:                                               ; preds = %9, %1
  br label %83

83:                                               ; preds = %82, %81
  ret void, !dbg !735
}

; Function Attrs: noinline nounwind
define internal i32 @prvTaskIsTaskSuspended(ptr noundef %0) #0 !dbg !736 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  store i32 0, ptr %3, align 4, !dbg !737
  %5 = load ptr, ptr %2, align 4, !dbg !738
  store ptr %5, ptr %4, align 4, !dbg !739
  %6 = load ptr, ptr %4, align 4, !dbg !740
  %7 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %6, i32 0, i32 1, !dbg !740
  %8 = getelementptr inbounds %struct.xLIST_ITEM, ptr %7, i32 0, i32 4, !dbg !740
  %9 = load ptr, ptr %8, align 4, !dbg !740
  %10 = icmp eq ptr %9, @xSuspendedTaskList, !dbg !740
  %11 = zext i1 %10 to i64, !dbg !740
  %12 = select i1 %10, i32 1, i32 0, !dbg !740
  %13 = icmp ne i32 %12, 0, !dbg !741
  br i1 %13, label %14, label %37, !dbg !740

14:                                               ; preds = %1
  %15 = load ptr, ptr %4, align 4, !dbg !742
  %16 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %15, i32 0, i32 2, !dbg !742
  %17 = getelementptr inbounds %struct.xLIST_ITEM, ptr %16, i32 0, i32 4, !dbg !742
  %18 = load ptr, ptr %17, align 4, !dbg !742
  %19 = icmp eq ptr %18, @xPendingReadyList, !dbg !742
  %20 = zext i1 %19 to i64, !dbg !742
  %21 = select i1 %19, i32 1, i32 0, !dbg !742
  %22 = icmp eq i32 %21, 0, !dbg !743
  br i1 %22, label %23, label %35, !dbg !742

23:                                               ; preds = %14
  %24 = load ptr, ptr %4, align 4, !dbg !744
  %25 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %24, i32 0, i32 2, !dbg !744
  %26 = getelementptr inbounds %struct.xLIST_ITEM, ptr %25, i32 0, i32 4, !dbg !744
  %27 = load ptr, ptr %26, align 4, !dbg !744
  %28 = icmp eq ptr %27, null, !dbg !744
  %29 = zext i1 %28 to i64, !dbg !744
  %30 = select i1 %28, i32 1, i32 0, !dbg !744
  %31 = icmp ne i32 %30, 0, !dbg !745
  br i1 %31, label %32, label %33, !dbg !744

32:                                               ; preds = %23
  store i32 1, ptr %3, align 4, !dbg !746
  br label %34, !dbg !747

33:                                               ; preds = %23
  br label %34

34:                                               ; preds = %33, %32
  br label %36, !dbg !748

35:                                               ; preds = %14
  br label %36

36:                                               ; preds = %35, %34
  br label %38, !dbg !749

37:                                               ; preds = %1
  br label %38

38:                                               ; preds = %37, %36
  %39 = load i32, ptr %3, align 4, !dbg !750
  ret i32 %39, !dbg !751
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskResumeFromISR(ptr noundef %0) #0 !dbg !752 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 4
  store ptr %0, ptr %5, align 4
  store i32 0, ptr %6, align 4, !dbg !753
  %10 = load ptr, ptr %5, align 4, !dbg !754
  store ptr %10, ptr %7, align 4, !dbg !755
  %11 = call { i32, i32 } asm sideeffect "\09mrs $0, basepri\09\09\09\09\09\09\09\09\09\09\09\0A\09mov $1, $2\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $1\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,=r,i,~{memory}"(i32 80) #3, !dbg !756, !srcloc !545
  %12 = extractvalue { i32, i32 } %11, 0, !dbg !756
  %13 = extractvalue { i32, i32 } %11, 1, !dbg !756
  store i32 %12, ptr %3, align 4, !dbg !756
  store i32 %13, ptr %4, align 4, !dbg !756
  %14 = load i32, ptr %3, align 4, !dbg !758
  store i32 %14, ptr %8, align 4, !dbg !759
  %15 = load ptr, ptr %7, align 4, !dbg !760
  %16 = call i32 @prvTaskIsTaskSuspended(ptr noundef %15), !dbg !761
  %17 = icmp ne i32 %16, 0, !dbg !762
  br i1 %17, label %18, label %89, !dbg !761

18:                                               ; preds = %1
  %19 = load volatile i32, ptr @uxSchedulerSuspended, align 4, !dbg !763
  %20 = icmp eq i32 %19, 0, !dbg !764
  br i1 %20, label %21, label %85, !dbg !763

21:                                               ; preds = %18
  %22 = load ptr, ptr %7, align 4, !dbg !765
  %23 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %22, i32 0, i32 3, !dbg !766
  %24 = load i32, ptr %23, align 4, !dbg !766
  %25 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !767
  %26 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %25, i32 0, i32 3, !dbg !768
  %27 = load i32, ptr %26, align 4, !dbg !768
  %28 = icmp uge i32 %24, %27, !dbg !769
  br i1 %28, label %29, label %30, !dbg !765

29:                                               ; preds = %21
  store i32 1, ptr %6, align 4, !dbg !770
  store volatile i32 1, ptr @xYieldPending, align 4, !dbg !771
  br label %31, !dbg !772

30:                                               ; preds = %21
  br label %31

31:                                               ; preds = %30, %29
  %32 = load ptr, ptr %7, align 4, !dbg !773
  %33 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %32, i32 0, i32 1, !dbg !774
  %34 = call i32 @uxListRemove(ptr noundef %33), !dbg !775
  %35 = load ptr, ptr %7, align 4, !dbg !776
  %36 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %35, i32 0, i32 3, !dbg !776
  %37 = load i32, ptr %36, align 4, !dbg !776
  %38 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !776
  %39 = icmp ugt i32 %37, %38, !dbg !776
  br i1 %39, label %40, label %44, !dbg !776

40:                                               ; preds = %31
  %41 = load ptr, ptr %7, align 4, !dbg !776
  %42 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %41, i32 0, i32 3, !dbg !776
  %43 = load i32, ptr %42, align 4, !dbg !776
  store volatile i32 %43, ptr @uxTopReadyPriority, align 4, !dbg !776
  br label %44, !dbg !776

44:                                               ; preds = %40, %31
  %45 = load ptr, ptr %7, align 4, !dbg !776
  %46 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %45, i32 0, i32 3, !dbg !776
  %47 = load i32, ptr %46, align 4, !dbg !776
  %48 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %47, !dbg !776
  %49 = getelementptr inbounds %struct.xLIST, ptr %48, i32 0, i32 1, !dbg !776
  %50 = load ptr, ptr %49, align 4, !dbg !776
  store ptr %50, ptr %9, align 4, !dbg !776
  %51 = load ptr, ptr %9, align 4, !dbg !776
  %52 = load ptr, ptr %7, align 4, !dbg !776
  %53 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %52, i32 0, i32 1, !dbg !776
  %54 = getelementptr inbounds %struct.xLIST_ITEM, ptr %53, i32 0, i32 1, !dbg !776
  store ptr %51, ptr %54, align 4, !dbg !776
  %55 = load ptr, ptr %9, align 4, !dbg !776
  %56 = getelementptr inbounds %struct.xLIST_ITEM, ptr %55, i32 0, i32 2, !dbg !776
  %57 = load ptr, ptr %56, align 4, !dbg !776
  %58 = load ptr, ptr %7, align 4, !dbg !776
  %59 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %58, i32 0, i32 1, !dbg !776
  %60 = getelementptr inbounds %struct.xLIST_ITEM, ptr %59, i32 0, i32 2, !dbg !776
  store ptr %57, ptr %60, align 4, !dbg !776
  %61 = load ptr, ptr %7, align 4, !dbg !776
  %62 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %61, i32 0, i32 1, !dbg !776
  %63 = load ptr, ptr %9, align 4, !dbg !776
  %64 = getelementptr inbounds %struct.xLIST_ITEM, ptr %63, i32 0, i32 2, !dbg !776
  %65 = load ptr, ptr %64, align 4, !dbg !776
  %66 = getelementptr inbounds %struct.xLIST_ITEM, ptr %65, i32 0, i32 1, !dbg !776
  store ptr %62, ptr %66, align 4, !dbg !776
  %67 = load ptr, ptr %7, align 4, !dbg !776
  %68 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %67, i32 0, i32 1, !dbg !776
  %69 = load ptr, ptr %9, align 4, !dbg !776
  %70 = getelementptr inbounds %struct.xLIST_ITEM, ptr %69, i32 0, i32 2, !dbg !776
  store ptr %68, ptr %70, align 4, !dbg !776
  %71 = load ptr, ptr %7, align 4, !dbg !776
  %72 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %71, i32 0, i32 3, !dbg !776
  %73 = load i32, ptr %72, align 4, !dbg !776
  %74 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %73, !dbg !776
  %75 = load ptr, ptr %7, align 4, !dbg !776
  %76 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %75, i32 0, i32 1, !dbg !776
  %77 = getelementptr inbounds %struct.xLIST_ITEM, ptr %76, i32 0, i32 4, !dbg !776
  store ptr %74, ptr %77, align 4, !dbg !776
  %78 = load ptr, ptr %7, align 4, !dbg !776
  %79 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %78, i32 0, i32 3, !dbg !776
  %80 = load i32, ptr %79, align 4, !dbg !776
  %81 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %80, !dbg !776
  %82 = getelementptr inbounds %struct.xLIST, ptr %81, i32 0, i32 0, !dbg !776
  %83 = load volatile i32, ptr %82, align 4, !dbg !776
  %84 = add i32 %83, 1, !dbg !776
  store volatile i32 %84, ptr %82, align 4, !dbg !776
  br label %88, !dbg !777

85:                                               ; preds = %18
  %86 = load ptr, ptr %7, align 4, !dbg !778
  %87 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %86, i32 0, i32 2, !dbg !779
  call void @vListInsertEnd(ptr noundef @xPendingReadyList, ptr noundef %87), !dbg !780
  br label %88

88:                                               ; preds = %85, %44
  br label %90, !dbg !781

89:                                               ; preds = %1
  br label %90

90:                                               ; preds = %89, %88
  %91 = load i32, ptr %8, align 4, !dbg !782
  store i32 %91, ptr %2, align 4
  %92 = load i32, ptr %2, align 4, !dbg !783
  call void asm sideeffect "\09msr basepri, $0\09", "r,~{memory}"(i32 %92) #3, !dbg !785, !srcloc !558
  %93 = load i32, ptr %6, align 4, !dbg !786
  ret i32 %93, !dbg !787
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskStartScheduler() #0 !dbg !788 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  store ptr null, ptr %3, align 4, !dbg !789
  store ptr null, ptr %4, align 4, !dbg !790
  call void @vApplicationGetIdleTaskMemory(ptr noundef %3, ptr noundef %4, ptr noundef %5), !dbg !791
  %6 = load i32, ptr %5, align 4, !dbg !792
  %7 = load ptr, ptr %4, align 4, !dbg !793
  %8 = load ptr, ptr %3, align 4, !dbg !794
  %9 = call ptr @xTaskCreateStatic(ptr noundef @prvIdleTask, ptr noundef @.str.3, i32 noundef %6, ptr noundef null, i32 noundef 0, ptr noundef %7, ptr noundef %8), !dbg !795
  store ptr %9, ptr @xIdleTaskHandle, align 4, !dbg !796
  %10 = load ptr, ptr @xIdleTaskHandle, align 4, !dbg !797
  %11 = icmp ne ptr %10, null, !dbg !798
  br i1 %11, label %12, label %13, !dbg !797

12:                                               ; preds = %0
  store i32 1, ptr %2, align 4, !dbg !799
  br label %14, !dbg !800

13:                                               ; preds = %0
  store i32 0, ptr %2, align 4, !dbg !801
  br label %14

14:                                               ; preds = %13, %12
  %15 = load i32, ptr %2, align 4, !dbg !802
  %16 = icmp eq i32 %15, 1, !dbg !803
  br i1 %16, label %17, label %19, !dbg !802

17:                                               ; preds = %14
  %18 = call i32 @xTimerCreateTimerTask(), !dbg !804
  store i32 %18, ptr %2, align 4, !dbg !805
  br label %20, !dbg !806

19:                                               ; preds = %14
  br label %20

20:                                               ; preds = %19, %17
  %21 = load i32, ptr %2, align 4, !dbg !807
  %22 = icmp eq i32 %21, 1, !dbg !808
  br i1 %22, label %23, label %30, !dbg !807

23:                                               ; preds = %20
  %24 = call i32 asm sideeffect "\09mov $0, $1\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $0\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,i,~{memory}"(i32 80) #3, !dbg !809, !srcloc !812
  store i32 %24, ptr %1, align 4, !dbg !809
  store volatile i32 -1, ptr @xNextTaskUnblockTime, align 4, !dbg !813
  store volatile i32 1, ptr @xSchedulerRunning, align 4, !dbg !814
  store volatile i32 0, ptr @xTickCount, align 4, !dbg !815
  %25 = call i32 @xPortStartScheduler(), !dbg !816
  %26 = icmp ne i32 %25, 0, !dbg !817
  br i1 %26, label %27, label %28, !dbg !816

27:                                               ; preds = %23
  br label %29, !dbg !818

28:                                               ; preds = %23
  br label %29

29:                                               ; preds = %28, %27
  br label %31, !dbg !819

30:                                               ; preds = %20
  br label %31

31:                                               ; preds = %30, %29
  %32 = load ptr, ptr @xIdleTaskHandle, align 4, !dbg !820
  %33 = load volatile i32, ptr @uxTopUsedPriority, align 4, !dbg !821
  ret void, !dbg !822
}

; Function Attrs: noinline nounwind
define internal void @prvIdleTask(ptr noundef %0) #0 !dbg !823 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %3 = load ptr, ptr %2, align 4, !dbg !824
  br label %4, !dbg !825

4:                                                ; preds = %9, %1
  call void @prvCheckTasksWaitingTermination(), !dbg !826
  %5 = load volatile i32, ptr @pxReadyTasksLists, align 4, !dbg !827
  %6 = icmp ugt i32 %5, 1, !dbg !828
  br i1 %6, label %7, label %8, !dbg !827

7:                                                ; preds = %4
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !829
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !829, !srcloc !830
  call void asm sideeffect "isb", ""() #3, !dbg !829, !srcloc !831
  br label %9, !dbg !832

8:                                                ; preds = %4
  br label %9

9:                                                ; preds = %8, %7
  br label %4, !dbg !825, !llvm.loop !833
}

declare dso_local i32 @xTimerCreateTimerTask() #1

declare dso_local i32 @xPortStartScheduler() #1

; Function Attrs: noinline nounwind
define dso_local void @vTaskEndScheduler() #0 !dbg !835 {
  %1 = alloca i32, align 4
  %2 = call i32 asm sideeffect "\09mov $0, $1\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $0\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,i,~{memory}"(i32 80) #3, !dbg !836, !srcloc !812
  store i32 %2, ptr %1, align 4, !dbg !836
  store volatile i32 0, ptr @xSchedulerRunning, align 4, !dbg !838
  call void @vPortEndScheduler(), !dbg !839
  ret void, !dbg !840
}

declare dso_local void @vPortEndScheduler() #1

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskIncrementTick() #0 !dbg !841 {
  %1 = alloca ptr, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca ptr, align 4
  %8 = alloca ptr, align 4
  store i32 0, ptr %3, align 4, !dbg !842
  %9 = load volatile i32, ptr @uxSchedulerSuspended, align 4, !dbg !843
  %10 = icmp eq i32 %9, 0, !dbg !844
  br i1 %10, label %11, label %228, !dbg !843

11:                                               ; preds = %0
  %12 = load volatile i32, ptr @xTickCount, align 4, !dbg !845
  %13 = add i32 %12, 1, !dbg !846
  store i32 %13, ptr %4, align 4, !dbg !847
  %14 = load i32, ptr %4, align 4, !dbg !848
  store volatile i32 %14, ptr @xTickCount, align 4, !dbg !849
  %15 = load i32, ptr %4, align 4, !dbg !850
  %16 = icmp eq i32 %15, 0, !dbg !851
  br i1 %16, label %17, label %23, !dbg !850

17:                                               ; preds = %11
  %18 = load volatile ptr, ptr @pxDelayedTaskList, align 4, !dbg !852
  store ptr %18, ptr %5, align 4, !dbg !852
  %19 = load volatile ptr, ptr @pxOverflowDelayedTaskList, align 4, !dbg !852
  store volatile ptr %19, ptr @pxDelayedTaskList, align 4, !dbg !852
  %20 = load ptr, ptr %5, align 4, !dbg !852
  store volatile ptr %20, ptr @pxOverflowDelayedTaskList, align 4, !dbg !852
  %21 = load volatile i32, ptr @xNumOfOverflows, align 4, !dbg !852
  %22 = add nsw i32 %21, 1, !dbg !852
  store volatile i32 %22, ptr @xNumOfOverflows, align 4, !dbg !852
  call void @prvResetNextTaskUnblockTime(), !dbg !852
  br label %24, !dbg !853

23:                                               ; preds = %11
  br label %24

24:                                               ; preds = %23, %17
  %25 = load i32, ptr %4, align 4, !dbg !854
  %26 = load volatile i32, ptr @xNextTaskUnblockTime, align 4, !dbg !855
  %27 = icmp uge i32 %25, %26, !dbg !856
  br i1 %27, label %28, label %212, !dbg !854

28:                                               ; preds = %24
  br label %29, !dbg !857

29:                                               ; preds = %210, %28
  %30 = load volatile ptr, ptr @pxDelayedTaskList, align 4, !dbg !858
  %31 = getelementptr inbounds %struct.xLIST, ptr %30, i32 0, i32 0, !dbg !858
  %32 = load volatile i32, ptr %31, align 4, !dbg !858
  %33 = icmp eq i32 %32, 0, !dbg !858
  %34 = zext i1 %33 to i64, !dbg !858
  %35 = select i1 %33, i32 1, i32 0, !dbg !858
  %36 = icmp ne i32 %35, 0, !dbg !859
  br i1 %36, label %37, label %38, !dbg !858

37:                                               ; preds = %29
  store volatile i32 -1, ptr @xNextTaskUnblockTime, align 4, !dbg !860
  br label %211, !dbg !861

38:                                               ; preds = %29
  %39 = load volatile ptr, ptr @pxDelayedTaskList, align 4, !dbg !862
  %40 = getelementptr inbounds %struct.xLIST, ptr %39, i32 0, i32 2, !dbg !862
  %41 = getelementptr inbounds %struct.xMINI_LIST_ITEM, ptr %40, i32 0, i32 1, !dbg !862
  %42 = load ptr, ptr %41, align 4, !dbg !862
  %43 = getelementptr inbounds %struct.xLIST_ITEM, ptr %42, i32 0, i32 3, !dbg !862
  %44 = load ptr, ptr %43, align 4, !dbg !862
  store ptr %44, ptr %1, align 4, !dbg !863
  %45 = load ptr, ptr %1, align 4, !dbg !864
  %46 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %45, i32 0, i32 1, !dbg !864
  %47 = getelementptr inbounds %struct.xLIST_ITEM, ptr %46, i32 0, i32 0, !dbg !864
  %48 = load i32, ptr %47, align 4, !dbg !864
  store i32 %48, ptr %2, align 4, !dbg !865
  %49 = load i32, ptr %4, align 4, !dbg !866
  %50 = load i32, ptr %2, align 4, !dbg !867
  %51 = icmp ult i32 %49, %50, !dbg !868
  br i1 %51, label %52, label %54, !dbg !866

52:                                               ; preds = %38
  %53 = load i32, ptr %2, align 4, !dbg !869
  store volatile i32 %53, ptr @xNextTaskUnblockTime, align 4, !dbg !870
  br label %211, !dbg !871

54:                                               ; preds = %38
  br label %55

55:                                               ; preds = %54
  %56 = load ptr, ptr %1, align 4, !dbg !872
  %57 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %56, i32 0, i32 1, !dbg !872
  %58 = getelementptr inbounds %struct.xLIST_ITEM, ptr %57, i32 0, i32 4, !dbg !872
  %59 = load ptr, ptr %58, align 4, !dbg !872
  store ptr %59, ptr %6, align 4, !dbg !872
  %60 = load ptr, ptr %1, align 4, !dbg !872
  %61 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %60, i32 0, i32 1, !dbg !872
  %62 = getelementptr inbounds %struct.xLIST_ITEM, ptr %61, i32 0, i32 2, !dbg !872
  %63 = load ptr, ptr %62, align 4, !dbg !872
  %64 = load ptr, ptr %1, align 4, !dbg !872
  %65 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %64, i32 0, i32 1, !dbg !872
  %66 = getelementptr inbounds %struct.xLIST_ITEM, ptr %65, i32 0, i32 1, !dbg !872
  %67 = load ptr, ptr %66, align 4, !dbg !872
  %68 = getelementptr inbounds %struct.xLIST_ITEM, ptr %67, i32 0, i32 2, !dbg !872
  store ptr %63, ptr %68, align 4, !dbg !872
  %69 = load ptr, ptr %1, align 4, !dbg !872
  %70 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %69, i32 0, i32 1, !dbg !872
  %71 = getelementptr inbounds %struct.xLIST_ITEM, ptr %70, i32 0, i32 1, !dbg !872
  %72 = load ptr, ptr %71, align 4, !dbg !872
  %73 = load ptr, ptr %1, align 4, !dbg !872
  %74 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %73, i32 0, i32 1, !dbg !872
  %75 = getelementptr inbounds %struct.xLIST_ITEM, ptr %74, i32 0, i32 2, !dbg !872
  %76 = load ptr, ptr %75, align 4, !dbg !872
  %77 = getelementptr inbounds %struct.xLIST_ITEM, ptr %76, i32 0, i32 1, !dbg !872
  store ptr %72, ptr %77, align 4, !dbg !872
  %78 = load ptr, ptr %6, align 4, !dbg !872
  %79 = getelementptr inbounds %struct.xLIST, ptr %78, i32 0, i32 1, !dbg !872
  %80 = load ptr, ptr %79, align 4, !dbg !872
  %81 = load ptr, ptr %1, align 4, !dbg !872
  %82 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %81, i32 0, i32 1, !dbg !872
  %83 = icmp eq ptr %80, %82, !dbg !872
  br i1 %83, label %84, label %91, !dbg !872

84:                                               ; preds = %55
  %85 = load ptr, ptr %1, align 4, !dbg !872
  %86 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %85, i32 0, i32 1, !dbg !872
  %87 = getelementptr inbounds %struct.xLIST_ITEM, ptr %86, i32 0, i32 2, !dbg !872
  %88 = load ptr, ptr %87, align 4, !dbg !872
  %89 = load ptr, ptr %6, align 4, !dbg !872
  %90 = getelementptr inbounds %struct.xLIST, ptr %89, i32 0, i32 1, !dbg !872
  store ptr %88, ptr %90, align 4, !dbg !872
  br label %91, !dbg !872

91:                                               ; preds = %84, %55
  %92 = load ptr, ptr %1, align 4, !dbg !872
  %93 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %92, i32 0, i32 1, !dbg !872
  %94 = getelementptr inbounds %struct.xLIST_ITEM, ptr %93, i32 0, i32 4, !dbg !872
  store ptr null, ptr %94, align 4, !dbg !872
  %95 = load ptr, ptr %6, align 4, !dbg !872
  %96 = getelementptr inbounds %struct.xLIST, ptr %95, i32 0, i32 0, !dbg !872
  %97 = load volatile i32, ptr %96, align 4, !dbg !872
  %98 = add i32 %97, -1, !dbg !872
  store volatile i32 %98, ptr %96, align 4, !dbg !872
  %99 = load ptr, ptr %1, align 4, !dbg !873
  %100 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %99, i32 0, i32 2, !dbg !873
  %101 = getelementptr inbounds %struct.xLIST_ITEM, ptr %100, i32 0, i32 4, !dbg !873
  %102 = load ptr, ptr %101, align 4, !dbg !873
  %103 = icmp ne ptr %102, null, !dbg !874
  br i1 %103, label %104, label %148, !dbg !873

104:                                              ; preds = %91
  %105 = load ptr, ptr %1, align 4, !dbg !875
  %106 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %105, i32 0, i32 2, !dbg !875
  %107 = getelementptr inbounds %struct.xLIST_ITEM, ptr %106, i32 0, i32 4, !dbg !875
  %108 = load ptr, ptr %107, align 4, !dbg !875
  store ptr %108, ptr %7, align 4, !dbg !875
  %109 = load ptr, ptr %1, align 4, !dbg !875
  %110 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %109, i32 0, i32 2, !dbg !875
  %111 = getelementptr inbounds %struct.xLIST_ITEM, ptr %110, i32 0, i32 2, !dbg !875
  %112 = load ptr, ptr %111, align 4, !dbg !875
  %113 = load ptr, ptr %1, align 4, !dbg !875
  %114 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %113, i32 0, i32 2, !dbg !875
  %115 = getelementptr inbounds %struct.xLIST_ITEM, ptr %114, i32 0, i32 1, !dbg !875
  %116 = load ptr, ptr %115, align 4, !dbg !875
  %117 = getelementptr inbounds %struct.xLIST_ITEM, ptr %116, i32 0, i32 2, !dbg !875
  store ptr %112, ptr %117, align 4, !dbg !875
  %118 = load ptr, ptr %1, align 4, !dbg !875
  %119 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %118, i32 0, i32 2, !dbg !875
  %120 = getelementptr inbounds %struct.xLIST_ITEM, ptr %119, i32 0, i32 1, !dbg !875
  %121 = load ptr, ptr %120, align 4, !dbg !875
  %122 = load ptr, ptr %1, align 4, !dbg !875
  %123 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %122, i32 0, i32 2, !dbg !875
  %124 = getelementptr inbounds %struct.xLIST_ITEM, ptr %123, i32 0, i32 2, !dbg !875
  %125 = load ptr, ptr %124, align 4, !dbg !875
  %126 = getelementptr inbounds %struct.xLIST_ITEM, ptr %125, i32 0, i32 1, !dbg !875
  store ptr %121, ptr %126, align 4, !dbg !875
  %127 = load ptr, ptr %7, align 4, !dbg !875
  %128 = getelementptr inbounds %struct.xLIST, ptr %127, i32 0, i32 1, !dbg !875
  %129 = load ptr, ptr %128, align 4, !dbg !875
  %130 = load ptr, ptr %1, align 4, !dbg !875
  %131 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %130, i32 0, i32 2, !dbg !875
  %132 = icmp eq ptr %129, %131, !dbg !875
  br i1 %132, label %133, label %140, !dbg !875

133:                                              ; preds = %104
  %134 = load ptr, ptr %1, align 4, !dbg !875
  %135 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %134, i32 0, i32 2, !dbg !875
  %136 = getelementptr inbounds %struct.xLIST_ITEM, ptr %135, i32 0, i32 2, !dbg !875
  %137 = load ptr, ptr %136, align 4, !dbg !875
  %138 = load ptr, ptr %7, align 4, !dbg !875
  %139 = getelementptr inbounds %struct.xLIST, ptr %138, i32 0, i32 1, !dbg !875
  store ptr %137, ptr %139, align 4, !dbg !875
  br label %140, !dbg !875

140:                                              ; preds = %133, %104
  %141 = load ptr, ptr %1, align 4, !dbg !875
  %142 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %141, i32 0, i32 2, !dbg !875
  %143 = getelementptr inbounds %struct.xLIST_ITEM, ptr %142, i32 0, i32 4, !dbg !875
  store ptr null, ptr %143, align 4, !dbg !875
  %144 = load ptr, ptr %7, align 4, !dbg !875
  %145 = getelementptr inbounds %struct.xLIST, ptr %144, i32 0, i32 0, !dbg !875
  %146 = load volatile i32, ptr %145, align 4, !dbg !875
  %147 = add i32 %146, -1, !dbg !875
  store volatile i32 %147, ptr %145, align 4, !dbg !875
  br label %149, !dbg !876

148:                                              ; preds = %91
  br label %149

149:                                              ; preds = %148, %140
  %150 = load ptr, ptr %1, align 4, !dbg !877
  %151 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %150, i32 0, i32 3, !dbg !877
  %152 = load i32, ptr %151, align 4, !dbg !877
  %153 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !877
  %154 = icmp ugt i32 %152, %153, !dbg !877
  br i1 %154, label %155, label %159, !dbg !877

155:                                              ; preds = %149
  %156 = load ptr, ptr %1, align 4, !dbg !877
  %157 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %156, i32 0, i32 3, !dbg !877
  %158 = load i32, ptr %157, align 4, !dbg !877
  store volatile i32 %158, ptr @uxTopReadyPriority, align 4, !dbg !877
  br label %159, !dbg !877

159:                                              ; preds = %155, %149
  %160 = load ptr, ptr %1, align 4, !dbg !877
  %161 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %160, i32 0, i32 3, !dbg !877
  %162 = load i32, ptr %161, align 4, !dbg !877
  %163 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %162, !dbg !877
  %164 = getelementptr inbounds %struct.xLIST, ptr %163, i32 0, i32 1, !dbg !877
  %165 = load ptr, ptr %164, align 4, !dbg !877
  store ptr %165, ptr %8, align 4, !dbg !877
  %166 = load ptr, ptr %8, align 4, !dbg !877
  %167 = load ptr, ptr %1, align 4, !dbg !877
  %168 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %167, i32 0, i32 1, !dbg !877
  %169 = getelementptr inbounds %struct.xLIST_ITEM, ptr %168, i32 0, i32 1, !dbg !877
  store ptr %166, ptr %169, align 4, !dbg !877
  %170 = load ptr, ptr %8, align 4, !dbg !877
  %171 = getelementptr inbounds %struct.xLIST_ITEM, ptr %170, i32 0, i32 2, !dbg !877
  %172 = load ptr, ptr %171, align 4, !dbg !877
  %173 = load ptr, ptr %1, align 4, !dbg !877
  %174 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %173, i32 0, i32 1, !dbg !877
  %175 = getelementptr inbounds %struct.xLIST_ITEM, ptr %174, i32 0, i32 2, !dbg !877
  store ptr %172, ptr %175, align 4, !dbg !877
  %176 = load ptr, ptr %1, align 4, !dbg !877
  %177 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %176, i32 0, i32 1, !dbg !877
  %178 = load ptr, ptr %8, align 4, !dbg !877
  %179 = getelementptr inbounds %struct.xLIST_ITEM, ptr %178, i32 0, i32 2, !dbg !877
  %180 = load ptr, ptr %179, align 4, !dbg !877
  %181 = getelementptr inbounds %struct.xLIST_ITEM, ptr %180, i32 0, i32 1, !dbg !877
  store ptr %177, ptr %181, align 4, !dbg !877
  %182 = load ptr, ptr %1, align 4, !dbg !877
  %183 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %182, i32 0, i32 1, !dbg !877
  %184 = load ptr, ptr %8, align 4, !dbg !877
  %185 = getelementptr inbounds %struct.xLIST_ITEM, ptr %184, i32 0, i32 2, !dbg !877
  store ptr %183, ptr %185, align 4, !dbg !877
  %186 = load ptr, ptr %1, align 4, !dbg !877
  %187 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %186, i32 0, i32 3, !dbg !877
  %188 = load i32, ptr %187, align 4, !dbg !877
  %189 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %188, !dbg !877
  %190 = load ptr, ptr %1, align 4, !dbg !877
  %191 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %190, i32 0, i32 1, !dbg !877
  %192 = getelementptr inbounds %struct.xLIST_ITEM, ptr %191, i32 0, i32 4, !dbg !877
  store ptr %189, ptr %192, align 4, !dbg !877
  %193 = load ptr, ptr %1, align 4, !dbg !877
  %194 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %193, i32 0, i32 3, !dbg !877
  %195 = load i32, ptr %194, align 4, !dbg !877
  %196 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %195, !dbg !877
  %197 = getelementptr inbounds %struct.xLIST, ptr %196, i32 0, i32 0, !dbg !877
  %198 = load volatile i32, ptr %197, align 4, !dbg !877
  %199 = add i32 %198, 1, !dbg !877
  store volatile i32 %199, ptr %197, align 4, !dbg !877
  %200 = load ptr, ptr %1, align 4, !dbg !878
  %201 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %200, i32 0, i32 3, !dbg !879
  %202 = load i32, ptr %201, align 4, !dbg !879
  %203 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !880
  %204 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %203, i32 0, i32 3, !dbg !881
  %205 = load i32, ptr %204, align 4, !dbg !881
  %206 = icmp uge i32 %202, %205, !dbg !882
  br i1 %206, label %207, label %208, !dbg !878

207:                                              ; preds = %159
  store i32 1, ptr %3, align 4, !dbg !883
  br label %209, !dbg !884

208:                                              ; preds = %159
  br label %209

209:                                              ; preds = %208, %207
  br label %210

210:                                              ; preds = %209
  br label %29, !dbg !857, !llvm.loop !885

211:                                              ; preds = %52, %37
  br label %212, !dbg !887

212:                                              ; preds = %211, %24
  %213 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !888
  %214 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %213, i32 0, i32 3, !dbg !888
  %215 = load i32, ptr %214, align 4, !dbg !888
  %216 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %215, !dbg !888
  %217 = getelementptr inbounds %struct.xLIST, ptr %216, i32 0, i32 0, !dbg !888
  %218 = load volatile i32, ptr %217, align 4, !dbg !888
  %219 = icmp ugt i32 %218, 1, !dbg !889
  br i1 %219, label %220, label %221, !dbg !888

220:                                              ; preds = %212
  store i32 1, ptr %3, align 4, !dbg !890
  br label %222, !dbg !891

221:                                              ; preds = %212
  br label %222

222:                                              ; preds = %221, %220
  %223 = load volatile i32, ptr @xYieldPending, align 4, !dbg !892
  %224 = icmp ne i32 %223, 0, !dbg !893
  br i1 %224, label %225, label %226, !dbg !892

225:                                              ; preds = %222
  store i32 1, ptr %3, align 4, !dbg !894
  br label %227, !dbg !895

226:                                              ; preds = %222
  br label %227

227:                                              ; preds = %226, %225
  br label %231, !dbg !896

228:                                              ; preds = %0
  %229 = load volatile i32, ptr @xPendedTicks, align 4, !dbg !897
  %230 = add i32 %229, 1, !dbg !897
  store volatile i32 %230, ptr @xPendedTicks, align 4, !dbg !897
  br label %231

231:                                              ; preds = %228, %227
  %232 = load i32, ptr %3, align 4, !dbg !898
  ret i32 %232, !dbg !899
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskGetTickCount() #0 !dbg !900 {
  %1 = alloca i32, align 4
  %2 = load volatile i32, ptr @xTickCount, align 4, !dbg !901
  store i32 %2, ptr %1, align 4, !dbg !902
  %3 = load i32, ptr %1, align 4, !dbg !903
  ret i32 %3, !dbg !904
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskGetTickCountFromISR() #0 !dbg !905 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %2, align 4, !dbg !906
  %3 = load volatile i32, ptr @xTickCount, align 4, !dbg !907
  store i32 %3, ptr %1, align 4, !dbg !908
  %4 = load i32, ptr %2, align 4, !dbg !909
  %5 = load i32, ptr %1, align 4, !dbg !910
  ret i32 %5, !dbg !911
}

; Function Attrs: noinline nounwind
define dso_local i32 @uxTaskGetNumberOfTasks() #0 !dbg !912 {
  %1 = load volatile i32, ptr @uxCurrentNumberOfTasks, align 4, !dbg !913
  ret i32 %1, !dbg !914
}

; Function Attrs: noinline nounwind
define dso_local ptr @pcTaskGetName(ptr noundef %0) #0 !dbg !915 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %4 = load ptr, ptr %2, align 4, !dbg !916
  %5 = icmp eq ptr %4, null, !dbg !916
  br i1 %5, label %6, label %8, !dbg !916

6:                                                ; preds = %1
  %7 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !916
  br label %10, !dbg !916

8:                                                ; preds = %1
  %9 = load ptr, ptr %2, align 4, !dbg !916
  br label %10, !dbg !916

10:                                               ; preds = %8, %6
  %11 = phi ptr [ %7, %6 ], [ %9, %8 ], !dbg !916
  store ptr %11, ptr %3, align 4, !dbg !917
  %12 = load ptr, ptr %3, align 4, !dbg !918
  %13 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %12, i32 0, i32 5, !dbg !919
  %14 = getelementptr inbounds [16 x i8], ptr %13, i32 0, i32 0, !dbg !918
  ret ptr %14, !dbg !920
}

; Function Attrs: noinline nounwind
define dso_local i32 @uxTaskGetSystemState(ptr noundef %0, i32 noundef %1, ptr noundef %2) #0 !dbg !921 {
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store ptr %2, ptr %6, align 4
  store i32 0, ptr %7, align 4, !dbg !922
  store i32 56, ptr %8, align 4, !dbg !923
  call void @vTaskSuspendAll(), !dbg !924
  %9 = load i32, ptr %5, align 4, !dbg !925
  %10 = load volatile i32, ptr @uxCurrentNumberOfTasks, align 4, !dbg !926
  %11 = icmp uge i32 %9, %10, !dbg !927
  br i1 %11, label %12, label %59, !dbg !925

12:                                               ; preds = %3
  br label %13, !dbg !928

13:                                               ; preds = %24, %12
  %14 = load i32, ptr %8, align 4, !dbg !929
  %15 = add i32 %14, -1, !dbg !929
  store i32 %15, ptr %8, align 4, !dbg !929
  %16 = load ptr, ptr %4, align 4, !dbg !930
  %17 = load i32, ptr %7, align 4, !dbg !931
  %18 = getelementptr inbounds %struct.xTASK_STATUS, ptr %16, i32 %17, !dbg !930
  %19 = load i32, ptr %8, align 4, !dbg !932
  %20 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %19, !dbg !933
  %21 = call i32 @prvListTasksWithinSingleList(ptr noundef %18, ptr noundef %20, i32 noundef 1), !dbg !934
  %22 = load i32, ptr %7, align 4, !dbg !935
  %23 = add i32 %22, %21, !dbg !935
  store i32 %23, ptr %7, align 4, !dbg !935
  br label %24, !dbg !936

24:                                               ; preds = %13
  %25 = load i32, ptr %8, align 4, !dbg !937
  %26 = icmp ugt i32 %25, 0, !dbg !938
  br i1 %26, label %13, label %27, !dbg !936, !llvm.loop !939

27:                                               ; preds = %24
  %28 = load ptr, ptr %4, align 4, !dbg !941
  %29 = load i32, ptr %7, align 4, !dbg !942
  %30 = getelementptr inbounds %struct.xTASK_STATUS, ptr %28, i32 %29, !dbg !941
  %31 = load volatile ptr, ptr @pxDelayedTaskList, align 4, !dbg !943
  %32 = call i32 @prvListTasksWithinSingleList(ptr noundef %30, ptr noundef %31, i32 noundef 2), !dbg !944
  %33 = load i32, ptr %7, align 4, !dbg !945
  %34 = add i32 %33, %32, !dbg !945
  store i32 %34, ptr %7, align 4, !dbg !945
  %35 = load ptr, ptr %4, align 4, !dbg !946
  %36 = load i32, ptr %7, align 4, !dbg !947
  %37 = getelementptr inbounds %struct.xTASK_STATUS, ptr %35, i32 %36, !dbg !946
  %38 = load volatile ptr, ptr @pxOverflowDelayedTaskList, align 4, !dbg !948
  %39 = call i32 @prvListTasksWithinSingleList(ptr noundef %37, ptr noundef %38, i32 noundef 2), !dbg !949
  %40 = load i32, ptr %7, align 4, !dbg !950
  %41 = add i32 %40, %39, !dbg !950
  store i32 %41, ptr %7, align 4, !dbg !950
  %42 = load ptr, ptr %4, align 4, !dbg !951
  %43 = load i32, ptr %7, align 4, !dbg !952
  %44 = getelementptr inbounds %struct.xTASK_STATUS, ptr %42, i32 %43, !dbg !951
  %45 = call i32 @prvListTasksWithinSingleList(ptr noundef %44, ptr noundef @xTasksWaitingTermination, i32 noundef 4), !dbg !953
  %46 = load i32, ptr %7, align 4, !dbg !954
  %47 = add i32 %46, %45, !dbg !954
  store i32 %47, ptr %7, align 4, !dbg !954
  %48 = load ptr, ptr %4, align 4, !dbg !955
  %49 = load i32, ptr %7, align 4, !dbg !956
  %50 = getelementptr inbounds %struct.xTASK_STATUS, ptr %48, i32 %49, !dbg !955
  %51 = call i32 @prvListTasksWithinSingleList(ptr noundef %50, ptr noundef @xSuspendedTaskList, i32 noundef 3), !dbg !957
  %52 = load i32, ptr %7, align 4, !dbg !958
  %53 = add i32 %52, %51, !dbg !958
  store i32 %53, ptr %7, align 4, !dbg !958
  %54 = load ptr, ptr %6, align 4, !dbg !959
  %55 = icmp ne ptr %54, null, !dbg !960
  br i1 %55, label %56, label %58, !dbg !959

56:                                               ; preds = %27
  %57 = load ptr, ptr %6, align 4, !dbg !961
  store i32 0, ptr %57, align 4, !dbg !962
  br label %58, !dbg !963

58:                                               ; preds = %56, %27
  br label %60, !dbg !964

59:                                               ; preds = %3
  br label %60

60:                                               ; preds = %59, %58
  %61 = call i32 @xTaskResumeAll(), !dbg !965
  %62 = load i32, ptr %7, align 4, !dbg !966
  ret i32 %62, !dbg !967
}

; Function Attrs: noinline nounwind
define internal i32 @prvListTasksWithinSingleList(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 !dbg !968 {
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 4
  %8 = alloca ptr, align 4
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 4
  %11 = alloca ptr, align 4
  store ptr %0, ptr %4, align 4
  store ptr %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %9, align 4, !dbg !969
  %12 = load ptr, ptr %5, align 4, !dbg !970
  %13 = getelementptr inbounds %struct.xLIST, ptr %12, i32 0, i32 0, !dbg !970
  %14 = load volatile i32, ptr %13, align 4, !dbg !970
  %15 = icmp ugt i32 %14, 0, !dbg !971
  br i1 %15, label %16, label %86, !dbg !970

16:                                               ; preds = %3
  %17 = load ptr, ptr %5, align 4, !dbg !972
  store ptr %17, ptr %10, align 4, !dbg !972
  %18 = load ptr, ptr %10, align 4, !dbg !972
  %19 = getelementptr inbounds %struct.xLIST, ptr %18, i32 0, i32 1, !dbg !972
  %20 = load ptr, ptr %19, align 4, !dbg !972
  %21 = getelementptr inbounds %struct.xLIST_ITEM, ptr %20, i32 0, i32 1, !dbg !972
  %22 = load ptr, ptr %21, align 4, !dbg !972
  %23 = load ptr, ptr %10, align 4, !dbg !972
  %24 = getelementptr inbounds %struct.xLIST, ptr %23, i32 0, i32 1, !dbg !972
  store ptr %22, ptr %24, align 4, !dbg !972
  %25 = load ptr, ptr %10, align 4, !dbg !972
  %26 = getelementptr inbounds %struct.xLIST, ptr %25, i32 0, i32 1, !dbg !972
  %27 = load ptr, ptr %26, align 4, !dbg !972
  %28 = load ptr, ptr %10, align 4, !dbg !972
  %29 = getelementptr inbounds %struct.xLIST, ptr %28, i32 0, i32 2, !dbg !972
  %30 = icmp eq ptr %27, %29, !dbg !972
  br i1 %30, label %31, label %39, !dbg !972

31:                                               ; preds = %16
  %32 = load ptr, ptr %10, align 4, !dbg !972
  %33 = getelementptr inbounds %struct.xLIST, ptr %32, i32 0, i32 1, !dbg !972
  %34 = load ptr, ptr %33, align 4, !dbg !972
  %35 = getelementptr inbounds %struct.xLIST_ITEM, ptr %34, i32 0, i32 1, !dbg !972
  %36 = load ptr, ptr %35, align 4, !dbg !972
  %37 = load ptr, ptr %10, align 4, !dbg !972
  %38 = getelementptr inbounds %struct.xLIST, ptr %37, i32 0, i32 1, !dbg !972
  store ptr %36, ptr %38, align 4, !dbg !972
  br label %39, !dbg !972

39:                                               ; preds = %31, %16
  %40 = load ptr, ptr %10, align 4, !dbg !972
  %41 = getelementptr inbounds %struct.xLIST, ptr %40, i32 0, i32 1, !dbg !972
  %42 = load ptr, ptr %41, align 4, !dbg !972
  %43 = getelementptr inbounds %struct.xLIST_ITEM, ptr %42, i32 0, i32 3, !dbg !972
  %44 = load ptr, ptr %43, align 4, !dbg !972
  store ptr %44, ptr %8, align 4, !dbg !972
  br label %45, !dbg !973

45:                                               ; preds = %81, %39
  %46 = load ptr, ptr %5, align 4, !dbg !974
  store ptr %46, ptr %11, align 4, !dbg !974
  %47 = load ptr, ptr %11, align 4, !dbg !974
  %48 = getelementptr inbounds %struct.xLIST, ptr %47, i32 0, i32 1, !dbg !974
  %49 = load ptr, ptr %48, align 4, !dbg !974
  %50 = getelementptr inbounds %struct.xLIST_ITEM, ptr %49, i32 0, i32 1, !dbg !974
  %51 = load ptr, ptr %50, align 4, !dbg !974
  %52 = load ptr, ptr %11, align 4, !dbg !974
  %53 = getelementptr inbounds %struct.xLIST, ptr %52, i32 0, i32 1, !dbg !974
  store ptr %51, ptr %53, align 4, !dbg !974
  %54 = load ptr, ptr %11, align 4, !dbg !974
  %55 = getelementptr inbounds %struct.xLIST, ptr %54, i32 0, i32 1, !dbg !974
  %56 = load ptr, ptr %55, align 4, !dbg !974
  %57 = load ptr, ptr %11, align 4, !dbg !974
  %58 = getelementptr inbounds %struct.xLIST, ptr %57, i32 0, i32 2, !dbg !974
  %59 = icmp eq ptr %56, %58, !dbg !974
  br i1 %59, label %60, label %68, !dbg !974

60:                                               ; preds = %45
  %61 = load ptr, ptr %11, align 4, !dbg !974
  %62 = getelementptr inbounds %struct.xLIST, ptr %61, i32 0, i32 1, !dbg !974
  %63 = load ptr, ptr %62, align 4, !dbg !974
  %64 = getelementptr inbounds %struct.xLIST_ITEM, ptr %63, i32 0, i32 1, !dbg !974
  %65 = load ptr, ptr %64, align 4, !dbg !974
  %66 = load ptr, ptr %11, align 4, !dbg !974
  %67 = getelementptr inbounds %struct.xLIST, ptr %66, i32 0, i32 1, !dbg !974
  store ptr %65, ptr %67, align 4, !dbg !974
  br label %68, !dbg !974

68:                                               ; preds = %60, %45
  %69 = load ptr, ptr %11, align 4, !dbg !974
  %70 = getelementptr inbounds %struct.xLIST, ptr %69, i32 0, i32 1, !dbg !974
  %71 = load ptr, ptr %70, align 4, !dbg !974
  %72 = getelementptr inbounds %struct.xLIST_ITEM, ptr %71, i32 0, i32 3, !dbg !974
  %73 = load ptr, ptr %72, align 4, !dbg !974
  store ptr %73, ptr %7, align 4, !dbg !974
  %74 = load ptr, ptr %7, align 4, !dbg !975
  %75 = load ptr, ptr %4, align 4, !dbg !976
  %76 = load i32, ptr %9, align 4, !dbg !977
  %77 = getelementptr inbounds %struct.xTASK_STATUS, ptr %75, i32 %76, !dbg !976
  %78 = load i32, ptr %6, align 4, !dbg !978
  call void @vTaskGetInfo(ptr noundef %74, ptr noundef %77, i32 noundef 1, i32 noundef %78), !dbg !979
  %79 = load i32, ptr %9, align 4, !dbg !980
  %80 = add i32 %79, 1, !dbg !980
  store i32 %80, ptr %9, align 4, !dbg !980
  br label %81, !dbg !981

81:                                               ; preds = %68
  %82 = load ptr, ptr %7, align 4, !dbg !982
  %83 = load ptr, ptr %8, align 4, !dbg !983
  %84 = icmp ne ptr %82, %83, !dbg !984
  br i1 %84, label %45, label %85, !dbg !981, !llvm.loop !985

85:                                               ; preds = %81
  br label %87, !dbg !987

86:                                               ; preds = %3
  br label %87

87:                                               ; preds = %86, %85
  %88 = load i32, ptr %9, align 4, !dbg !988
  ret i32 %88, !dbg !989
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskCatchUpTicks(i32 noundef %0) #0 !dbg !990 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  call void @vTaskSuspendAll(), !dbg !991
  %4 = load i32, ptr %2, align 4, !dbg !992
  %5 = load volatile i32, ptr @xPendedTicks, align 4, !dbg !993
  %6 = add i32 %5, %4, !dbg !993
  store volatile i32 %6, ptr @xPendedTicks, align 4, !dbg !993
  %7 = call i32 @xTaskResumeAll(), !dbg !994
  store i32 %7, ptr %3, align 4, !dbg !995
  %8 = load i32, ptr %3, align 4, !dbg !996
  ret i32 %8, !dbg !997
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskPlaceOnEventList(ptr noundef %0, i32 noundef %1) #0 !dbg !998 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 4, !dbg !999
  %6 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1000
  %7 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %6, i32 0, i32 2, !dbg !1001
  call void @vListInsert(ptr noundef %5, ptr noundef %7), !dbg !1002
  %8 = load i32, ptr %4, align 4, !dbg !1003
  call void @prvAddCurrentTaskToDelayedList(i32 noundef %8, i32 noundef 1), !dbg !1004
  ret void, !dbg !1005
}

declare dso_local void @vListInsert(ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind
define dso_local void @vTaskPlaceOnUnorderedEventList(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 !dbg !1006 {
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 4
  store ptr %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %8 = load i32, ptr %5, align 4, !dbg !1007
  %9 = or i32 %8, -2147483648, !dbg !1007
  %10 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1007
  %11 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %10, i32 0, i32 2, !dbg !1007
  %12 = getelementptr inbounds %struct.xLIST_ITEM, ptr %11, i32 0, i32 0, !dbg !1007
  store i32 %9, ptr %12, align 4, !dbg !1007
  %13 = load ptr, ptr %4, align 4, !dbg !1008
  %14 = getelementptr inbounds %struct.xLIST, ptr %13, i32 0, i32 1, !dbg !1008
  %15 = load ptr, ptr %14, align 4, !dbg !1008
  store ptr %15, ptr %7, align 4, !dbg !1008
  %16 = load ptr, ptr %7, align 4, !dbg !1008
  %17 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1008
  %18 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %17, i32 0, i32 2, !dbg !1008
  %19 = getelementptr inbounds %struct.xLIST_ITEM, ptr %18, i32 0, i32 1, !dbg !1008
  store ptr %16, ptr %19, align 4, !dbg !1008
  %20 = load ptr, ptr %7, align 4, !dbg !1008
  %21 = getelementptr inbounds %struct.xLIST_ITEM, ptr %20, i32 0, i32 2, !dbg !1008
  %22 = load ptr, ptr %21, align 4, !dbg !1008
  %23 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1008
  %24 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %23, i32 0, i32 2, !dbg !1008
  %25 = getelementptr inbounds %struct.xLIST_ITEM, ptr %24, i32 0, i32 2, !dbg !1008
  store ptr %22, ptr %25, align 4, !dbg !1008
  %26 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1008
  %27 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %26, i32 0, i32 2, !dbg !1008
  %28 = load ptr, ptr %7, align 4, !dbg !1008
  %29 = getelementptr inbounds %struct.xLIST_ITEM, ptr %28, i32 0, i32 2, !dbg !1008
  %30 = load ptr, ptr %29, align 4, !dbg !1008
  %31 = getelementptr inbounds %struct.xLIST_ITEM, ptr %30, i32 0, i32 1, !dbg !1008
  store ptr %27, ptr %31, align 4, !dbg !1008
  %32 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1008
  %33 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %32, i32 0, i32 2, !dbg !1008
  %34 = load ptr, ptr %7, align 4, !dbg !1008
  %35 = getelementptr inbounds %struct.xLIST_ITEM, ptr %34, i32 0, i32 2, !dbg !1008
  store ptr %33, ptr %35, align 4, !dbg !1008
  %36 = load ptr, ptr %4, align 4, !dbg !1008
  %37 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1008
  %38 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %37, i32 0, i32 2, !dbg !1008
  %39 = getelementptr inbounds %struct.xLIST_ITEM, ptr %38, i32 0, i32 4, !dbg !1008
  store ptr %36, ptr %39, align 4, !dbg !1008
  %40 = load ptr, ptr %4, align 4, !dbg !1008
  %41 = getelementptr inbounds %struct.xLIST, ptr %40, i32 0, i32 0, !dbg !1008
  %42 = load volatile i32, ptr %41, align 4, !dbg !1008
  %43 = add i32 %42, 1, !dbg !1008
  store volatile i32 %43, ptr %41, align 4, !dbg !1008
  %44 = load i32, ptr %6, align 4, !dbg !1009
  call void @prvAddCurrentTaskToDelayedList(i32 noundef %44, i32 noundef 1), !dbg !1010
  ret void, !dbg !1011
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskPlaceOnEventListRestricted(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 !dbg !1012 {
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 4
  store ptr %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %8 = load ptr, ptr %4, align 4, !dbg !1013
  %9 = getelementptr inbounds %struct.xLIST, ptr %8, i32 0, i32 1, !dbg !1013
  %10 = load ptr, ptr %9, align 4, !dbg !1013
  store ptr %10, ptr %7, align 4, !dbg !1013
  %11 = load ptr, ptr %7, align 4, !dbg !1013
  %12 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1013
  %13 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %12, i32 0, i32 2, !dbg !1013
  %14 = getelementptr inbounds %struct.xLIST_ITEM, ptr %13, i32 0, i32 1, !dbg !1013
  store ptr %11, ptr %14, align 4, !dbg !1013
  %15 = load ptr, ptr %7, align 4, !dbg !1013
  %16 = getelementptr inbounds %struct.xLIST_ITEM, ptr %15, i32 0, i32 2, !dbg !1013
  %17 = load ptr, ptr %16, align 4, !dbg !1013
  %18 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1013
  %19 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %18, i32 0, i32 2, !dbg !1013
  %20 = getelementptr inbounds %struct.xLIST_ITEM, ptr %19, i32 0, i32 2, !dbg !1013
  store ptr %17, ptr %20, align 4, !dbg !1013
  %21 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1013
  %22 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %21, i32 0, i32 2, !dbg !1013
  %23 = load ptr, ptr %7, align 4, !dbg !1013
  %24 = getelementptr inbounds %struct.xLIST_ITEM, ptr %23, i32 0, i32 2, !dbg !1013
  %25 = load ptr, ptr %24, align 4, !dbg !1013
  %26 = getelementptr inbounds %struct.xLIST_ITEM, ptr %25, i32 0, i32 1, !dbg !1013
  store ptr %22, ptr %26, align 4, !dbg !1013
  %27 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1013
  %28 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %27, i32 0, i32 2, !dbg !1013
  %29 = load ptr, ptr %7, align 4, !dbg !1013
  %30 = getelementptr inbounds %struct.xLIST_ITEM, ptr %29, i32 0, i32 2, !dbg !1013
  store ptr %28, ptr %30, align 4, !dbg !1013
  %31 = load ptr, ptr %4, align 4, !dbg !1013
  %32 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1013
  %33 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %32, i32 0, i32 2, !dbg !1013
  %34 = getelementptr inbounds %struct.xLIST_ITEM, ptr %33, i32 0, i32 4, !dbg !1013
  store ptr %31, ptr %34, align 4, !dbg !1013
  %35 = load ptr, ptr %4, align 4, !dbg !1013
  %36 = getelementptr inbounds %struct.xLIST, ptr %35, i32 0, i32 0, !dbg !1013
  %37 = load volatile i32, ptr %36, align 4, !dbg !1013
  %38 = add i32 %37, 1, !dbg !1013
  store volatile i32 %38, ptr %36, align 4, !dbg !1013
  %39 = load i32, ptr %6, align 4, !dbg !1014
  %40 = icmp ne i32 %39, 0, !dbg !1015
  br i1 %40, label %41, label %42, !dbg !1014

41:                                               ; preds = %3
  store i32 -1, ptr %5, align 4, !dbg !1016
  br label %42, !dbg !1017

42:                                               ; preds = %41, %3
  %43 = load i32, ptr %5, align 4, !dbg !1018
  %44 = load i32, ptr %6, align 4, !dbg !1019
  call void @prvAddCurrentTaskToDelayedList(i32 noundef %43, i32 noundef %44), !dbg !1020
  ret void, !dbg !1021
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskRemoveFromEventList(ptr noundef %0) #0 !dbg !1022 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca ptr, align 4
  %8 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %9 = load ptr, ptr %2, align 4, !dbg !1023
  %10 = getelementptr inbounds %struct.xLIST, ptr %9, i32 0, i32 2, !dbg !1023
  %11 = getelementptr inbounds %struct.xMINI_LIST_ITEM, ptr %10, i32 0, i32 1, !dbg !1023
  %12 = load ptr, ptr %11, align 4, !dbg !1023
  %13 = getelementptr inbounds %struct.xLIST_ITEM, ptr %12, i32 0, i32 3, !dbg !1023
  %14 = load ptr, ptr %13, align 4, !dbg !1023
  store ptr %14, ptr %3, align 4, !dbg !1024
  %15 = load ptr, ptr %3, align 4, !dbg !1025
  %16 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %15, i32 0, i32 2, !dbg !1025
  %17 = getelementptr inbounds %struct.xLIST_ITEM, ptr %16, i32 0, i32 4, !dbg !1025
  %18 = load ptr, ptr %17, align 4, !dbg !1025
  store ptr %18, ptr %5, align 4, !dbg !1025
  %19 = load ptr, ptr %3, align 4, !dbg !1025
  %20 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %19, i32 0, i32 2, !dbg !1025
  %21 = getelementptr inbounds %struct.xLIST_ITEM, ptr %20, i32 0, i32 2, !dbg !1025
  %22 = load ptr, ptr %21, align 4, !dbg !1025
  %23 = load ptr, ptr %3, align 4, !dbg !1025
  %24 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %23, i32 0, i32 2, !dbg !1025
  %25 = getelementptr inbounds %struct.xLIST_ITEM, ptr %24, i32 0, i32 1, !dbg !1025
  %26 = load ptr, ptr %25, align 4, !dbg !1025
  %27 = getelementptr inbounds %struct.xLIST_ITEM, ptr %26, i32 0, i32 2, !dbg !1025
  store ptr %22, ptr %27, align 4, !dbg !1025
  %28 = load ptr, ptr %3, align 4, !dbg !1025
  %29 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %28, i32 0, i32 2, !dbg !1025
  %30 = getelementptr inbounds %struct.xLIST_ITEM, ptr %29, i32 0, i32 1, !dbg !1025
  %31 = load ptr, ptr %30, align 4, !dbg !1025
  %32 = load ptr, ptr %3, align 4, !dbg !1025
  %33 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %32, i32 0, i32 2, !dbg !1025
  %34 = getelementptr inbounds %struct.xLIST_ITEM, ptr %33, i32 0, i32 2, !dbg !1025
  %35 = load ptr, ptr %34, align 4, !dbg !1025
  %36 = getelementptr inbounds %struct.xLIST_ITEM, ptr %35, i32 0, i32 1, !dbg !1025
  store ptr %31, ptr %36, align 4, !dbg !1025
  %37 = load ptr, ptr %5, align 4, !dbg !1025
  %38 = getelementptr inbounds %struct.xLIST, ptr %37, i32 0, i32 1, !dbg !1025
  %39 = load ptr, ptr %38, align 4, !dbg !1025
  %40 = load ptr, ptr %3, align 4, !dbg !1025
  %41 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %40, i32 0, i32 2, !dbg !1025
  %42 = icmp eq ptr %39, %41, !dbg !1025
  br i1 %42, label %43, label %50, !dbg !1025

43:                                               ; preds = %1
  %44 = load ptr, ptr %3, align 4, !dbg !1025
  %45 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %44, i32 0, i32 2, !dbg !1025
  %46 = getelementptr inbounds %struct.xLIST_ITEM, ptr %45, i32 0, i32 2, !dbg !1025
  %47 = load ptr, ptr %46, align 4, !dbg !1025
  %48 = load ptr, ptr %5, align 4, !dbg !1025
  %49 = getelementptr inbounds %struct.xLIST, ptr %48, i32 0, i32 1, !dbg !1025
  store ptr %47, ptr %49, align 4, !dbg !1025
  br label %50, !dbg !1025

50:                                               ; preds = %43, %1
  %51 = load ptr, ptr %3, align 4, !dbg !1025
  %52 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %51, i32 0, i32 2, !dbg !1025
  %53 = getelementptr inbounds %struct.xLIST_ITEM, ptr %52, i32 0, i32 4, !dbg !1025
  store ptr null, ptr %53, align 4, !dbg !1025
  %54 = load ptr, ptr %5, align 4, !dbg !1025
  %55 = getelementptr inbounds %struct.xLIST, ptr %54, i32 0, i32 0, !dbg !1025
  %56 = load volatile i32, ptr %55, align 4, !dbg !1025
  %57 = add i32 %56, -1, !dbg !1025
  store volatile i32 %57, ptr %55, align 4, !dbg !1025
  %58 = load volatile i32, ptr @uxSchedulerSuspended, align 4, !dbg !1026
  %59 = icmp eq i32 %58, 0, !dbg !1027
  br i1 %59, label %60, label %154, !dbg !1026

60:                                               ; preds = %50
  %61 = load ptr, ptr %3, align 4, !dbg !1028
  %62 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %61, i32 0, i32 1, !dbg !1028
  %63 = getelementptr inbounds %struct.xLIST_ITEM, ptr %62, i32 0, i32 4, !dbg !1028
  %64 = load ptr, ptr %63, align 4, !dbg !1028
  store ptr %64, ptr %6, align 4, !dbg !1028
  %65 = load ptr, ptr %3, align 4, !dbg !1028
  %66 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %65, i32 0, i32 1, !dbg !1028
  %67 = getelementptr inbounds %struct.xLIST_ITEM, ptr %66, i32 0, i32 2, !dbg !1028
  %68 = load ptr, ptr %67, align 4, !dbg !1028
  %69 = load ptr, ptr %3, align 4, !dbg !1028
  %70 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %69, i32 0, i32 1, !dbg !1028
  %71 = getelementptr inbounds %struct.xLIST_ITEM, ptr %70, i32 0, i32 1, !dbg !1028
  %72 = load ptr, ptr %71, align 4, !dbg !1028
  %73 = getelementptr inbounds %struct.xLIST_ITEM, ptr %72, i32 0, i32 2, !dbg !1028
  store ptr %68, ptr %73, align 4, !dbg !1028
  %74 = load ptr, ptr %3, align 4, !dbg !1028
  %75 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %74, i32 0, i32 1, !dbg !1028
  %76 = getelementptr inbounds %struct.xLIST_ITEM, ptr %75, i32 0, i32 1, !dbg !1028
  %77 = load ptr, ptr %76, align 4, !dbg !1028
  %78 = load ptr, ptr %3, align 4, !dbg !1028
  %79 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %78, i32 0, i32 1, !dbg !1028
  %80 = getelementptr inbounds %struct.xLIST_ITEM, ptr %79, i32 0, i32 2, !dbg !1028
  %81 = load ptr, ptr %80, align 4, !dbg !1028
  %82 = getelementptr inbounds %struct.xLIST_ITEM, ptr %81, i32 0, i32 1, !dbg !1028
  store ptr %77, ptr %82, align 4, !dbg !1028
  %83 = load ptr, ptr %6, align 4, !dbg !1028
  %84 = getelementptr inbounds %struct.xLIST, ptr %83, i32 0, i32 1, !dbg !1028
  %85 = load ptr, ptr %84, align 4, !dbg !1028
  %86 = load ptr, ptr %3, align 4, !dbg !1028
  %87 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %86, i32 0, i32 1, !dbg !1028
  %88 = icmp eq ptr %85, %87, !dbg !1028
  br i1 %88, label %89, label %96, !dbg !1028

89:                                               ; preds = %60
  %90 = load ptr, ptr %3, align 4, !dbg !1028
  %91 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %90, i32 0, i32 1, !dbg !1028
  %92 = getelementptr inbounds %struct.xLIST_ITEM, ptr %91, i32 0, i32 2, !dbg !1028
  %93 = load ptr, ptr %92, align 4, !dbg !1028
  %94 = load ptr, ptr %6, align 4, !dbg !1028
  %95 = getelementptr inbounds %struct.xLIST, ptr %94, i32 0, i32 1, !dbg !1028
  store ptr %93, ptr %95, align 4, !dbg !1028
  br label %96, !dbg !1028

96:                                               ; preds = %89, %60
  %97 = load ptr, ptr %3, align 4, !dbg !1028
  %98 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %97, i32 0, i32 1, !dbg !1028
  %99 = getelementptr inbounds %struct.xLIST_ITEM, ptr %98, i32 0, i32 4, !dbg !1028
  store ptr null, ptr %99, align 4, !dbg !1028
  %100 = load ptr, ptr %6, align 4, !dbg !1028
  %101 = getelementptr inbounds %struct.xLIST, ptr %100, i32 0, i32 0, !dbg !1028
  %102 = load volatile i32, ptr %101, align 4, !dbg !1028
  %103 = add i32 %102, -1, !dbg !1028
  store volatile i32 %103, ptr %101, align 4, !dbg !1028
  %104 = load ptr, ptr %3, align 4, !dbg !1029
  %105 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %104, i32 0, i32 3, !dbg !1029
  %106 = load i32, ptr %105, align 4, !dbg !1029
  %107 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !1029
  %108 = icmp ugt i32 %106, %107, !dbg !1029
  br i1 %108, label %109, label %113, !dbg !1029

109:                                              ; preds = %96
  %110 = load ptr, ptr %3, align 4, !dbg !1029
  %111 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %110, i32 0, i32 3, !dbg !1029
  %112 = load i32, ptr %111, align 4, !dbg !1029
  store volatile i32 %112, ptr @uxTopReadyPriority, align 4, !dbg !1029
  br label %113, !dbg !1029

113:                                              ; preds = %109, %96
  %114 = load ptr, ptr %3, align 4, !dbg !1029
  %115 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %114, i32 0, i32 3, !dbg !1029
  %116 = load i32, ptr %115, align 4, !dbg !1029
  %117 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %116, !dbg !1029
  %118 = getelementptr inbounds %struct.xLIST, ptr %117, i32 0, i32 1, !dbg !1029
  %119 = load ptr, ptr %118, align 4, !dbg !1029
  store ptr %119, ptr %7, align 4, !dbg !1029
  %120 = load ptr, ptr %7, align 4, !dbg !1029
  %121 = load ptr, ptr %3, align 4, !dbg !1029
  %122 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %121, i32 0, i32 1, !dbg !1029
  %123 = getelementptr inbounds %struct.xLIST_ITEM, ptr %122, i32 0, i32 1, !dbg !1029
  store ptr %120, ptr %123, align 4, !dbg !1029
  %124 = load ptr, ptr %7, align 4, !dbg !1029
  %125 = getelementptr inbounds %struct.xLIST_ITEM, ptr %124, i32 0, i32 2, !dbg !1029
  %126 = load ptr, ptr %125, align 4, !dbg !1029
  %127 = load ptr, ptr %3, align 4, !dbg !1029
  %128 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %127, i32 0, i32 1, !dbg !1029
  %129 = getelementptr inbounds %struct.xLIST_ITEM, ptr %128, i32 0, i32 2, !dbg !1029
  store ptr %126, ptr %129, align 4, !dbg !1029
  %130 = load ptr, ptr %3, align 4, !dbg !1029
  %131 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %130, i32 0, i32 1, !dbg !1029
  %132 = load ptr, ptr %7, align 4, !dbg !1029
  %133 = getelementptr inbounds %struct.xLIST_ITEM, ptr %132, i32 0, i32 2, !dbg !1029
  %134 = load ptr, ptr %133, align 4, !dbg !1029
  %135 = getelementptr inbounds %struct.xLIST_ITEM, ptr %134, i32 0, i32 1, !dbg !1029
  store ptr %131, ptr %135, align 4, !dbg !1029
  %136 = load ptr, ptr %3, align 4, !dbg !1029
  %137 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %136, i32 0, i32 1, !dbg !1029
  %138 = load ptr, ptr %7, align 4, !dbg !1029
  %139 = getelementptr inbounds %struct.xLIST_ITEM, ptr %138, i32 0, i32 2, !dbg !1029
  store ptr %137, ptr %139, align 4, !dbg !1029
  %140 = load ptr, ptr %3, align 4, !dbg !1029
  %141 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %140, i32 0, i32 3, !dbg !1029
  %142 = load i32, ptr %141, align 4, !dbg !1029
  %143 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %142, !dbg !1029
  %144 = load ptr, ptr %3, align 4, !dbg !1029
  %145 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %144, i32 0, i32 1, !dbg !1029
  %146 = getelementptr inbounds %struct.xLIST_ITEM, ptr %145, i32 0, i32 4, !dbg !1029
  store ptr %143, ptr %146, align 4, !dbg !1029
  %147 = load ptr, ptr %3, align 4, !dbg !1029
  %148 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %147, i32 0, i32 3, !dbg !1029
  %149 = load i32, ptr %148, align 4, !dbg !1029
  %150 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %149, !dbg !1029
  %151 = getelementptr inbounds %struct.xLIST, ptr %150, i32 0, i32 0, !dbg !1029
  %152 = load volatile i32, ptr %151, align 4, !dbg !1029
  %153 = add i32 %152, 1, !dbg !1029
  store volatile i32 %153, ptr %151, align 4, !dbg !1029
  br label %181, !dbg !1030

154:                                              ; preds = %50
  %155 = load ptr, ptr getelementptr inbounds (%struct.xLIST, ptr @xPendingReadyList, i32 0, i32 1), align 4, !dbg !1031
  store ptr %155, ptr %8, align 4, !dbg !1031
  %156 = load ptr, ptr %8, align 4, !dbg !1031
  %157 = load ptr, ptr %3, align 4, !dbg !1031
  %158 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %157, i32 0, i32 2, !dbg !1031
  %159 = getelementptr inbounds %struct.xLIST_ITEM, ptr %158, i32 0, i32 1, !dbg !1031
  store ptr %156, ptr %159, align 4, !dbg !1031
  %160 = load ptr, ptr %8, align 4, !dbg !1031
  %161 = getelementptr inbounds %struct.xLIST_ITEM, ptr %160, i32 0, i32 2, !dbg !1031
  %162 = load ptr, ptr %161, align 4, !dbg !1031
  %163 = load ptr, ptr %3, align 4, !dbg !1031
  %164 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %163, i32 0, i32 2, !dbg !1031
  %165 = getelementptr inbounds %struct.xLIST_ITEM, ptr %164, i32 0, i32 2, !dbg !1031
  store ptr %162, ptr %165, align 4, !dbg !1031
  %166 = load ptr, ptr %3, align 4, !dbg !1031
  %167 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %166, i32 0, i32 2, !dbg !1031
  %168 = load ptr, ptr %8, align 4, !dbg !1031
  %169 = getelementptr inbounds %struct.xLIST_ITEM, ptr %168, i32 0, i32 2, !dbg !1031
  %170 = load ptr, ptr %169, align 4, !dbg !1031
  %171 = getelementptr inbounds %struct.xLIST_ITEM, ptr %170, i32 0, i32 1, !dbg !1031
  store ptr %167, ptr %171, align 4, !dbg !1031
  %172 = load ptr, ptr %3, align 4, !dbg !1031
  %173 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %172, i32 0, i32 2, !dbg !1031
  %174 = load ptr, ptr %8, align 4, !dbg !1031
  %175 = getelementptr inbounds %struct.xLIST_ITEM, ptr %174, i32 0, i32 2, !dbg !1031
  store ptr %173, ptr %175, align 4, !dbg !1031
  %176 = load ptr, ptr %3, align 4, !dbg !1031
  %177 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %176, i32 0, i32 2, !dbg !1031
  %178 = getelementptr inbounds %struct.xLIST_ITEM, ptr %177, i32 0, i32 4, !dbg !1031
  store ptr @xPendingReadyList, ptr %178, align 4, !dbg !1031
  %179 = load volatile i32, ptr @xPendingReadyList, align 4, !dbg !1031
  %180 = add i32 %179, 1, !dbg !1031
  store volatile i32 %180, ptr @xPendingReadyList, align 4, !dbg !1031
  br label %181

181:                                              ; preds = %154, %113
  %182 = load ptr, ptr %3, align 4, !dbg !1032
  %183 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %182, i32 0, i32 3, !dbg !1033
  %184 = load i32, ptr %183, align 4, !dbg !1033
  %185 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1034
  %186 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %185, i32 0, i32 3, !dbg !1035
  %187 = load i32, ptr %186, align 4, !dbg !1035
  %188 = icmp ugt i32 %184, %187, !dbg !1036
  br i1 %188, label %189, label %190, !dbg !1032

189:                                              ; preds = %181
  store i32 1, ptr %4, align 4, !dbg !1037
  store volatile i32 1, ptr @xYieldPending, align 4, !dbg !1038
  br label %191, !dbg !1039

190:                                              ; preds = %181
  store i32 0, ptr %4, align 4, !dbg !1040
  br label %191

191:                                              ; preds = %190, %189
  %192 = load i32, ptr %4, align 4, !dbg !1041
  ret i32 %192, !dbg !1042
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskRemoveFromUnorderedEventList(ptr noundef %0, i32 noundef %1) #0 !dbg !1043 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca ptr, align 4
  %8 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %9 = load i32, ptr %4, align 4, !dbg !1044
  %10 = or i32 %9, -2147483648, !dbg !1044
  %11 = load ptr, ptr %3, align 4, !dbg !1044
  %12 = getelementptr inbounds %struct.xLIST_ITEM, ptr %11, i32 0, i32 0, !dbg !1044
  store i32 %10, ptr %12, align 4, !dbg !1044
  %13 = load ptr, ptr %3, align 4, !dbg !1045
  %14 = getelementptr inbounds %struct.xLIST_ITEM, ptr %13, i32 0, i32 3, !dbg !1045
  %15 = load ptr, ptr %14, align 4, !dbg !1045
  store ptr %15, ptr %5, align 4, !dbg !1046
  %16 = load ptr, ptr %3, align 4, !dbg !1047
  %17 = getelementptr inbounds %struct.xLIST_ITEM, ptr %16, i32 0, i32 4, !dbg !1047
  %18 = load ptr, ptr %17, align 4, !dbg !1047
  store ptr %18, ptr %6, align 4, !dbg !1047
  %19 = load ptr, ptr %3, align 4, !dbg !1047
  %20 = getelementptr inbounds %struct.xLIST_ITEM, ptr %19, i32 0, i32 2, !dbg !1047
  %21 = load ptr, ptr %20, align 4, !dbg !1047
  %22 = load ptr, ptr %3, align 4, !dbg !1047
  %23 = getelementptr inbounds %struct.xLIST_ITEM, ptr %22, i32 0, i32 1, !dbg !1047
  %24 = load ptr, ptr %23, align 4, !dbg !1047
  %25 = getelementptr inbounds %struct.xLIST_ITEM, ptr %24, i32 0, i32 2, !dbg !1047
  store ptr %21, ptr %25, align 4, !dbg !1047
  %26 = load ptr, ptr %3, align 4, !dbg !1047
  %27 = getelementptr inbounds %struct.xLIST_ITEM, ptr %26, i32 0, i32 1, !dbg !1047
  %28 = load ptr, ptr %27, align 4, !dbg !1047
  %29 = load ptr, ptr %3, align 4, !dbg !1047
  %30 = getelementptr inbounds %struct.xLIST_ITEM, ptr %29, i32 0, i32 2, !dbg !1047
  %31 = load ptr, ptr %30, align 4, !dbg !1047
  %32 = getelementptr inbounds %struct.xLIST_ITEM, ptr %31, i32 0, i32 1, !dbg !1047
  store ptr %28, ptr %32, align 4, !dbg !1047
  %33 = load ptr, ptr %6, align 4, !dbg !1047
  %34 = getelementptr inbounds %struct.xLIST, ptr %33, i32 0, i32 1, !dbg !1047
  %35 = load ptr, ptr %34, align 4, !dbg !1047
  %36 = load ptr, ptr %3, align 4, !dbg !1047
  %37 = icmp eq ptr %35, %36, !dbg !1047
  br i1 %37, label %38, label %44, !dbg !1047

38:                                               ; preds = %2
  %39 = load ptr, ptr %3, align 4, !dbg !1047
  %40 = getelementptr inbounds %struct.xLIST_ITEM, ptr %39, i32 0, i32 2, !dbg !1047
  %41 = load ptr, ptr %40, align 4, !dbg !1047
  %42 = load ptr, ptr %6, align 4, !dbg !1047
  %43 = getelementptr inbounds %struct.xLIST, ptr %42, i32 0, i32 1, !dbg !1047
  store ptr %41, ptr %43, align 4, !dbg !1047
  br label %44, !dbg !1047

44:                                               ; preds = %38, %2
  %45 = load ptr, ptr %3, align 4, !dbg !1047
  %46 = getelementptr inbounds %struct.xLIST_ITEM, ptr %45, i32 0, i32 4, !dbg !1047
  store ptr null, ptr %46, align 4, !dbg !1047
  %47 = load ptr, ptr %6, align 4, !dbg !1047
  %48 = getelementptr inbounds %struct.xLIST, ptr %47, i32 0, i32 0, !dbg !1047
  %49 = load volatile i32, ptr %48, align 4, !dbg !1047
  %50 = add i32 %49, -1, !dbg !1047
  store volatile i32 %50, ptr %48, align 4, !dbg !1047
  %51 = load ptr, ptr %5, align 4, !dbg !1048
  %52 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %51, i32 0, i32 1, !dbg !1048
  %53 = getelementptr inbounds %struct.xLIST_ITEM, ptr %52, i32 0, i32 4, !dbg !1048
  %54 = load ptr, ptr %53, align 4, !dbg !1048
  store ptr %54, ptr %7, align 4, !dbg !1048
  %55 = load ptr, ptr %5, align 4, !dbg !1048
  %56 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %55, i32 0, i32 1, !dbg !1048
  %57 = getelementptr inbounds %struct.xLIST_ITEM, ptr %56, i32 0, i32 2, !dbg !1048
  %58 = load ptr, ptr %57, align 4, !dbg !1048
  %59 = load ptr, ptr %5, align 4, !dbg !1048
  %60 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %59, i32 0, i32 1, !dbg !1048
  %61 = getelementptr inbounds %struct.xLIST_ITEM, ptr %60, i32 0, i32 1, !dbg !1048
  %62 = load ptr, ptr %61, align 4, !dbg !1048
  %63 = getelementptr inbounds %struct.xLIST_ITEM, ptr %62, i32 0, i32 2, !dbg !1048
  store ptr %58, ptr %63, align 4, !dbg !1048
  %64 = load ptr, ptr %5, align 4, !dbg !1048
  %65 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %64, i32 0, i32 1, !dbg !1048
  %66 = getelementptr inbounds %struct.xLIST_ITEM, ptr %65, i32 0, i32 1, !dbg !1048
  %67 = load ptr, ptr %66, align 4, !dbg !1048
  %68 = load ptr, ptr %5, align 4, !dbg !1048
  %69 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %68, i32 0, i32 1, !dbg !1048
  %70 = getelementptr inbounds %struct.xLIST_ITEM, ptr %69, i32 0, i32 2, !dbg !1048
  %71 = load ptr, ptr %70, align 4, !dbg !1048
  %72 = getelementptr inbounds %struct.xLIST_ITEM, ptr %71, i32 0, i32 1, !dbg !1048
  store ptr %67, ptr %72, align 4, !dbg !1048
  %73 = load ptr, ptr %7, align 4, !dbg !1048
  %74 = getelementptr inbounds %struct.xLIST, ptr %73, i32 0, i32 1, !dbg !1048
  %75 = load ptr, ptr %74, align 4, !dbg !1048
  %76 = load ptr, ptr %5, align 4, !dbg !1048
  %77 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %76, i32 0, i32 1, !dbg !1048
  %78 = icmp eq ptr %75, %77, !dbg !1048
  br i1 %78, label %79, label %86, !dbg !1048

79:                                               ; preds = %44
  %80 = load ptr, ptr %5, align 4, !dbg !1048
  %81 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %80, i32 0, i32 1, !dbg !1048
  %82 = getelementptr inbounds %struct.xLIST_ITEM, ptr %81, i32 0, i32 2, !dbg !1048
  %83 = load ptr, ptr %82, align 4, !dbg !1048
  %84 = load ptr, ptr %7, align 4, !dbg !1048
  %85 = getelementptr inbounds %struct.xLIST, ptr %84, i32 0, i32 1, !dbg !1048
  store ptr %83, ptr %85, align 4, !dbg !1048
  br label %86, !dbg !1048

86:                                               ; preds = %79, %44
  %87 = load ptr, ptr %5, align 4, !dbg !1048
  %88 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %87, i32 0, i32 1, !dbg !1048
  %89 = getelementptr inbounds %struct.xLIST_ITEM, ptr %88, i32 0, i32 4, !dbg !1048
  store ptr null, ptr %89, align 4, !dbg !1048
  %90 = load ptr, ptr %7, align 4, !dbg !1048
  %91 = getelementptr inbounds %struct.xLIST, ptr %90, i32 0, i32 0, !dbg !1048
  %92 = load volatile i32, ptr %91, align 4, !dbg !1048
  %93 = add i32 %92, -1, !dbg !1048
  store volatile i32 %93, ptr %91, align 4, !dbg !1048
  %94 = load ptr, ptr %5, align 4, !dbg !1049
  %95 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %94, i32 0, i32 3, !dbg !1049
  %96 = load i32, ptr %95, align 4, !dbg !1049
  %97 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !1049
  %98 = icmp ugt i32 %96, %97, !dbg !1049
  br i1 %98, label %99, label %103, !dbg !1049

99:                                               ; preds = %86
  %100 = load ptr, ptr %5, align 4, !dbg !1049
  %101 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %100, i32 0, i32 3, !dbg !1049
  %102 = load i32, ptr %101, align 4, !dbg !1049
  store volatile i32 %102, ptr @uxTopReadyPriority, align 4, !dbg !1049
  br label %103, !dbg !1049

103:                                              ; preds = %99, %86
  %104 = load ptr, ptr %5, align 4, !dbg !1049
  %105 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %104, i32 0, i32 3, !dbg !1049
  %106 = load i32, ptr %105, align 4, !dbg !1049
  %107 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %106, !dbg !1049
  %108 = getelementptr inbounds %struct.xLIST, ptr %107, i32 0, i32 1, !dbg !1049
  %109 = load ptr, ptr %108, align 4, !dbg !1049
  store ptr %109, ptr %8, align 4, !dbg !1049
  %110 = load ptr, ptr %8, align 4, !dbg !1049
  %111 = load ptr, ptr %5, align 4, !dbg !1049
  %112 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %111, i32 0, i32 1, !dbg !1049
  %113 = getelementptr inbounds %struct.xLIST_ITEM, ptr %112, i32 0, i32 1, !dbg !1049
  store ptr %110, ptr %113, align 4, !dbg !1049
  %114 = load ptr, ptr %8, align 4, !dbg !1049
  %115 = getelementptr inbounds %struct.xLIST_ITEM, ptr %114, i32 0, i32 2, !dbg !1049
  %116 = load ptr, ptr %115, align 4, !dbg !1049
  %117 = load ptr, ptr %5, align 4, !dbg !1049
  %118 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %117, i32 0, i32 1, !dbg !1049
  %119 = getelementptr inbounds %struct.xLIST_ITEM, ptr %118, i32 0, i32 2, !dbg !1049
  store ptr %116, ptr %119, align 4, !dbg !1049
  %120 = load ptr, ptr %5, align 4, !dbg !1049
  %121 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %120, i32 0, i32 1, !dbg !1049
  %122 = load ptr, ptr %8, align 4, !dbg !1049
  %123 = getelementptr inbounds %struct.xLIST_ITEM, ptr %122, i32 0, i32 2, !dbg !1049
  %124 = load ptr, ptr %123, align 4, !dbg !1049
  %125 = getelementptr inbounds %struct.xLIST_ITEM, ptr %124, i32 0, i32 1, !dbg !1049
  store ptr %121, ptr %125, align 4, !dbg !1049
  %126 = load ptr, ptr %5, align 4, !dbg !1049
  %127 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %126, i32 0, i32 1, !dbg !1049
  %128 = load ptr, ptr %8, align 4, !dbg !1049
  %129 = getelementptr inbounds %struct.xLIST_ITEM, ptr %128, i32 0, i32 2, !dbg !1049
  store ptr %127, ptr %129, align 4, !dbg !1049
  %130 = load ptr, ptr %5, align 4, !dbg !1049
  %131 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %130, i32 0, i32 3, !dbg !1049
  %132 = load i32, ptr %131, align 4, !dbg !1049
  %133 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %132, !dbg !1049
  %134 = load ptr, ptr %5, align 4, !dbg !1049
  %135 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %134, i32 0, i32 1, !dbg !1049
  %136 = getelementptr inbounds %struct.xLIST_ITEM, ptr %135, i32 0, i32 4, !dbg !1049
  store ptr %133, ptr %136, align 4, !dbg !1049
  %137 = load ptr, ptr %5, align 4, !dbg !1049
  %138 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %137, i32 0, i32 3, !dbg !1049
  %139 = load i32, ptr %138, align 4, !dbg !1049
  %140 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %139, !dbg !1049
  %141 = getelementptr inbounds %struct.xLIST, ptr %140, i32 0, i32 0, !dbg !1049
  %142 = load volatile i32, ptr %141, align 4, !dbg !1049
  %143 = add i32 %142, 1, !dbg !1049
  store volatile i32 %143, ptr %141, align 4, !dbg !1049
  %144 = load ptr, ptr %5, align 4, !dbg !1050
  %145 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %144, i32 0, i32 3, !dbg !1051
  %146 = load i32, ptr %145, align 4, !dbg !1051
  %147 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1052
  %148 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %147, i32 0, i32 3, !dbg !1053
  %149 = load i32, ptr %148, align 4, !dbg !1053
  %150 = icmp ugt i32 %146, %149, !dbg !1054
  br i1 %150, label %151, label %152, !dbg !1050

151:                                              ; preds = %103
  store volatile i32 1, ptr @xYieldPending, align 4, !dbg !1055
  br label %152, !dbg !1056

152:                                              ; preds = %151, %103
  ret void, !dbg !1057
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskSetTimeOutState(ptr noundef %0) #0 !dbg !1058 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  call void @vPortEnterCritical(), !dbg !1059
  %3 = load volatile i32, ptr @xNumOfOverflows, align 4, !dbg !1060
  %4 = load ptr, ptr %2, align 4, !dbg !1061
  %5 = getelementptr inbounds %struct.xTIME_OUT, ptr %4, i32 0, i32 0, !dbg !1062
  store i32 %3, ptr %5, align 4, !dbg !1063
  %6 = load volatile i32, ptr @xTickCount, align 4, !dbg !1064
  %7 = load ptr, ptr %2, align 4, !dbg !1065
  %8 = getelementptr inbounds %struct.xTIME_OUT, ptr %7, i32 0, i32 1, !dbg !1066
  store i32 %6, ptr %8, align 4, !dbg !1067
  call void @vPortExitCritical(), !dbg !1068
  ret void, !dbg !1069
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskInternalSetTimeOutState(ptr noundef %0) #0 !dbg !1070 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %3 = load volatile i32, ptr @xNumOfOverflows, align 4, !dbg !1071
  %4 = load ptr, ptr %2, align 4, !dbg !1072
  %5 = getelementptr inbounds %struct.xTIME_OUT, ptr %4, i32 0, i32 0, !dbg !1073
  store i32 %3, ptr %5, align 4, !dbg !1074
  %6 = load volatile i32, ptr @xTickCount, align 4, !dbg !1075
  %7 = load ptr, ptr %2, align 4, !dbg !1076
  %8 = getelementptr inbounds %struct.xTIME_OUT, ptr %7, i32 0, i32 1, !dbg !1077
  store i32 %6, ptr %8, align 4, !dbg !1078
  ret void, !dbg !1079
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskCheckForTimeOut(ptr noundef %0, ptr noundef %1) #0 !dbg !1080 {
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store ptr %1, ptr %4, align 4
  call void @vPortEnterCritical(), !dbg !1081
  %8 = load volatile i32, ptr @xTickCount, align 4, !dbg !1082
  store i32 %8, ptr %6, align 4, !dbg !1083
  %9 = load i32, ptr %6, align 4, !dbg !1084
  %10 = load ptr, ptr %3, align 4, !dbg !1085
  %11 = getelementptr inbounds %struct.xTIME_OUT, ptr %10, i32 0, i32 1, !dbg !1086
  %12 = load i32, ptr %11, align 4, !dbg !1086
  %13 = sub i32 %9, %12, !dbg !1087
  store i32 %13, ptr %7, align 4, !dbg !1088
  %14 = load ptr, ptr %4, align 4, !dbg !1089
  %15 = load i32, ptr %14, align 4, !dbg !1090
  %16 = icmp eq i32 %15, -1, !dbg !1091
  br i1 %16, label %17, label %18, !dbg !1090

17:                                               ; preds = %2
  store i32 0, ptr %5, align 4, !dbg !1092
  br label %47, !dbg !1093

18:                                               ; preds = %2
  %19 = load volatile i32, ptr @xNumOfOverflows, align 4, !dbg !1094
  %20 = load ptr, ptr %3, align 4, !dbg !1095
  %21 = getelementptr inbounds %struct.xTIME_OUT, ptr %20, i32 0, i32 0, !dbg !1096
  %22 = load i32, ptr %21, align 4, !dbg !1096
  %23 = icmp ne i32 %19, %22, !dbg !1097
  br i1 %23, label %24, label %32, !dbg !1098

24:                                               ; preds = %18
  %25 = load i32, ptr %6, align 4, !dbg !1099
  %26 = load ptr, ptr %3, align 4, !dbg !1100
  %27 = getelementptr inbounds %struct.xTIME_OUT, ptr %26, i32 0, i32 1, !dbg !1101
  %28 = load i32, ptr %27, align 4, !dbg !1101
  %29 = icmp uge i32 %25, %28, !dbg !1102
  br i1 %29, label %30, label %32, !dbg !1103

30:                                               ; preds = %24
  store i32 1, ptr %5, align 4, !dbg !1104
  %31 = load ptr, ptr %4, align 4, !dbg !1105
  store i32 0, ptr %31, align 4, !dbg !1106
  br label %46, !dbg !1107

32:                                               ; preds = %24, %18
  %33 = load i32, ptr %7, align 4, !dbg !1108
  %34 = load ptr, ptr %4, align 4, !dbg !1109
  %35 = load i32, ptr %34, align 4, !dbg !1110
  %36 = icmp ult i32 %33, %35, !dbg !1111
  br i1 %36, label %37, label %43, !dbg !1108

37:                                               ; preds = %32
  %38 = load i32, ptr %7, align 4, !dbg !1112
  %39 = load ptr, ptr %4, align 4, !dbg !1113
  %40 = load i32, ptr %39, align 4, !dbg !1114
  %41 = sub i32 %40, %38, !dbg !1114
  store i32 %41, ptr %39, align 4, !dbg !1114
  %42 = load ptr, ptr %3, align 4, !dbg !1115
  call void @vTaskInternalSetTimeOutState(ptr noundef %42), !dbg !1116
  store i32 0, ptr %5, align 4, !dbg !1117
  br label %45, !dbg !1118

43:                                               ; preds = %32
  %44 = load ptr, ptr %4, align 4, !dbg !1119
  store i32 0, ptr %44, align 4, !dbg !1120
  store i32 1, ptr %5, align 4, !dbg !1121
  br label %45

45:                                               ; preds = %43, %37
  br label %46

46:                                               ; preds = %45, %30
  br label %47

47:                                               ; preds = %46, %17
  call void @vPortExitCritical(), !dbg !1122
  %48 = load i32, ptr %5, align 4, !dbg !1123
  ret i32 %48, !dbg !1124
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskMissedYield() #0 !dbg !1125 {
  store volatile i32 1, ptr @xYieldPending, align 4, !dbg !1126
  ret void, !dbg !1127
}

; Function Attrs: noinline nounwind
define dso_local i32 @uxTaskGetTaskNumber(ptr noundef %0) #0 !dbg !1128 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !1129
  %6 = icmp ne ptr %5, null, !dbg !1130
  br i1 %6, label %7, label %12, !dbg !1129

7:                                                ; preds = %1
  %8 = load ptr, ptr %2, align 4, !dbg !1131
  store ptr %8, ptr %4, align 4, !dbg !1132
  %9 = load ptr, ptr %4, align 4, !dbg !1133
  %10 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %9, i32 0, i32 7, !dbg !1134
  %11 = load i32, ptr %10, align 4, !dbg !1134
  store i32 %11, ptr %3, align 4, !dbg !1135
  br label %13, !dbg !1136

12:                                               ; preds = %1
  store i32 0, ptr %3, align 4, !dbg !1137
  br label %13

13:                                               ; preds = %12, %7
  %14 = load i32, ptr %3, align 4, !dbg !1138
  ret i32 %14, !dbg !1139
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskSetTaskNumber(ptr noundef %0, i32 noundef %1) #0 !dbg !1140 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %6 = load ptr, ptr %3, align 4, !dbg !1141
  %7 = icmp ne ptr %6, null, !dbg !1142
  br i1 %7, label %8, label %13, !dbg !1141

8:                                                ; preds = %2
  %9 = load ptr, ptr %3, align 4, !dbg !1143
  store ptr %9, ptr %5, align 4, !dbg !1144
  %10 = load i32, ptr %4, align 4, !dbg !1145
  %11 = load ptr, ptr %5, align 4, !dbg !1146
  %12 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %11, i32 0, i32 7, !dbg !1147
  store i32 %10, ptr %12, align 4, !dbg !1148
  br label %13, !dbg !1149

13:                                               ; preds = %8, %2
  ret void, !dbg !1150
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskGetInfo(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 !dbg !1151 {
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 4
  store ptr %0, ptr %5, align 4
  store ptr %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %10 = load ptr, ptr %5, align 4, !dbg !1152
  %11 = icmp eq ptr %10, null, !dbg !1152
  br i1 %11, label %12, label %14, !dbg !1152

12:                                               ; preds = %4
  %13 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1152
  br label %16, !dbg !1152

14:                                               ; preds = %4
  %15 = load ptr, ptr %5, align 4, !dbg !1152
  br label %16, !dbg !1152

16:                                               ; preds = %14, %12
  %17 = phi ptr [ %13, %12 ], [ %15, %14 ], !dbg !1152
  store ptr %17, ptr %9, align 4, !dbg !1153
  %18 = load ptr, ptr %9, align 4, !dbg !1154
  %19 = load ptr, ptr %6, align 4, !dbg !1155
  %20 = getelementptr inbounds %struct.xTASK_STATUS, ptr %19, i32 0, i32 0, !dbg !1156
  store ptr %18, ptr %20, align 4, !dbg !1157
  %21 = load ptr, ptr %9, align 4, !dbg !1158
  %22 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %21, i32 0, i32 5, !dbg !1159
  %23 = getelementptr inbounds [16 x i8], ptr %22, i32 0, i32 0, !dbg !1158
  %24 = load ptr, ptr %6, align 4, !dbg !1160
  %25 = getelementptr inbounds %struct.xTASK_STATUS, ptr %24, i32 0, i32 1, !dbg !1161
  store ptr %23, ptr %25, align 4, !dbg !1162
  %26 = load ptr, ptr %9, align 4, !dbg !1163
  %27 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %26, i32 0, i32 3, !dbg !1164
  %28 = load i32, ptr %27, align 4, !dbg !1164
  %29 = load ptr, ptr %6, align 4, !dbg !1165
  %30 = getelementptr inbounds %struct.xTASK_STATUS, ptr %29, i32 0, i32 4, !dbg !1166
  store i32 %28, ptr %30, align 4, !dbg !1167
  %31 = load ptr, ptr %9, align 4, !dbg !1168
  %32 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %31, i32 0, i32 4, !dbg !1169
  %33 = load ptr, ptr %32, align 4, !dbg !1169
  %34 = load ptr, ptr %6, align 4, !dbg !1170
  %35 = getelementptr inbounds %struct.xTASK_STATUS, ptr %34, i32 0, i32 7, !dbg !1171
  store ptr %33, ptr %35, align 4, !dbg !1172
  %36 = load ptr, ptr %9, align 4, !dbg !1173
  %37 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %36, i32 0, i32 6, !dbg !1174
  %38 = load i32, ptr %37, align 4, !dbg !1174
  %39 = load ptr, ptr %6, align 4, !dbg !1175
  %40 = getelementptr inbounds %struct.xTASK_STATUS, ptr %39, i32 0, i32 2, !dbg !1176
  store i32 %38, ptr %40, align 4, !dbg !1177
  %41 = load ptr, ptr %9, align 4, !dbg !1178
  %42 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %41, i32 0, i32 8, !dbg !1179
  %43 = load i32, ptr %42, align 4, !dbg !1179
  %44 = load ptr, ptr %6, align 4, !dbg !1180
  %45 = getelementptr inbounds %struct.xTASK_STATUS, ptr %44, i32 0, i32 5, !dbg !1181
  store i32 %43, ptr %45, align 4, !dbg !1182
  %46 = load ptr, ptr %6, align 4, !dbg !1183
  %47 = getelementptr inbounds %struct.xTASK_STATUS, ptr %46, i32 0, i32 6, !dbg !1184
  store i32 0, ptr %47, align 4, !dbg !1185
  %48 = load i32, ptr %8, align 4, !dbg !1186
  %49 = icmp ne i32 %48, 5, !dbg !1187
  br i1 %49, label %50, label %76, !dbg !1186

50:                                               ; preds = %16
  %51 = load ptr, ptr %9, align 4, !dbg !1188
  %52 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1189
  %53 = icmp eq ptr %51, %52, !dbg !1190
  br i1 %53, label %54, label %57, !dbg !1188

54:                                               ; preds = %50
  %55 = load ptr, ptr %6, align 4, !dbg !1191
  %56 = getelementptr inbounds %struct.xTASK_STATUS, ptr %55, i32 0, i32 3, !dbg !1192
  store i32 0, ptr %56, align 4, !dbg !1193
  br label %75, !dbg !1194

57:                                               ; preds = %50
  %58 = load i32, ptr %8, align 4, !dbg !1195
  %59 = load ptr, ptr %6, align 4, !dbg !1196
  %60 = getelementptr inbounds %struct.xTASK_STATUS, ptr %59, i32 0, i32 3, !dbg !1197
  store i32 %58, ptr %60, align 4, !dbg !1198
  %61 = load i32, ptr %8, align 4, !dbg !1199
  %62 = icmp eq i32 %61, 3, !dbg !1200
  br i1 %62, label %63, label %74, !dbg !1199

63:                                               ; preds = %57
  call void @vTaskSuspendAll(), !dbg !1201
  %64 = load ptr, ptr %9, align 4, !dbg !1202
  %65 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %64, i32 0, i32 2, !dbg !1202
  %66 = getelementptr inbounds %struct.xLIST_ITEM, ptr %65, i32 0, i32 4, !dbg !1202
  %67 = load ptr, ptr %66, align 4, !dbg !1202
  %68 = icmp ne ptr %67, null, !dbg !1203
  br i1 %68, label %69, label %72, !dbg !1202

69:                                               ; preds = %63
  %70 = load ptr, ptr %6, align 4, !dbg !1204
  %71 = getelementptr inbounds %struct.xTASK_STATUS, ptr %70, i32 0, i32 3, !dbg !1205
  store i32 2, ptr %71, align 4, !dbg !1206
  br label %72, !dbg !1207

72:                                               ; preds = %69, %63
  %73 = call i32 @xTaskResumeAll(), !dbg !1208
  br label %74, !dbg !1209

74:                                               ; preds = %72, %57
  br label %75

75:                                               ; preds = %74, %54
  br label %81, !dbg !1210

76:                                               ; preds = %16
  %77 = load ptr, ptr %9, align 4, !dbg !1211
  %78 = call i32 @eTaskGetState(ptr noundef %77), !dbg !1212
  %79 = load ptr, ptr %6, align 4, !dbg !1213
  %80 = getelementptr inbounds %struct.xTASK_STATUS, ptr %79, i32 0, i32 3, !dbg !1214
  store i32 %78, ptr %80, align 4, !dbg !1215
  br label %81

81:                                               ; preds = %76, %75
  %82 = load i32, ptr %7, align 4, !dbg !1216
  %83 = icmp ne i32 %82, 0, !dbg !1217
  br i1 %83, label %84, label %91, !dbg !1216

84:                                               ; preds = %81
  %85 = load ptr, ptr %9, align 4, !dbg !1218
  %86 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %85, i32 0, i32 4, !dbg !1219
  %87 = load ptr, ptr %86, align 4, !dbg !1219
  %88 = call zeroext i16 @prvTaskCheckFreeStackSpace(ptr noundef %87), !dbg !1220
  %89 = load ptr, ptr %6, align 4, !dbg !1221
  %90 = getelementptr inbounds %struct.xTASK_STATUS, ptr %89, i32 0, i32 8, !dbg !1222
  store i16 %88, ptr %90, align 4, !dbg !1223
  br label %94, !dbg !1224

91:                                               ; preds = %81
  %92 = load ptr, ptr %6, align 4, !dbg !1225
  %93 = getelementptr inbounds %struct.xTASK_STATUS, ptr %92, i32 0, i32 8, !dbg !1226
  store i16 0, ptr %93, align 4, !dbg !1227
  br label %94

94:                                               ; preds = %91, %84
  ret void, !dbg !1228
}

; Function Attrs: noinline nounwind
define internal zeroext i16 @prvTaskCheckFreeStackSpace(ptr noundef %0) #0 !dbg !1229 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  store i32 0, ptr %3, align 4, !dbg !1230
  br label %4, !dbg !1231

4:                                                ; preds = %9, %1
  %5 = load ptr, ptr %2, align 4, !dbg !1232
  %6 = load i8, ptr %5, align 1, !dbg !1233
  %7 = zext i8 %6 to i32, !dbg !1233
  %8 = icmp eq i32 %7, 165, !dbg !1234
  br i1 %8, label %9, label %14, !dbg !1231

9:                                                ; preds = %4
  %10 = load ptr, ptr %2, align 4, !dbg !1235
  %11 = getelementptr inbounds i8, ptr %10, i32 1, !dbg !1235
  store ptr %11, ptr %2, align 4, !dbg !1235
  %12 = load i32, ptr %3, align 4, !dbg !1236
  %13 = add i32 %12, 1, !dbg !1236
  store i32 %13, ptr %3, align 4, !dbg !1236
  br label %4, !dbg !1231, !llvm.loop !1237

14:                                               ; preds = %4
  %15 = load i32, ptr %3, align 4, !dbg !1239
  %16 = udiv i32 %15, 4, !dbg !1239
  store i32 %16, ptr %3, align 4, !dbg !1239
  %17 = load i32, ptr %3, align 4, !dbg !1240
  %18 = trunc i32 %17 to i16, !dbg !1241
  ret i16 %18, !dbg !1242
}

; Function Attrs: noinline nounwind
define dso_local i32 @uxTaskGetStackHighWaterMark(ptr noundef %0) #0 !dbg !1243 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  %6 = load ptr, ptr %2, align 4, !dbg !1244
  %7 = icmp eq ptr %6, null, !dbg !1244
  br i1 %7, label %8, label %10, !dbg !1244

8:                                                ; preds = %1
  %9 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1244
  br label %12, !dbg !1244

10:                                               ; preds = %1
  %11 = load ptr, ptr %2, align 4, !dbg !1244
  br label %12, !dbg !1244

12:                                               ; preds = %10, %8
  %13 = phi ptr [ %9, %8 ], [ %11, %10 ], !dbg !1244
  store ptr %13, ptr %3, align 4, !dbg !1245
  %14 = load ptr, ptr %3, align 4, !dbg !1246
  %15 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %14, i32 0, i32 4, !dbg !1247
  %16 = load ptr, ptr %15, align 4, !dbg !1247
  store ptr %16, ptr %4, align 4, !dbg !1248
  %17 = load ptr, ptr %4, align 4, !dbg !1249
  %18 = call zeroext i16 @prvTaskCheckFreeStackSpace(ptr noundef %17), !dbg !1250
  %19 = zext i16 %18 to i32, !dbg !1251
  store i32 %19, ptr %5, align 4, !dbg !1252
  %20 = load i32, ptr %5, align 4, !dbg !1253
  ret i32 %20, !dbg !1254
}

; Function Attrs: noinline nounwind
define dso_local ptr @xTaskGetCurrentTaskHandle() #0 !dbg !1255 {
  %1 = alloca ptr, align 4
  %2 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1256
  store ptr %2, ptr %1, align 4, !dbg !1257
  %3 = load ptr, ptr %1, align 4, !dbg !1258
  ret ptr %3, !dbg !1259
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskGetSchedulerState() #0 !dbg !1260 {
  %1 = alloca i32, align 4
  %2 = load volatile i32, ptr @xSchedulerRunning, align 4, !dbg !1261
  %3 = icmp eq i32 %2, 0, !dbg !1262
  br i1 %3, label %4, label %5, !dbg !1261

4:                                                ; preds = %0
  store i32 1, ptr %1, align 4, !dbg !1263
  br label %11, !dbg !1264

5:                                                ; preds = %0
  %6 = load volatile i32, ptr @uxSchedulerSuspended, align 4, !dbg !1265
  %7 = icmp eq i32 %6, 0, !dbg !1266
  br i1 %7, label %8, label %9, !dbg !1265

8:                                                ; preds = %5
  store i32 2, ptr %1, align 4, !dbg !1267
  br label %10, !dbg !1268

9:                                                ; preds = %5
  store i32 0, ptr %1, align 4, !dbg !1269
  br label %10

10:                                               ; preds = %9, %8
  br label %11

11:                                               ; preds = %10, %4
  %12 = load i32, ptr %1, align 4, !dbg !1270
  ret i32 %12, !dbg !1271
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskPriorityInherit(ptr noundef %0) #0 !dbg !1272 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %6 = load ptr, ptr %2, align 4, !dbg !1273
  store ptr %6, ptr %3, align 4, !dbg !1274
  store i32 0, ptr %4, align 4, !dbg !1275
  %7 = load ptr, ptr %2, align 4, !dbg !1276
  %8 = icmp ne ptr %7, null, !dbg !1277
  br i1 %8, label %9, label %128, !dbg !1276

9:                                                ; preds = %1
  %10 = load ptr, ptr %3, align 4, !dbg !1278
  %11 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %10, i32 0, i32 3, !dbg !1279
  %12 = load i32, ptr %11, align 4, !dbg !1279
  %13 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1280
  %14 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %13, i32 0, i32 3, !dbg !1281
  %15 = load i32, ptr %14, align 4, !dbg !1281
  %16 = icmp ult i32 %12, %15, !dbg !1282
  br i1 %16, label %17, label %116, !dbg !1278

17:                                               ; preds = %9
  %18 = load ptr, ptr %3, align 4, !dbg !1283
  %19 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %18, i32 0, i32 2, !dbg !1283
  %20 = getelementptr inbounds %struct.xLIST_ITEM, ptr %19, i32 0, i32 0, !dbg !1283
  %21 = load i32, ptr %20, align 4, !dbg !1283
  %22 = and i32 %21, -2147483648, !dbg !1284
  %23 = icmp eq i32 %22, 0, !dbg !1285
  br i1 %23, label %24, label %32, !dbg !1286

24:                                               ; preds = %17
  %25 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1287
  %26 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %25, i32 0, i32 3, !dbg !1287
  %27 = load i32, ptr %26, align 4, !dbg !1287
  %28 = sub i32 56, %27, !dbg !1287
  %29 = load ptr, ptr %3, align 4, !dbg !1287
  %30 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %29, i32 0, i32 2, !dbg !1287
  %31 = getelementptr inbounds %struct.xLIST_ITEM, ptr %30, i32 0, i32 0, !dbg !1287
  store i32 %28, ptr %31, align 4, !dbg !1287
  br label %33, !dbg !1288

32:                                               ; preds = %17
  br label %33

33:                                               ; preds = %32, %24
  %34 = load ptr, ptr %3, align 4, !dbg !1289
  %35 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %34, i32 0, i32 1, !dbg !1289
  %36 = getelementptr inbounds %struct.xLIST_ITEM, ptr %35, i32 0, i32 4, !dbg !1289
  %37 = load ptr, ptr %36, align 4, !dbg !1289
  %38 = load ptr, ptr %3, align 4, !dbg !1289
  %39 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %38, i32 0, i32 3, !dbg !1289
  %40 = load i32, ptr %39, align 4, !dbg !1289
  %41 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %40, !dbg !1289
  %42 = icmp eq ptr %37, %41, !dbg !1289
  %43 = zext i1 %42 to i64, !dbg !1289
  %44 = select i1 %42, i32 1, i32 0, !dbg !1289
  %45 = icmp ne i32 %44, 0, !dbg !1290
  br i1 %45, label %46, label %109, !dbg !1289

46:                                               ; preds = %33
  %47 = load ptr, ptr %3, align 4, !dbg !1291
  %48 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %47, i32 0, i32 1, !dbg !1292
  %49 = call i32 @uxListRemove(ptr noundef %48), !dbg !1293
  %50 = icmp eq i32 %49, 0, !dbg !1294
  br i1 %50, label %51, label %52, !dbg !1293

51:                                               ; preds = %46
  br label %53, !dbg !1295

52:                                               ; preds = %46
  br label %53

53:                                               ; preds = %52, %51
  %54 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1296
  %55 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %54, i32 0, i32 3, !dbg !1297
  %56 = load i32, ptr %55, align 4, !dbg !1297
  %57 = load ptr, ptr %3, align 4, !dbg !1298
  %58 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %57, i32 0, i32 3, !dbg !1299
  store i32 %56, ptr %58, align 4, !dbg !1300
  %59 = load ptr, ptr %3, align 4, !dbg !1301
  %60 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %59, i32 0, i32 3, !dbg !1301
  %61 = load i32, ptr %60, align 4, !dbg !1301
  %62 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !1301
  %63 = icmp ugt i32 %61, %62, !dbg !1301
  br i1 %63, label %64, label %68, !dbg !1301

64:                                               ; preds = %53
  %65 = load ptr, ptr %3, align 4, !dbg !1301
  %66 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %65, i32 0, i32 3, !dbg !1301
  %67 = load i32, ptr %66, align 4, !dbg !1301
  store volatile i32 %67, ptr @uxTopReadyPriority, align 4, !dbg !1301
  br label %68, !dbg !1301

68:                                               ; preds = %64, %53
  %69 = load ptr, ptr %3, align 4, !dbg !1301
  %70 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %69, i32 0, i32 3, !dbg !1301
  %71 = load i32, ptr %70, align 4, !dbg !1301
  %72 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %71, !dbg !1301
  %73 = getelementptr inbounds %struct.xLIST, ptr %72, i32 0, i32 1, !dbg !1301
  %74 = load ptr, ptr %73, align 4, !dbg !1301
  store ptr %74, ptr %5, align 4, !dbg !1301
  %75 = load ptr, ptr %5, align 4, !dbg !1301
  %76 = load ptr, ptr %3, align 4, !dbg !1301
  %77 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %76, i32 0, i32 1, !dbg !1301
  %78 = getelementptr inbounds %struct.xLIST_ITEM, ptr %77, i32 0, i32 1, !dbg !1301
  store ptr %75, ptr %78, align 4, !dbg !1301
  %79 = load ptr, ptr %5, align 4, !dbg !1301
  %80 = getelementptr inbounds %struct.xLIST_ITEM, ptr %79, i32 0, i32 2, !dbg !1301
  %81 = load ptr, ptr %80, align 4, !dbg !1301
  %82 = load ptr, ptr %3, align 4, !dbg !1301
  %83 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %82, i32 0, i32 1, !dbg !1301
  %84 = getelementptr inbounds %struct.xLIST_ITEM, ptr %83, i32 0, i32 2, !dbg !1301
  store ptr %81, ptr %84, align 4, !dbg !1301
  %85 = load ptr, ptr %3, align 4, !dbg !1301
  %86 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %85, i32 0, i32 1, !dbg !1301
  %87 = load ptr, ptr %5, align 4, !dbg !1301
  %88 = getelementptr inbounds %struct.xLIST_ITEM, ptr %87, i32 0, i32 2, !dbg !1301
  %89 = load ptr, ptr %88, align 4, !dbg !1301
  %90 = getelementptr inbounds %struct.xLIST_ITEM, ptr %89, i32 0, i32 1, !dbg !1301
  store ptr %86, ptr %90, align 4, !dbg !1301
  %91 = load ptr, ptr %3, align 4, !dbg !1301
  %92 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %91, i32 0, i32 1, !dbg !1301
  %93 = load ptr, ptr %5, align 4, !dbg !1301
  %94 = getelementptr inbounds %struct.xLIST_ITEM, ptr %93, i32 0, i32 2, !dbg !1301
  store ptr %92, ptr %94, align 4, !dbg !1301
  %95 = load ptr, ptr %3, align 4, !dbg !1301
  %96 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %95, i32 0, i32 3, !dbg !1301
  %97 = load i32, ptr %96, align 4, !dbg !1301
  %98 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %97, !dbg !1301
  %99 = load ptr, ptr %3, align 4, !dbg !1301
  %100 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %99, i32 0, i32 1, !dbg !1301
  %101 = getelementptr inbounds %struct.xLIST_ITEM, ptr %100, i32 0, i32 4, !dbg !1301
  store ptr %98, ptr %101, align 4, !dbg !1301
  %102 = load ptr, ptr %3, align 4, !dbg !1301
  %103 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %102, i32 0, i32 3, !dbg !1301
  %104 = load i32, ptr %103, align 4, !dbg !1301
  %105 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %104, !dbg !1301
  %106 = getelementptr inbounds %struct.xLIST, ptr %105, i32 0, i32 0, !dbg !1301
  %107 = load volatile i32, ptr %106, align 4, !dbg !1301
  %108 = add i32 %107, 1, !dbg !1301
  store volatile i32 %108, ptr %106, align 4, !dbg !1301
  br label %115, !dbg !1302

109:                                              ; preds = %33
  %110 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1303
  %111 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %110, i32 0, i32 3, !dbg !1304
  %112 = load i32, ptr %111, align 4, !dbg !1304
  %113 = load ptr, ptr %3, align 4, !dbg !1305
  %114 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %113, i32 0, i32 3, !dbg !1306
  store i32 %112, ptr %114, align 4, !dbg !1307
  br label %115

115:                                              ; preds = %109, %68
  store i32 1, ptr %4, align 4, !dbg !1308
  br label %127, !dbg !1309

116:                                              ; preds = %9
  %117 = load ptr, ptr %3, align 4, !dbg !1310
  %118 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %117, i32 0, i32 8, !dbg !1311
  %119 = load i32, ptr %118, align 4, !dbg !1311
  %120 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1312
  %121 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %120, i32 0, i32 3, !dbg !1313
  %122 = load i32, ptr %121, align 4, !dbg !1313
  %123 = icmp ult i32 %119, %122, !dbg !1314
  br i1 %123, label %124, label %125, !dbg !1310

124:                                              ; preds = %116
  store i32 1, ptr %4, align 4, !dbg !1315
  br label %126, !dbg !1316

125:                                              ; preds = %116
  br label %126

126:                                              ; preds = %125, %124
  br label %127

127:                                              ; preds = %126, %115
  br label %129, !dbg !1317

128:                                              ; preds = %1
  br label %129

129:                                              ; preds = %128, %127
  %130 = load i32, ptr %4, align 4, !dbg !1318
  ret i32 %130, !dbg !1319
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskPriorityDisinherit(ptr noundef %0) #0 !dbg !1320 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %6 = load ptr, ptr %2, align 4, !dbg !1321
  store ptr %6, ptr %3, align 4, !dbg !1322
  store i32 0, ptr %4, align 4, !dbg !1323
  %7 = load ptr, ptr %2, align 4, !dbg !1324
  %8 = icmp ne ptr %7, null, !dbg !1325
  br i1 %8, label %9, label %100, !dbg !1324

9:                                                ; preds = %1
  %10 = load ptr, ptr %3, align 4, !dbg !1326
  %11 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %10, i32 0, i32 9, !dbg !1327
  %12 = load i32, ptr %11, align 4, !dbg !1328
  %13 = add i32 %12, -1, !dbg !1328
  store i32 %13, ptr %11, align 4, !dbg !1328
  %14 = load ptr, ptr %3, align 4, !dbg !1329
  %15 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %14, i32 0, i32 3, !dbg !1330
  %16 = load i32, ptr %15, align 4, !dbg !1330
  %17 = load ptr, ptr %3, align 4, !dbg !1331
  %18 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %17, i32 0, i32 8, !dbg !1332
  %19 = load i32, ptr %18, align 4, !dbg !1332
  %20 = icmp ne i32 %16, %19, !dbg !1333
  br i1 %20, label %21, label %98, !dbg !1329

21:                                               ; preds = %9
  %22 = load ptr, ptr %3, align 4, !dbg !1334
  %23 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %22, i32 0, i32 9, !dbg !1335
  %24 = load i32, ptr %23, align 4, !dbg !1335
  %25 = icmp eq i32 %24, 0, !dbg !1336
  br i1 %25, label %26, label %96, !dbg !1334

26:                                               ; preds = %21
  %27 = load ptr, ptr %3, align 4, !dbg !1337
  %28 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %27, i32 0, i32 1, !dbg !1338
  %29 = call i32 @uxListRemove(ptr noundef %28), !dbg !1339
  %30 = icmp eq i32 %29, 0, !dbg !1340
  br i1 %30, label %31, label %32, !dbg !1339

31:                                               ; preds = %26
  br label %33, !dbg !1341

32:                                               ; preds = %26
  br label %33

33:                                               ; preds = %32, %31
  %34 = load ptr, ptr %3, align 4, !dbg !1342
  %35 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %34, i32 0, i32 8, !dbg !1343
  %36 = load i32, ptr %35, align 4, !dbg !1343
  %37 = load ptr, ptr %3, align 4, !dbg !1344
  %38 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %37, i32 0, i32 3, !dbg !1345
  store i32 %36, ptr %38, align 4, !dbg !1346
  %39 = load ptr, ptr %3, align 4, !dbg !1347
  %40 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %39, i32 0, i32 3, !dbg !1347
  %41 = load i32, ptr %40, align 4, !dbg !1347
  %42 = sub i32 56, %41, !dbg !1347
  %43 = load ptr, ptr %3, align 4, !dbg !1347
  %44 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %43, i32 0, i32 2, !dbg !1347
  %45 = getelementptr inbounds %struct.xLIST_ITEM, ptr %44, i32 0, i32 0, !dbg !1347
  store i32 %42, ptr %45, align 4, !dbg !1347
  %46 = load ptr, ptr %3, align 4, !dbg !1348
  %47 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %46, i32 0, i32 3, !dbg !1348
  %48 = load i32, ptr %47, align 4, !dbg !1348
  %49 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !1348
  %50 = icmp ugt i32 %48, %49, !dbg !1348
  br i1 %50, label %51, label %55, !dbg !1348

51:                                               ; preds = %33
  %52 = load ptr, ptr %3, align 4, !dbg !1348
  %53 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %52, i32 0, i32 3, !dbg !1348
  %54 = load i32, ptr %53, align 4, !dbg !1348
  store volatile i32 %54, ptr @uxTopReadyPriority, align 4, !dbg !1348
  br label %55, !dbg !1348

55:                                               ; preds = %51, %33
  %56 = load ptr, ptr %3, align 4, !dbg !1348
  %57 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %56, i32 0, i32 3, !dbg !1348
  %58 = load i32, ptr %57, align 4, !dbg !1348
  %59 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %58, !dbg !1348
  %60 = getelementptr inbounds %struct.xLIST, ptr %59, i32 0, i32 1, !dbg !1348
  %61 = load ptr, ptr %60, align 4, !dbg !1348
  store ptr %61, ptr %5, align 4, !dbg !1348
  %62 = load ptr, ptr %5, align 4, !dbg !1348
  %63 = load ptr, ptr %3, align 4, !dbg !1348
  %64 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %63, i32 0, i32 1, !dbg !1348
  %65 = getelementptr inbounds %struct.xLIST_ITEM, ptr %64, i32 0, i32 1, !dbg !1348
  store ptr %62, ptr %65, align 4, !dbg !1348
  %66 = load ptr, ptr %5, align 4, !dbg !1348
  %67 = getelementptr inbounds %struct.xLIST_ITEM, ptr %66, i32 0, i32 2, !dbg !1348
  %68 = load ptr, ptr %67, align 4, !dbg !1348
  %69 = load ptr, ptr %3, align 4, !dbg !1348
  %70 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %69, i32 0, i32 1, !dbg !1348
  %71 = getelementptr inbounds %struct.xLIST_ITEM, ptr %70, i32 0, i32 2, !dbg !1348
  store ptr %68, ptr %71, align 4, !dbg !1348
  %72 = load ptr, ptr %3, align 4, !dbg !1348
  %73 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %72, i32 0, i32 1, !dbg !1348
  %74 = load ptr, ptr %5, align 4, !dbg !1348
  %75 = getelementptr inbounds %struct.xLIST_ITEM, ptr %74, i32 0, i32 2, !dbg !1348
  %76 = load ptr, ptr %75, align 4, !dbg !1348
  %77 = getelementptr inbounds %struct.xLIST_ITEM, ptr %76, i32 0, i32 1, !dbg !1348
  store ptr %73, ptr %77, align 4, !dbg !1348
  %78 = load ptr, ptr %3, align 4, !dbg !1348
  %79 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %78, i32 0, i32 1, !dbg !1348
  %80 = load ptr, ptr %5, align 4, !dbg !1348
  %81 = getelementptr inbounds %struct.xLIST_ITEM, ptr %80, i32 0, i32 2, !dbg !1348
  store ptr %79, ptr %81, align 4, !dbg !1348
  %82 = load ptr, ptr %3, align 4, !dbg !1348
  %83 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %82, i32 0, i32 3, !dbg !1348
  %84 = load i32, ptr %83, align 4, !dbg !1348
  %85 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %84, !dbg !1348
  %86 = load ptr, ptr %3, align 4, !dbg !1348
  %87 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %86, i32 0, i32 1, !dbg !1348
  %88 = getelementptr inbounds %struct.xLIST_ITEM, ptr %87, i32 0, i32 4, !dbg !1348
  store ptr %85, ptr %88, align 4, !dbg !1348
  %89 = load ptr, ptr %3, align 4, !dbg !1348
  %90 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %89, i32 0, i32 3, !dbg !1348
  %91 = load i32, ptr %90, align 4, !dbg !1348
  %92 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %91, !dbg !1348
  %93 = getelementptr inbounds %struct.xLIST, ptr %92, i32 0, i32 0, !dbg !1348
  %94 = load volatile i32, ptr %93, align 4, !dbg !1348
  %95 = add i32 %94, 1, !dbg !1348
  store volatile i32 %95, ptr %93, align 4, !dbg !1348
  store i32 1, ptr %4, align 4, !dbg !1349
  br label %97, !dbg !1350

96:                                               ; preds = %21
  br label %97

97:                                               ; preds = %96, %55
  br label %99, !dbg !1351

98:                                               ; preds = %9
  br label %99

99:                                               ; preds = %98, %97
  br label %101, !dbg !1352

100:                                              ; preds = %1
  br label %101

101:                                              ; preds = %100, %99
  %102 = load i32, ptr %4, align 4, !dbg !1353
  ret i32 %102, !dbg !1354
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskPriorityDisinheritAfterTimeout(ptr noundef %0, i32 noundef %1) #0 !dbg !1355 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %10 = load ptr, ptr %3, align 4, !dbg !1356
  store ptr %10, ptr %5, align 4, !dbg !1357
  store i32 1, ptr %8, align 4, !dbg !1358
  %11 = load ptr, ptr %3, align 4, !dbg !1359
  %12 = icmp ne ptr %11, null, !dbg !1360
  br i1 %12, label %13, label %131, !dbg !1359

13:                                               ; preds = %2
  %14 = load ptr, ptr %5, align 4, !dbg !1361
  %15 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %14, i32 0, i32 8, !dbg !1362
  %16 = load i32, ptr %15, align 4, !dbg !1362
  %17 = load i32, ptr %4, align 4, !dbg !1363
  %18 = icmp ult i32 %16, %17, !dbg !1364
  br i1 %18, label %19, label %21, !dbg !1361

19:                                               ; preds = %13
  %20 = load i32, ptr %4, align 4, !dbg !1365
  store i32 %20, ptr %7, align 4, !dbg !1366
  br label %25, !dbg !1367

21:                                               ; preds = %13
  %22 = load ptr, ptr %5, align 4, !dbg !1368
  %23 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %22, i32 0, i32 8, !dbg !1369
  %24 = load i32, ptr %23, align 4, !dbg !1369
  store i32 %24, ptr %7, align 4, !dbg !1370
  br label %25

25:                                               ; preds = %21, %19
  %26 = load ptr, ptr %5, align 4, !dbg !1371
  %27 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %26, i32 0, i32 3, !dbg !1372
  %28 = load i32, ptr %27, align 4, !dbg !1372
  %29 = load i32, ptr %7, align 4, !dbg !1373
  %30 = icmp ne i32 %28, %29, !dbg !1374
  br i1 %30, label %31, label %129, !dbg !1371

31:                                               ; preds = %25
  %32 = load ptr, ptr %5, align 4, !dbg !1375
  %33 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %32, i32 0, i32 9, !dbg !1376
  %34 = load i32, ptr %33, align 4, !dbg !1376
  %35 = icmp eq i32 %34, 1, !dbg !1377
  br i1 %35, label %36, label %127, !dbg !1375

36:                                               ; preds = %31
  %37 = load ptr, ptr %5, align 4, !dbg !1378
  %38 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %37, i32 0, i32 3, !dbg !1379
  %39 = load i32, ptr %38, align 4, !dbg !1379
  store i32 %39, ptr %6, align 4, !dbg !1380
  %40 = load i32, ptr %7, align 4, !dbg !1381
  %41 = load ptr, ptr %5, align 4, !dbg !1382
  %42 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %41, i32 0, i32 3, !dbg !1383
  store i32 %40, ptr %42, align 4, !dbg !1384
  %43 = load ptr, ptr %5, align 4, !dbg !1385
  %44 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %43, i32 0, i32 2, !dbg !1385
  %45 = getelementptr inbounds %struct.xLIST_ITEM, ptr %44, i32 0, i32 0, !dbg !1385
  %46 = load i32, ptr %45, align 4, !dbg !1385
  %47 = and i32 %46, -2147483648, !dbg !1386
  %48 = icmp eq i32 %47, 0, !dbg !1387
  br i1 %48, label %49, label %55, !dbg !1388

49:                                               ; preds = %36
  %50 = load i32, ptr %7, align 4, !dbg !1389
  %51 = sub i32 56, %50, !dbg !1389
  %52 = load ptr, ptr %5, align 4, !dbg !1389
  %53 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %52, i32 0, i32 2, !dbg !1389
  %54 = getelementptr inbounds %struct.xLIST_ITEM, ptr %53, i32 0, i32 0, !dbg !1389
  store i32 %51, ptr %54, align 4, !dbg !1389
  br label %56, !dbg !1390

55:                                               ; preds = %36
  br label %56

56:                                               ; preds = %55, %49
  %57 = load ptr, ptr %5, align 4, !dbg !1391
  %58 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %57, i32 0, i32 1, !dbg !1391
  %59 = getelementptr inbounds %struct.xLIST_ITEM, ptr %58, i32 0, i32 4, !dbg !1391
  %60 = load ptr, ptr %59, align 4, !dbg !1391
  %61 = load i32, ptr %6, align 4, !dbg !1391
  %62 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %61, !dbg !1391
  %63 = icmp eq ptr %60, %62, !dbg !1391
  %64 = zext i1 %63 to i64, !dbg !1391
  %65 = select i1 %63, i32 1, i32 0, !dbg !1391
  %66 = icmp ne i32 %65, 0, !dbg !1392
  br i1 %66, label %67, label %125, !dbg !1391

67:                                               ; preds = %56
  %68 = load ptr, ptr %5, align 4, !dbg !1393
  %69 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %68, i32 0, i32 1, !dbg !1394
  %70 = call i32 @uxListRemove(ptr noundef %69), !dbg !1395
  %71 = icmp eq i32 %70, 0, !dbg !1396
  br i1 %71, label %72, label %73, !dbg !1395

72:                                               ; preds = %67
  br label %74, !dbg !1397

73:                                               ; preds = %67
  br label %74

74:                                               ; preds = %73, %72
  %75 = load ptr, ptr %5, align 4, !dbg !1398
  %76 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %75, i32 0, i32 3, !dbg !1398
  %77 = load i32, ptr %76, align 4, !dbg !1398
  %78 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !1398
  %79 = icmp ugt i32 %77, %78, !dbg !1398
  br i1 %79, label %80, label %84, !dbg !1398

80:                                               ; preds = %74
  %81 = load ptr, ptr %5, align 4, !dbg !1398
  %82 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %81, i32 0, i32 3, !dbg !1398
  %83 = load i32, ptr %82, align 4, !dbg !1398
  store volatile i32 %83, ptr @uxTopReadyPriority, align 4, !dbg !1398
  br label %84, !dbg !1398

84:                                               ; preds = %80, %74
  %85 = load ptr, ptr %5, align 4, !dbg !1398
  %86 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %85, i32 0, i32 3, !dbg !1398
  %87 = load i32, ptr %86, align 4, !dbg !1398
  %88 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %87, !dbg !1398
  %89 = getelementptr inbounds %struct.xLIST, ptr %88, i32 0, i32 1, !dbg !1398
  %90 = load ptr, ptr %89, align 4, !dbg !1398
  store ptr %90, ptr %9, align 4, !dbg !1398
  %91 = load ptr, ptr %9, align 4, !dbg !1398
  %92 = load ptr, ptr %5, align 4, !dbg !1398
  %93 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %92, i32 0, i32 1, !dbg !1398
  %94 = getelementptr inbounds %struct.xLIST_ITEM, ptr %93, i32 0, i32 1, !dbg !1398
  store ptr %91, ptr %94, align 4, !dbg !1398
  %95 = load ptr, ptr %9, align 4, !dbg !1398
  %96 = getelementptr inbounds %struct.xLIST_ITEM, ptr %95, i32 0, i32 2, !dbg !1398
  %97 = load ptr, ptr %96, align 4, !dbg !1398
  %98 = load ptr, ptr %5, align 4, !dbg !1398
  %99 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %98, i32 0, i32 1, !dbg !1398
  %100 = getelementptr inbounds %struct.xLIST_ITEM, ptr %99, i32 0, i32 2, !dbg !1398
  store ptr %97, ptr %100, align 4, !dbg !1398
  %101 = load ptr, ptr %5, align 4, !dbg !1398
  %102 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %101, i32 0, i32 1, !dbg !1398
  %103 = load ptr, ptr %9, align 4, !dbg !1398
  %104 = getelementptr inbounds %struct.xLIST_ITEM, ptr %103, i32 0, i32 2, !dbg !1398
  %105 = load ptr, ptr %104, align 4, !dbg !1398
  %106 = getelementptr inbounds %struct.xLIST_ITEM, ptr %105, i32 0, i32 1, !dbg !1398
  store ptr %102, ptr %106, align 4, !dbg !1398
  %107 = load ptr, ptr %5, align 4, !dbg !1398
  %108 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %107, i32 0, i32 1, !dbg !1398
  %109 = load ptr, ptr %9, align 4, !dbg !1398
  %110 = getelementptr inbounds %struct.xLIST_ITEM, ptr %109, i32 0, i32 2, !dbg !1398
  store ptr %108, ptr %110, align 4, !dbg !1398
  %111 = load ptr, ptr %5, align 4, !dbg !1398
  %112 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %111, i32 0, i32 3, !dbg !1398
  %113 = load i32, ptr %112, align 4, !dbg !1398
  %114 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %113, !dbg !1398
  %115 = load ptr, ptr %5, align 4, !dbg !1398
  %116 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %115, i32 0, i32 1, !dbg !1398
  %117 = getelementptr inbounds %struct.xLIST_ITEM, ptr %116, i32 0, i32 4, !dbg !1398
  store ptr %114, ptr %117, align 4, !dbg !1398
  %118 = load ptr, ptr %5, align 4, !dbg !1398
  %119 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %118, i32 0, i32 3, !dbg !1398
  %120 = load i32, ptr %119, align 4, !dbg !1398
  %121 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %120, !dbg !1398
  %122 = getelementptr inbounds %struct.xLIST, ptr %121, i32 0, i32 0, !dbg !1398
  %123 = load volatile i32, ptr %122, align 4, !dbg !1398
  %124 = add i32 %123, 1, !dbg !1398
  store volatile i32 %124, ptr %122, align 4, !dbg !1398
  br label %126, !dbg !1399

125:                                              ; preds = %56
  br label %126

126:                                              ; preds = %125, %84
  br label %128, !dbg !1400

127:                                              ; preds = %31
  br label %128

128:                                              ; preds = %127, %126
  br label %130, !dbg !1401

129:                                              ; preds = %25
  br label %130

130:                                              ; preds = %129, %128
  br label %132, !dbg !1402

131:                                              ; preds = %2
  br label %132

132:                                              ; preds = %131, %130
  ret void, !dbg !1403
}

; Function Attrs: noinline nounwind
define dso_local i32 @uxTaskResetEventItemValue() #0 !dbg !1404 {
  %1 = alloca i32, align 4
  %2 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1405
  %3 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %2, i32 0, i32 2, !dbg !1405
  %4 = getelementptr inbounds %struct.xLIST_ITEM, ptr %3, i32 0, i32 0, !dbg !1405
  %5 = load i32, ptr %4, align 4, !dbg !1405
  store i32 %5, ptr %1, align 4, !dbg !1406
  %6 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1407
  %7 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %6, i32 0, i32 3, !dbg !1407
  %8 = load i32, ptr %7, align 4, !dbg !1407
  %9 = sub i32 56, %8, !dbg !1407
  %10 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1407
  %11 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %10, i32 0, i32 2, !dbg !1407
  %12 = getelementptr inbounds %struct.xLIST_ITEM, ptr %11, i32 0, i32 0, !dbg !1407
  store i32 %9, ptr %12, align 4, !dbg !1407
  %13 = load i32, ptr %1, align 4, !dbg !1408
  ret i32 %13, !dbg !1409
}

; Function Attrs: noinline nounwind
define dso_local ptr @pvTaskIncrementMutexHeldCount() #0 !dbg !1410 {
  %1 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1411
  %2 = icmp ne ptr %1, null, !dbg !1412
  br i1 %2, label %3, label %8, !dbg !1411

3:                                                ; preds = %0
  %4 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1413
  %5 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %4, i32 0, i32 9, !dbg !1414
  %6 = load i32, ptr %5, align 4, !dbg !1415
  %7 = add i32 %6, 1, !dbg !1415
  store i32 %7, ptr %5, align 4, !dbg !1415
  br label %8, !dbg !1416

8:                                                ; preds = %3, %0
  %9 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1417
  ret ptr %9, !dbg !1418
}

; Function Attrs: noinline nounwind
define dso_local i32 @ulTaskGenericNotifyTake(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 !dbg !1419 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  call void @vPortEnterCritical(), !dbg !1420
  %8 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1421
  %9 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %8, i32 0, i32 10, !dbg !1422
  %10 = load i32, ptr %4, align 4, !dbg !1423
  %11 = getelementptr inbounds [1 x i32], ptr %9, i32 0, i32 %10, !dbg !1421
  %12 = load volatile i32, ptr %11, align 4, !dbg !1421
  %13 = icmp eq i32 %12, 0, !dbg !1424
  br i1 %13, label %14, label %25, !dbg !1421

14:                                               ; preds = %3
  %15 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1425
  %16 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %15, i32 0, i32 11, !dbg !1426
  %17 = load i32, ptr %4, align 4, !dbg !1427
  %18 = getelementptr inbounds [1 x i8], ptr %16, i32 0, i32 %17, !dbg !1425
  store volatile i8 1, ptr %18, align 1, !dbg !1428
  %19 = load i32, ptr %6, align 4, !dbg !1429
  %20 = icmp ugt i32 %19, 0, !dbg !1430
  br i1 %20, label %21, label %23, !dbg !1429

21:                                               ; preds = %14
  %22 = load i32, ptr %6, align 4, !dbg !1431
  call void @prvAddCurrentTaskToDelayedList(i32 noundef %22, i32 noundef 1), !dbg !1432
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !1433
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !1433, !srcloc !1434
  call void asm sideeffect "isb", ""() #3, !dbg !1433, !srcloc !1435
  br label %24, !dbg !1436

23:                                               ; preds = %14
  br label %24

24:                                               ; preds = %23, %21
  br label %26, !dbg !1437

25:                                               ; preds = %3
  br label %26

26:                                               ; preds = %25, %24
  call void @vPortExitCritical(), !dbg !1438
  call void @vPortEnterCritical(), !dbg !1439
  %27 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1440
  %28 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %27, i32 0, i32 10, !dbg !1441
  %29 = load i32, ptr %4, align 4, !dbg !1442
  %30 = getelementptr inbounds [1 x i32], ptr %28, i32 0, i32 %29, !dbg !1440
  %31 = load volatile i32, ptr %30, align 4, !dbg !1440
  store i32 %31, ptr %7, align 4, !dbg !1443
  %32 = load i32, ptr %7, align 4, !dbg !1444
  %33 = icmp ne i32 %32, 0, !dbg !1445
  br i1 %33, label %34, label %50, !dbg !1444

34:                                               ; preds = %26
  %35 = load i32, ptr %5, align 4, !dbg !1446
  %36 = icmp ne i32 %35, 0, !dbg !1447
  br i1 %36, label %37, label %42, !dbg !1446

37:                                               ; preds = %34
  %38 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1448
  %39 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %38, i32 0, i32 10, !dbg !1449
  %40 = load i32, ptr %4, align 4, !dbg !1450
  %41 = getelementptr inbounds [1 x i32], ptr %39, i32 0, i32 %40, !dbg !1448
  store volatile i32 0, ptr %41, align 4, !dbg !1451
  br label %49, !dbg !1452

42:                                               ; preds = %34
  %43 = load i32, ptr %7, align 4, !dbg !1453
  %44 = sub i32 %43, 1, !dbg !1454
  %45 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1455
  %46 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %45, i32 0, i32 10, !dbg !1456
  %47 = load i32, ptr %4, align 4, !dbg !1457
  %48 = getelementptr inbounds [1 x i32], ptr %46, i32 0, i32 %47, !dbg !1455
  store volatile i32 %44, ptr %48, align 4, !dbg !1458
  br label %49

49:                                               ; preds = %42, %37
  br label %51, !dbg !1459

50:                                               ; preds = %26
  br label %51

51:                                               ; preds = %50, %49
  %52 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1460
  %53 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %52, i32 0, i32 11, !dbg !1461
  %54 = load i32, ptr %4, align 4, !dbg !1462
  %55 = getelementptr inbounds [1 x i8], ptr %53, i32 0, i32 %54, !dbg !1460
  store volatile i8 0, ptr %55, align 1, !dbg !1463
  call void @vPortExitCritical(), !dbg !1464
  %56 = load i32, ptr %7, align 4, !dbg !1465
  ret i32 %56, !dbg !1466
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskGenericNotifyWait(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3, i32 noundef %4) #0 !dbg !1467 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store ptr %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  call void @vPortEnterCritical(), !dbg !1468
  %12 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1469
  %13 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %12, i32 0, i32 11, !dbg !1470
  %14 = load i32, ptr %6, align 4, !dbg !1471
  %15 = getelementptr inbounds [1 x i8], ptr %13, i32 0, i32 %14, !dbg !1469
  %16 = load volatile i8, ptr %15, align 1, !dbg !1469
  %17 = zext i8 %16 to i32, !dbg !1469
  %18 = icmp ne i32 %17, 2, !dbg !1472
  br i1 %18, label %19, label %38, !dbg !1469

19:                                               ; preds = %5
  %20 = load i32, ptr %7, align 4, !dbg !1473
  %21 = xor i32 %20, -1, !dbg !1474
  %22 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1475
  %23 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %22, i32 0, i32 10, !dbg !1476
  %24 = load i32, ptr %6, align 4, !dbg !1477
  %25 = getelementptr inbounds [1 x i32], ptr %23, i32 0, i32 %24, !dbg !1475
  %26 = load volatile i32, ptr %25, align 4, !dbg !1478
  %27 = and i32 %26, %21, !dbg !1478
  store volatile i32 %27, ptr %25, align 4, !dbg !1478
  %28 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1479
  %29 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %28, i32 0, i32 11, !dbg !1480
  %30 = load i32, ptr %6, align 4, !dbg !1481
  %31 = getelementptr inbounds [1 x i8], ptr %29, i32 0, i32 %30, !dbg !1479
  store volatile i8 1, ptr %31, align 1, !dbg !1482
  %32 = load i32, ptr %10, align 4, !dbg !1483
  %33 = icmp ugt i32 %32, 0, !dbg !1484
  br i1 %33, label %34, label %36, !dbg !1483

34:                                               ; preds = %19
  %35 = load i32, ptr %10, align 4, !dbg !1485
  call void @prvAddCurrentTaskToDelayedList(i32 noundef %35, i32 noundef 1), !dbg !1486
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !1487
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !1487, !srcloc !1488
  call void asm sideeffect "isb", ""() #3, !dbg !1487, !srcloc !1489
  br label %37, !dbg !1490

36:                                               ; preds = %19
  br label %37

37:                                               ; preds = %36, %34
  br label %39, !dbg !1491

38:                                               ; preds = %5
  br label %39

39:                                               ; preds = %38, %37
  call void @vPortExitCritical(), !dbg !1492
  call void @vPortEnterCritical(), !dbg !1493
  %40 = load ptr, ptr %9, align 4, !dbg !1494
  %41 = icmp ne ptr %40, null, !dbg !1495
  br i1 %41, label %42, label %49, !dbg !1494

42:                                               ; preds = %39
  %43 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1496
  %44 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %43, i32 0, i32 10, !dbg !1497
  %45 = load i32, ptr %6, align 4, !dbg !1498
  %46 = getelementptr inbounds [1 x i32], ptr %44, i32 0, i32 %45, !dbg !1496
  %47 = load volatile i32, ptr %46, align 4, !dbg !1496
  %48 = load ptr, ptr %9, align 4, !dbg !1499
  store i32 %47, ptr %48, align 4, !dbg !1500
  br label %49, !dbg !1501

49:                                               ; preds = %42, %39
  %50 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1502
  %51 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %50, i32 0, i32 11, !dbg !1503
  %52 = load i32, ptr %6, align 4, !dbg !1504
  %53 = getelementptr inbounds [1 x i8], ptr %51, i32 0, i32 %52, !dbg !1502
  %54 = load volatile i8, ptr %53, align 1, !dbg !1502
  %55 = zext i8 %54 to i32, !dbg !1502
  %56 = icmp ne i32 %55, 2, !dbg !1505
  br i1 %56, label %57, label %58, !dbg !1502

57:                                               ; preds = %49
  store i32 0, ptr %11, align 4, !dbg !1506
  br label %67, !dbg !1507

58:                                               ; preds = %49
  %59 = load i32, ptr %8, align 4, !dbg !1508
  %60 = xor i32 %59, -1, !dbg !1509
  %61 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1510
  %62 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %61, i32 0, i32 10, !dbg !1511
  %63 = load i32, ptr %6, align 4, !dbg !1512
  %64 = getelementptr inbounds [1 x i32], ptr %62, i32 0, i32 %63, !dbg !1510
  %65 = load volatile i32, ptr %64, align 4, !dbg !1513
  %66 = and i32 %65, %60, !dbg !1513
  store volatile i32 %66, ptr %64, align 4, !dbg !1513
  store i32 1, ptr %11, align 4, !dbg !1514
  br label %67

67:                                               ; preds = %58, %57
  %68 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1515
  %69 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %68, i32 0, i32 11, !dbg !1516
  %70 = load i32, ptr %6, align 4, !dbg !1517
  %71 = getelementptr inbounds [1 x i8], ptr %69, i32 0, i32 %70, !dbg !1515
  store volatile i8 0, ptr %71, align 1, !dbg !1518
  call void @vPortExitCritical(), !dbg !1519
  %72 = load i32, ptr %11, align 4, !dbg !1520
  ret i32 %72, !dbg !1521
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskGenericNotify(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, ptr noundef %4) #0 !dbg !1522 {
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 4
  %11 = alloca ptr, align 4
  %12 = alloca i32, align 4
  %13 = alloca i8, align 1
  %14 = alloca ptr, align 4
  %15 = alloca ptr, align 4
  store ptr %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  store ptr %4, ptr %10, align 4
  store i32 1, ptr %12, align 4, !dbg !1523
  %16 = load ptr, ptr %6, align 4, !dbg !1524
  store ptr %16, ptr %11, align 4, !dbg !1525
  call void @vPortEnterCritical(), !dbg !1526
  %17 = load ptr, ptr %10, align 4, !dbg !1527
  %18 = icmp ne ptr %17, null, !dbg !1528
  br i1 %18, label %19, label %26, !dbg !1527

19:                                               ; preds = %5
  %20 = load ptr, ptr %11, align 4, !dbg !1529
  %21 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %20, i32 0, i32 10, !dbg !1530
  %22 = load i32, ptr %7, align 4, !dbg !1531
  %23 = getelementptr inbounds [1 x i32], ptr %21, i32 0, i32 %22, !dbg !1529
  %24 = load volatile i32, ptr %23, align 4, !dbg !1529
  %25 = load ptr, ptr %10, align 4, !dbg !1532
  store i32 %24, ptr %25, align 4, !dbg !1533
  br label %26, !dbg !1534

26:                                               ; preds = %19, %5
  %27 = load ptr, ptr %11, align 4, !dbg !1535
  %28 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %27, i32 0, i32 11, !dbg !1536
  %29 = load i32, ptr %7, align 4, !dbg !1537
  %30 = getelementptr inbounds [1 x i8], ptr %28, i32 0, i32 %29, !dbg !1535
  %31 = load volatile i8, ptr %30, align 1, !dbg !1535
  store i8 %31, ptr %13, align 1, !dbg !1538
  %32 = load ptr, ptr %11, align 4, !dbg !1539
  %33 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %32, i32 0, i32 11, !dbg !1540
  %34 = load i32, ptr %7, align 4, !dbg !1541
  %35 = getelementptr inbounds [1 x i8], ptr %33, i32 0, i32 %34, !dbg !1539
  store volatile i8 2, ptr %35, align 1, !dbg !1542
  %36 = load i32, ptr %9, align 4, !dbg !1543
  switch i32 %36, label %71 [
    i32 1, label %37
    i32 2, label %45
    i32 3, label %52
    i32 4, label %58
    i32 0, label %70
  ], !dbg !1544

37:                                               ; preds = %26
  %38 = load i32, ptr %8, align 4, !dbg !1545
  %39 = load ptr, ptr %11, align 4, !dbg !1546
  %40 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %39, i32 0, i32 10, !dbg !1547
  %41 = load i32, ptr %7, align 4, !dbg !1548
  %42 = getelementptr inbounds [1 x i32], ptr %40, i32 0, i32 %41, !dbg !1546
  %43 = load volatile i32, ptr %42, align 4, !dbg !1549
  %44 = or i32 %43, %38, !dbg !1549
  store volatile i32 %44, ptr %42, align 4, !dbg !1549
  br label %72, !dbg !1550

45:                                               ; preds = %26
  %46 = load ptr, ptr %11, align 4, !dbg !1551
  %47 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %46, i32 0, i32 10, !dbg !1552
  %48 = load i32, ptr %7, align 4, !dbg !1553
  %49 = getelementptr inbounds [1 x i32], ptr %47, i32 0, i32 %48, !dbg !1551
  %50 = load volatile i32, ptr %49, align 4, !dbg !1554
  %51 = add i32 %50, 1, !dbg !1554
  store volatile i32 %51, ptr %49, align 4, !dbg !1554
  br label %72, !dbg !1555

52:                                               ; preds = %26
  %53 = load i32, ptr %8, align 4, !dbg !1556
  %54 = load ptr, ptr %11, align 4, !dbg !1557
  %55 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %54, i32 0, i32 10, !dbg !1558
  %56 = load i32, ptr %7, align 4, !dbg !1559
  %57 = getelementptr inbounds [1 x i32], ptr %55, i32 0, i32 %56, !dbg !1557
  store volatile i32 %53, ptr %57, align 4, !dbg !1560
  br label %72, !dbg !1561

58:                                               ; preds = %26
  %59 = load i8, ptr %13, align 1, !dbg !1562
  %60 = zext i8 %59 to i32, !dbg !1562
  %61 = icmp ne i32 %60, 2, !dbg !1563
  br i1 %61, label %62, label %68, !dbg !1562

62:                                               ; preds = %58
  %63 = load i32, ptr %8, align 4, !dbg !1564
  %64 = load ptr, ptr %11, align 4, !dbg !1565
  %65 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %64, i32 0, i32 10, !dbg !1566
  %66 = load i32, ptr %7, align 4, !dbg !1567
  %67 = getelementptr inbounds [1 x i32], ptr %65, i32 0, i32 %66, !dbg !1565
  store volatile i32 %63, ptr %67, align 4, !dbg !1568
  br label %69, !dbg !1569

68:                                               ; preds = %58
  store i32 0, ptr %12, align 4, !dbg !1570
  br label %69

69:                                               ; preds = %68, %62
  br label %72, !dbg !1571

70:                                               ; preds = %26
  br label %72, !dbg !1572

71:                                               ; preds = %26
  br label %72, !dbg !1573

72:                                               ; preds = %71, %70, %69, %52, %45, %37
  %73 = load i8, ptr %13, align 1, !dbg !1574
  %74 = zext i8 %73 to i32, !dbg !1574
  %75 = icmp eq i32 %74, 1, !dbg !1575
  br i1 %75, label %76, label %180, !dbg !1574

76:                                               ; preds = %72
  %77 = load ptr, ptr %11, align 4, !dbg !1576
  %78 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %77, i32 0, i32 1, !dbg !1576
  %79 = getelementptr inbounds %struct.xLIST_ITEM, ptr %78, i32 0, i32 4, !dbg !1576
  %80 = load ptr, ptr %79, align 4, !dbg !1576
  store ptr %80, ptr %14, align 4, !dbg !1576
  %81 = load ptr, ptr %11, align 4, !dbg !1576
  %82 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %81, i32 0, i32 1, !dbg !1576
  %83 = getelementptr inbounds %struct.xLIST_ITEM, ptr %82, i32 0, i32 2, !dbg !1576
  %84 = load ptr, ptr %83, align 4, !dbg !1576
  %85 = load ptr, ptr %11, align 4, !dbg !1576
  %86 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %85, i32 0, i32 1, !dbg !1576
  %87 = getelementptr inbounds %struct.xLIST_ITEM, ptr %86, i32 0, i32 1, !dbg !1576
  %88 = load ptr, ptr %87, align 4, !dbg !1576
  %89 = getelementptr inbounds %struct.xLIST_ITEM, ptr %88, i32 0, i32 2, !dbg !1576
  store ptr %84, ptr %89, align 4, !dbg !1576
  %90 = load ptr, ptr %11, align 4, !dbg !1576
  %91 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %90, i32 0, i32 1, !dbg !1576
  %92 = getelementptr inbounds %struct.xLIST_ITEM, ptr %91, i32 0, i32 1, !dbg !1576
  %93 = load ptr, ptr %92, align 4, !dbg !1576
  %94 = load ptr, ptr %11, align 4, !dbg !1576
  %95 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %94, i32 0, i32 1, !dbg !1576
  %96 = getelementptr inbounds %struct.xLIST_ITEM, ptr %95, i32 0, i32 2, !dbg !1576
  %97 = load ptr, ptr %96, align 4, !dbg !1576
  %98 = getelementptr inbounds %struct.xLIST_ITEM, ptr %97, i32 0, i32 1, !dbg !1576
  store ptr %93, ptr %98, align 4, !dbg !1576
  %99 = load ptr, ptr %14, align 4, !dbg !1576
  %100 = getelementptr inbounds %struct.xLIST, ptr %99, i32 0, i32 1, !dbg !1576
  %101 = load ptr, ptr %100, align 4, !dbg !1576
  %102 = load ptr, ptr %11, align 4, !dbg !1576
  %103 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %102, i32 0, i32 1, !dbg !1576
  %104 = icmp eq ptr %101, %103, !dbg !1576
  br i1 %104, label %105, label %112, !dbg !1576

105:                                              ; preds = %76
  %106 = load ptr, ptr %11, align 4, !dbg !1576
  %107 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %106, i32 0, i32 1, !dbg !1576
  %108 = getelementptr inbounds %struct.xLIST_ITEM, ptr %107, i32 0, i32 2, !dbg !1576
  %109 = load ptr, ptr %108, align 4, !dbg !1576
  %110 = load ptr, ptr %14, align 4, !dbg !1576
  %111 = getelementptr inbounds %struct.xLIST, ptr %110, i32 0, i32 1, !dbg !1576
  store ptr %109, ptr %111, align 4, !dbg !1576
  br label %112, !dbg !1576

112:                                              ; preds = %105, %76
  %113 = load ptr, ptr %11, align 4, !dbg !1576
  %114 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %113, i32 0, i32 1, !dbg !1576
  %115 = getelementptr inbounds %struct.xLIST_ITEM, ptr %114, i32 0, i32 4, !dbg !1576
  store ptr null, ptr %115, align 4, !dbg !1576
  %116 = load ptr, ptr %14, align 4, !dbg !1576
  %117 = getelementptr inbounds %struct.xLIST, ptr %116, i32 0, i32 0, !dbg !1576
  %118 = load volatile i32, ptr %117, align 4, !dbg !1576
  %119 = add i32 %118, -1, !dbg !1576
  store volatile i32 %119, ptr %117, align 4, !dbg !1576
  %120 = load ptr, ptr %11, align 4, !dbg !1577
  %121 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %120, i32 0, i32 3, !dbg !1577
  %122 = load i32, ptr %121, align 4, !dbg !1577
  %123 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !1577
  %124 = icmp ugt i32 %122, %123, !dbg !1577
  br i1 %124, label %125, label %129, !dbg !1577

125:                                              ; preds = %112
  %126 = load ptr, ptr %11, align 4, !dbg !1577
  %127 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %126, i32 0, i32 3, !dbg !1577
  %128 = load i32, ptr %127, align 4, !dbg !1577
  store volatile i32 %128, ptr @uxTopReadyPriority, align 4, !dbg !1577
  br label %129, !dbg !1577

129:                                              ; preds = %125, %112
  %130 = load ptr, ptr %11, align 4, !dbg !1577
  %131 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %130, i32 0, i32 3, !dbg !1577
  %132 = load i32, ptr %131, align 4, !dbg !1577
  %133 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %132, !dbg !1577
  %134 = getelementptr inbounds %struct.xLIST, ptr %133, i32 0, i32 1, !dbg !1577
  %135 = load ptr, ptr %134, align 4, !dbg !1577
  store ptr %135, ptr %15, align 4, !dbg !1577
  %136 = load ptr, ptr %15, align 4, !dbg !1577
  %137 = load ptr, ptr %11, align 4, !dbg !1577
  %138 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %137, i32 0, i32 1, !dbg !1577
  %139 = getelementptr inbounds %struct.xLIST_ITEM, ptr %138, i32 0, i32 1, !dbg !1577
  store ptr %136, ptr %139, align 4, !dbg !1577
  %140 = load ptr, ptr %15, align 4, !dbg !1577
  %141 = getelementptr inbounds %struct.xLIST_ITEM, ptr %140, i32 0, i32 2, !dbg !1577
  %142 = load ptr, ptr %141, align 4, !dbg !1577
  %143 = load ptr, ptr %11, align 4, !dbg !1577
  %144 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %143, i32 0, i32 1, !dbg !1577
  %145 = getelementptr inbounds %struct.xLIST_ITEM, ptr %144, i32 0, i32 2, !dbg !1577
  store ptr %142, ptr %145, align 4, !dbg !1577
  %146 = load ptr, ptr %11, align 4, !dbg !1577
  %147 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %146, i32 0, i32 1, !dbg !1577
  %148 = load ptr, ptr %15, align 4, !dbg !1577
  %149 = getelementptr inbounds %struct.xLIST_ITEM, ptr %148, i32 0, i32 2, !dbg !1577
  %150 = load ptr, ptr %149, align 4, !dbg !1577
  %151 = getelementptr inbounds %struct.xLIST_ITEM, ptr %150, i32 0, i32 1, !dbg !1577
  store ptr %147, ptr %151, align 4, !dbg !1577
  %152 = load ptr, ptr %11, align 4, !dbg !1577
  %153 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %152, i32 0, i32 1, !dbg !1577
  %154 = load ptr, ptr %15, align 4, !dbg !1577
  %155 = getelementptr inbounds %struct.xLIST_ITEM, ptr %154, i32 0, i32 2, !dbg !1577
  store ptr %153, ptr %155, align 4, !dbg !1577
  %156 = load ptr, ptr %11, align 4, !dbg !1577
  %157 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %156, i32 0, i32 3, !dbg !1577
  %158 = load i32, ptr %157, align 4, !dbg !1577
  %159 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %158, !dbg !1577
  %160 = load ptr, ptr %11, align 4, !dbg !1577
  %161 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %160, i32 0, i32 1, !dbg !1577
  %162 = getelementptr inbounds %struct.xLIST_ITEM, ptr %161, i32 0, i32 4, !dbg !1577
  store ptr %159, ptr %162, align 4, !dbg !1577
  %163 = load ptr, ptr %11, align 4, !dbg !1577
  %164 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %163, i32 0, i32 3, !dbg !1577
  %165 = load i32, ptr %164, align 4, !dbg !1577
  %166 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %165, !dbg !1577
  %167 = getelementptr inbounds %struct.xLIST, ptr %166, i32 0, i32 0, !dbg !1577
  %168 = load volatile i32, ptr %167, align 4, !dbg !1577
  %169 = add i32 %168, 1, !dbg !1577
  store volatile i32 %169, ptr %167, align 4, !dbg !1577
  %170 = load ptr, ptr %11, align 4, !dbg !1578
  %171 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %170, i32 0, i32 3, !dbg !1579
  %172 = load i32, ptr %171, align 4, !dbg !1579
  %173 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1580
  %174 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %173, i32 0, i32 3, !dbg !1581
  %175 = load i32, ptr %174, align 4, !dbg !1581
  %176 = icmp ugt i32 %172, %175, !dbg !1582
  br i1 %176, label %177, label %178, !dbg !1578

177:                                              ; preds = %129
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !1583
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !1583, !srcloc !1584
  call void asm sideeffect "isb", ""() #3, !dbg !1583, !srcloc !1585
  br label %179, !dbg !1586

178:                                              ; preds = %129
  br label %179

179:                                              ; preds = %178, %177
  br label %181, !dbg !1587

180:                                              ; preds = %72
  br label %181

181:                                              ; preds = %180, %179
  call void @vPortExitCritical(), !dbg !1588
  %182 = load i32, ptr %12, align 4, !dbg !1589
  ret i32 %182, !dbg !1590
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskGenericNotifyFromISR(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, ptr noundef %4, ptr noundef %5) #0 !dbg !1591 {
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca ptr, align 4
  %15 = alloca ptr, align 4
  %16 = alloca ptr, align 4
  %17 = alloca i8, align 1
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca ptr, align 4
  %21 = alloca ptr, align 4
  %22 = alloca ptr, align 4
  store ptr %0, ptr %10, align 4
  store i32 %1, ptr %11, align 4
  store i32 %2, ptr %12, align 4
  store i32 %3, ptr %13, align 4
  store ptr %4, ptr %14, align 4
  store ptr %5, ptr %15, align 4
  store i32 1, ptr %18, align 4, !dbg !1592
  %23 = load ptr, ptr %10, align 4, !dbg !1593
  store ptr %23, ptr %16, align 4, !dbg !1594
  %24 = call { i32, i32 } asm sideeffect "\09mrs $0, basepri\09\09\09\09\09\09\09\09\09\09\09\0A\09mov $1, $2\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $1\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,=r,i,~{memory}"(i32 80) #3, !dbg !1595, !srcloc !545
  %25 = extractvalue { i32, i32 } %24, 0, !dbg !1595
  %26 = extractvalue { i32, i32 } %24, 1, !dbg !1595
  store i32 %25, ptr %8, align 4, !dbg !1595
  store i32 %26, ptr %9, align 4, !dbg !1595
  %27 = load i32, ptr %8, align 4, !dbg !1597
  store i32 %27, ptr %19, align 4, !dbg !1598
  %28 = load ptr, ptr %14, align 4, !dbg !1599
  %29 = icmp ne ptr %28, null, !dbg !1600
  br i1 %29, label %30, label %37, !dbg !1599

30:                                               ; preds = %6
  %31 = load ptr, ptr %16, align 4, !dbg !1601
  %32 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %31, i32 0, i32 10, !dbg !1602
  %33 = load i32, ptr %11, align 4, !dbg !1603
  %34 = getelementptr inbounds [1 x i32], ptr %32, i32 0, i32 %33, !dbg !1601
  %35 = load volatile i32, ptr %34, align 4, !dbg !1601
  %36 = load ptr, ptr %14, align 4, !dbg !1604
  store i32 %35, ptr %36, align 4, !dbg !1605
  br label %37, !dbg !1606

37:                                               ; preds = %30, %6
  %38 = load ptr, ptr %16, align 4, !dbg !1607
  %39 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %38, i32 0, i32 11, !dbg !1608
  %40 = load i32, ptr %11, align 4, !dbg !1609
  %41 = getelementptr inbounds [1 x i8], ptr %39, i32 0, i32 %40, !dbg !1607
  %42 = load volatile i8, ptr %41, align 1, !dbg !1607
  store i8 %42, ptr %17, align 1, !dbg !1610
  %43 = load ptr, ptr %16, align 4, !dbg !1611
  %44 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %43, i32 0, i32 11, !dbg !1612
  %45 = load i32, ptr %11, align 4, !dbg !1613
  %46 = getelementptr inbounds [1 x i8], ptr %44, i32 0, i32 %45, !dbg !1611
  store volatile i8 2, ptr %46, align 1, !dbg !1614
  %47 = load i32, ptr %13, align 4, !dbg !1615
  switch i32 %47, label %82 [
    i32 1, label %48
    i32 2, label %56
    i32 3, label %63
    i32 4, label %69
    i32 0, label %81
  ], !dbg !1616

48:                                               ; preds = %37
  %49 = load i32, ptr %12, align 4, !dbg !1617
  %50 = load ptr, ptr %16, align 4, !dbg !1618
  %51 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %50, i32 0, i32 10, !dbg !1619
  %52 = load i32, ptr %11, align 4, !dbg !1620
  %53 = getelementptr inbounds [1 x i32], ptr %51, i32 0, i32 %52, !dbg !1618
  %54 = load volatile i32, ptr %53, align 4, !dbg !1621
  %55 = or i32 %54, %49, !dbg !1621
  store volatile i32 %55, ptr %53, align 4, !dbg !1621
  br label %83, !dbg !1622

56:                                               ; preds = %37
  %57 = load ptr, ptr %16, align 4, !dbg !1623
  %58 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %57, i32 0, i32 10, !dbg !1624
  %59 = load i32, ptr %11, align 4, !dbg !1625
  %60 = getelementptr inbounds [1 x i32], ptr %58, i32 0, i32 %59, !dbg !1623
  %61 = load volatile i32, ptr %60, align 4, !dbg !1626
  %62 = add i32 %61, 1, !dbg !1626
  store volatile i32 %62, ptr %60, align 4, !dbg !1626
  br label %83, !dbg !1627

63:                                               ; preds = %37
  %64 = load i32, ptr %12, align 4, !dbg !1628
  %65 = load ptr, ptr %16, align 4, !dbg !1629
  %66 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %65, i32 0, i32 10, !dbg !1630
  %67 = load i32, ptr %11, align 4, !dbg !1631
  %68 = getelementptr inbounds [1 x i32], ptr %66, i32 0, i32 %67, !dbg !1629
  store volatile i32 %64, ptr %68, align 4, !dbg !1632
  br label %83, !dbg !1633

69:                                               ; preds = %37
  %70 = load i8, ptr %17, align 1, !dbg !1634
  %71 = zext i8 %70 to i32, !dbg !1634
  %72 = icmp ne i32 %71, 2, !dbg !1635
  br i1 %72, label %73, label %79, !dbg !1634

73:                                               ; preds = %69
  %74 = load i32, ptr %12, align 4, !dbg !1636
  %75 = load ptr, ptr %16, align 4, !dbg !1637
  %76 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %75, i32 0, i32 10, !dbg !1638
  %77 = load i32, ptr %11, align 4, !dbg !1639
  %78 = getelementptr inbounds [1 x i32], ptr %76, i32 0, i32 %77, !dbg !1637
  store volatile i32 %74, ptr %78, align 4, !dbg !1640
  br label %80, !dbg !1641

79:                                               ; preds = %69
  store i32 0, ptr %18, align 4, !dbg !1642
  br label %80

80:                                               ; preds = %79, %73
  br label %83, !dbg !1643

81:                                               ; preds = %37
  br label %83, !dbg !1644

82:                                               ; preds = %37
  br label %83, !dbg !1645

83:                                               ; preds = %82, %81, %80, %63, %56, %48
  %84 = load i8, ptr %17, align 1, !dbg !1646
  %85 = zext i8 %84 to i32, !dbg !1646
  %86 = icmp eq i32 %85, 1, !dbg !1647
  br i1 %86, label %87, label %227, !dbg !1646

87:                                               ; preds = %83
  %88 = load volatile i32, ptr @uxSchedulerSuspended, align 4, !dbg !1648
  %89 = icmp eq i32 %88, 0, !dbg !1649
  br i1 %89, label %90, label %184, !dbg !1648

90:                                               ; preds = %87
  %91 = load ptr, ptr %16, align 4, !dbg !1650
  %92 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %91, i32 0, i32 1, !dbg !1650
  %93 = getelementptr inbounds %struct.xLIST_ITEM, ptr %92, i32 0, i32 4, !dbg !1650
  %94 = load ptr, ptr %93, align 4, !dbg !1650
  store ptr %94, ptr %20, align 4, !dbg !1650
  %95 = load ptr, ptr %16, align 4, !dbg !1650
  %96 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %95, i32 0, i32 1, !dbg !1650
  %97 = getelementptr inbounds %struct.xLIST_ITEM, ptr %96, i32 0, i32 2, !dbg !1650
  %98 = load ptr, ptr %97, align 4, !dbg !1650
  %99 = load ptr, ptr %16, align 4, !dbg !1650
  %100 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %99, i32 0, i32 1, !dbg !1650
  %101 = getelementptr inbounds %struct.xLIST_ITEM, ptr %100, i32 0, i32 1, !dbg !1650
  %102 = load ptr, ptr %101, align 4, !dbg !1650
  %103 = getelementptr inbounds %struct.xLIST_ITEM, ptr %102, i32 0, i32 2, !dbg !1650
  store ptr %98, ptr %103, align 4, !dbg !1650
  %104 = load ptr, ptr %16, align 4, !dbg !1650
  %105 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %104, i32 0, i32 1, !dbg !1650
  %106 = getelementptr inbounds %struct.xLIST_ITEM, ptr %105, i32 0, i32 1, !dbg !1650
  %107 = load ptr, ptr %106, align 4, !dbg !1650
  %108 = load ptr, ptr %16, align 4, !dbg !1650
  %109 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %108, i32 0, i32 1, !dbg !1650
  %110 = getelementptr inbounds %struct.xLIST_ITEM, ptr %109, i32 0, i32 2, !dbg !1650
  %111 = load ptr, ptr %110, align 4, !dbg !1650
  %112 = getelementptr inbounds %struct.xLIST_ITEM, ptr %111, i32 0, i32 1, !dbg !1650
  store ptr %107, ptr %112, align 4, !dbg !1650
  %113 = load ptr, ptr %20, align 4, !dbg !1650
  %114 = getelementptr inbounds %struct.xLIST, ptr %113, i32 0, i32 1, !dbg !1650
  %115 = load ptr, ptr %114, align 4, !dbg !1650
  %116 = load ptr, ptr %16, align 4, !dbg !1650
  %117 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %116, i32 0, i32 1, !dbg !1650
  %118 = icmp eq ptr %115, %117, !dbg !1650
  br i1 %118, label %119, label %126, !dbg !1650

119:                                              ; preds = %90
  %120 = load ptr, ptr %16, align 4, !dbg !1650
  %121 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %120, i32 0, i32 1, !dbg !1650
  %122 = getelementptr inbounds %struct.xLIST_ITEM, ptr %121, i32 0, i32 2, !dbg !1650
  %123 = load ptr, ptr %122, align 4, !dbg !1650
  %124 = load ptr, ptr %20, align 4, !dbg !1650
  %125 = getelementptr inbounds %struct.xLIST, ptr %124, i32 0, i32 1, !dbg !1650
  store ptr %123, ptr %125, align 4, !dbg !1650
  br label %126, !dbg !1650

126:                                              ; preds = %119, %90
  %127 = load ptr, ptr %16, align 4, !dbg !1650
  %128 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %127, i32 0, i32 1, !dbg !1650
  %129 = getelementptr inbounds %struct.xLIST_ITEM, ptr %128, i32 0, i32 4, !dbg !1650
  store ptr null, ptr %129, align 4, !dbg !1650
  %130 = load ptr, ptr %20, align 4, !dbg !1650
  %131 = getelementptr inbounds %struct.xLIST, ptr %130, i32 0, i32 0, !dbg !1650
  %132 = load volatile i32, ptr %131, align 4, !dbg !1650
  %133 = add i32 %132, -1, !dbg !1650
  store volatile i32 %133, ptr %131, align 4, !dbg !1650
  %134 = load ptr, ptr %16, align 4, !dbg !1651
  %135 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %134, i32 0, i32 3, !dbg !1651
  %136 = load i32, ptr %135, align 4, !dbg !1651
  %137 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !1651
  %138 = icmp ugt i32 %136, %137, !dbg !1651
  br i1 %138, label %139, label %143, !dbg !1651

139:                                              ; preds = %126
  %140 = load ptr, ptr %16, align 4, !dbg !1651
  %141 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %140, i32 0, i32 3, !dbg !1651
  %142 = load i32, ptr %141, align 4, !dbg !1651
  store volatile i32 %142, ptr @uxTopReadyPriority, align 4, !dbg !1651
  br label %143, !dbg !1651

143:                                              ; preds = %139, %126
  %144 = load ptr, ptr %16, align 4, !dbg !1651
  %145 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %144, i32 0, i32 3, !dbg !1651
  %146 = load i32, ptr %145, align 4, !dbg !1651
  %147 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %146, !dbg !1651
  %148 = getelementptr inbounds %struct.xLIST, ptr %147, i32 0, i32 1, !dbg !1651
  %149 = load ptr, ptr %148, align 4, !dbg !1651
  store ptr %149, ptr %21, align 4, !dbg !1651
  %150 = load ptr, ptr %21, align 4, !dbg !1651
  %151 = load ptr, ptr %16, align 4, !dbg !1651
  %152 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %151, i32 0, i32 1, !dbg !1651
  %153 = getelementptr inbounds %struct.xLIST_ITEM, ptr %152, i32 0, i32 1, !dbg !1651
  store ptr %150, ptr %153, align 4, !dbg !1651
  %154 = load ptr, ptr %21, align 4, !dbg !1651
  %155 = getelementptr inbounds %struct.xLIST_ITEM, ptr %154, i32 0, i32 2, !dbg !1651
  %156 = load ptr, ptr %155, align 4, !dbg !1651
  %157 = load ptr, ptr %16, align 4, !dbg !1651
  %158 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %157, i32 0, i32 1, !dbg !1651
  %159 = getelementptr inbounds %struct.xLIST_ITEM, ptr %158, i32 0, i32 2, !dbg !1651
  store ptr %156, ptr %159, align 4, !dbg !1651
  %160 = load ptr, ptr %16, align 4, !dbg !1651
  %161 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %160, i32 0, i32 1, !dbg !1651
  %162 = load ptr, ptr %21, align 4, !dbg !1651
  %163 = getelementptr inbounds %struct.xLIST_ITEM, ptr %162, i32 0, i32 2, !dbg !1651
  %164 = load ptr, ptr %163, align 4, !dbg !1651
  %165 = getelementptr inbounds %struct.xLIST_ITEM, ptr %164, i32 0, i32 1, !dbg !1651
  store ptr %161, ptr %165, align 4, !dbg !1651
  %166 = load ptr, ptr %16, align 4, !dbg !1651
  %167 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %166, i32 0, i32 1, !dbg !1651
  %168 = load ptr, ptr %21, align 4, !dbg !1651
  %169 = getelementptr inbounds %struct.xLIST_ITEM, ptr %168, i32 0, i32 2, !dbg !1651
  store ptr %167, ptr %169, align 4, !dbg !1651
  %170 = load ptr, ptr %16, align 4, !dbg !1651
  %171 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %170, i32 0, i32 3, !dbg !1651
  %172 = load i32, ptr %171, align 4, !dbg !1651
  %173 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %172, !dbg !1651
  %174 = load ptr, ptr %16, align 4, !dbg !1651
  %175 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %174, i32 0, i32 1, !dbg !1651
  %176 = getelementptr inbounds %struct.xLIST_ITEM, ptr %175, i32 0, i32 4, !dbg !1651
  store ptr %173, ptr %176, align 4, !dbg !1651
  %177 = load ptr, ptr %16, align 4, !dbg !1651
  %178 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %177, i32 0, i32 3, !dbg !1651
  %179 = load i32, ptr %178, align 4, !dbg !1651
  %180 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %179, !dbg !1651
  %181 = getelementptr inbounds %struct.xLIST, ptr %180, i32 0, i32 0, !dbg !1651
  %182 = load volatile i32, ptr %181, align 4, !dbg !1651
  %183 = add i32 %182, 1, !dbg !1651
  store volatile i32 %183, ptr %181, align 4, !dbg !1651
  br label %211, !dbg !1652

184:                                              ; preds = %87
  %185 = load ptr, ptr getelementptr inbounds (%struct.xLIST, ptr @xPendingReadyList, i32 0, i32 1), align 4, !dbg !1653
  store ptr %185, ptr %22, align 4, !dbg !1653
  %186 = load ptr, ptr %22, align 4, !dbg !1653
  %187 = load ptr, ptr %16, align 4, !dbg !1653
  %188 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %187, i32 0, i32 2, !dbg !1653
  %189 = getelementptr inbounds %struct.xLIST_ITEM, ptr %188, i32 0, i32 1, !dbg !1653
  store ptr %186, ptr %189, align 4, !dbg !1653
  %190 = load ptr, ptr %22, align 4, !dbg !1653
  %191 = getelementptr inbounds %struct.xLIST_ITEM, ptr %190, i32 0, i32 2, !dbg !1653
  %192 = load ptr, ptr %191, align 4, !dbg !1653
  %193 = load ptr, ptr %16, align 4, !dbg !1653
  %194 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %193, i32 0, i32 2, !dbg !1653
  %195 = getelementptr inbounds %struct.xLIST_ITEM, ptr %194, i32 0, i32 2, !dbg !1653
  store ptr %192, ptr %195, align 4, !dbg !1653
  %196 = load ptr, ptr %16, align 4, !dbg !1653
  %197 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %196, i32 0, i32 2, !dbg !1653
  %198 = load ptr, ptr %22, align 4, !dbg !1653
  %199 = getelementptr inbounds %struct.xLIST_ITEM, ptr %198, i32 0, i32 2, !dbg !1653
  %200 = load ptr, ptr %199, align 4, !dbg !1653
  %201 = getelementptr inbounds %struct.xLIST_ITEM, ptr %200, i32 0, i32 1, !dbg !1653
  store ptr %197, ptr %201, align 4, !dbg !1653
  %202 = load ptr, ptr %16, align 4, !dbg !1653
  %203 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %202, i32 0, i32 2, !dbg !1653
  %204 = load ptr, ptr %22, align 4, !dbg !1653
  %205 = getelementptr inbounds %struct.xLIST_ITEM, ptr %204, i32 0, i32 2, !dbg !1653
  store ptr %203, ptr %205, align 4, !dbg !1653
  %206 = load ptr, ptr %16, align 4, !dbg !1653
  %207 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %206, i32 0, i32 2, !dbg !1653
  %208 = getelementptr inbounds %struct.xLIST_ITEM, ptr %207, i32 0, i32 4, !dbg !1653
  store ptr @xPendingReadyList, ptr %208, align 4, !dbg !1653
  %209 = load volatile i32, ptr @xPendingReadyList, align 4, !dbg !1653
  %210 = add i32 %209, 1, !dbg !1653
  store volatile i32 %210, ptr @xPendingReadyList, align 4, !dbg !1653
  br label %211

211:                                              ; preds = %184, %143
  %212 = load ptr, ptr %16, align 4, !dbg !1654
  %213 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %212, i32 0, i32 3, !dbg !1655
  %214 = load i32, ptr %213, align 4, !dbg !1655
  %215 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1656
  %216 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %215, i32 0, i32 3, !dbg !1657
  %217 = load i32, ptr %216, align 4, !dbg !1657
  %218 = icmp ugt i32 %214, %217, !dbg !1658
  br i1 %218, label %219, label %225, !dbg !1654

219:                                              ; preds = %211
  %220 = load ptr, ptr %15, align 4, !dbg !1659
  %221 = icmp ne ptr %220, null, !dbg !1660
  br i1 %221, label %222, label %224, !dbg !1659

222:                                              ; preds = %219
  %223 = load ptr, ptr %15, align 4, !dbg !1661
  store i32 1, ptr %223, align 4, !dbg !1662
  br label %224, !dbg !1663

224:                                              ; preds = %222, %219
  store volatile i32 1, ptr @xYieldPending, align 4, !dbg !1664
  br label %226, !dbg !1665

225:                                              ; preds = %211
  br label %226

226:                                              ; preds = %225, %224
  br label %227, !dbg !1666

227:                                              ; preds = %226, %83
  %228 = load i32, ptr %19, align 4, !dbg !1667
  store i32 %228, ptr %7, align 4
  %229 = load i32, ptr %7, align 4, !dbg !1668
  call void asm sideeffect "\09msr basepri, $0\09", "r,~{memory}"(i32 %229) #3, !dbg !1670, !srcloc !558
  %230 = load i32, ptr %18, align 4, !dbg !1671
  ret i32 %230, !dbg !1672
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskGenericNotifyGiveFromISR(ptr noundef %0, i32 noundef %1, ptr noundef %2) #0 !dbg !1673 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 4
  %10 = alloca ptr, align 4
  %11 = alloca i8, align 1
  %12 = alloca i32, align 4
  %13 = alloca ptr, align 4
  %14 = alloca ptr, align 4
  %15 = alloca ptr, align 4
  store ptr %0, ptr %7, align 4
  store i32 %1, ptr %8, align 4
  store ptr %2, ptr %9, align 4
  %16 = load ptr, ptr %7, align 4, !dbg !1674
  store ptr %16, ptr %10, align 4, !dbg !1675
  %17 = call { i32, i32 } asm sideeffect "\09mrs $0, basepri\09\09\09\09\09\09\09\09\09\09\09\0A\09mov $1, $2\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $1\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,=r,i,~{memory}"(i32 80) #3, !dbg !1676, !srcloc !545
  %18 = extractvalue { i32, i32 } %17, 0, !dbg !1676
  %19 = extractvalue { i32, i32 } %17, 1, !dbg !1676
  store i32 %18, ptr %5, align 4, !dbg !1676
  store i32 %19, ptr %6, align 4, !dbg !1676
  %20 = load i32, ptr %5, align 4, !dbg !1678
  store i32 %20, ptr %12, align 4, !dbg !1679
  %21 = load ptr, ptr %10, align 4, !dbg !1680
  %22 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %21, i32 0, i32 11, !dbg !1681
  %23 = load i32, ptr %8, align 4, !dbg !1682
  %24 = getelementptr inbounds [1 x i8], ptr %22, i32 0, i32 %23, !dbg !1680
  %25 = load volatile i8, ptr %24, align 1, !dbg !1680
  store i8 %25, ptr %11, align 1, !dbg !1683
  %26 = load ptr, ptr %10, align 4, !dbg !1684
  %27 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %26, i32 0, i32 11, !dbg !1685
  %28 = load i32, ptr %8, align 4, !dbg !1686
  %29 = getelementptr inbounds [1 x i8], ptr %27, i32 0, i32 %28, !dbg !1684
  store volatile i8 2, ptr %29, align 1, !dbg !1687
  %30 = load ptr, ptr %10, align 4, !dbg !1688
  %31 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %30, i32 0, i32 10, !dbg !1689
  %32 = load i32, ptr %8, align 4, !dbg !1690
  %33 = getelementptr inbounds [1 x i32], ptr %31, i32 0, i32 %32, !dbg !1688
  %34 = load volatile i32, ptr %33, align 4, !dbg !1691
  %35 = add i32 %34, 1, !dbg !1691
  store volatile i32 %35, ptr %33, align 4, !dbg !1691
  %36 = load i8, ptr %11, align 1, !dbg !1692
  %37 = zext i8 %36 to i32, !dbg !1692
  %38 = icmp eq i32 %37, 1, !dbg !1693
  br i1 %38, label %39, label %179, !dbg !1692

39:                                               ; preds = %3
  %40 = load volatile i32, ptr @uxSchedulerSuspended, align 4, !dbg !1694
  %41 = icmp eq i32 %40, 0, !dbg !1695
  br i1 %41, label %42, label %136, !dbg !1694

42:                                               ; preds = %39
  %43 = load ptr, ptr %10, align 4, !dbg !1696
  %44 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %43, i32 0, i32 1, !dbg !1696
  %45 = getelementptr inbounds %struct.xLIST_ITEM, ptr %44, i32 0, i32 4, !dbg !1696
  %46 = load ptr, ptr %45, align 4, !dbg !1696
  store ptr %46, ptr %13, align 4, !dbg !1696
  %47 = load ptr, ptr %10, align 4, !dbg !1696
  %48 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %47, i32 0, i32 1, !dbg !1696
  %49 = getelementptr inbounds %struct.xLIST_ITEM, ptr %48, i32 0, i32 2, !dbg !1696
  %50 = load ptr, ptr %49, align 4, !dbg !1696
  %51 = load ptr, ptr %10, align 4, !dbg !1696
  %52 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %51, i32 0, i32 1, !dbg !1696
  %53 = getelementptr inbounds %struct.xLIST_ITEM, ptr %52, i32 0, i32 1, !dbg !1696
  %54 = load ptr, ptr %53, align 4, !dbg !1696
  %55 = getelementptr inbounds %struct.xLIST_ITEM, ptr %54, i32 0, i32 2, !dbg !1696
  store ptr %50, ptr %55, align 4, !dbg !1696
  %56 = load ptr, ptr %10, align 4, !dbg !1696
  %57 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %56, i32 0, i32 1, !dbg !1696
  %58 = getelementptr inbounds %struct.xLIST_ITEM, ptr %57, i32 0, i32 1, !dbg !1696
  %59 = load ptr, ptr %58, align 4, !dbg !1696
  %60 = load ptr, ptr %10, align 4, !dbg !1696
  %61 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %60, i32 0, i32 1, !dbg !1696
  %62 = getelementptr inbounds %struct.xLIST_ITEM, ptr %61, i32 0, i32 2, !dbg !1696
  %63 = load ptr, ptr %62, align 4, !dbg !1696
  %64 = getelementptr inbounds %struct.xLIST_ITEM, ptr %63, i32 0, i32 1, !dbg !1696
  store ptr %59, ptr %64, align 4, !dbg !1696
  %65 = load ptr, ptr %13, align 4, !dbg !1696
  %66 = getelementptr inbounds %struct.xLIST, ptr %65, i32 0, i32 1, !dbg !1696
  %67 = load ptr, ptr %66, align 4, !dbg !1696
  %68 = load ptr, ptr %10, align 4, !dbg !1696
  %69 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %68, i32 0, i32 1, !dbg !1696
  %70 = icmp eq ptr %67, %69, !dbg !1696
  br i1 %70, label %71, label %78, !dbg !1696

71:                                               ; preds = %42
  %72 = load ptr, ptr %10, align 4, !dbg !1696
  %73 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %72, i32 0, i32 1, !dbg !1696
  %74 = getelementptr inbounds %struct.xLIST_ITEM, ptr %73, i32 0, i32 2, !dbg !1696
  %75 = load ptr, ptr %74, align 4, !dbg !1696
  %76 = load ptr, ptr %13, align 4, !dbg !1696
  %77 = getelementptr inbounds %struct.xLIST, ptr %76, i32 0, i32 1, !dbg !1696
  store ptr %75, ptr %77, align 4, !dbg !1696
  br label %78, !dbg !1696

78:                                               ; preds = %71, %42
  %79 = load ptr, ptr %10, align 4, !dbg !1696
  %80 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %79, i32 0, i32 1, !dbg !1696
  %81 = getelementptr inbounds %struct.xLIST_ITEM, ptr %80, i32 0, i32 4, !dbg !1696
  store ptr null, ptr %81, align 4, !dbg !1696
  %82 = load ptr, ptr %13, align 4, !dbg !1696
  %83 = getelementptr inbounds %struct.xLIST, ptr %82, i32 0, i32 0, !dbg !1696
  %84 = load volatile i32, ptr %83, align 4, !dbg !1696
  %85 = add i32 %84, -1, !dbg !1696
  store volatile i32 %85, ptr %83, align 4, !dbg !1696
  %86 = load ptr, ptr %10, align 4, !dbg !1697
  %87 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %86, i32 0, i32 3, !dbg !1697
  %88 = load i32, ptr %87, align 4, !dbg !1697
  %89 = load volatile i32, ptr @uxTopReadyPriority, align 4, !dbg !1697
  %90 = icmp ugt i32 %88, %89, !dbg !1697
  br i1 %90, label %91, label %95, !dbg !1697

91:                                               ; preds = %78
  %92 = load ptr, ptr %10, align 4, !dbg !1697
  %93 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %92, i32 0, i32 3, !dbg !1697
  %94 = load i32, ptr %93, align 4, !dbg !1697
  store volatile i32 %94, ptr @uxTopReadyPriority, align 4, !dbg !1697
  br label %95, !dbg !1697

95:                                               ; preds = %91, %78
  %96 = load ptr, ptr %10, align 4, !dbg !1697
  %97 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %96, i32 0, i32 3, !dbg !1697
  %98 = load i32, ptr %97, align 4, !dbg !1697
  %99 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %98, !dbg !1697
  %100 = getelementptr inbounds %struct.xLIST, ptr %99, i32 0, i32 1, !dbg !1697
  %101 = load ptr, ptr %100, align 4, !dbg !1697
  store ptr %101, ptr %14, align 4, !dbg !1697
  %102 = load ptr, ptr %14, align 4, !dbg !1697
  %103 = load ptr, ptr %10, align 4, !dbg !1697
  %104 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %103, i32 0, i32 1, !dbg !1697
  %105 = getelementptr inbounds %struct.xLIST_ITEM, ptr %104, i32 0, i32 1, !dbg !1697
  store ptr %102, ptr %105, align 4, !dbg !1697
  %106 = load ptr, ptr %14, align 4, !dbg !1697
  %107 = getelementptr inbounds %struct.xLIST_ITEM, ptr %106, i32 0, i32 2, !dbg !1697
  %108 = load ptr, ptr %107, align 4, !dbg !1697
  %109 = load ptr, ptr %10, align 4, !dbg !1697
  %110 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %109, i32 0, i32 1, !dbg !1697
  %111 = getelementptr inbounds %struct.xLIST_ITEM, ptr %110, i32 0, i32 2, !dbg !1697
  store ptr %108, ptr %111, align 4, !dbg !1697
  %112 = load ptr, ptr %10, align 4, !dbg !1697
  %113 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %112, i32 0, i32 1, !dbg !1697
  %114 = load ptr, ptr %14, align 4, !dbg !1697
  %115 = getelementptr inbounds %struct.xLIST_ITEM, ptr %114, i32 0, i32 2, !dbg !1697
  %116 = load ptr, ptr %115, align 4, !dbg !1697
  %117 = getelementptr inbounds %struct.xLIST_ITEM, ptr %116, i32 0, i32 1, !dbg !1697
  store ptr %113, ptr %117, align 4, !dbg !1697
  %118 = load ptr, ptr %10, align 4, !dbg !1697
  %119 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %118, i32 0, i32 1, !dbg !1697
  %120 = load ptr, ptr %14, align 4, !dbg !1697
  %121 = getelementptr inbounds %struct.xLIST_ITEM, ptr %120, i32 0, i32 2, !dbg !1697
  store ptr %119, ptr %121, align 4, !dbg !1697
  %122 = load ptr, ptr %10, align 4, !dbg !1697
  %123 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %122, i32 0, i32 3, !dbg !1697
  %124 = load i32, ptr %123, align 4, !dbg !1697
  %125 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %124, !dbg !1697
  %126 = load ptr, ptr %10, align 4, !dbg !1697
  %127 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %126, i32 0, i32 1, !dbg !1697
  %128 = getelementptr inbounds %struct.xLIST_ITEM, ptr %127, i32 0, i32 4, !dbg !1697
  store ptr %125, ptr %128, align 4, !dbg !1697
  %129 = load ptr, ptr %10, align 4, !dbg !1697
  %130 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %129, i32 0, i32 3, !dbg !1697
  %131 = load i32, ptr %130, align 4, !dbg !1697
  %132 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %131, !dbg !1697
  %133 = getelementptr inbounds %struct.xLIST, ptr %132, i32 0, i32 0, !dbg !1697
  %134 = load volatile i32, ptr %133, align 4, !dbg !1697
  %135 = add i32 %134, 1, !dbg !1697
  store volatile i32 %135, ptr %133, align 4, !dbg !1697
  br label %163, !dbg !1698

136:                                              ; preds = %39
  %137 = load ptr, ptr getelementptr inbounds (%struct.xLIST, ptr @xPendingReadyList, i32 0, i32 1), align 4, !dbg !1699
  store ptr %137, ptr %15, align 4, !dbg !1699
  %138 = load ptr, ptr %15, align 4, !dbg !1699
  %139 = load ptr, ptr %10, align 4, !dbg !1699
  %140 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %139, i32 0, i32 2, !dbg !1699
  %141 = getelementptr inbounds %struct.xLIST_ITEM, ptr %140, i32 0, i32 1, !dbg !1699
  store ptr %138, ptr %141, align 4, !dbg !1699
  %142 = load ptr, ptr %15, align 4, !dbg !1699
  %143 = getelementptr inbounds %struct.xLIST_ITEM, ptr %142, i32 0, i32 2, !dbg !1699
  %144 = load ptr, ptr %143, align 4, !dbg !1699
  %145 = load ptr, ptr %10, align 4, !dbg !1699
  %146 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %145, i32 0, i32 2, !dbg !1699
  %147 = getelementptr inbounds %struct.xLIST_ITEM, ptr %146, i32 0, i32 2, !dbg !1699
  store ptr %144, ptr %147, align 4, !dbg !1699
  %148 = load ptr, ptr %10, align 4, !dbg !1699
  %149 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %148, i32 0, i32 2, !dbg !1699
  %150 = load ptr, ptr %15, align 4, !dbg !1699
  %151 = getelementptr inbounds %struct.xLIST_ITEM, ptr %150, i32 0, i32 2, !dbg !1699
  %152 = load ptr, ptr %151, align 4, !dbg !1699
  %153 = getelementptr inbounds %struct.xLIST_ITEM, ptr %152, i32 0, i32 1, !dbg !1699
  store ptr %149, ptr %153, align 4, !dbg !1699
  %154 = load ptr, ptr %10, align 4, !dbg !1699
  %155 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %154, i32 0, i32 2, !dbg !1699
  %156 = load ptr, ptr %15, align 4, !dbg !1699
  %157 = getelementptr inbounds %struct.xLIST_ITEM, ptr %156, i32 0, i32 2, !dbg !1699
  store ptr %155, ptr %157, align 4, !dbg !1699
  %158 = load ptr, ptr %10, align 4, !dbg !1699
  %159 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %158, i32 0, i32 2, !dbg !1699
  %160 = getelementptr inbounds %struct.xLIST_ITEM, ptr %159, i32 0, i32 4, !dbg !1699
  store ptr @xPendingReadyList, ptr %160, align 4, !dbg !1699
  %161 = load volatile i32, ptr @xPendingReadyList, align 4, !dbg !1699
  %162 = add i32 %161, 1, !dbg !1699
  store volatile i32 %162, ptr @xPendingReadyList, align 4, !dbg !1699
  br label %163

163:                                              ; preds = %136, %95
  %164 = load ptr, ptr %10, align 4, !dbg !1700
  %165 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %164, i32 0, i32 3, !dbg !1701
  %166 = load i32, ptr %165, align 4, !dbg !1701
  %167 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1702
  %168 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %167, i32 0, i32 3, !dbg !1703
  %169 = load i32, ptr %168, align 4, !dbg !1703
  %170 = icmp ugt i32 %166, %169, !dbg !1704
  br i1 %170, label %171, label %177, !dbg !1700

171:                                              ; preds = %163
  %172 = load ptr, ptr %9, align 4, !dbg !1705
  %173 = icmp ne ptr %172, null, !dbg !1706
  br i1 %173, label %174, label %176, !dbg !1705

174:                                              ; preds = %171
  %175 = load ptr, ptr %9, align 4, !dbg !1707
  store i32 1, ptr %175, align 4, !dbg !1708
  br label %176, !dbg !1709

176:                                              ; preds = %174, %171
  store volatile i32 1, ptr @xYieldPending, align 4, !dbg !1710
  br label %178, !dbg !1711

177:                                              ; preds = %163
  br label %178

178:                                              ; preds = %177, %176
  br label %179, !dbg !1712

179:                                              ; preds = %178, %3
  %180 = load i32, ptr %12, align 4, !dbg !1713
  store i32 %180, ptr %4, align 4
  %181 = load i32, ptr %4, align 4, !dbg !1714
  call void asm sideeffect "\09msr basepri, $0\09", "r,~{memory}"(i32 %181) #3, !dbg !1716, !srcloc !558
  ret void, !dbg !1717
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTaskGenericNotifyStateClear(ptr noundef %0, i32 noundef %1) #0 !dbg !1718 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = load ptr, ptr %3, align 4, !dbg !1719
  %8 = icmp eq ptr %7, null, !dbg !1719
  br i1 %8, label %9, label %11, !dbg !1719

9:                                                ; preds = %2
  %10 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1719
  br label %13, !dbg !1719

11:                                               ; preds = %2
  %12 = load ptr, ptr %3, align 4, !dbg !1719
  br label %13, !dbg !1719

13:                                               ; preds = %11, %9
  %14 = phi ptr [ %10, %9 ], [ %12, %11 ], !dbg !1719
  store ptr %14, ptr %5, align 4, !dbg !1720
  call void @vPortEnterCritical(), !dbg !1721
  %15 = load ptr, ptr %5, align 4, !dbg !1722
  %16 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %15, i32 0, i32 11, !dbg !1723
  %17 = load i32, ptr %4, align 4, !dbg !1724
  %18 = getelementptr inbounds [1 x i8], ptr %16, i32 0, i32 %17, !dbg !1722
  %19 = load volatile i8, ptr %18, align 1, !dbg !1722
  %20 = zext i8 %19 to i32, !dbg !1722
  %21 = icmp eq i32 %20, 2, !dbg !1725
  br i1 %21, label %22, label %27, !dbg !1722

22:                                               ; preds = %13
  %23 = load ptr, ptr %5, align 4, !dbg !1726
  %24 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %23, i32 0, i32 11, !dbg !1727
  %25 = load i32, ptr %4, align 4, !dbg !1728
  %26 = getelementptr inbounds [1 x i8], ptr %24, i32 0, i32 %25, !dbg !1726
  store volatile i8 0, ptr %26, align 1, !dbg !1729
  store i32 1, ptr %6, align 4, !dbg !1730
  br label %28, !dbg !1731

27:                                               ; preds = %13
  store i32 0, ptr %6, align 4, !dbg !1732
  br label %28

28:                                               ; preds = %27, %22
  call void @vPortExitCritical(), !dbg !1733
  %29 = load i32, ptr %6, align 4, !dbg !1734
  ret i32 %29, !dbg !1735
}

; Function Attrs: noinline nounwind
define dso_local i32 @ulTaskGenericNotifyValueClear(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 !dbg !1736 {
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %9 = load ptr, ptr %4, align 4, !dbg !1737
  %10 = icmp eq ptr %9, null, !dbg !1737
  br i1 %10, label %11, label %13, !dbg !1737

11:                                               ; preds = %3
  %12 = load volatile ptr, ptr @pxCurrentTCB, align 4, !dbg !1737
  br label %15, !dbg !1737

13:                                               ; preds = %3
  %14 = load ptr, ptr %4, align 4, !dbg !1737
  br label %15, !dbg !1737

15:                                               ; preds = %13, %11
  %16 = phi ptr [ %12, %11 ], [ %14, %13 ], !dbg !1737
  store ptr %16, ptr %7, align 4, !dbg !1738
  call void @vPortEnterCritical(), !dbg !1739
  %17 = load ptr, ptr %7, align 4, !dbg !1740
  %18 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %17, i32 0, i32 10, !dbg !1741
  %19 = load i32, ptr %5, align 4, !dbg !1742
  %20 = getelementptr inbounds [1 x i32], ptr %18, i32 0, i32 %19, !dbg !1740
  %21 = load volatile i32, ptr %20, align 4, !dbg !1740
  store i32 %21, ptr %8, align 4, !dbg !1743
  %22 = load i32, ptr %6, align 4, !dbg !1744
  %23 = xor i32 %22, -1, !dbg !1745
  %24 = load ptr, ptr %7, align 4, !dbg !1746
  %25 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %24, i32 0, i32 10, !dbg !1747
  %26 = load i32, ptr %5, align 4, !dbg !1748
  %27 = getelementptr inbounds [1 x i32], ptr %25, i32 0, i32 %26, !dbg !1746
  %28 = load volatile i32, ptr %27, align 4, !dbg !1749
  %29 = and i32 %28, %23, !dbg !1749
  store volatile i32 %29, ptr %27, align 4, !dbg !1749
  call void @vPortExitCritical(), !dbg !1750
  %30 = load i32, ptr %8, align 4, !dbg !1751
  ret i32 %30, !dbg !1752
}

; Function Attrs: argmemonly nocallback nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i32(ptr nocapture writeonly, i8, i32, i1 immarg) #2

declare dso_local void @vListInitialiseItem(ptr noundef) #1

declare dso_local ptr @pxPortInitialiseStack(ptr noundef, ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind
define internal void @prvInitialiseTaskLists() #0 !dbg !1753 {
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4, !dbg !1754
  br label %2, !dbg !1755

2:                                                ; preds = %8, %0
  %3 = load i32, ptr %1, align 4, !dbg !1756
  %4 = icmp ult i32 %3, 56, !dbg !1757
  br i1 %4, label %5, label %11, !dbg !1758

5:                                                ; preds = %2
  %6 = load i32, ptr %1, align 4, !dbg !1759
  %7 = getelementptr inbounds [56 x %struct.xLIST], ptr @pxReadyTasksLists, i32 0, i32 %6, !dbg !1760
  call void @vListInitialise(ptr noundef %7), !dbg !1761
  br label %8, !dbg !1762

8:                                                ; preds = %5
  %9 = load i32, ptr %1, align 4, !dbg !1763
  %10 = add i32 %9, 1, !dbg !1763
  store i32 %10, ptr %1, align 4, !dbg !1763
  br label %2, !dbg !1758, !llvm.loop !1764

11:                                               ; preds = %2
  call void @vListInitialise(ptr noundef @xDelayedTaskList1), !dbg !1765
  call void @vListInitialise(ptr noundef @xDelayedTaskList2), !dbg !1766
  call void @vListInitialise(ptr noundef @xPendingReadyList), !dbg !1767
  call void @vListInitialise(ptr noundef @xTasksWaitingTermination), !dbg !1768
  call void @vListInitialise(ptr noundef @xSuspendedTaskList), !dbg !1769
  store volatile ptr @xDelayedTaskList1, ptr @pxDelayedTaskList, align 4, !dbg !1770
  store volatile ptr @xDelayedTaskList2, ptr @pxOverflowDelayedTaskList, align 4, !dbg !1771
  ret void, !dbg !1772
}

declare dso_local void @vListInitialise(ptr noundef) #1

; Function Attrs: noinline nounwind
define internal void @prvCheckTasksWaitingTermination() #0 !dbg !1773 {
  %1 = alloca ptr, align 4
  br label %2, !dbg !1774

2:                                                ; preds = %5, %0
  %3 = load volatile i32, ptr @uxDeletedTasksWaitingCleanUp, align 4, !dbg !1775
  %4 = icmp ugt i32 %3, 0, !dbg !1776
  br i1 %4, label %5, label %17, !dbg !1774

5:                                                ; preds = %2
  call void @vPortEnterCritical(), !dbg !1777
  %6 = load ptr, ptr getelementptr inbounds (%struct.xLIST, ptr @xTasksWaitingTermination, i32 0, i32 2, i32 1), align 4, !dbg !1778
  %7 = getelementptr inbounds %struct.xLIST_ITEM, ptr %6, i32 0, i32 3, !dbg !1778
  %8 = load ptr, ptr %7, align 4, !dbg !1778
  store ptr %8, ptr %1, align 4, !dbg !1779
  %9 = load ptr, ptr %1, align 4, !dbg !1780
  %10 = getelementptr inbounds %struct.tskTaskControlBlock, ptr %9, i32 0, i32 1, !dbg !1781
  %11 = call i32 @uxListRemove(ptr noundef %10), !dbg !1782
  %12 = load volatile i32, ptr @uxCurrentNumberOfTasks, align 4, !dbg !1783
  %13 = add i32 %12, -1, !dbg !1783
  store volatile i32 %13, ptr @uxCurrentNumberOfTasks, align 4, !dbg !1783
  %14 = load volatile i32, ptr @uxDeletedTasksWaitingCleanUp, align 4, !dbg !1784
  %15 = add i32 %14, -1, !dbg !1784
  store volatile i32 %15, ptr @uxDeletedTasksWaitingCleanUp, align 4, !dbg !1784
  call void @vPortExitCritical(), !dbg !1785
  %16 = load ptr, ptr %1, align 4, !dbg !1786
  call void @prvDeleteTCB(ptr noundef %16), !dbg !1787
  br label %2, !dbg !1774, !llvm.loop !1788

17:                                               ; preds = %2
  ret void, !dbg !1790
}

attributes #0 = { noinline nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #2 = { argmemonly nocallback nofree nounwind willreturn writeonly }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "FreeRTOS/Source/tasks.c", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 1, !"min_enum_size", i32 4}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{!"clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)"}
!7 = distinct !DISubprogram(name: "vApplicationGetIdleTaskMemory", scope: !1, file: !1, line: 582, type: !8, scopeLine: 582, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!8 = !DISubroutineType(types: !9)
!9 = !{}
!10 = !DILocation(line: 583, column: 10, scope: !7)
!11 = !DILocation(line: 583, column: 33, scope: !7)
!12 = !DILocation(line: 584, column: 10, scope: !7)
!13 = !DILocation(line: 584, column: 33, scope: !7)
!14 = !DILocation(line: 585, column: 10, scope: !7)
!15 = !DILocation(line: 585, column: 33, scope: !7)
!16 = !DILocation(line: 586, column: 5, scope: !7)
!17 = distinct !DISubprogram(name: "xTaskCreateStatic", scope: !1, file: !1, line: 588, type: !8, scopeLine: 595, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!18 = !DILocation(line: 613, column: 15, scope: !17)
!19 = !DILocation(line: 613, column: 28, scope: !17)
!20 = !DILocation(line: 613, column: 38, scope: !17)
!21 = !DILocation(line: 613, column: 43, scope: !17)
!22 = !DILocation(line: 613, column: 58, scope: !17)
!23 = !DILocation(line: 613, column: 13, scope: !17)
!24 = !DILocation(line: 617, column: 36, scope: !17)
!25 = !DILocation(line: 617, column: 22, scope: !17)
!26 = !DILocation(line: 618, column: 51, scope: !17)
!27 = !DILocation(line: 618, column: 13, scope: !17)
!28 = !DILocation(line: 618, column: 23, scope: !17)
!29 = !DILocation(line: 618, column: 31, scope: !17)
!30 = !DILocation(line: 624, column: 21, scope: !17)
!31 = !DILocation(line: 624, column: 31, scope: !17)
!32 = !DILocation(line: 624, column: 53, scope: !17)
!33 = !DILocation(line: 628, column: 35, scope: !17)
!34 = !DILocation(line: 628, column: 47, scope: !17)
!35 = !DILocation(line: 628, column: 55, scope: !17)
!36 = !DILocation(line: 628, column: 69, scope: !17)
!37 = !DILocation(line: 628, column: 83, scope: !17)
!38 = !DILocation(line: 628, column: 105, scope: !17)
!39 = !DILocation(line: 628, column: 13, scope: !17)
!40 = !DILocation(line: 629, column: 39, scope: !17)
!41 = !DILocation(line: 629, column: 13, scope: !17)
!42 = !DILocation(line: 630, column: 9, scope: !17)
!43 = !DILocation(line: 633, column: 21, scope: !17)
!44 = !DILocation(line: 636, column: 16, scope: !17)
!45 = !DILocation(line: 636, column: 9, scope: !17)
!46 = distinct !DISubprogram(name: "prvInitialiseNewTask", scope: !1, file: !1, line: 832, type: !8, scopeLine: 840, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!47 = !DILocation(line: 863, column: 30, scope: !46)
!48 = !DILocation(line: 863, column: 40, scope: !46)
!49 = !DILocation(line: 863, column: 88, scope: !46)
!50 = !DILocation(line: 863, column: 101, scope: !46)
!51 = !DILocation(line: 863, column: 22, scope: !46)
!52 = !DILocation(line: 873, column: 31, scope: !46)
!53 = !DILocation(line: 873, column: 41, scope: !46)
!54 = !DILocation(line: 873, column: 50, scope: !46)
!55 = !DILocation(line: 873, column: 63, scope: !46)
!56 = !DILocation(line: 873, column: 26, scope: !46)
!57 = !DILocation(line: 874, column: 76, scope: !46)
!58 = !DILocation(line: 874, column: 50, scope: !46)
!59 = !DILocation(line: 874, column: 91, scope: !46)
!60 = !DILocation(line: 874, column: 28, scope: !46)
!61 = !DILocation(line: 874, column: 26, scope: !46)
!62 = !DILocation(line: 901, column: 9, scope: !46)
!63 = !DILocation(line: 901, column: 16, scope: !46)
!64 = !DILocation(line: 903, column: 16, scope: !46)
!65 = !DILocation(line: 903, column: 14, scope: !46)
!66 = !DILocation(line: 903, column: 37, scope: !46)
!67 = !DILocation(line: 903, column: 39, scope: !46)
!68 = !DILocation(line: 903, column: 9, scope: !46)
!69 = !DILocation(line: 905, column: 41, scope: !46)
!70 = !DILocation(line: 905, column: 49, scope: !46)
!71 = !DILocation(line: 905, column: 13, scope: !46)
!72 = !DILocation(line: 905, column: 23, scope: !46)
!73 = !DILocation(line: 905, column: 35, scope: !46)
!74 = !DILocation(line: 905, column: 39, scope: !46)
!75 = !DILocation(line: 910, column: 17, scope: !46)
!76 = !DILocation(line: 910, column: 25, scope: !46)
!77 = !DILocation(line: 910, column: 29, scope: !46)
!78 = !DILocation(line: 912, column: 17, scope: !46)
!79 = !DILocation(line: 918, column: 9, scope: !46)
!80 = !DILocation(line: 903, column: 83, scope: !46)
!81 = distinct !{!81, !68, !79, !82}
!82 = !{!"llvm.loop.mustprogress"}
!83 = !DILocation(line: 922, column: 9, scope: !46)
!84 = !DILocation(line: 922, column: 19, scope: !46)
!85 = !DILocation(line: 922, column: 61, scope: !46)
!86 = !DILocation(line: 923, column: 5, scope: !46)
!87 = !DILocation(line: 928, column: 9, scope: !46)
!88 = !DILocation(line: 928, column: 19, scope: !46)
!89 = !DILocation(line: 928, column: 35, scope: !46)
!90 = !DILocation(line: 934, column: 9, scope: !46)
!91 = !DILocation(line: 934, column: 20, scope: !46)
!92 = !DILocation(line: 936, column: 20, scope: !46)
!93 = !DILocation(line: 937, column: 5, scope: !46)
!94 = !DILocation(line: 943, column: 28, scope: !46)
!95 = !DILocation(line: 943, column: 5, scope: !46)
!96 = !DILocation(line: 943, column: 15, scope: !46)
!97 = !DILocation(line: 943, column: 26, scope: !46)
!98 = !DILocation(line: 946, column: 40, scope: !46)
!99 = !DILocation(line: 946, column: 13, scope: !46)
!100 = !DILocation(line: 946, column: 23, scope: !46)
!101 = !DILocation(line: 946, column: 38, scope: !46)
!102 = !DILocation(line: 947, column: 13, scope: !46)
!103 = !DILocation(line: 947, column: 23, scope: !46)
!104 = !DILocation(line: 947, column: 37, scope: !46)
!105 = !DILocation(line: 951, column: 29, scope: !46)
!106 = !DILocation(line: 951, column: 39, scope: !46)
!107 = !DILocation(line: 951, column: 5, scope: !46)
!108 = !DILocation(line: 952, column: 29, scope: !46)
!109 = !DILocation(line: 952, column: 39, scope: !46)
!110 = !DILocation(line: 952, column: 5, scope: !46)
!111 = !DILocation(line: 956, column: 5, scope: !46)
!112 = !DILocation(line: 959, column: 5, scope: !46)
!113 = !DILocation(line: 960, column: 5, scope: !46)
!114 = !DILocation(line: 987, column: 22, scope: !46)
!115 = !DILocation(line: 999, column: 35, scope: !46)
!116 = !DILocation(line: 999, column: 45, scope: !46)
!117 = !DILocation(line: 999, column: 13, scope: !46)
!118 = !DILocation(line: 1000, column: 35, scope: !46)
!119 = !DILocation(line: 1000, column: 45, scope: !46)
!120 = !DILocation(line: 1000, column: 13, scope: !46)
!121 = !DILocation(line: 1065, column: 69, scope: !46)
!122 = !DILocation(line: 1065, column: 83, scope: !46)
!123 = !DILocation(line: 1065, column: 95, scope: !46)
!124 = !DILocation(line: 1065, column: 46, scope: !46)
!125 = !DILocation(line: 1065, column: 21, scope: !46)
!126 = !DILocation(line: 1065, column: 31, scope: !46)
!127 = !DILocation(line: 1065, column: 44, scope: !46)
!128 = !DILocation(line: 1071, column: 9, scope: !46)
!129 = !DILocation(line: 1071, column: 23, scope: !46)
!130 = !DILocation(line: 1075, column: 43, scope: !46)
!131 = !DILocation(line: 1075, column: 10, scope: !46)
!132 = !DILocation(line: 1075, column: 24, scope: !46)
!133 = !DILocation(line: 1076, column: 5, scope: !46)
!134 = !DILocation(line: 1081, column: 1, scope: !46)
!135 = distinct !DISubprogram(name: "prvAddNewTaskToReadyList", scope: !1, file: !1, line: 1084, type: !8, scopeLine: 1085, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!136 = !DILocation(line: 1088, column: 5, scope: !135)
!137 = !DILocation(line: 1090, column: 31, scope: !135)
!138 = !DILocation(line: 1092, column: 13, scope: !135)
!139 = !DILocation(line: 1092, column: 26, scope: !135)
!140 = !DILocation(line: 1096, column: 28, scope: !135)
!141 = !DILocation(line: 1096, column: 26, scope: !135)
!142 = !DILocation(line: 1098, column: 17, scope: !135)
!143 = !DILocation(line: 1098, column: 40, scope: !135)
!144 = !DILocation(line: 1103, column: 17, scope: !135)
!145 = !DILocation(line: 1104, column: 13, scope: !135)
!146 = !DILocation(line: 1109, column: 9, scope: !135)
!147 = !DILocation(line: 1115, column: 17, scope: !135)
!148 = !DILocation(line: 1115, column: 35, scope: !135)
!149 = !DILocation(line: 1117, column: 21, scope: !135)
!150 = !DILocation(line: 1117, column: 35, scope: !135)
!151 = !DILocation(line: 1117, column: 49, scope: !135)
!152 = !DILocation(line: 1117, column: 59, scope: !135)
!153 = !DILocation(line: 1117, column: 46, scope: !135)
!154 = !DILocation(line: 1119, column: 36, scope: !135)
!155 = !DILocation(line: 1119, column: 34, scope: !135)
!156 = !DILocation(line: 1120, column: 17, scope: !135)
!157 = !DILocation(line: 1125, column: 13, scope: !135)
!158 = !DILocation(line: 1132, column: 21, scope: !135)
!159 = !DILocation(line: 1137, column: 41, scope: !135)
!160 = !DILocation(line: 1137, column: 17, scope: !135)
!161 = !DILocation(line: 1137, column: 27, scope: !135)
!162 = !DILocation(line: 1137, column: 39, scope: !135)
!163 = !DILocation(line: 1142, column: 9, scope: !135)
!164 = !DILocation(line: 1144, column: 9, scope: !135)
!165 = !DILocation(line: 1146, column: 5, scope: !135)
!166 = !DILocation(line: 1148, column: 9, scope: !135)
!167 = !DILocation(line: 1148, column: 27, scope: !135)
!168 = !DILocation(line: 1152, column: 13, scope: !135)
!169 = !DILocation(line: 1152, column: 27, scope: !135)
!170 = !DILocation(line: 1152, column: 40, scope: !135)
!171 = !DILocation(line: 1152, column: 50, scope: !135)
!172 = !DILocation(line: 1152, column: 38, scope: !135)
!173 = !DILocation(line: 1154, column: 13, scope: !135)
!174 = !{i64 2148284884}
!175 = !{i64 2148284954}
!176 = !DILocation(line: 1155, column: 9, scope: !135)
!177 = !DILocation(line: 1160, column: 5, scope: !135)
!178 = !DILocation(line: 1165, column: 1, scope: !135)
!179 = distinct !DISubprogram(name: "xTaskCreate", scope: !1, file: !1, line: 741, type: !8, scopeLine: 747, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!180 = !DILocation(line: 781, column: 61, scope: !179)
!181 = !DILocation(line: 781, column: 50, scope: !179)
!182 = !DILocation(line: 781, column: 76, scope: !179)
!183 = !DILocation(line: 781, column: 27, scope: !179)
!184 = !DILocation(line: 781, column: 25, scope: !179)
!185 = !DILocation(line: 783, column: 21, scope: !179)
!186 = !DILocation(line: 783, column: 29, scope: !179)
!187 = !DILocation(line: 786, column: 44, scope: !179)
!188 = !DILocation(line: 786, column: 30, scope: !179)
!189 = !DILocation(line: 788, column: 25, scope: !179)
!190 = !DILocation(line: 788, column: 34, scope: !179)
!191 = !DILocation(line: 791, column: 45, scope: !179)
!192 = !DILocation(line: 791, column: 25, scope: !179)
!193 = !DILocation(line: 791, column: 35, scope: !179)
!194 = !DILocation(line: 791, column: 43, scope: !179)
!195 = !DILocation(line: 792, column: 21, scope: !179)
!196 = !DILocation(line: 797, column: 41, scope: !179)
!197 = !DILocation(line: 797, column: 25, scope: !179)
!198 = !DILocation(line: 799, column: 17, scope: !179)
!199 = !DILocation(line: 802, column: 30, scope: !179)
!200 = !DILocation(line: 807, column: 13, scope: !179)
!201 = !DILocation(line: 807, column: 22, scope: !179)
!202 = !DILocation(line: 813, column: 21, scope: !179)
!203 = !DILocation(line: 813, column: 31, scope: !179)
!204 = !DILocation(line: 813, column: 53, scope: !179)
!205 = !DILocation(line: 817, column: 35, scope: !179)
!206 = !DILocation(line: 817, column: 47, scope: !179)
!207 = !DILocation(line: 817, column: 68, scope: !179)
!208 = !DILocation(line: 817, column: 55, scope: !179)
!209 = !DILocation(line: 817, column: 82, scope: !179)
!210 = !DILocation(line: 817, column: 96, scope: !179)
!211 = !DILocation(line: 817, column: 108, scope: !179)
!212 = !DILocation(line: 817, column: 123, scope: !179)
!213 = !DILocation(line: 817, column: 13, scope: !179)
!214 = !DILocation(line: 818, column: 39, scope: !179)
!215 = !DILocation(line: 818, column: 13, scope: !179)
!216 = !DILocation(line: 819, column: 21, scope: !179)
!217 = !DILocation(line: 820, column: 9, scope: !179)
!218 = !DILocation(line: 823, column: 21, scope: !179)
!219 = !DILocation(line: 826, column: 16, scope: !179)
!220 = !DILocation(line: 826, column: 9, scope: !179)
!221 = distinct !DISubprogram(name: "vTaskDelete", scope: !1, file: !1, line: 1170, type: !8, scopeLine: 1171, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!222 = !DILocation(line: 1174, column: 9, scope: !221)
!223 = !DILocation(line: 1178, column: 21, scope: !221)
!224 = !DILocation(line: 1178, column: 19, scope: !221)
!225 = !DILocation(line: 1181, column: 34, scope: !221)
!226 = !DILocation(line: 1181, column: 41, scope: !221)
!227 = !DILocation(line: 1181, column: 17, scope: !221)
!228 = !DILocation(line: 1181, column: 60, scope: !221)
!229 = !DILocation(line: 1184, column: 13, scope: !221)
!230 = !DILocation(line: 1191, column: 17, scope: !221)
!231 = !DILocation(line: 1191, column: 71, scope: !221)
!232 = !DILocation(line: 1193, column: 43, scope: !221)
!233 = !DILocation(line: 1193, column: 50, scope: !221)
!234 = !DILocation(line: 1193, column: 26, scope: !221)
!235 = !DILocation(line: 1194, column: 13, scope: !221)
!236 = !DILocation(line: 1204, column: 25, scope: !221)
!237 = !DILocation(line: 1206, column: 17, scope: !221)
!238 = !DILocation(line: 1206, column: 26, scope: !221)
!239 = !DILocation(line: 1206, column: 23, scope: !221)
!240 = !DILocation(line: 1213, column: 63, scope: !221)
!241 = !DILocation(line: 1213, column: 70, scope: !221)
!242 = !DILocation(line: 1213, column: 17, scope: !221)
!243 = !DILocation(line: 1218, column: 17, scope: !221)
!244 = !DILocation(line: 1230, column: 13, scope: !221)
!245 = !DILocation(line: 1233, column: 17, scope: !221)
!246 = !DILocation(line: 1238, column: 17, scope: !221)
!247 = !DILocation(line: 1241, column: 9, scope: !221)
!248 = !DILocation(line: 1246, column: 13, scope: !221)
!249 = !DILocation(line: 1246, column: 22, scope: !221)
!250 = !DILocation(line: 1246, column: 19, scope: !221)
!251 = !DILocation(line: 1248, column: 27, scope: !221)
!252 = !DILocation(line: 1248, column: 13, scope: !221)
!253 = !DILocation(line: 1249, column: 9, scope: !221)
!254 = !DILocation(line: 1253, column: 13, scope: !221)
!255 = !DILocation(line: 1253, column: 31, scope: !221)
!256 = !DILocation(line: 1255, column: 17, scope: !221)
!257 = !DILocation(line: 1255, column: 26, scope: !221)
!258 = !DILocation(line: 1255, column: 23, scope: !221)
!259 = !DILocation(line: 1258, column: 17, scope: !221)
!260 = !{i64 2148285773}
!261 = !{i64 2148285843}
!262 = !DILocation(line: 1259, column: 13, scope: !221)
!263 = !DILocation(line: 1264, column: 9, scope: !221)
!264 = !DILocation(line: 1265, column: 5, scope: !221)
!265 = distinct !DISubprogram(name: "prvResetNextTaskUnblockTime", scope: !1, file: !1, line: 4019, type: !8, scopeLine: 4020, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!266 = !DILocation(line: 4021, column: 9, scope: !265)
!267 = !DILocation(line: 4021, column: 48, scope: !265)
!268 = !DILocation(line: 4027, column: 30, scope: !265)
!269 = !DILocation(line: 4028, column: 5, scope: !265)
!270 = !DILocation(line: 4035, column: 32, scope: !265)
!271 = !DILocation(line: 4035, column: 30, scope: !265)
!272 = !DILocation(line: 4037, column: 1, scope: !265)
!273 = distinct !DISubprogram(name: "prvDeleteTCB", scope: !1, file: !1, line: 3963, type: !8, scopeLine: 3964, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!274 = !DILocation(line: 3968, column: 9, scope: !273)
!275 = !DILocation(line: 3992, column: 21, scope: !273)
!276 = !DILocation(line: 3992, column: 28, scope: !273)
!277 = !DILocation(line: 3992, column: 50, scope: !273)
!278 = !DILocation(line: 3996, column: 37, scope: !273)
!279 = !DILocation(line: 3996, column: 44, scope: !273)
!280 = !DILocation(line: 3996, column: 21, scope: !273)
!281 = !DILocation(line: 3997, column: 32, scope: !273)
!282 = !DILocation(line: 3997, column: 21, scope: !273)
!283 = !DILocation(line: 3998, column: 17, scope: !273)
!284 = !DILocation(line: 3999, column: 26, scope: !273)
!285 = !DILocation(line: 3999, column: 33, scope: !273)
!286 = !DILocation(line: 3999, column: 55, scope: !273)
!287 = !DILocation(line: 4003, column: 32, scope: !273)
!288 = !DILocation(line: 4003, column: 21, scope: !273)
!289 = !DILocation(line: 4004, column: 17, scope: !273)
!290 = !DILocation(line: 4014, column: 5, scope: !273)
!291 = distinct !DISubprogram(name: "xTaskDelayUntil", scope: !1, file: !1, line: 1272, type: !8, scopeLine: 1274, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!292 = !DILocation(line: 1276, column: 37, scope: !291)
!293 = !DILocation(line: 1282, column: 9, scope: !291)
!294 = !DILocation(line: 1286, column: 48, scope: !291)
!295 = !DILocation(line: 1286, column: 30, scope: !291)
!296 = !DILocation(line: 1289, column: 28, scope: !291)
!297 = !DILocation(line: 1289, column: 27, scope: !291)
!298 = !DILocation(line: 1289, column: 49, scope: !291)
!299 = !DILocation(line: 1289, column: 47, scope: !291)
!300 = !DILocation(line: 1289, column: 25, scope: !291)
!301 = !DILocation(line: 1291, column: 17, scope: !291)
!302 = !DILocation(line: 1291, column: 36, scope: !291)
!303 = !DILocation(line: 1291, column: 35, scope: !291)
!304 = !DILocation(line: 1291, column: 33, scope: !291)
!305 = !DILocation(line: 1298, column: 23, scope: !291)
!306 = !DILocation(line: 1298, column: 38, scope: !291)
!307 = !DILocation(line: 1298, column: 37, scope: !291)
!308 = !DILocation(line: 1298, column: 35, scope: !291)
!309 = !DILocation(line: 1298, column: 59, scope: !291)
!310 = !DILocation(line: 1298, column: 64, scope: !291)
!311 = !DILocation(line: 1298, column: 78, scope: !291)
!312 = !DILocation(line: 1298, column: 76, scope: !291)
!313 = !DILocation(line: 1298, column: 21, scope: !291)
!314 = !DILocation(line: 1300, column: 34, scope: !291)
!315 = !DILocation(line: 1301, column: 17, scope: !291)
!316 = !DILocation(line: 1306, column: 13, scope: !291)
!317 = !DILocation(line: 1312, column: 23, scope: !291)
!318 = !DILocation(line: 1312, column: 38, scope: !291)
!319 = !DILocation(line: 1312, column: 37, scope: !291)
!320 = !DILocation(line: 1312, column: 35, scope: !291)
!321 = !DILocation(line: 1312, column: 59, scope: !291)
!322 = !DILocation(line: 1312, column: 64, scope: !291)
!323 = !DILocation(line: 1312, column: 78, scope: !291)
!324 = !DILocation(line: 1312, column: 76, scope: !291)
!325 = !DILocation(line: 1312, column: 21, scope: !291)
!326 = !DILocation(line: 1314, column: 34, scope: !291)
!327 = !DILocation(line: 1315, column: 17, scope: !291)
!328 = !DILocation(line: 1323, column: 35, scope: !291)
!329 = !DILocation(line: 1323, column: 14, scope: !291)
!330 = !DILocation(line: 1323, column: 33, scope: !291)
!331 = !DILocation(line: 1325, column: 17, scope: !291)
!332 = !DILocation(line: 1325, column: 30, scope: !291)
!333 = !DILocation(line: 1331, column: 49, scope: !291)
!334 = !DILocation(line: 1331, column: 63, scope: !291)
!335 = !DILocation(line: 1331, column: 61, scope: !291)
!336 = !DILocation(line: 1331, column: 17, scope: !291)
!337 = !DILocation(line: 1332, column: 13, scope: !291)
!338 = !DILocation(line: 1338, column: 27, scope: !291)
!339 = !DILocation(line: 1338, column: 25, scope: !291)
!340 = !DILocation(line: 1342, column: 13, scope: !291)
!341 = !DILocation(line: 1342, column: 29, scope: !291)
!342 = !DILocation(line: 1344, column: 13, scope: !291)
!343 = !{i64 2148286529}
!344 = !{i64 2148286599}
!345 = !DILocation(line: 1345, column: 9, scope: !291)
!346 = !DILocation(line: 1351, column: 16, scope: !291)
!347 = !DILocation(line: 1351, column: 9, scope: !291)
!348 = distinct !DISubprogram(name: "vTaskSuspendAll", scope: !1, file: !1, line: 2149, type: !8, scopeLine: 2150, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!349 = !DILocation(line: 2162, column: 5, scope: !348)
!350 = !DILocation(line: 2166, column: 5, scope: !348)
!351 = !{i64 2148300314}
!352 = !DILocation(line: 2167, column: 1, scope: !348)
!353 = distinct !DISubprogram(name: "prvAddCurrentTaskToDelayedList", scope: !1, file: !1, line: 5323, type: !8, scopeLine: 5325, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!354 = !DILocation(line: 5327, column: 40, scope: !353)
!355 = !DILocation(line: 5327, column: 22, scope: !353)
!356 = !DILocation(line: 5340, column: 26, scope: !353)
!357 = !DILocation(line: 5340, column: 40, scope: !353)
!358 = !DILocation(line: 5340, column: 9, scope: !353)
!359 = !DILocation(line: 5340, column: 59, scope: !353)
!360 = !DILocation(line: 5345, column: 5, scope: !353)
!361 = !DILocation(line: 5353, column: 19, scope: !353)
!362 = !DILocation(line: 5353, column: 32, scope: !353)
!363 = !DILocation(line: 5353, column: 51, scope: !353)
!364 = !DILocation(line: 5353, column: 56, scope: !353)
!365 = !DILocation(line: 5353, column: 78, scope: !353)
!366 = !DILocation(line: 5353, column: 17, scope: !353)
!367 = !DILocation(line: 5358, column: 17, scope: !353)
!368 = !DILocation(line: 5359, column: 13, scope: !353)
!369 = !DILocation(line: 5365, column: 31, scope: !353)
!370 = !DILocation(line: 5365, column: 49, scope: !353)
!371 = !DILocation(line: 5365, column: 47, scope: !353)
!372 = !DILocation(line: 5365, column: 29, scope: !353)
!373 = !DILocation(line: 5368, column: 17, scope: !353)
!374 = !DILocation(line: 5370, column: 21, scope: !353)
!375 = !DILocation(line: 5370, column: 35, scope: !353)
!376 = !DILocation(line: 5370, column: 33, scope: !353)
!377 = !DILocation(line: 5374, column: 34, scope: !353)
!378 = !DILocation(line: 5374, column: 64, scope: !353)
!379 = !DILocation(line: 5374, column: 78, scope: !353)
!380 = !DILocation(line: 5374, column: 21, scope: !353)
!381 = !DILocation(line: 5375, column: 17, scope: !353)
!382 = !DILocation(line: 5380, column: 34, scope: !353)
!383 = !DILocation(line: 5380, column: 56, scope: !353)
!384 = !DILocation(line: 5380, column: 70, scope: !353)
!385 = !DILocation(line: 5380, column: 21, scope: !353)
!386 = !DILocation(line: 5385, column: 25, scope: !353)
!387 = !DILocation(line: 5385, column: 39, scope: !353)
!388 = !DILocation(line: 5385, column: 37, scope: !353)
!389 = !DILocation(line: 5387, column: 48, scope: !353)
!390 = !DILocation(line: 5387, column: 46, scope: !353)
!391 = !DILocation(line: 5388, column: 21, scope: !353)
!392 = !DILocation(line: 5433, column: 1, scope: !353)
!393 = distinct !DISubprogram(name: "xTaskResumeAll", scope: !1, file: !1, line: 2233, type: !8, scopeLine: 2234, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!394 = !DILocation(line: 2235, column: 13, scope: !393)
!395 = !DILocation(line: 2236, column: 16, scope: !393)
!396 = !DILocation(line: 2247, column: 5, scope: !393)
!397 = !DILocation(line: 2249, column: 9, scope: !393)
!398 = !DILocation(line: 2251, column: 13, scope: !393)
!399 = !DILocation(line: 2251, column: 34, scope: !393)
!400 = !DILocation(line: 2253, column: 17, scope: !393)
!401 = !DILocation(line: 2253, column: 40, scope: !393)
!402 = !DILocation(line: 2257, column: 17, scope: !393)
!403 = !DILocation(line: 2257, column: 24, scope: !393)
!404 = !DILocation(line: 2257, column: 64, scope: !393)
!405 = !DILocation(line: 2259, column: 29, scope: !393)
!406 = !DILocation(line: 2259, column: 27, scope: !393)
!407 = !DILocation(line: 2260, column: 21, scope: !393)
!408 = !DILocation(line: 2261, column: 21, scope: !393)
!409 = !{i64 2148302154}
!410 = !DILocation(line: 2262, column: 21, scope: !393)
!411 = !DILocation(line: 2263, column: 21, scope: !393)
!412 = !DILocation(line: 2267, column: 25, scope: !393)
!413 = !DILocation(line: 2267, column: 32, scope: !393)
!414 = !DILocation(line: 2267, column: 46, scope: !393)
!415 = !DILocation(line: 2267, column: 60, scope: !393)
!416 = !DILocation(line: 2267, column: 43, scope: !393)
!417 = !DILocation(line: 2269, column: 39, scope: !393)
!418 = !DILocation(line: 2270, column: 21, scope: !393)
!419 = distinct !{!419, !402, !420, !82}
!420 = !DILocation(line: 2275, column: 17, scope: !393)
!421 = !DILocation(line: 2277, column: 21, scope: !393)
!422 = !DILocation(line: 2277, column: 27, scope: !393)
!423 = !DILocation(line: 2285, column: 21, scope: !393)
!424 = !DILocation(line: 2286, column: 17, scope: !393)
!425 = !DILocation(line: 2293, column: 48, scope: !393)
!426 = !DILocation(line: 2293, column: 32, scope: !393)
!427 = !DILocation(line: 2295, column: 25, scope: !393)
!428 = !DILocation(line: 2295, column: 39, scope: !393)
!429 = !DILocation(line: 2297, column: 25, scope: !393)
!430 = !DILocation(line: 2299, column: 33, scope: !393)
!431 = !DILocation(line: 2299, column: 54, scope: !393)
!432 = !DILocation(line: 2301, column: 47, scope: !393)
!433 = !DILocation(line: 2302, column: 29, scope: !393)
!434 = !DILocation(line: 2308, column: 29, scope: !393)
!435 = !DILocation(line: 2309, column: 25, scope: !393)
!436 = !DILocation(line: 2309, column: 34, scope: !393)
!437 = !DILocation(line: 2309, column: 48, scope: !393)
!438 = distinct !{!438, !429, !439, !82}
!439 = !DILocation(line: 2309, column: 68, scope: !393)
!440 = !DILocation(line: 2311, column: 38, scope: !393)
!441 = !DILocation(line: 2312, column: 21, scope: !393)
!442 = !DILocation(line: 2319, column: 21, scope: !393)
!443 = !DILocation(line: 2319, column: 35, scope: !393)
!444 = !DILocation(line: 2323, column: 45, scope: !393)
!445 = !DILocation(line: 2326, column: 21, scope: !393)
!446 = !{i64 2148306878}
!447 = !{i64 2148306948}
!448 = !DILocation(line: 2327, column: 17, scope: !393)
!449 = !DILocation(line: 2332, column: 13, scope: !393)
!450 = !DILocation(line: 2333, column: 9, scope: !393)
!451 = !DILocation(line: 2339, column: 5, scope: !393)
!452 = !DILocation(line: 2341, column: 12, scope: !393)
!453 = !DILocation(line: 2341, column: 5, scope: !393)
!454 = distinct !DISubprogram(name: "vTaskDelay", scope: !1, file: !1, line: 1359, type: !8, scopeLine: 1360, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!455 = !DILocation(line: 1361, column: 20, scope: !454)
!456 = !DILocation(line: 1364, column: 13, scope: !454)
!457 = !DILocation(line: 1364, column: 27, scope: !454)
!458 = !DILocation(line: 1367, column: 13, scope: !454)
!459 = !DILocation(line: 1378, column: 49, scope: !454)
!460 = !DILocation(line: 1378, column: 17, scope: !454)
!461 = !DILocation(line: 1380, column: 31, scope: !454)
!462 = !DILocation(line: 1380, column: 29, scope: !454)
!463 = !DILocation(line: 1381, column: 9, scope: !454)
!464 = !DILocation(line: 1389, column: 13, scope: !454)
!465 = !DILocation(line: 1389, column: 29, scope: !454)
!466 = !DILocation(line: 1391, column: 13, scope: !454)
!467 = !{i64 2148287198}
!468 = !{i64 2148287268}
!469 = !DILocation(line: 1392, column: 9, scope: !454)
!470 = !DILocation(line: 1397, column: 5, scope: !454)
!471 = distinct !DISubprogram(name: "eTaskGetState", scope: !1, file: !1, line: 1404, type: !8, scopeLine: 1405, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!472 = !DILocation(line: 1408, column: 37, scope: !471)
!473 = !DILocation(line: 1408, column: 29, scope: !471)
!474 = !DILocation(line: 1412, column: 13, scope: !471)
!475 = !DILocation(line: 1412, column: 22, scope: !471)
!476 = !DILocation(line: 1412, column: 19, scope: !471)
!477 = !DILocation(line: 1415, column: 21, scope: !471)
!478 = !DILocation(line: 1416, column: 9, scope: !471)
!479 = !DILocation(line: 1419, column: 13, scope: !471)
!480 = !DILocation(line: 1421, column: 31, scope: !471)
!481 = !DILocation(line: 1421, column: 29, scope: !471)
!482 = !DILocation(line: 1422, column: 33, scope: !471)
!483 = !DILocation(line: 1422, column: 31, scope: !471)
!484 = !DILocation(line: 1423, column: 43, scope: !471)
!485 = !DILocation(line: 1423, column: 41, scope: !471)
!486 = !DILocation(line: 1425, column: 13, scope: !471)
!487 = !DILocation(line: 1427, column: 19, scope: !471)
!488 = !DILocation(line: 1427, column: 34, scope: !471)
!489 = !DILocation(line: 1427, column: 31, scope: !471)
!490 = !DILocation(line: 1427, column: 50, scope: !471)
!491 = !DILocation(line: 1427, column: 55, scope: !471)
!492 = !DILocation(line: 1427, column: 70, scope: !471)
!493 = !DILocation(line: 1427, column: 67, scope: !471)
!494 = !DILocation(line: 1427, column: 17, scope: !471)
!495 = !DILocation(line: 1431, column: 25, scope: !471)
!496 = !DILocation(line: 1432, column: 13, scope: !471)
!497 = !DILocation(line: 1435, column: 26, scope: !471)
!498 = !DILocation(line: 1435, column: 38, scope: !471)
!499 = !DILocation(line: 1440, column: 25, scope: !471)
!500 = !DILocation(line: 1440, column: 79, scope: !471)
!501 = !DILocation(line: 1451, column: 41, scope: !471)
!502 = !DILocation(line: 1453, column: 40, scope: !471)
!503 = !DILocation(line: 1453, column: 38, scope: !471)
!504 = !DILocation(line: 1453, column: 45, scope: !471)
!505 = !DILocation(line: 1453, column: 47, scope: !471)
!506 = !DILocation(line: 1453, column: 33, scope: !471)
!507 = !DILocation(line: 1455, column: 41, scope: !471)
!508 = !DILocation(line: 1455, column: 48, scope: !471)
!509 = !DILocation(line: 1455, column: 63, scope: !471)
!510 = !DILocation(line: 1455, column: 67, scope: !471)
!511 = !DILocation(line: 1457, column: 49, scope: !471)
!512 = !DILocation(line: 1458, column: 41, scope: !471)
!513 = !DILocation(line: 1460, column: 33, scope: !471)
!514 = !DILocation(line: 1453, column: 89, scope: !471)
!515 = distinct !{!515, !506, !513, !82}
!516 = !DILocation(line: 1467, column: 21, scope: !471)
!517 = !DILocation(line: 1470, column: 33, scope: !471)
!518 = !DILocation(line: 1472, column: 17, scope: !471)
!519 = !DILocation(line: 1476, column: 28, scope: !471)
!520 = !DILocation(line: 1476, column: 40, scope: !471)
!521 = !DILocation(line: 1476, column: 71, scope: !471)
!522 = !DILocation(line: 1476, column: 76, scope: !471)
!523 = !DILocation(line: 1476, column: 88, scope: !471)
!524 = !DILocation(line: 1476, column: 26, scope: !471)
!525 = !DILocation(line: 1481, column: 29, scope: !471)
!526 = !DILocation(line: 1482, column: 17, scope: !471)
!527 = !DILocation(line: 1489, column: 25, scope: !471)
!528 = !DILocation(line: 1493, column: 16, scope: !471)
!529 = !DILocation(line: 1493, column: 9, scope: !471)
!530 = distinct !DISubprogram(name: "uxTaskPriorityGet", scope: !1, file: !1, line: 1501, type: !8, scopeLine: 1502, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!531 = !DILocation(line: 1506, column: 9, scope: !530)
!532 = !DILocation(line: 1510, column: 21, scope: !530)
!533 = !DILocation(line: 1510, column: 19, scope: !530)
!534 = !DILocation(line: 1511, column: 24, scope: !530)
!535 = !DILocation(line: 1511, column: 31, scope: !530)
!536 = !DILocation(line: 1511, column: 22, scope: !530)
!537 = !DILocation(line: 1513, column: 9, scope: !530)
!538 = !DILocation(line: 1515, column: 16, scope: !530)
!539 = !DILocation(line: 1515, column: 9, scope: !530)
!540 = distinct !DISubprogram(name: "uxTaskPriorityGetFromISR", scope: !1, file: !1, line: 1523, type: !8, scopeLine: 1524, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!541 = !DILocation(line: 216, column: 9, scope: !542, inlinedAt: !544)
!542 = distinct !DISubprogram(name: "ulPortRaiseBASEPRI", scope: !543, file: !543, line: 212, type: !8, scopeLine: 213, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!543 = !DIFile(filename: "FreeRTOS/Source/portable/GCC/ARM_CM3/portmacro.h", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!544 = distinct !DILocation(line: 1546, column: 33, scope: !540)
!545 = !{i64 548790, i64 548837, i64 548879, i64 548925, i64 548962}
!546 = !DILocation(line: 228, column: 16, scope: !542, inlinedAt: !544)
!547 = !DILocation(line: 1546, column: 31, scope: !540)
!548 = !DILocation(line: 1550, column: 21, scope: !540)
!549 = !DILocation(line: 1550, column: 19, scope: !540)
!550 = !DILocation(line: 1551, column: 24, scope: !540)
!551 = !DILocation(line: 1551, column: 31, scope: !540)
!552 = !DILocation(line: 1551, column: 22, scope: !540)
!553 = !DILocation(line: 1553, column: 9, scope: !540)
!554 = !DILocation(line: 236, column: 40, scope: !555, inlinedAt: !556)
!555 = distinct !DISubprogram(name: "vPortSetBASEPRI", scope: !543, file: !543, line: 232, type: !8, scopeLine: 233, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!556 = distinct !DILocation(line: 1553, column: 9, scope: !540)
!557 = !DILocation(line: 234, column: 9, scope: !555, inlinedAt: !556)
!558 = !{i64 549469}
!559 = !DILocation(line: 1555, column: 16, scope: !540)
!560 = !DILocation(line: 1555, column: 9, scope: !540)
!561 = distinct !DISubprogram(name: "vTaskPrioritySet", scope: !1, file: !1, line: 1563, type: !8, scopeLine: 1565, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!562 = !DILocation(line: 1568, column: 20, scope: !561)
!563 = !DILocation(line: 1573, column: 13, scope: !561)
!564 = !DILocation(line: 1573, column: 27, scope: !561)
!565 = !DILocation(line: 1575, column: 27, scope: !561)
!566 = !DILocation(line: 1576, column: 9, scope: !561)
!567 = !DILocation(line: 1582, column: 9, scope: !561)
!568 = !DILocation(line: 1586, column: 21, scope: !561)
!569 = !DILocation(line: 1586, column: 19, scope: !561)
!570 = !DILocation(line: 1592, column: 45, scope: !561)
!571 = !DILocation(line: 1592, column: 52, scope: !561)
!572 = !DILocation(line: 1592, column: 43, scope: !561)
!573 = !DILocation(line: 1600, column: 17, scope: !561)
!574 = !DILocation(line: 1600, column: 42, scope: !561)
!575 = !DILocation(line: 1600, column: 39, scope: !561)
!576 = !DILocation(line: 1604, column: 21, scope: !561)
!577 = !DILocation(line: 1604, column: 37, scope: !561)
!578 = !DILocation(line: 1604, column: 35, scope: !561)
!579 = !DILocation(line: 1606, column: 25, scope: !561)
!580 = !DILocation(line: 1606, column: 34, scope: !561)
!581 = !DILocation(line: 1606, column: 31, scope: !561)
!582 = !DILocation(line: 1611, column: 29, scope: !561)
!583 = !DILocation(line: 1611, column: 46, scope: !561)
!584 = !DILocation(line: 1611, column: 60, scope: !561)
!585 = !DILocation(line: 1611, column: 43, scope: !561)
!586 = !DILocation(line: 1613, column: 44, scope: !561)
!587 = !DILocation(line: 1614, column: 25, scope: !561)
!588 = !DILocation(line: 1619, column: 21, scope: !561)
!589 = !DILocation(line: 1626, column: 17, scope: !561)
!590 = !DILocation(line: 1627, column: 26, scope: !561)
!591 = !DILocation(line: 1627, column: 35, scope: !561)
!592 = !DILocation(line: 1627, column: 32, scope: !561)
!593 = !DILocation(line: 1632, column: 36, scope: !561)
!594 = !DILocation(line: 1633, column: 17, scope: !561)
!595 = !DILocation(line: 1644, column: 41, scope: !561)
!596 = !DILocation(line: 1644, column: 48, scope: !561)
!597 = !DILocation(line: 1644, column: 39, scope: !561)
!598 = !DILocation(line: 1650, column: 29, scope: !561)
!599 = !DILocation(line: 1650, column: 36, scope: !561)
!600 = !DILocation(line: 1650, column: 54, scope: !561)
!601 = !DILocation(line: 1650, column: 61, scope: !561)
!602 = !DILocation(line: 1650, column: 51, scope: !561)
!603 = !DILocation(line: 1652, column: 49, scope: !561)
!604 = !DILocation(line: 1652, column: 29, scope: !561)
!605 = !DILocation(line: 1652, column: 36, scope: !561)
!606 = !DILocation(line: 1652, column: 47, scope: !561)
!607 = !DILocation(line: 1653, column: 25, scope: !561)
!608 = !DILocation(line: 1660, column: 49, scope: !561)
!609 = !DILocation(line: 1660, column: 25, scope: !561)
!610 = !DILocation(line: 1660, column: 32, scope: !561)
!611 = !DILocation(line: 1660, column: 47, scope: !561)
!612 = !DILocation(line: 1670, column: 23, scope: !561)
!613 = !DILocation(line: 1670, column: 77, scope: !561)
!614 = !DILocation(line: 1670, column: 114, scope: !561)
!615 = !DILocation(line: 1670, column: 21, scope: !561)
!616 = !DILocation(line: 1672, column: 21, scope: !561)
!617 = !DILocation(line: 1673, column: 17, scope: !561)
!618 = !DILocation(line: 1683, column: 21, scope: !561)
!619 = !DILocation(line: 1683, column: 124, scope: !561)
!620 = !DILocation(line: 1688, column: 42, scope: !561)
!621 = !DILocation(line: 1688, column: 49, scope: !561)
!622 = !DILocation(line: 1688, column: 25, scope: !561)
!623 = !DILocation(line: 1688, column: 68, scope: !561)
!624 = !DILocation(line: 1694, column: 21, scope: !561)
!625 = !DILocation(line: 1700, column: 21, scope: !561)
!626 = !DILocation(line: 1701, column: 17, scope: !561)
!627 = !DILocation(line: 1707, column: 21, scope: !561)
!628 = !DILocation(line: 1707, column: 36, scope: !561)
!629 = !DILocation(line: 1709, column: 21, scope: !561)
!630 = !{i64 2148291744}
!631 = !{i64 2148291814}
!632 = !DILocation(line: 1710, column: 17, scope: !561)
!633 = !DILocation(line: 1718, column: 26, scope: !561)
!634 = !DILocation(line: 1719, column: 13, scope: !561)
!635 = !DILocation(line: 1721, column: 9, scope: !561)
!636 = !DILocation(line: 1722, column: 5, scope: !561)
!637 = distinct !DISubprogram(name: "vTaskSuspend", scope: !1, file: !1, line: 1729, type: !8, scopeLine: 1730, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!638 = !DILocation(line: 1733, column: 9, scope: !637)
!639 = !DILocation(line: 1737, column: 21, scope: !637)
!640 = !DILocation(line: 1737, column: 19, scope: !637)
!641 = !DILocation(line: 1743, column: 34, scope: !637)
!642 = !DILocation(line: 1743, column: 41, scope: !637)
!643 = !DILocation(line: 1743, column: 17, scope: !637)
!644 = !DILocation(line: 1743, column: 60, scope: !637)
!645 = !DILocation(line: 1746, column: 13, scope: !637)
!646 = !DILocation(line: 1753, column: 17, scope: !637)
!647 = !DILocation(line: 1753, column: 71, scope: !637)
!648 = !DILocation(line: 1755, column: 43, scope: !637)
!649 = !DILocation(line: 1755, column: 50, scope: !637)
!650 = !DILocation(line: 1755, column: 26, scope: !637)
!651 = !DILocation(line: 1756, column: 13, scope: !637)
!652 = !DILocation(line: 1762, column: 53, scope: !637)
!653 = !DILocation(line: 1762, column: 60, scope: !637)
!654 = !DILocation(line: 1762, column: 13, scope: !637)
!655 = !DILocation(line: 1768, column: 28, scope: !637)
!656 = !DILocation(line: 1768, column: 26, scope: !637)
!657 = !DILocation(line: 1768, column: 33, scope: !637)
!658 = !DILocation(line: 1768, column: 35, scope: !637)
!659 = !DILocation(line: 1768, column: 21, scope: !637)
!660 = !DILocation(line: 1770, column: 29, scope: !637)
!661 = !DILocation(line: 1770, column: 36, scope: !637)
!662 = !DILocation(line: 1770, column: 51, scope: !637)
!663 = !DILocation(line: 1770, column: 55, scope: !637)
!664 = !DILocation(line: 1774, column: 29, scope: !637)
!665 = !DILocation(line: 1774, column: 36, scope: !637)
!666 = !DILocation(line: 1774, column: 51, scope: !637)
!667 = !DILocation(line: 1774, column: 55, scope: !637)
!668 = !DILocation(line: 1775, column: 25, scope: !637)
!669 = !DILocation(line: 1776, column: 21, scope: !637)
!670 = !DILocation(line: 1768, column: 77, scope: !637)
!671 = distinct !{!671, !659, !669, !82}
!672 = !DILocation(line: 1780, column: 9, scope: !637)
!673 = !DILocation(line: 1782, column: 13, scope: !637)
!674 = !DILocation(line: 1782, column: 31, scope: !637)
!675 = !DILocation(line: 1786, column: 13, scope: !637)
!676 = !DILocation(line: 1788, column: 17, scope: !637)
!677 = !DILocation(line: 1790, column: 13, scope: !637)
!678 = !DILocation(line: 1791, column: 9, scope: !637)
!679 = !DILocation(line: 1797, column: 13, scope: !637)
!680 = !DILocation(line: 1797, column: 22, scope: !637)
!681 = !DILocation(line: 1797, column: 19, scope: !637)
!682 = !DILocation(line: 1799, column: 17, scope: !637)
!683 = !DILocation(line: 1799, column: 35, scope: !637)
!684 = !DILocation(line: 1803, column: 17, scope: !637)
!685 = !{i64 2148292818}
!686 = !{i64 2148292888}
!687 = !DILocation(line: 1804, column: 13, scope: !637)
!688 = !DILocation(line: 1810, column: 21, scope: !637)
!689 = !DILocation(line: 1810, column: 71, scope: !637)
!690 = !DILocation(line: 1810, column: 68, scope: !637)
!691 = !DILocation(line: 1816, column: 34, scope: !637)
!692 = !DILocation(line: 1817, column: 17, scope: !637)
!693 = !DILocation(line: 1820, column: 21, scope: !637)
!694 = !DILocation(line: 1823, column: 9, scope: !637)
!695 = !DILocation(line: 1828, column: 5, scope: !637)
!696 = distinct !DISubprogram(name: "vTaskSwitchContext", scope: !1, file: !1, line: 3034, type: !8, scopeLine: 3035, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!697 = !DILocation(line: 3036, column: 9, scope: !696)
!698 = !DILocation(line: 3036, column: 30, scope: !696)
!699 = !DILocation(line: 3040, column: 23, scope: !696)
!700 = !DILocation(line: 3041, column: 5, scope: !696)
!701 = !DILocation(line: 3044, column: 23, scope: !696)
!702 = !DILocation(line: 3087, column: 9, scope: !696)
!703 = distinct !{!703, !702, !702, !82}
!704 = !DILocation(line: 3107, column: 1, scope: !696)
!705 = distinct !DISubprogram(name: "vTaskResume", scope: !1, file: !1, line: 1881, type: !8, scopeLine: 1882, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!706 = !DILocation(line: 1883, column: 31, scope: !705)
!707 = !DILocation(line: 1883, column: 23, scope: !705)
!708 = !DILocation(line: 1890, column: 15, scope: !705)
!709 = !DILocation(line: 1890, column: 24, scope: !705)
!710 = !DILocation(line: 1890, column: 21, scope: !705)
!711 = !DILocation(line: 1890, column: 39, scope: !705)
!712 = !DILocation(line: 1890, column: 44, scope: !705)
!713 = !DILocation(line: 1890, column: 50, scope: !705)
!714 = !DILocation(line: 1890, column: 13, scope: !705)
!715 = !DILocation(line: 1892, column: 13, scope: !705)
!716 = !DILocation(line: 1894, column: 45, scope: !705)
!717 = !DILocation(line: 1894, column: 21, scope: !705)
!718 = !DILocation(line: 1894, column: 53, scope: !705)
!719 = !DILocation(line: 1900, column: 47, scope: !705)
!720 = !DILocation(line: 1900, column: 54, scope: !705)
!721 = !DILocation(line: 1900, column: 30, scope: !705)
!722 = !DILocation(line: 1901, column: 21, scope: !705)
!723 = !DILocation(line: 1904, column: 25, scope: !705)
!724 = !DILocation(line: 1904, column: 32, scope: !705)
!725 = !DILocation(line: 1904, column: 46, scope: !705)
!726 = !DILocation(line: 1904, column: 60, scope: !705)
!727 = !DILocation(line: 1904, column: 43, scope: !705)
!728 = !DILocation(line: 1909, column: 25, scope: !705)
!729 = !{i64 2148296892}
!730 = !{i64 2148296962}
!731 = !DILocation(line: 1910, column: 21, scope: !705)
!732 = !DILocation(line: 1915, column: 17, scope: !705)
!733 = !DILocation(line: 1921, column: 13, scope: !705)
!734 = !DILocation(line: 1922, column: 9, scope: !705)
!735 = !DILocation(line: 1927, column: 5, scope: !705)
!736 = distinct !DISubprogram(name: "prvTaskIsTaskSuspended", scope: !1, file: !1, line: 1835, type: !8, scopeLine: 1836, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!737 = !DILocation(line: 1837, column: 20, scope: !736)
!738 = !DILocation(line: 1838, column: 37, scope: !736)
!739 = !DILocation(line: 1838, column: 29, scope: !736)
!740 = !DILocation(line: 1847, column: 13, scope: !736)
!741 = !DILocation(line: 1847, column: 88, scope: !736)
!742 = !DILocation(line: 1850, column: 17, scope: !736)
!743 = !DILocation(line: 1850, column: 91, scope: !736)
!744 = !DILocation(line: 1854, column: 21, scope: !736)
!745 = !DILocation(line: 1854, column: 81, scope: !736)
!746 = !DILocation(line: 1856, column: 29, scope: !736)
!747 = !DILocation(line: 1857, column: 17, scope: !736)
!748 = !DILocation(line: 1862, column: 13, scope: !736)
!749 = !DILocation(line: 1867, column: 9, scope: !736)
!750 = !DILocation(line: 1873, column: 16, scope: !736)
!751 = !DILocation(line: 1873, column: 9, scope: !736)
!752 = distinct !DISubprogram(name: "xTaskResumeFromISR", scope: !1, file: !1, line: 1935, type: !8, scopeLine: 1936, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!753 = !DILocation(line: 1937, column: 20, scope: !752)
!754 = !DILocation(line: 1938, column: 31, scope: !752)
!755 = !DILocation(line: 1938, column: 23, scope: !752)
!756 = !DILocation(line: 216, column: 9, scope: !542, inlinedAt: !757)
!757 = distinct !DILocation(line: 1961, column: 34, scope: !752)
!758 = !DILocation(line: 228, column: 16, scope: !542, inlinedAt: !757)
!759 = !DILocation(line: 1961, column: 32, scope: !752)
!760 = !DILocation(line: 1963, column: 41, scope: !752)
!761 = !DILocation(line: 1963, column: 17, scope: !752)
!762 = !DILocation(line: 1963, column: 49, scope: !752)
!763 = !DILocation(line: 1968, column: 21, scope: !752)
!764 = !DILocation(line: 1968, column: 42, scope: !752)
!765 = !DILocation(line: 1972, column: 25, scope: !752)
!766 = !DILocation(line: 1972, column: 32, scope: !752)
!767 = !DILocation(line: 1972, column: 46, scope: !752)
!768 = !DILocation(line: 1972, column: 60, scope: !752)
!769 = !DILocation(line: 1972, column: 43, scope: !752)
!770 = !DILocation(line: 1974, column: 40, scope: !752)
!771 = !DILocation(line: 1979, column: 39, scope: !752)
!772 = !DILocation(line: 1980, column: 21, scope: !752)
!773 = !DILocation(line: 1986, column: 47, scope: !752)
!774 = !DILocation(line: 1986, column: 54, scope: !752)
!775 = !DILocation(line: 1986, column: 30, scope: !752)
!776 = !DILocation(line: 1987, column: 21, scope: !752)
!777 = !DILocation(line: 1988, column: 17, scope: !752)
!778 = !DILocation(line: 1994, column: 64, scope: !752)
!779 = !DILocation(line: 1994, column: 71, scope: !752)
!780 = !DILocation(line: 1994, column: 21, scope: !752)
!781 = !DILocation(line: 1996, column: 13, scope: !752)
!782 = !DILocation(line: 2002, column: 9, scope: !752)
!783 = !DILocation(line: 236, column: 40, scope: !555, inlinedAt: !784)
!784 = distinct !DILocation(line: 2002, column: 9, scope: !752)
!785 = !DILocation(line: 234, column: 9, scope: !555, inlinedAt: !784)
!786 = !DILocation(line: 2004, column: 16, scope: !752)
!787 = !DILocation(line: 2004, column: 9, scope: !752)
!788 = distinct !DISubprogram(name: "vTaskStartScheduler", scope: !1, file: !1, line: 2010, type: !8, scopeLine: 2011, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!789 = !DILocation(line: 2017, column: 28, scope: !788)
!790 = !DILocation(line: 2018, column: 27, scope: !788)
!791 = !DILocation(line: 2023, column: 13, scope: !788)
!792 = !DILocation(line: 2026, column: 50, scope: !788)
!793 = !DILocation(line: 2029, column: 50, scope: !788)
!794 = !DILocation(line: 2030, column: 50, scope: !788)
!795 = !DILocation(line: 2024, column: 31, scope: !788)
!796 = !DILocation(line: 2024, column: 29, scope: !788)
!797 = !DILocation(line: 2032, column: 17, scope: !788)
!798 = !DILocation(line: 2032, column: 33, scope: !788)
!799 = !DILocation(line: 2034, column: 25, scope: !788)
!800 = !DILocation(line: 2035, column: 13, scope: !788)
!801 = !DILocation(line: 2038, column: 25, scope: !788)
!802 = !DILocation(line: 2055, column: 17, scope: !788)
!803 = !DILocation(line: 2055, column: 25, scope: !788)
!804 = !DILocation(line: 2057, column: 27, scope: !788)
!805 = !DILocation(line: 2057, column: 25, scope: !788)
!806 = !DILocation(line: 2058, column: 13, scope: !788)
!807 = !DILocation(line: 2066, column: 9, scope: !788)
!808 = !DILocation(line: 2066, column: 17, scope: !788)
!809 = !DILocation(line: 200, column: 9, scope: !810, inlinedAt: !811)
!810 = distinct !DISubprogram(name: "vPortRaiseBASEPRI", scope: !543, file: !543, line: 196, type: !8, scopeLine: 197, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!811 = distinct !DILocation(line: 2082, column: 9, scope: !788)
!812 = !{i64 548285, i64 548328, i64 548374, i64 548411}
!813 = !DILocation(line: 2094, column: 30, scope: !788)
!814 = !DILocation(line: 2095, column: 27, scope: !788)
!815 = !DILocation(line: 2096, column: 20, scope: !788)
!816 = !DILocation(line: 2110, column: 13, scope: !788)
!817 = !DILocation(line: 2110, column: 35, scope: !788)
!818 = !DILocation(line: 2114, column: 9, scope: !788)
!819 = !DILocation(line: 2119, column: 5, scope: !788)
!820 = !DILocation(line: 2130, column: 14, scope: !788)
!821 = !DILocation(line: 2134, column: 14, scope: !788)
!822 = !DILocation(line: 2135, column: 1, scope: !788)
!823 = distinct !DISubprogram(name: "prvIdleTask", scope: !1, file: !1, line: 3454, type: !8, scopeLine: 3455, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!824 = !DILocation(line: 3457, column: 14, scope: !823)
!825 = !DILocation(line: 3467, column: 5, scope: !823)
!826 = !DILocation(line: 3471, column: 9, scope: !823)
!827 = !DILocation(line: 3494, column: 21, scope: !823)
!828 = !DILocation(line: 3494, column: 91, scope: !823)
!829 = !DILocation(line: 3496, column: 21, scope: !823)
!830 = !{i64 2148335582}
!831 = !{i64 2148335652}
!832 = !DILocation(line: 3497, column: 17, scope: !823)
!833 = distinct !{!833, !825, !834}
!834 = !DILocation(line: 3567, column: 5, scope: !823)
!835 = distinct !DISubprogram(name: "vTaskEndScheduler", scope: !1, file: !1, line: 2138, type: !8, scopeLine: 2139, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!836 = !DILocation(line: 200, column: 9, scope: !810, inlinedAt: !837)
!837 = distinct !DILocation(line: 2143, column: 5, scope: !835)
!838 = !DILocation(line: 2144, column: 23, scope: !835)
!839 = !DILocation(line: 2145, column: 5, scope: !835)
!840 = !DILocation(line: 2146, column: 1, scope: !835)
!841 = distinct !DISubprogram(name: "xTaskIncrementTick", scope: !1, file: !1, line: 2749, type: !8, scopeLine: 2750, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!842 = !DILocation(line: 2753, column: 16, scope: !841)
!843 = !DILocation(line: 2760, column: 9, scope: !841)
!844 = !DILocation(line: 2760, column: 30, scope: !841)
!845 = !DILocation(line: 2764, column: 44, scope: !841)
!846 = !DILocation(line: 2764, column: 55, scope: !841)
!847 = !DILocation(line: 2764, column: 26, scope: !841)
!848 = !DILocation(line: 2768, column: 22, scope: !841)
!849 = !DILocation(line: 2768, column: 20, scope: !841)
!850 = !DILocation(line: 2770, column: 13, scope: !841)
!851 = !DILocation(line: 2770, column: 29, scope: !841)
!852 = !DILocation(line: 2772, column: 13, scope: !841)
!853 = !DILocation(line: 2773, column: 9, scope: !841)
!854 = !DILocation(line: 2783, column: 13, scope: !841)
!855 = !DILocation(line: 2783, column: 32, scope: !841)
!856 = !DILocation(line: 2783, column: 29, scope: !841)
!857 = !DILocation(line: 2785, column: 13, scope: !841)
!858 = !DILocation(line: 2787, column: 21, scope: !841)
!859 = !DILocation(line: 2787, column: 60, scope: !841)
!860 = !DILocation(line: 2794, column: 42, scope: !841)
!861 = !DILocation(line: 2795, column: 21, scope: !841)
!862 = !DILocation(line: 2803, column: 29, scope: !841)
!863 = !DILocation(line: 2803, column: 27, scope: !841)
!864 = !DILocation(line: 2804, column: 34, scope: !841)
!865 = !DILocation(line: 2804, column: 32, scope: !841)
!866 = !DILocation(line: 2806, column: 25, scope: !841)
!867 = !DILocation(line: 2806, column: 43, scope: !841)
!868 = !DILocation(line: 2806, column: 41, scope: !841)
!869 = !DILocation(line: 2813, column: 48, scope: !841)
!870 = !DILocation(line: 2813, column: 46, scope: !841)
!871 = !DILocation(line: 2814, column: 25, scope: !841)
!872 = !DILocation(line: 2822, column: 21, scope: !841)
!873 = !DILocation(line: 2826, column: 25, scope: !841)
!874 = !DILocation(line: 2826, column: 79, scope: !841)
!875 = !DILocation(line: 2828, column: 25, scope: !841)
!876 = !DILocation(line: 2829, column: 21, scope: !841)
!877 = !DILocation(line: 2837, column: 21, scope: !841)
!878 = !DILocation(line: 2847, column: 33, scope: !841)
!879 = !DILocation(line: 2847, column: 40, scope: !841)
!880 = !DILocation(line: 2847, column: 54, scope: !841)
!881 = !DILocation(line: 2847, column: 68, scope: !841)
!882 = !DILocation(line: 2847, column: 51, scope: !841)
!883 = !DILocation(line: 2849, column: 49, scope: !841)
!884 = !DILocation(line: 2850, column: 29, scope: !841)
!885 = distinct !{!885, !857, !886}
!886 = !DILocation(line: 2858, column: 13, scope: !841)
!887 = !DILocation(line: 2859, column: 9, scope: !841)
!888 = !DILocation(line: 2866, column: 21, scope: !841)
!889 = !DILocation(line: 2866, column: 99, scope: !841)
!890 = !DILocation(line: 2868, column: 37, scope: !841)
!891 = !DILocation(line: 2869, column: 17, scope: !841)
!892 = !DILocation(line: 2894, column: 21, scope: !841)
!893 = !DILocation(line: 2894, column: 35, scope: !841)
!894 = !DILocation(line: 2896, column: 37, scope: !841)
!895 = !DILocation(line: 2897, column: 17, scope: !841)
!896 = !DILocation(line: 2904, column: 5, scope: !841)
!897 = !DILocation(line: 2907, column: 9, scope: !841)
!898 = !DILocation(line: 2918, column: 12, scope: !841)
!899 = !DILocation(line: 2918, column: 5, scope: !841)
!900 = distinct !DISubprogram(name: "xTaskGetTickCount", scope: !1, file: !1, line: 2345, type: !8, scopeLine: 2346, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!901 = !DILocation(line: 2352, column: 18, scope: !900)
!902 = !DILocation(line: 2352, column: 16, scope: !900)
!903 = !DILocation(line: 2356, column: 12, scope: !900)
!904 = !DILocation(line: 2356, column: 5, scope: !900)
!905 = distinct !DISubprogram(name: "xTaskGetTickCountFromISR", scope: !1, file: !1, line: 2360, type: !8, scopeLine: 2361, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!906 = !DILocation(line: 2381, column: 28, scope: !905)
!907 = !DILocation(line: 2383, column: 19, scope: !905)
!908 = !DILocation(line: 2383, column: 17, scope: !905)
!909 = !DILocation(line: 2385, column: 5, scope: !905)
!910 = !DILocation(line: 2387, column: 12, scope: !905)
!911 = !DILocation(line: 2387, column: 5, scope: !905)
!912 = distinct !DISubprogram(name: "uxTaskGetNumberOfTasks", scope: !1, file: !1, line: 2391, type: !8, scopeLine: 2392, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!913 = !DILocation(line: 2395, column: 12, scope: !912)
!914 = !DILocation(line: 2395, column: 5, scope: !912)
!915 = distinct !DISubprogram(name: "pcTaskGetName", scope: !1, file: !1, line: 2399, type: !8, scopeLine: 2400, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!916 = !DILocation(line: 2405, column: 13, scope: !915)
!917 = !DILocation(line: 2405, column: 11, scope: !915)
!918 = !DILocation(line: 2407, column: 15, scope: !915)
!919 = !DILocation(line: 2407, column: 22, scope: !915)
!920 = !DILocation(line: 2407, column: 5, scope: !915)
!921 = distinct !DISubprogram(name: "uxTaskGetSystemState", scope: !1, file: !1, line: 2546, type: !8, scopeLine: 2549, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!922 = !DILocation(line: 2550, column: 21, scope: !921)
!923 = !DILocation(line: 2550, column: 33, scope: !921)
!924 = !DILocation(line: 2552, column: 9, scope: !921)
!925 = !DILocation(line: 2555, column: 17, scope: !921)
!926 = !DILocation(line: 2555, column: 32, scope: !921)
!927 = !DILocation(line: 2555, column: 29, scope: !921)
!928 = !DILocation(line: 2559, column: 17, scope: !921)
!929 = !DILocation(line: 2561, column: 28, scope: !921)
!930 = !DILocation(line: 2562, column: 64, scope: !921)
!931 = !DILocation(line: 2562, column: 83, scope: !921)
!932 = !DILocation(line: 2562, column: 117, scope: !921)
!933 = !DILocation(line: 2562, column: 98, scope: !921)
!934 = !DILocation(line: 2562, column: 31, scope: !921)
!935 = !DILocation(line: 2562, column: 28, scope: !921)
!936 = !DILocation(line: 2563, column: 17, scope: !921)
!937 = !DILocation(line: 2563, column: 26, scope: !921)
!938 = !DILocation(line: 2563, column: 34, scope: !921)
!939 = distinct !{!939, !928, !940, !82}
!940 = !DILocation(line: 2563, column: 69, scope: !921)
!941 = !DILocation(line: 2567, column: 60, scope: !921)
!942 = !DILocation(line: 2567, column: 79, scope: !921)
!943 = !DILocation(line: 2567, column: 104, scope: !921)
!944 = !DILocation(line: 2567, column: 27, scope: !921)
!945 = !DILocation(line: 2567, column: 24, scope: !921)
!946 = !DILocation(line: 2568, column: 60, scope: !921)
!947 = !DILocation(line: 2568, column: 79, scope: !921)
!948 = !DILocation(line: 2568, column: 104, scope: !921)
!949 = !DILocation(line: 2568, column: 27, scope: !921)
!950 = !DILocation(line: 2568, column: 24, scope: !921)
!951 = !DILocation(line: 2574, column: 68, scope: !921)
!952 = !DILocation(line: 2574, column: 87, scope: !921)
!953 = !DILocation(line: 2574, column: 35, scope: !921)
!954 = !DILocation(line: 2574, column: 32, scope: !921)
!955 = !DILocation(line: 2582, column: 68, scope: !921)
!956 = !DILocation(line: 2582, column: 87, scope: !921)
!957 = !DILocation(line: 2582, column: 35, scope: !921)
!958 = !DILocation(line: 2582, column: 32, scope: !921)
!959 = !DILocation(line: 2599, column: 29, scope: !921)
!960 = !DILocation(line: 2599, column: 45, scope: !921)
!961 = !DILocation(line: 2601, column: 30, scope: !921)
!962 = !DILocation(line: 2601, column: 46, scope: !921)
!963 = !DILocation(line: 2602, column: 25, scope: !921)
!964 = !DILocation(line: 2605, column: 13, scope: !921)
!965 = !DILocation(line: 2611, column: 18, scope: !921)
!966 = !DILocation(line: 2613, column: 16, scope: !921)
!967 = !DILocation(line: 2613, column: 9, scope: !921)
!968 = distinct !DISubprogram(name: "prvListTasksWithinSingleList", scope: !1, file: !1, line: 3840, type: !8, scopeLine: 3843, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!969 = !DILocation(line: 3845, column: 21, scope: !968)
!970 = !DILocation(line: 3847, column: 13, scope: !968)
!971 = !DILocation(line: 3847, column: 47, scope: !968)
!972 = !DILocation(line: 3849, column: 13, scope: !968)
!973 = !DILocation(line: 3855, column: 13, scope: !968)
!974 = !DILocation(line: 3857, column: 17, scope: !968)
!975 = !DILocation(line: 3858, column: 48, scope: !968)
!976 = !DILocation(line: 3858, column: 62, scope: !968)
!977 = !DILocation(line: 3858, column: 81, scope: !968)
!978 = !DILocation(line: 3858, column: 101, scope: !968)
!979 = !DILocation(line: 3858, column: 17, scope: !968)
!980 = !DILocation(line: 3859, column: 23, scope: !968)
!981 = !DILocation(line: 3860, column: 13, scope: !968)
!982 = !DILocation(line: 3860, column: 22, scope: !968)
!983 = !DILocation(line: 3860, column: 35, scope: !968)
!984 = !DILocation(line: 3860, column: 32, scope: !968)
!985 = distinct !{!985, !973, !986, !82}
!986 = !DILocation(line: 3860, column: 46, scope: !968)
!987 = !DILocation(line: 3861, column: 9, scope: !968)
!988 = !DILocation(line: 3867, column: 16, scope: !968)
!989 = !DILocation(line: 3867, column: 9, scope: !968)
!990 = distinct !DISubprogram(name: "xTaskCatchUpTicks", scope: !1, file: !1, line: 2651, type: !8, scopeLine: 2652, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!991 = !DILocation(line: 2661, column: 5, scope: !990)
!992 = !DILocation(line: 2662, column: 21, scope: !990)
!993 = !DILocation(line: 2662, column: 18, scope: !990)
!994 = !DILocation(line: 2663, column: 22, scope: !990)
!995 = !DILocation(line: 2663, column: 20, scope: !990)
!996 = !DILocation(line: 2665, column: 12, scope: !990)
!997 = !DILocation(line: 2665, column: 5, scope: !990)
!998 = distinct !DISubprogram(name: "vTaskPlaceOnEventList", scope: !1, file: !1, line: 3110, type: !8, scopeLine: 3112, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!999 = !DILocation(line: 3129, column: 18, scope: !998)
!1000 = !DILocation(line: 3129, column: 34, scope: !998)
!1001 = !DILocation(line: 3129, column: 48, scope: !998)
!1002 = !DILocation(line: 3129, column: 5, scope: !998)
!1003 = !DILocation(line: 3131, column: 37, scope: !998)
!1004 = !DILocation(line: 3131, column: 5, scope: !998)
!1005 = !DILocation(line: 3132, column: 1, scope: !998)
!1006 = distinct !DISubprogram(name: "vTaskPlaceOnUnorderedEventList", scope: !1, file: !1, line: 3135, type: !8, scopeLine: 3138, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1007 = !DILocation(line: 3148, column: 5, scope: !1006)
!1008 = !DILocation(line: 3155, column: 5, scope: !1006)
!1009 = !DILocation(line: 3157, column: 37, scope: !1006)
!1010 = !DILocation(line: 3157, column: 5, scope: !1006)
!1011 = !DILocation(line: 3158, column: 1, scope: !1006)
!1012 = distinct !DISubprogram(name: "vTaskPlaceOnEventListRestricted", scope: !1, file: !1, line: 3163, type: !8, scopeLine: 3166, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1013 = !DILocation(line: 3179, column: 9, scope: !1012)
!1014 = !DILocation(line: 3184, column: 13, scope: !1012)
!1015 = !DILocation(line: 3184, column: 31, scope: !1012)
!1016 = !DILocation(line: 3186, column: 26, scope: !1012)
!1017 = !DILocation(line: 3187, column: 9, scope: !1012)
!1018 = !DILocation(line: 3190, column: 41, scope: !1012)
!1019 = !DILocation(line: 3190, column: 55, scope: !1012)
!1020 = !DILocation(line: 3190, column: 9, scope: !1012)
!1021 = !DILocation(line: 3191, column: 5, scope: !1012)
!1022 = distinct !DISubprogram(name: "xTaskRemoveFromEventList", scope: !1, file: !1, line: 3196, type: !8, scopeLine: 3197, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1023 = !DILocation(line: 3214, column: 22, scope: !1022)
!1024 = !DILocation(line: 3214, column: 20, scope: !1022)
!1025 = !DILocation(line: 3216, column: 5, scope: !1022)
!1026 = !DILocation(line: 3218, column: 9, scope: !1022)
!1027 = !DILocation(line: 3218, column: 30, scope: !1022)
!1028 = !DILocation(line: 3220, column: 9, scope: !1022)
!1029 = !DILocation(line: 3221, column: 9, scope: !1022)
!1030 = !DILocation(line: 3236, column: 5, scope: !1022)
!1031 = !DILocation(line: 3241, column: 9, scope: !1022)
!1032 = !DILocation(line: 3244, column: 9, scope: !1022)
!1033 = !DILocation(line: 3244, column: 25, scope: !1022)
!1034 = !DILocation(line: 3244, column: 38, scope: !1022)
!1035 = !DILocation(line: 3244, column: 52, scope: !1022)
!1036 = !DILocation(line: 3244, column: 36, scope: !1022)
!1037 = !DILocation(line: 3249, column: 17, scope: !1022)
!1038 = !DILocation(line: 3253, column: 23, scope: !1022)
!1039 = !DILocation(line: 3254, column: 5, scope: !1022)
!1040 = !DILocation(line: 3257, column: 17, scope: !1022)
!1041 = !DILocation(line: 3260, column: 12, scope: !1022)
!1042 = !DILocation(line: 3260, column: 5, scope: !1022)
!1043 = distinct !DISubprogram(name: "vTaskRemoveFromUnorderedEventList", scope: !1, file: !1, line: 3264, type: !8, scopeLine: 3266, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1044 = !DILocation(line: 3274, column: 5, scope: !1043)
!1045 = !DILocation(line: 3278, column: 22, scope: !1043)
!1046 = !DILocation(line: 3278, column: 20, scope: !1043)
!1047 = !DILocation(line: 3280, column: 5, scope: !1043)
!1048 = !DILocation(line: 3299, column: 5, scope: !1043)
!1049 = !DILocation(line: 3300, column: 5, scope: !1043)
!1050 = !DILocation(line: 3302, column: 9, scope: !1043)
!1051 = !DILocation(line: 3302, column: 25, scope: !1043)
!1052 = !DILocation(line: 3302, column: 38, scope: !1043)
!1053 = !DILocation(line: 3302, column: 52, scope: !1043)
!1054 = !DILocation(line: 3302, column: 36, scope: !1043)
!1055 = !DILocation(line: 3308, column: 23, scope: !1043)
!1056 = !DILocation(line: 3309, column: 5, scope: !1043)
!1057 = !DILocation(line: 3310, column: 1, scope: !1043)
!1058 = distinct !DISubprogram(name: "vTaskSetTimeOutState", scope: !1, file: !1, line: 3313, type: !8, scopeLine: 3314, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1059 = !DILocation(line: 3316, column: 5, scope: !1058)
!1060 = !DILocation(line: 3318, column: 37, scope: !1058)
!1061 = !DILocation(line: 3318, column: 9, scope: !1058)
!1062 = !DILocation(line: 3318, column: 20, scope: !1058)
!1063 = !DILocation(line: 3318, column: 35, scope: !1058)
!1064 = !DILocation(line: 3319, column: 38, scope: !1058)
!1065 = !DILocation(line: 3319, column: 9, scope: !1058)
!1066 = !DILocation(line: 3319, column: 20, scope: !1058)
!1067 = !DILocation(line: 3319, column: 36, scope: !1058)
!1068 = !DILocation(line: 3321, column: 5, scope: !1058)
!1069 = !DILocation(line: 3322, column: 1, scope: !1058)
!1070 = distinct !DISubprogram(name: "vTaskInternalSetTimeOutState", scope: !1, file: !1, line: 3325, type: !8, scopeLine: 3326, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1071 = !DILocation(line: 3328, column: 33, scope: !1070)
!1072 = !DILocation(line: 3328, column: 5, scope: !1070)
!1073 = !DILocation(line: 3328, column: 16, scope: !1070)
!1074 = !DILocation(line: 3328, column: 31, scope: !1070)
!1075 = !DILocation(line: 3329, column: 34, scope: !1070)
!1076 = !DILocation(line: 3329, column: 5, scope: !1070)
!1077 = !DILocation(line: 3329, column: 16, scope: !1070)
!1078 = !DILocation(line: 3329, column: 32, scope: !1070)
!1079 = !DILocation(line: 3330, column: 1, scope: !1070)
!1080 = distinct !DISubprogram(name: "xTaskCheckForTimeOut", scope: !1, file: !1, line: 3333, type: !8, scopeLine: 3335, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1081 = !DILocation(line: 3341, column: 5, scope: !1080)
!1082 = !DILocation(line: 3344, column: 44, scope: !1080)
!1083 = !DILocation(line: 3344, column: 26, scope: !1080)
!1084 = !DILocation(line: 3345, column: 41, scope: !1080)
!1085 = !DILocation(line: 3345, column: 59, scope: !1080)
!1086 = !DILocation(line: 3345, column: 70, scope: !1080)
!1087 = !DILocation(line: 3345, column: 57, scope: !1080)
!1088 = !DILocation(line: 3345, column: 26, scope: !1080)
!1089 = !DILocation(line: 3359, column: 18, scope: !1080)
!1090 = !DILocation(line: 3359, column: 17, scope: !1080)
!1091 = !DILocation(line: 3359, column: 32, scope: !1080)
!1092 = !DILocation(line: 3364, column: 25, scope: !1080)
!1093 = !DILocation(line: 3365, column: 13, scope: !1080)
!1094 = !DILocation(line: 3369, column: 15, scope: !1080)
!1095 = !DILocation(line: 3369, column: 34, scope: !1080)
!1096 = !DILocation(line: 3369, column: 45, scope: !1080)
!1097 = !DILocation(line: 3369, column: 31, scope: !1080)
!1098 = !DILocation(line: 3369, column: 62, scope: !1080)
!1099 = !DILocation(line: 3369, column: 67, scope: !1080)
!1100 = !DILocation(line: 3369, column: 86, scope: !1080)
!1101 = !DILocation(line: 3369, column: 97, scope: !1080)
!1102 = !DILocation(line: 3369, column: 83, scope: !1080)
!1103 = !DILocation(line: 3369, column: 13, scope: !1080)
!1104 = !DILocation(line: 3376, column: 21, scope: !1080)
!1105 = !DILocation(line: 3377, column: 14, scope: !1080)
!1106 = !DILocation(line: 3377, column: 28, scope: !1080)
!1107 = !DILocation(line: 3378, column: 9, scope: !1080)
!1108 = !DILocation(line: 3379, column: 18, scope: !1080)
!1109 = !DILocation(line: 3379, column: 34, scope: !1080)
!1110 = !DILocation(line: 3379, column: 33, scope: !1080)
!1111 = !DILocation(line: 3379, column: 31, scope: !1080)
!1112 = !DILocation(line: 3382, column: 31, scope: !1080)
!1113 = !DILocation(line: 3382, column: 14, scope: !1080)
!1114 = !DILocation(line: 3382, column: 28, scope: !1080)
!1115 = !DILocation(line: 3383, column: 43, scope: !1080)
!1116 = !DILocation(line: 3383, column: 13, scope: !1080)
!1117 = !DILocation(line: 3384, column: 21, scope: !1080)
!1118 = !DILocation(line: 3385, column: 9, scope: !1080)
!1119 = !DILocation(line: 3388, column: 14, scope: !1080)
!1120 = !DILocation(line: 3388, column: 28, scope: !1080)
!1121 = !DILocation(line: 3389, column: 21, scope: !1080)
!1122 = !DILocation(line: 3392, column: 5, scope: !1080)
!1123 = !DILocation(line: 3394, column: 12, scope: !1080)
!1124 = !DILocation(line: 3394, column: 5, scope: !1080)
!1125 = distinct !DISubprogram(name: "vTaskMissedYield", scope: !1, file: !1, line: 3398, type: !8, scopeLine: 3399, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1126 = !DILocation(line: 3400, column: 19, scope: !1125)
!1127 = !DILocation(line: 3401, column: 1, scope: !1125)
!1128 = distinct !DISubprogram(name: "uxTaskGetTaskNumber", scope: !1, file: !1, line: 3406, type: !8, scopeLine: 3407, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1129 = !DILocation(line: 3411, column: 13, scope: !1128)
!1130 = !DILocation(line: 3411, column: 19, scope: !1128)
!1131 = !DILocation(line: 3413, column: 21, scope: !1128)
!1132 = !DILocation(line: 3413, column: 19, scope: !1128)
!1133 = !DILocation(line: 3414, column: 24, scope: !1128)
!1134 = !DILocation(line: 3414, column: 31, scope: !1128)
!1135 = !DILocation(line: 3414, column: 22, scope: !1128)
!1136 = !DILocation(line: 3415, column: 9, scope: !1128)
!1137 = !DILocation(line: 3418, column: 22, scope: !1128)
!1138 = !DILocation(line: 3421, column: 16, scope: !1128)
!1139 = !DILocation(line: 3421, column: 9, scope: !1128)
!1140 = distinct !DISubprogram(name: "vTaskSetTaskNumber", scope: !1, file: !1, line: 3429, type: !8, scopeLine: 3431, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1141 = !DILocation(line: 3434, column: 13, scope: !1140)
!1142 = !DILocation(line: 3434, column: 19, scope: !1140)
!1143 = !DILocation(line: 3436, column: 21, scope: !1140)
!1144 = !DILocation(line: 3436, column: 19, scope: !1140)
!1145 = !DILocation(line: 3437, column: 35, scope: !1140)
!1146 = !DILocation(line: 3437, column: 13, scope: !1140)
!1147 = !DILocation(line: 3437, column: 20, scope: !1140)
!1148 = !DILocation(line: 3437, column: 33, scope: !1140)
!1149 = !DILocation(line: 3438, column: 9, scope: !1140)
!1150 = !DILocation(line: 3439, column: 5, scope: !1140)
!1151 = distinct !DISubprogram(name: "vTaskGetInfo", scope: !1, file: !1, line: 3741, type: !8, scopeLine: 3745, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1152 = !DILocation(line: 3749, column: 17, scope: !1151)
!1153 = !DILocation(line: 3749, column: 15, scope: !1151)
!1154 = !DILocation(line: 3751, column: 50, scope: !1151)
!1155 = !DILocation(line: 3751, column: 9, scope: !1151)
!1156 = !DILocation(line: 3751, column: 23, scope: !1151)
!1157 = !DILocation(line: 3751, column: 31, scope: !1151)
!1158 = !DILocation(line: 3752, column: 56, scope: !1151)
!1159 = !DILocation(line: 3752, column: 63, scope: !1151)
!1160 = !DILocation(line: 3752, column: 9, scope: !1151)
!1161 = !DILocation(line: 3752, column: 23, scope: !1151)
!1162 = !DILocation(line: 3752, column: 34, scope: !1151)
!1163 = !DILocation(line: 3753, column: 43, scope: !1151)
!1164 = !DILocation(line: 3753, column: 50, scope: !1151)
!1165 = !DILocation(line: 3753, column: 9, scope: !1151)
!1166 = !DILocation(line: 3753, column: 23, scope: !1151)
!1167 = !DILocation(line: 3753, column: 41, scope: !1151)
!1168 = !DILocation(line: 3754, column: 37, scope: !1151)
!1169 = !DILocation(line: 3754, column: 44, scope: !1151)
!1170 = !DILocation(line: 3754, column: 9, scope: !1151)
!1171 = !DILocation(line: 3754, column: 23, scope: !1151)
!1172 = !DILocation(line: 3754, column: 35, scope: !1151)
!1173 = !DILocation(line: 3755, column: 37, scope: !1151)
!1174 = !DILocation(line: 3755, column: 44, scope: !1151)
!1175 = !DILocation(line: 3755, column: 9, scope: !1151)
!1176 = !DILocation(line: 3755, column: 23, scope: !1151)
!1177 = !DILocation(line: 3755, column: 35, scope: !1151)
!1178 = !DILocation(line: 3759, column: 48, scope: !1151)
!1179 = !DILocation(line: 3759, column: 55, scope: !1151)
!1180 = !DILocation(line: 3759, column: 17, scope: !1151)
!1181 = !DILocation(line: 3759, column: 31, scope: !1151)
!1182 = !DILocation(line: 3759, column: 46, scope: !1151)
!1183 = !DILocation(line: 3773, column: 17, scope: !1151)
!1184 = !DILocation(line: 3773, column: 31, scope: !1151)
!1185 = !DILocation(line: 3773, column: 48, scope: !1151)
!1186 = !DILocation(line: 3780, column: 13, scope: !1151)
!1187 = !DILocation(line: 3780, column: 20, scope: !1151)
!1188 = !DILocation(line: 3782, column: 17, scope: !1151)
!1189 = !DILocation(line: 3782, column: 26, scope: !1151)
!1190 = !DILocation(line: 3782, column: 23, scope: !1151)
!1191 = !DILocation(line: 3784, column: 17, scope: !1151)
!1192 = !DILocation(line: 3784, column: 31, scope: !1151)
!1193 = !DILocation(line: 3784, column: 45, scope: !1151)
!1194 = !DILocation(line: 3785, column: 13, scope: !1151)
!1195 = !DILocation(line: 3788, column: 47, scope: !1151)
!1196 = !DILocation(line: 3788, column: 17, scope: !1151)
!1197 = !DILocation(line: 3788, column: 31, scope: !1151)
!1198 = !DILocation(line: 3788, column: 45, scope: !1151)
!1199 = !DILocation(line: 3795, column: 29, scope: !1151)
!1200 = !DILocation(line: 3795, column: 36, scope: !1151)
!1201 = !DILocation(line: 3797, column: 29, scope: !1151)
!1202 = !DILocation(line: 3799, column: 37, scope: !1151)
!1203 = !DILocation(line: 3799, column: 91, scope: !1151)
!1204 = !DILocation(line: 3801, column: 37, scope: !1151)
!1205 = !DILocation(line: 3801, column: 51, scope: !1151)
!1206 = !DILocation(line: 3801, column: 65, scope: !1151)
!1207 = !DILocation(line: 3802, column: 33, scope: !1151)
!1208 = !DILocation(line: 3804, column: 38, scope: !1151)
!1209 = !DILocation(line: 3805, column: 25, scope: !1151)
!1210 = !DILocation(line: 3809, column: 9, scope: !1151)
!1211 = !DILocation(line: 3812, column: 58, scope: !1151)
!1212 = !DILocation(line: 3812, column: 43, scope: !1151)
!1213 = !DILocation(line: 3812, column: 13, scope: !1151)
!1214 = !DILocation(line: 3812, column: 27, scope: !1151)
!1215 = !DILocation(line: 3812, column: 41, scope: !1151)
!1216 = !DILocation(line: 3817, column: 13, scope: !1151)
!1217 = !DILocation(line: 3817, column: 32, scope: !1151)
!1218 = !DILocation(line: 3825, column: 100, scope: !1151)
!1219 = !DILocation(line: 3825, column: 107, scope: !1151)
!1220 = !DILocation(line: 3825, column: 58, scope: !1151)
!1221 = !DILocation(line: 3825, column: 21, scope: !1151)
!1222 = !DILocation(line: 3825, column: 35, scope: !1151)
!1223 = !DILocation(line: 3825, column: 56, scope: !1151)
!1224 = !DILocation(line: 3828, column: 9, scope: !1151)
!1225 = !DILocation(line: 3831, column: 13, scope: !1151)
!1226 = !DILocation(line: 3831, column: 27, scope: !1151)
!1227 = !DILocation(line: 3831, column: 48, scope: !1151)
!1228 = !DILocation(line: 3833, column: 5, scope: !1151)
!1229 = distinct !DISubprogram(name: "prvTaskCheckFreeStackSpace", scope: !1, file: !1, line: 3875, type: !8, scopeLine: 3876, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1230 = !DILocation(line: 3877, column: 18, scope: !1229)
!1231 = !DILocation(line: 3879, column: 9, scope: !1229)
!1232 = !DILocation(line: 3879, column: 17, scope: !1229)
!1233 = !DILocation(line: 3879, column: 16, scope: !1229)
!1234 = !DILocation(line: 3879, column: 30, scope: !1229)
!1235 = !DILocation(line: 3881, column: 26, scope: !1229)
!1236 = !DILocation(line: 3882, column: 20, scope: !1229)
!1237 = distinct !{!1237, !1231, !1238, !82}
!1238 = !DILocation(line: 3883, column: 9, scope: !1229)
!1239 = !DILocation(line: 3885, column: 17, scope: !1229)
!1240 = !DILocation(line: 3887, column: 43, scope: !1229)
!1241 = !DILocation(line: 3887, column: 16, scope: !1229)
!1242 = !DILocation(line: 3887, column: 9, scope: !1229)
!1243 = distinct !DISubprogram(name: "uxTaskGetStackHighWaterMark", scope: !1, file: !1, line: 3935, type: !8, scopeLine: 3936, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1244 = !DILocation(line: 3941, column: 17, scope: !1243)
!1245 = !DILocation(line: 3941, column: 15, scope: !1243)
!1246 = !DILocation(line: 3945, column: 47, scope: !1243)
!1247 = !DILocation(line: 3945, column: 54, scope: !1243)
!1248 = !DILocation(line: 3945, column: 31, scope: !1243)
!1249 = !DILocation(line: 3953, column: 64, scope: !1243)
!1250 = !DILocation(line: 3953, column: 36, scope: !1243)
!1251 = !DILocation(line: 3953, column: 20, scope: !1243)
!1252 = !DILocation(line: 3953, column: 18, scope: !1243)
!1253 = !DILocation(line: 3955, column: 16, scope: !1243)
!1254 = !DILocation(line: 3955, column: 9, scope: !1243)
!1255 = distinct !DISubprogram(name: "xTaskGetCurrentTaskHandle", scope: !1, file: !1, line: 4042, type: !8, scopeLine: 4043, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1256 = !DILocation(line: 4049, column: 19, scope: !1255)
!1257 = !DILocation(line: 4049, column: 17, scope: !1255)
!1258 = !DILocation(line: 4051, column: 16, scope: !1255)
!1259 = !DILocation(line: 4051, column: 9, scope: !1255)
!1260 = distinct !DISubprogram(name: "xTaskGetSchedulerState", scope: !1, file: !1, line: 4059, type: !8, scopeLine: 4060, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1261 = !DILocation(line: 4063, column: 13, scope: !1260)
!1262 = !DILocation(line: 4063, column: 31, scope: !1260)
!1263 = !DILocation(line: 4065, column: 21, scope: !1260)
!1264 = !DILocation(line: 4066, column: 9, scope: !1260)
!1265 = !DILocation(line: 4069, column: 17, scope: !1260)
!1266 = !DILocation(line: 4069, column: 38, scope: !1260)
!1267 = !DILocation(line: 4071, column: 25, scope: !1260)
!1268 = !DILocation(line: 4072, column: 13, scope: !1260)
!1269 = !DILocation(line: 4075, column: 25, scope: !1260)
!1270 = !DILocation(line: 4079, column: 16, scope: !1260)
!1271 = !DILocation(line: 4079, column: 9, scope: !1260)
!1272 = distinct !DISubprogram(name: "xTaskPriorityInherit", scope: !1, file: !1, line: 4087, type: !8, scopeLine: 4088, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1273 = !DILocation(line: 4089, column: 42, scope: !1272)
!1274 = !DILocation(line: 4089, column: 23, scope: !1272)
!1275 = !DILocation(line: 4090, column: 20, scope: !1272)
!1276 = !DILocation(line: 4095, column: 13, scope: !1272)
!1277 = !DILocation(line: 4095, column: 27, scope: !1272)
!1278 = !DILocation(line: 4100, column: 17, scope: !1272)
!1279 = !DILocation(line: 4100, column: 35, scope: !1272)
!1280 = !DILocation(line: 4100, column: 48, scope: !1272)
!1281 = !DILocation(line: 4100, column: 62, scope: !1272)
!1282 = !DILocation(line: 4100, column: 46, scope: !1272)
!1283 = !DILocation(line: 4105, column: 23, scope: !1272)
!1284 = !DILocation(line: 4105, column: 88, scope: !1272)
!1285 = !DILocation(line: 4105, column: 125, scope: !1272)
!1286 = !DILocation(line: 4105, column: 21, scope: !1272)
!1287 = !DILocation(line: 4107, column: 21, scope: !1272)
!1288 = !DILocation(line: 4108, column: 17, scope: !1272)
!1289 = !DILocation(line: 4116, column: 21, scope: !1272)
!1290 = !DILocation(line: 4116, column: 142, scope: !1272)
!1291 = !DILocation(line: 4118, column: 42, scope: !1272)
!1292 = !DILocation(line: 4118, column: 60, scope: !1272)
!1293 = !DILocation(line: 4118, column: 25, scope: !1272)
!1294 = !DILocation(line: 4118, column: 79, scope: !1272)
!1295 = !DILocation(line: 4124, column: 21, scope: !1272)
!1296 = !DILocation(line: 4131, column: 52, scope: !1272)
!1297 = !DILocation(line: 4131, column: 66, scope: !1272)
!1298 = !DILocation(line: 4131, column: 21, scope: !1272)
!1299 = !DILocation(line: 4131, column: 39, scope: !1272)
!1300 = !DILocation(line: 4131, column: 50, scope: !1272)
!1301 = !DILocation(line: 4132, column: 21, scope: !1272)
!1302 = !DILocation(line: 4133, column: 17, scope: !1272)
!1303 = !DILocation(line: 4137, column: 52, scope: !1272)
!1304 = !DILocation(line: 4137, column: 66, scope: !1272)
!1305 = !DILocation(line: 4137, column: 21, scope: !1272)
!1306 = !DILocation(line: 4137, column: 39, scope: !1272)
!1307 = !DILocation(line: 4137, column: 50, scope: !1272)
!1308 = !DILocation(line: 4143, column: 25, scope: !1272)
!1309 = !DILocation(line: 4144, column: 13, scope: !1272)
!1310 = !DILocation(line: 4147, column: 21, scope: !1272)
!1311 = !DILocation(line: 4147, column: 39, scope: !1272)
!1312 = !DILocation(line: 4147, column: 56, scope: !1272)
!1313 = !DILocation(line: 4147, column: 70, scope: !1272)
!1314 = !DILocation(line: 4147, column: 54, scope: !1272)
!1315 = !DILocation(line: 4156, column: 29, scope: !1272)
!1316 = !DILocation(line: 4157, column: 17, scope: !1272)
!1317 = !DILocation(line: 4163, column: 9, scope: !1272)
!1318 = !DILocation(line: 4169, column: 16, scope: !1272)
!1319 = !DILocation(line: 4169, column: 9, scope: !1272)
!1320 = distinct !DISubprogram(name: "xTaskPriorityDisinherit", scope: !1, file: !1, line: 4177, type: !8, scopeLine: 4178, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1321 = !DILocation(line: 4179, column: 31, scope: !1320)
!1322 = !DILocation(line: 4179, column: 23, scope: !1320)
!1323 = !DILocation(line: 4180, column: 20, scope: !1320)
!1324 = !DILocation(line: 4182, column: 13, scope: !1320)
!1325 = !DILocation(line: 4182, column: 27, scope: !1320)
!1326 = !DILocation(line: 4190, column: 15, scope: !1320)
!1327 = !DILocation(line: 4190, column: 22, scope: !1320)
!1328 = !DILocation(line: 4190, column: 37, scope: !1320)
!1329 = !DILocation(line: 4194, column: 17, scope: !1320)
!1330 = !DILocation(line: 4194, column: 24, scope: !1320)
!1331 = !DILocation(line: 4194, column: 38, scope: !1320)
!1332 = !DILocation(line: 4194, column: 45, scope: !1320)
!1333 = !DILocation(line: 4194, column: 35, scope: !1320)
!1334 = !DILocation(line: 4197, column: 21, scope: !1320)
!1335 = !DILocation(line: 4197, column: 28, scope: !1320)
!1336 = !DILocation(line: 4197, column: 42, scope: !1320)
!1337 = !DILocation(line: 4204, column: 42, scope: !1320)
!1338 = !DILocation(line: 4204, column: 49, scope: !1320)
!1339 = !DILocation(line: 4204, column: 25, scope: !1320)
!1340 = !DILocation(line: 4204, column: 68, scope: !1320)
!1341 = !DILocation(line: 4207, column: 21, scope: !1320)
!1342 = !DILocation(line: 4216, column: 41, scope: !1320)
!1343 = !DILocation(line: 4216, column: 48, scope: !1320)
!1344 = !DILocation(line: 4216, column: 21, scope: !1320)
!1345 = !DILocation(line: 4216, column: 28, scope: !1320)
!1346 = !DILocation(line: 4216, column: 39, scope: !1320)
!1347 = !DILocation(line: 4221, column: 21, scope: !1320)
!1348 = !DILocation(line: 4222, column: 21, scope: !1320)
!1349 = !DILocation(line: 4232, column: 29, scope: !1320)
!1350 = !DILocation(line: 4233, column: 17, scope: !1320)
!1351 = !DILocation(line: 4238, column: 13, scope: !1320)
!1352 = !DILocation(line: 4243, column: 9, scope: !1320)
!1353 = !DILocation(line: 4249, column: 16, scope: !1320)
!1354 = !DILocation(line: 4249, column: 9, scope: !1320)
!1355 = distinct !DISubprogram(name: "vTaskPriorityDisinheritAfterTimeout", scope: !1, file: !1, line: 4257, type: !8, scopeLine: 4259, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1356 = !DILocation(line: 4260, column: 31, scope: !1355)
!1357 = !DILocation(line: 4260, column: 23, scope: !1355)
!1358 = !DILocation(line: 4262, column: 27, scope: !1355)
!1359 = !DILocation(line: 4264, column: 13, scope: !1355)
!1360 = !DILocation(line: 4264, column: 27, scope: !1355)
!1361 = !DILocation(line: 4274, column: 17, scope: !1355)
!1362 = !DILocation(line: 4274, column: 24, scope: !1355)
!1363 = !DILocation(line: 4274, column: 41, scope: !1355)
!1364 = !DILocation(line: 4274, column: 39, scope: !1355)
!1365 = !DILocation(line: 4276, column: 35, scope: !1355)
!1366 = !DILocation(line: 4276, column: 33, scope: !1355)
!1367 = !DILocation(line: 4277, column: 13, scope: !1355)
!1368 = !DILocation(line: 4280, column: 35, scope: !1355)
!1369 = !DILocation(line: 4280, column: 42, scope: !1355)
!1370 = !DILocation(line: 4280, column: 33, scope: !1355)
!1371 = !DILocation(line: 4284, column: 17, scope: !1355)
!1372 = !DILocation(line: 4284, column: 24, scope: !1355)
!1373 = !DILocation(line: 4284, column: 38, scope: !1355)
!1374 = !DILocation(line: 4284, column: 35, scope: !1355)
!1375 = !DILocation(line: 4290, column: 21, scope: !1355)
!1376 = !DILocation(line: 4290, column: 28, scope: !1355)
!1377 = !DILocation(line: 4290, column: 42, scope: !1355)
!1378 = !DILocation(line: 4301, column: 45, scope: !1355)
!1379 = !DILocation(line: 4301, column: 52, scope: !1355)
!1380 = !DILocation(line: 4301, column: 43, scope: !1355)
!1381 = !DILocation(line: 4302, column: 41, scope: !1355)
!1382 = !DILocation(line: 4302, column: 21, scope: !1355)
!1383 = !DILocation(line: 4302, column: 28, scope: !1355)
!1384 = !DILocation(line: 4302, column: 39, scope: !1355)
!1385 = !DILocation(line: 4306, column: 27, scope: !1355)
!1386 = !DILocation(line: 4306, column: 81, scope: !1355)
!1387 = !DILocation(line: 4306, column: 118, scope: !1355)
!1388 = !DILocation(line: 4306, column: 25, scope: !1355)
!1389 = !DILocation(line: 4308, column: 25, scope: !1355)
!1390 = !DILocation(line: 4309, column: 21, scope: !1355)
!1391 = !DILocation(line: 4321, column: 25, scope: !1355)
!1392 = !DILocation(line: 4321, column: 128, scope: !1355)
!1393 = !DILocation(line: 4323, column: 46, scope: !1355)
!1394 = !DILocation(line: 4323, column: 53, scope: !1355)
!1395 = !DILocation(line: 4323, column: 29, scope: !1355)
!1396 = !DILocation(line: 4323, column: 72, scope: !1355)
!1397 = !DILocation(line: 4329, column: 25, scope: !1355)
!1398 = !DILocation(line: 4335, column: 25, scope: !1355)
!1399 = !DILocation(line: 4336, column: 21, scope: !1355)
!1400 = !DILocation(line: 4341, column: 17, scope: !1355)
!1401 = !DILocation(line: 4346, column: 13, scope: !1355)
!1402 = !DILocation(line: 4351, column: 9, scope: !1355)
!1403 = !DILocation(line: 4356, column: 5, scope: !1355)
!1404 = distinct !DISubprogram(name: "uxTaskResetEventItemValue", scope: !1, file: !1, line: 4684, type: !8, scopeLine: 4685, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1405 = !DILocation(line: 4688, column: 16, scope: !1404)
!1406 = !DILocation(line: 4688, column: 14, scope: !1404)
!1407 = !DILocation(line: 4692, column: 5, scope: !1404)
!1408 = !DILocation(line: 4694, column: 12, scope: !1404)
!1409 = !DILocation(line: 4694, column: 5, scope: !1404)
!1410 = distinct !DISubprogram(name: "pvTaskIncrementMutexHeldCount", scope: !1, file: !1, line: 4700, type: !8, scopeLine: 4701, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1411 = !DILocation(line: 4704, column: 13, scope: !1410)
!1412 = !DILocation(line: 4704, column: 26, scope: !1410)
!1413 = !DILocation(line: 4706, column: 15, scope: !1410)
!1414 = !DILocation(line: 4706, column: 29, scope: !1410)
!1415 = !DILocation(line: 4706, column: 44, scope: !1410)
!1416 = !DILocation(line: 4707, column: 9, scope: !1410)
!1417 = !DILocation(line: 4709, column: 16, scope: !1410)
!1418 = !DILocation(line: 4709, column: 9, scope: !1410)
!1419 = distinct !DISubprogram(name: "ulTaskGenericNotifyTake", scope: !1, file: !1, line: 4717, type: !8, scopeLine: 4720, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1420 = !DILocation(line: 4725, column: 9, scope: !1419)
!1421 = !DILocation(line: 4728, column: 17, scope: !1419)
!1422 = !DILocation(line: 4728, column: 31, scope: !1419)
!1423 = !DILocation(line: 4728, column: 48, scope: !1419)
!1424 = !DILocation(line: 4728, column: 64, scope: !1419)
!1425 = !DILocation(line: 4731, column: 17, scope: !1419)
!1426 = !DILocation(line: 4731, column: 31, scope: !1419)
!1427 = !DILocation(line: 4731, column: 46, scope: !1419)
!1428 = !DILocation(line: 4731, column: 62, scope: !1419)
!1429 = !DILocation(line: 4733, column: 21, scope: !1419)
!1430 = !DILocation(line: 4733, column: 34, scope: !1419)
!1431 = !DILocation(line: 4735, column: 53, scope: !1419)
!1432 = !DILocation(line: 4735, column: 21, scope: !1419)
!1433 = !DILocation(line: 4742, column: 21, scope: !1419)
!1434 = !{i64 2148349160}
!1435 = !{i64 2148349230}
!1436 = !DILocation(line: 4743, column: 17, scope: !1419)
!1437 = !DILocation(line: 4748, column: 13, scope: !1419)
!1438 = !DILocation(line: 4754, column: 9, scope: !1419)
!1439 = !DILocation(line: 4756, column: 9, scope: !1419)
!1440 = !DILocation(line: 4759, column: 24, scope: !1419)
!1441 = !DILocation(line: 4759, column: 38, scope: !1419)
!1442 = !DILocation(line: 4759, column: 55, scope: !1419)
!1443 = !DILocation(line: 4759, column: 22, scope: !1419)
!1444 = !DILocation(line: 4761, column: 17, scope: !1419)
!1445 = !DILocation(line: 4761, column: 26, scope: !1419)
!1446 = !DILocation(line: 4763, column: 21, scope: !1419)
!1447 = !DILocation(line: 4763, column: 39, scope: !1419)
!1448 = !DILocation(line: 4765, column: 21, scope: !1419)
!1449 = !DILocation(line: 4765, column: 35, scope: !1419)
!1450 = !DILocation(line: 4765, column: 52, scope: !1419)
!1451 = !DILocation(line: 4765, column: 68, scope: !1419)
!1452 = !DILocation(line: 4766, column: 17, scope: !1419)
!1453 = !DILocation(line: 4769, column: 70, scope: !1419)
!1454 = !DILocation(line: 4769, column: 79, scope: !1419)
!1455 = !DILocation(line: 4769, column: 21, scope: !1419)
!1456 = !DILocation(line: 4769, column: 35, scope: !1419)
!1457 = !DILocation(line: 4769, column: 52, scope: !1419)
!1458 = !DILocation(line: 4769, column: 68, scope: !1419)
!1459 = !DILocation(line: 4771, column: 13, scope: !1419)
!1460 = !DILocation(line: 4777, column: 13, scope: !1419)
!1461 = !DILocation(line: 4777, column: 27, scope: !1419)
!1462 = !DILocation(line: 4777, column: 42, scope: !1419)
!1463 = !DILocation(line: 4777, column: 58, scope: !1419)
!1464 = !DILocation(line: 4779, column: 9, scope: !1419)
!1465 = !DILocation(line: 4781, column: 16, scope: !1419)
!1466 = !DILocation(line: 4781, column: 9, scope: !1419)
!1467 = distinct !DISubprogram(name: "xTaskGenericNotifyWait", scope: !1, file: !1, line: 4789, type: !8, scopeLine: 4794, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1468 = !DILocation(line: 4799, column: 9, scope: !1467)
!1469 = !DILocation(line: 4802, column: 17, scope: !1467)
!1470 = !DILocation(line: 4802, column: 31, scope: !1467)
!1471 = !DILocation(line: 4802, column: 46, scope: !1467)
!1472 = !DILocation(line: 4802, column: 62, scope: !1467)
!1473 = !DILocation(line: 4807, column: 68, scope: !1467)
!1474 = !DILocation(line: 4807, column: 67, scope: !1467)
!1475 = !DILocation(line: 4807, column: 17, scope: !1467)
!1476 = !DILocation(line: 4807, column: 31, scope: !1467)
!1477 = !DILocation(line: 4807, column: 48, scope: !1467)
!1478 = !DILocation(line: 4807, column: 64, scope: !1467)
!1479 = !DILocation(line: 4810, column: 17, scope: !1467)
!1480 = !DILocation(line: 4810, column: 31, scope: !1467)
!1481 = !DILocation(line: 4810, column: 46, scope: !1467)
!1482 = !DILocation(line: 4810, column: 62, scope: !1467)
!1483 = !DILocation(line: 4812, column: 21, scope: !1467)
!1484 = !DILocation(line: 4812, column: 34, scope: !1467)
!1485 = !DILocation(line: 4814, column: 53, scope: !1467)
!1486 = !DILocation(line: 4814, column: 21, scope: !1467)
!1487 = !DILocation(line: 4821, column: 21, scope: !1467)
!1488 = !{i64 2148350026}
!1489 = !{i64 2148350096}
!1490 = !DILocation(line: 4822, column: 17, scope: !1467)
!1491 = !DILocation(line: 4827, column: 13, scope: !1467)
!1492 = !DILocation(line: 4833, column: 9, scope: !1467)
!1493 = !DILocation(line: 4835, column: 9, scope: !1467)
!1494 = !DILocation(line: 4839, column: 17, scope: !1467)
!1495 = !DILocation(line: 4839, column: 38, scope: !1467)
!1496 = !DILocation(line: 4843, column: 41, scope: !1467)
!1497 = !DILocation(line: 4843, column: 55, scope: !1467)
!1498 = !DILocation(line: 4843, column: 72, scope: !1467)
!1499 = !DILocation(line: 4843, column: 18, scope: !1467)
!1500 = !DILocation(line: 4843, column: 39, scope: !1467)
!1501 = !DILocation(line: 4844, column: 13, scope: !1467)
!1502 = !DILocation(line: 4850, column: 17, scope: !1467)
!1503 = !DILocation(line: 4850, column: 31, scope: !1467)
!1504 = !DILocation(line: 4850, column: 46, scope: !1467)
!1505 = !DILocation(line: 4850, column: 62, scope: !1467)
!1506 = !DILocation(line: 4853, column: 25, scope: !1467)
!1507 = !DILocation(line: 4854, column: 13, scope: !1467)
!1508 = !DILocation(line: 4859, column: 68, scope: !1467)
!1509 = !DILocation(line: 4859, column: 67, scope: !1467)
!1510 = !DILocation(line: 4859, column: 17, scope: !1467)
!1511 = !DILocation(line: 4859, column: 31, scope: !1467)
!1512 = !DILocation(line: 4859, column: 48, scope: !1467)
!1513 = !DILocation(line: 4859, column: 64, scope: !1467)
!1514 = !DILocation(line: 4860, column: 25, scope: !1467)
!1515 = !DILocation(line: 4863, column: 13, scope: !1467)
!1516 = !DILocation(line: 4863, column: 27, scope: !1467)
!1517 = !DILocation(line: 4863, column: 42, scope: !1467)
!1518 = !DILocation(line: 4863, column: 58, scope: !1467)
!1519 = !DILocation(line: 4865, column: 9, scope: !1467)
!1520 = !DILocation(line: 4867, column: 16, scope: !1467)
!1521 = !DILocation(line: 4867, column: 9, scope: !1467)
!1522 = distinct !DISubprogram(name: "xTaskGenericNotify", scope: !1, file: !1, line: 4875, type: !8, scopeLine: 4880, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1523 = !DILocation(line: 4882, column: 20, scope: !1522)
!1524 = !DILocation(line: 4887, column: 17, scope: !1522)
!1525 = !DILocation(line: 4887, column: 15, scope: !1522)
!1526 = !DILocation(line: 4889, column: 9, scope: !1522)
!1527 = !DILocation(line: 4891, column: 17, scope: !1522)
!1528 = !DILocation(line: 4891, column: 46, scope: !1522)
!1529 = !DILocation(line: 4893, column: 49, scope: !1522)
!1530 = !DILocation(line: 4893, column: 56, scope: !1522)
!1531 = !DILocation(line: 4893, column: 73, scope: !1522)
!1532 = !DILocation(line: 4893, column: 18, scope: !1522)
!1533 = !DILocation(line: 4893, column: 47, scope: !1522)
!1534 = !DILocation(line: 4894, column: 13, scope: !1522)
!1535 = !DILocation(line: 4896, column: 37, scope: !1522)
!1536 = !DILocation(line: 4896, column: 44, scope: !1522)
!1537 = !DILocation(line: 4896, column: 59, scope: !1522)
!1538 = !DILocation(line: 4896, column: 35, scope: !1522)
!1539 = !DILocation(line: 4898, column: 13, scope: !1522)
!1540 = !DILocation(line: 4898, column: 20, scope: !1522)
!1541 = !DILocation(line: 4898, column: 35, scope: !1522)
!1542 = !DILocation(line: 4898, column: 53, scope: !1522)
!1543 = !DILocation(line: 4900, column: 21, scope: !1522)
!1544 = !DILocation(line: 4900, column: 13, scope: !1522)
!1545 = !DILocation(line: 4903, column: 66, scope: !1522)
!1546 = !DILocation(line: 4903, column: 21, scope: !1522)
!1547 = !DILocation(line: 4903, column: 28, scope: !1522)
!1548 = !DILocation(line: 4903, column: 45, scope: !1522)
!1549 = !DILocation(line: 4903, column: 63, scope: !1522)
!1550 = !DILocation(line: 4904, column: 21, scope: !1522)
!1551 = !DILocation(line: 4907, column: 23, scope: !1522)
!1552 = !DILocation(line: 4907, column: 30, scope: !1522)
!1553 = !DILocation(line: 4907, column: 47, scope: !1522)
!1554 = !DILocation(line: 4907, column: 66, scope: !1522)
!1555 = !DILocation(line: 4908, column: 21, scope: !1522)
!1556 = !DILocation(line: 4911, column: 65, scope: !1522)
!1557 = !DILocation(line: 4911, column: 21, scope: !1522)
!1558 = !DILocation(line: 4911, column: 28, scope: !1522)
!1559 = !DILocation(line: 4911, column: 45, scope: !1522)
!1560 = !DILocation(line: 4911, column: 63, scope: !1522)
!1561 = !DILocation(line: 4912, column: 21, scope: !1522)
!1562 = !DILocation(line: 4916, column: 25, scope: !1522)
!1563 = !DILocation(line: 4916, column: 47, scope: !1522)
!1564 = !DILocation(line: 4918, column: 69, scope: !1522)
!1565 = !DILocation(line: 4918, column: 25, scope: !1522)
!1566 = !DILocation(line: 4918, column: 32, scope: !1522)
!1567 = !DILocation(line: 4918, column: 49, scope: !1522)
!1568 = !DILocation(line: 4918, column: 67, scope: !1522)
!1569 = !DILocation(line: 4919, column: 21, scope: !1522)
!1570 = !DILocation(line: 4923, column: 33, scope: !1522)
!1571 = !DILocation(line: 4926, column: 21, scope: !1522)
!1572 = !DILocation(line: 4932, column: 21, scope: !1522)
!1573 = !DILocation(line: 4941, column: 21, scope: !1522)
!1574 = !DILocation(line: 4948, column: 17, scope: !1522)
!1575 = !DILocation(line: 4948, column: 39, scope: !1522)
!1576 = !DILocation(line: 4950, column: 17, scope: !1522)
!1577 = !DILocation(line: 4951, column: 17, scope: !1522)
!1578 = !DILocation(line: 4972, column: 21, scope: !1522)
!1579 = !DILocation(line: 4972, column: 28, scope: !1522)
!1580 = !DILocation(line: 4972, column: 41, scope: !1522)
!1581 = !DILocation(line: 4972, column: 55, scope: !1522)
!1582 = !DILocation(line: 4972, column: 39, scope: !1522)
!1583 = !DILocation(line: 4976, column: 21, scope: !1522)
!1584 = !{i64 2148355182}
!1585 = !{i64 2148355252}
!1586 = !DILocation(line: 4977, column: 17, scope: !1522)
!1587 = !DILocation(line: 4982, column: 13, scope: !1522)
!1588 = !DILocation(line: 4988, column: 9, scope: !1522)
!1589 = !DILocation(line: 4990, column: 16, scope: !1522)
!1590 = !DILocation(line: 4990, column: 9, scope: !1522)
!1591 = distinct !DISubprogram(name: "xTaskGenericNotifyFromISR", scope: !1, file: !1, line: 4998, type: !8, scopeLine: 5004, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1592 = !DILocation(line: 5007, column: 20, scope: !1591)
!1593 = !DILocation(line: 5031, column: 17, scope: !1591)
!1594 = !DILocation(line: 5031, column: 15, scope: !1591)
!1595 = !DILocation(line: 216, column: 9, scope: !542, inlinedAt: !1596)
!1596 = distinct !DILocation(line: 5033, column: 34, scope: !1591)
!1597 = !DILocation(line: 228, column: 16, scope: !542, inlinedAt: !1596)
!1598 = !DILocation(line: 5033, column: 32, scope: !1591)
!1599 = !DILocation(line: 5035, column: 17, scope: !1591)
!1600 = !DILocation(line: 5035, column: 46, scope: !1591)
!1601 = !DILocation(line: 5037, column: 49, scope: !1591)
!1602 = !DILocation(line: 5037, column: 56, scope: !1591)
!1603 = !DILocation(line: 5037, column: 73, scope: !1591)
!1604 = !DILocation(line: 5037, column: 18, scope: !1591)
!1605 = !DILocation(line: 5037, column: 47, scope: !1591)
!1606 = !DILocation(line: 5038, column: 13, scope: !1591)
!1607 = !DILocation(line: 5040, column: 37, scope: !1591)
!1608 = !DILocation(line: 5040, column: 44, scope: !1591)
!1609 = !DILocation(line: 5040, column: 59, scope: !1591)
!1610 = !DILocation(line: 5040, column: 35, scope: !1591)
!1611 = !DILocation(line: 5041, column: 13, scope: !1591)
!1612 = !DILocation(line: 5041, column: 20, scope: !1591)
!1613 = !DILocation(line: 5041, column: 35, scope: !1591)
!1614 = !DILocation(line: 5041, column: 53, scope: !1591)
!1615 = !DILocation(line: 5043, column: 21, scope: !1591)
!1616 = !DILocation(line: 5043, column: 13, scope: !1591)
!1617 = !DILocation(line: 5046, column: 66, scope: !1591)
!1618 = !DILocation(line: 5046, column: 21, scope: !1591)
!1619 = !DILocation(line: 5046, column: 28, scope: !1591)
!1620 = !DILocation(line: 5046, column: 45, scope: !1591)
!1621 = !DILocation(line: 5046, column: 63, scope: !1591)
!1622 = !DILocation(line: 5047, column: 21, scope: !1591)
!1623 = !DILocation(line: 5050, column: 23, scope: !1591)
!1624 = !DILocation(line: 5050, column: 30, scope: !1591)
!1625 = !DILocation(line: 5050, column: 47, scope: !1591)
!1626 = !DILocation(line: 5050, column: 66, scope: !1591)
!1627 = !DILocation(line: 5051, column: 21, scope: !1591)
!1628 = !DILocation(line: 5054, column: 65, scope: !1591)
!1629 = !DILocation(line: 5054, column: 21, scope: !1591)
!1630 = !DILocation(line: 5054, column: 28, scope: !1591)
!1631 = !DILocation(line: 5054, column: 45, scope: !1591)
!1632 = !DILocation(line: 5054, column: 63, scope: !1591)
!1633 = !DILocation(line: 5055, column: 21, scope: !1591)
!1634 = !DILocation(line: 5059, column: 25, scope: !1591)
!1635 = !DILocation(line: 5059, column: 47, scope: !1591)
!1636 = !DILocation(line: 5061, column: 69, scope: !1591)
!1637 = !DILocation(line: 5061, column: 25, scope: !1591)
!1638 = !DILocation(line: 5061, column: 32, scope: !1591)
!1639 = !DILocation(line: 5061, column: 49, scope: !1591)
!1640 = !DILocation(line: 5061, column: 67, scope: !1591)
!1641 = !DILocation(line: 5062, column: 21, scope: !1591)
!1642 = !DILocation(line: 5066, column: 33, scope: !1591)
!1643 = !DILocation(line: 5069, column: 21, scope: !1591)
!1644 = !DILocation(line: 5075, column: 21, scope: !1591)
!1645 = !DILocation(line: 5083, column: 21, scope: !1591)
!1646 = !DILocation(line: 5090, column: 17, scope: !1591)
!1647 = !DILocation(line: 5090, column: 39, scope: !1591)
!1648 = !DILocation(line: 5095, column: 21, scope: !1591)
!1649 = !DILocation(line: 5095, column: 42, scope: !1591)
!1650 = !DILocation(line: 5097, column: 21, scope: !1591)
!1651 = !DILocation(line: 5098, column: 21, scope: !1591)
!1652 = !DILocation(line: 5099, column: 17, scope: !1591)
!1653 = !DILocation(line: 5104, column: 21, scope: !1591)
!1654 = !DILocation(line: 5107, column: 21, scope: !1591)
!1655 = !DILocation(line: 5107, column: 28, scope: !1591)
!1656 = !DILocation(line: 5107, column: 41, scope: !1591)
!1657 = !DILocation(line: 5107, column: 55, scope: !1591)
!1658 = !DILocation(line: 5107, column: 39, scope: !1591)
!1659 = !DILocation(line: 5111, column: 25, scope: !1591)
!1660 = !DILocation(line: 5111, column: 51, scope: !1591)
!1661 = !DILocation(line: 5113, column: 26, scope: !1591)
!1662 = !DILocation(line: 5113, column: 52, scope: !1591)
!1663 = !DILocation(line: 5114, column: 21, scope: !1591)
!1664 = !DILocation(line: 5119, column: 35, scope: !1591)
!1665 = !DILocation(line: 5120, column: 17, scope: !1591)
!1666 = !DILocation(line: 5125, column: 13, scope: !1591)
!1667 = !DILocation(line: 5127, column: 9, scope: !1591)
!1668 = !DILocation(line: 236, column: 40, scope: !555, inlinedAt: !1669)
!1669 = distinct !DILocation(line: 5127, column: 9, scope: !1591)
!1670 = !DILocation(line: 234, column: 9, scope: !555, inlinedAt: !1669)
!1671 = !DILocation(line: 5129, column: 16, scope: !1591)
!1672 = !DILocation(line: 5129, column: 9, scope: !1591)
!1673 = distinct !DISubprogram(name: "vTaskGenericNotifyGiveFromISR", scope: !1, file: !1, line: 5137, type: !8, scopeLine: 5140, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1674 = !DILocation(line: 5166, column: 17, scope: !1673)
!1675 = !DILocation(line: 5166, column: 15, scope: !1673)
!1676 = !DILocation(line: 216, column: 9, scope: !542, inlinedAt: !1677)
!1677 = distinct !DILocation(line: 5168, column: 34, scope: !1673)
!1678 = !DILocation(line: 228, column: 16, scope: !542, inlinedAt: !1677)
!1679 = !DILocation(line: 5168, column: 32, scope: !1673)
!1680 = !DILocation(line: 5170, column: 37, scope: !1673)
!1681 = !DILocation(line: 5170, column: 44, scope: !1673)
!1682 = !DILocation(line: 5170, column: 59, scope: !1673)
!1683 = !DILocation(line: 5170, column: 35, scope: !1673)
!1684 = !DILocation(line: 5171, column: 13, scope: !1673)
!1685 = !DILocation(line: 5171, column: 20, scope: !1673)
!1686 = !DILocation(line: 5171, column: 35, scope: !1673)
!1687 = !DILocation(line: 5171, column: 53, scope: !1673)
!1688 = !DILocation(line: 5175, column: 15, scope: !1673)
!1689 = !DILocation(line: 5175, column: 22, scope: !1673)
!1690 = !DILocation(line: 5175, column: 39, scope: !1673)
!1691 = !DILocation(line: 5175, column: 58, scope: !1673)
!1692 = !DILocation(line: 5181, column: 17, scope: !1673)
!1693 = !DILocation(line: 5181, column: 39, scope: !1673)
!1694 = !DILocation(line: 5186, column: 21, scope: !1673)
!1695 = !DILocation(line: 5186, column: 42, scope: !1673)
!1696 = !DILocation(line: 5188, column: 21, scope: !1673)
!1697 = !DILocation(line: 5189, column: 21, scope: !1673)
!1698 = !DILocation(line: 5190, column: 17, scope: !1673)
!1699 = !DILocation(line: 5195, column: 21, scope: !1673)
!1700 = !DILocation(line: 5198, column: 21, scope: !1673)
!1701 = !DILocation(line: 5198, column: 28, scope: !1673)
!1702 = !DILocation(line: 5198, column: 41, scope: !1673)
!1703 = !DILocation(line: 5198, column: 55, scope: !1673)
!1704 = !DILocation(line: 5198, column: 39, scope: !1673)
!1705 = !DILocation(line: 5202, column: 25, scope: !1673)
!1706 = !DILocation(line: 5202, column: 51, scope: !1673)
!1707 = !DILocation(line: 5204, column: 26, scope: !1673)
!1708 = !DILocation(line: 5204, column: 52, scope: !1673)
!1709 = !DILocation(line: 5205, column: 21, scope: !1673)
!1710 = !DILocation(line: 5210, column: 35, scope: !1673)
!1711 = !DILocation(line: 5211, column: 17, scope: !1673)
!1712 = !DILocation(line: 5216, column: 13, scope: !1673)
!1713 = !DILocation(line: 5218, column: 9, scope: !1673)
!1714 = !DILocation(line: 236, column: 40, scope: !555, inlinedAt: !1715)
!1715 = distinct !DILocation(line: 5218, column: 9, scope: !1673)
!1716 = !DILocation(line: 234, column: 9, scope: !555, inlinedAt: !1715)
!1717 = !DILocation(line: 5219, column: 5, scope: !1673)
!1718 = distinct !DISubprogram(name: "xTaskGenericNotifyStateClear", scope: !1, file: !1, line: 5226, type: !8, scopeLine: 5228, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1719 = !DILocation(line: 5236, column: 17, scope: !1718)
!1720 = !DILocation(line: 5236, column: 15, scope: !1718)
!1721 = !DILocation(line: 5238, column: 9, scope: !1718)
!1722 = !DILocation(line: 5240, column: 17, scope: !1718)
!1723 = !DILocation(line: 5240, column: 24, scope: !1718)
!1724 = !DILocation(line: 5240, column: 39, scope: !1718)
!1725 = !DILocation(line: 5240, column: 56, scope: !1718)
!1726 = !DILocation(line: 5242, column: 17, scope: !1718)
!1727 = !DILocation(line: 5242, column: 24, scope: !1718)
!1728 = !DILocation(line: 5242, column: 39, scope: !1718)
!1729 = !DILocation(line: 5242, column: 56, scope: !1718)
!1730 = !DILocation(line: 5243, column: 25, scope: !1718)
!1731 = !DILocation(line: 5244, column: 13, scope: !1718)
!1732 = !DILocation(line: 5247, column: 25, scope: !1718)
!1733 = !DILocation(line: 5250, column: 9, scope: !1718)
!1734 = !DILocation(line: 5252, column: 16, scope: !1718)
!1735 = !DILocation(line: 5252, column: 9, scope: !1718)
!1736 = distinct !DISubprogram(name: "ulTaskGenericNotifyValueClear", scope: !1, file: !1, line: 5260, type: !8, scopeLine: 5263, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1737 = !DILocation(line: 5269, column: 17, scope: !1736)
!1738 = !DILocation(line: 5269, column: 15, scope: !1736)
!1739 = !DILocation(line: 5271, column: 9, scope: !1736)
!1740 = !DILocation(line: 5275, column: 24, scope: !1736)
!1741 = !DILocation(line: 5275, column: 31, scope: !1736)
!1742 = !DILocation(line: 5275, column: 48, scope: !1736)
!1743 = !DILocation(line: 5275, column: 22, scope: !1736)
!1744 = !DILocation(line: 5276, column: 58, scope: !1736)
!1745 = !DILocation(line: 5276, column: 57, scope: !1736)
!1746 = !DILocation(line: 5276, column: 13, scope: !1736)
!1747 = !DILocation(line: 5276, column: 20, scope: !1736)
!1748 = !DILocation(line: 5276, column: 37, scope: !1736)
!1749 = !DILocation(line: 5276, column: 54, scope: !1736)
!1750 = !DILocation(line: 5278, column: 9, scope: !1736)
!1751 = !DILocation(line: 5280, column: 16, scope: !1736)
!1752 = !DILocation(line: 5280, column: 9, scope: !1736)
!1753 = distinct !DISubprogram(name: "prvInitialiseTaskLists", scope: !1, file: !1, line: 3679, type: !8, scopeLine: 3680, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1754 = !DILocation(line: 3683, column: 21, scope: !1753)
!1755 = !DILocation(line: 3683, column: 10, scope: !1753)
!1756 = !DILocation(line: 3683, column: 43, scope: !1753)
!1757 = !DILocation(line: 3683, column: 54, scope: !1753)
!1758 = !DILocation(line: 3683, column: 5, scope: !1753)
!1759 = !DILocation(line: 3685, column: 48, scope: !1753)
!1760 = !DILocation(line: 3685, column: 29, scope: !1753)
!1761 = !DILocation(line: 3685, column: 9, scope: !1753)
!1762 = !DILocation(line: 3686, column: 5, scope: !1753)
!1763 = !DILocation(line: 3683, column: 104, scope: !1753)
!1764 = distinct !{!1764, !1758, !1762, !82}
!1765 = !DILocation(line: 3688, column: 5, scope: !1753)
!1766 = !DILocation(line: 3689, column: 5, scope: !1753)
!1767 = !DILocation(line: 3690, column: 5, scope: !1753)
!1768 = !DILocation(line: 3694, column: 13, scope: !1753)
!1769 = !DILocation(line: 3700, column: 13, scope: !1753)
!1770 = !DILocation(line: 3706, column: 23, scope: !1753)
!1771 = !DILocation(line: 3707, column: 31, scope: !1753)
!1772 = !DILocation(line: 3708, column: 1, scope: !1753)
!1773 = distinct !DISubprogram(name: "prvCheckTasksWaitingTermination", scope: !1, file: !1, line: 3711, type: !8, scopeLine: 3712, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1774 = !DILocation(line: 3721, column: 13, scope: !1773)
!1775 = !DILocation(line: 3721, column: 20, scope: !1773)
!1776 = !DILocation(line: 3721, column: 49, scope: !1773)
!1777 = !DILocation(line: 3723, column: 17, scope: !1773)
!1778 = !DILocation(line: 3725, column: 29, scope: !1773)
!1779 = !DILocation(line: 3725, column: 27, scope: !1773)
!1780 = !DILocation(line: 3726, column: 47, scope: !1773)
!1781 = !DILocation(line: 3726, column: 54, scope: !1773)
!1782 = !DILocation(line: 3726, column: 30, scope: !1773)
!1783 = !DILocation(line: 3727, column: 21, scope: !1773)
!1784 = !DILocation(line: 3728, column: 21, scope: !1773)
!1785 = !DILocation(line: 3730, column: 17, scope: !1773)
!1786 = !DILocation(line: 3732, column: 31, scope: !1773)
!1787 = !DILocation(line: 3732, column: 17, scope: !1773)
!1788 = distinct !{!1788, !1774, !1789, !82}
!1789 = !DILocation(line: 3733, column: 13, scope: !1773)
!1790 = !DILocation(line: 3736, column: 1, scope: !1773)
