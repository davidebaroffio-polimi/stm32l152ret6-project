; ModuleID = 'FreeRTOS/Source/timers.c'
source_filename = "FreeRTOS/Source/timers.c"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-unknown-eabi"

%struct.xSTATIC_TCB = type { ptr, [2 x %struct.xSTATIC_LIST_ITEM], i32, ptr, [16 x i8], [2 x i32], [2 x i32], [1 x i32], [1 x i8], i8 }
%struct.xSTATIC_LIST_ITEM = type { i32, [4 x ptr] }
%struct.xLIST = type { i32, ptr, %struct.xMINI_LIST_ITEM }
%struct.xMINI_LIST_ITEM = type { i32, ptr, ptr }
%struct.xSTATIC_QUEUE = type { [3 x ptr], %union.anon.0, [2 x %struct.xSTATIC_LIST], [3 x i32], [2 x i8], i8, i32, i8 }
%union.anon.0 = type { ptr }
%struct.xSTATIC_LIST = type { i32, ptr, %struct.xSTATIC_MINI_LIST_ITEM }
%struct.xSTATIC_MINI_LIST_ITEM = type { i32, [2 x ptr] }
%struct.tmrTimerControl = type { ptr, %struct.xLIST_ITEM, i32, ptr, ptr, i32, i8 }
%struct.xLIST_ITEM = type { i32, ptr, ptr, ptr, ptr }
%struct.tmrTimerQueueMessage = type { i32, %union.anon }
%union.anon = type { %struct.tmrCallbackParameters }
%struct.tmrCallbackParameters = type { ptr, ptr, i32 }
%struct.tmrTimerParameters = type { i32, ptr }

@xTimerQueue = internal global ptr null, align 4
@.str = private unnamed_addr constant [8 x i8] c"Tmr Svc\00", align 1
@xTimerTaskHandle = internal global ptr null, align 4
@Timer_TCB = internal global %struct.xSTATIC_TCB zeroinitializer, align 4
@Timer_Stack = internal global [256 x i32] zeroinitializer, align 4
@pxCurrentTimerList = internal global ptr null, align 4
@pxOverflowTimerList = internal global ptr null, align 4
@prvSampleTimeNow.xLastTime = internal global i32 0, align 4
@xActiveTimerList1 = internal global %struct.xLIST zeroinitializer, align 4
@xActiveTimerList2 = internal global %struct.xLIST zeroinitializer, align 4
@prvCheckForValidListAndQueue.xStaticTimerQueue = internal global %struct.xSTATIC_QUEUE zeroinitializer, align 4
@prvCheckForValidListAndQueue.ucStaticTimerQueueStorage = internal global [160 x i8] zeroinitializer, align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"TmrQ\00", align 1

; Function Attrs: noinline nounwind
define dso_local i32 @xTimerCreateTimerTask() #0 !dbg !7 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4, !dbg !10
  call void @prvCheckForValidListAndQueue(), !dbg !11
  %5 = load ptr, ptr @xTimerQueue, align 4, !dbg !12
  %6 = icmp ne ptr %5, null, !dbg !13
  br i1 %6, label %7, label %16, !dbg !12

7:                                                ; preds = %0
  store ptr null, ptr %2, align 4, !dbg !14
  store ptr null, ptr %3, align 4, !dbg !15
  call void @vApplicationGetTimerTaskMemory(ptr noundef %2, ptr noundef %3, ptr noundef %4), !dbg !16
  %8 = load i32, ptr %4, align 4, !dbg !17
  %9 = load ptr, ptr %3, align 4, !dbg !18
  %10 = load ptr, ptr %2, align 4, !dbg !19
  %11 = call ptr @xTaskCreateStatic(ptr noundef @prvTimerTask, ptr noundef @.str, i32 noundef %8, ptr noundef null, i32 noundef 2, ptr noundef %9, ptr noundef %10), !dbg !20
  store ptr %11, ptr @xTimerTaskHandle, align 4, !dbg !21
  %12 = load ptr, ptr @xTimerTaskHandle, align 4, !dbg !22
  %13 = icmp ne ptr %12, null, !dbg !23
  br i1 %13, label %14, label %15, !dbg !22

14:                                               ; preds = %7
  store i32 1, ptr %1, align 4, !dbg !24
  br label %15, !dbg !25

15:                                               ; preds = %14, %7
  br label %17, !dbg !26

16:                                               ; preds = %0
  br label %17

17:                                               ; preds = %16, %15
  %18 = load i32, ptr %1, align 4, !dbg !27
  ret i32 %18, !dbg !28
}

; Function Attrs: noinline nounwind
define internal void @prvCheckForValidListAndQueue() #0 !dbg !29 {
  call void @vPortEnterCritical(), !dbg !30
  %1 = load ptr, ptr @xTimerQueue, align 4, !dbg !31
  %2 = icmp eq ptr %1, null, !dbg !32
  br i1 %2, label %3, label %11, !dbg !31

3:                                                ; preds = %0
  call void @vListInitialise(ptr noundef @xActiveTimerList1), !dbg !33
  call void @vListInitialise(ptr noundef @xActiveTimerList2), !dbg !34
  store ptr @xActiveTimerList1, ptr @pxCurrentTimerList, align 4, !dbg !35
  store ptr @xActiveTimerList2, ptr @pxOverflowTimerList, align 4, !dbg !36
  %4 = call ptr @xQueueGenericCreateStatic(i32 noundef 10, i32 noundef 16, ptr noundef @prvCheckForValidListAndQueue.ucStaticTimerQueueStorage, ptr noundef @prvCheckForValidListAndQueue.xStaticTimerQueue, i8 noundef zeroext 0), !dbg !37
  store ptr %4, ptr @xTimerQueue, align 4, !dbg !38
  %5 = load ptr, ptr @xTimerQueue, align 4, !dbg !39
  %6 = icmp ne ptr %5, null, !dbg !40
  br i1 %6, label %7, label %9, !dbg !39

7:                                                ; preds = %3
  %8 = load ptr, ptr @xTimerQueue, align 4, !dbg !41
  call void @vQueueAddToRegistry(ptr noundef %8, ptr noundef @.str.1), !dbg !42
  br label %10, !dbg !43

9:                                                ; preds = %3
  br label %10

10:                                               ; preds = %9, %7
  br label %12, !dbg !44

11:                                               ; preds = %0
  br label %12

12:                                               ; preds = %11, %10
  call void @vPortExitCritical(), !dbg !45
  ret void, !dbg !46
}

; Function Attrs: noinline nounwind
define dso_local void @vApplicationGetTimerTaskMemory(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 !dbg !47 {
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  store ptr %0, ptr %4, align 4
  store ptr %1, ptr %5, align 4
  store ptr %2, ptr %6, align 4
  %7 = load ptr, ptr %4, align 4, !dbg !48
  store ptr @Timer_TCB, ptr %7, align 4, !dbg !49
  %8 = load ptr, ptr %5, align 4, !dbg !50
  store ptr @Timer_Stack, ptr %8, align 4, !dbg !51
  %9 = load ptr, ptr %6, align 4, !dbg !52
  store i32 256, ptr %9, align 4, !dbg !53
  ret void, !dbg !54
}

declare dso_local ptr @xTaskCreateStatic(ptr noundef, ptr noundef, i32 noundef, ptr noundef, i32 noundef, ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind
define internal void @prvTimerTask(ptr noundef %0) #0 !dbg !55 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !56
  br label %6, !dbg !57

6:                                                ; preds = %6, %1
  %7 = call i32 @prvGetNextExpireTime(ptr noundef %4), !dbg !58
  store i32 %7, ptr %3, align 4, !dbg !59
  %8 = load i32, ptr %3, align 4, !dbg !60
  %9 = load i32, ptr %4, align 4, !dbg !61
  call void @prvProcessTimerOrBlockTask(i32 noundef %8, i32 noundef %9), !dbg !62
  call void @prvProcessReceivedCommands(), !dbg !63
  br label %6, !dbg !57, !llvm.loop !64
}

; Function Attrs: noinline nounwind
define dso_local ptr @xTimerCreate(ptr noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3, ptr noundef %4) #0 !dbg !66 {
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 4
  %10 = alloca ptr, align 4
  %11 = alloca ptr, align 4
  store ptr %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store ptr %3, ptr %9, align 4
  store ptr %4, ptr %10, align 4
  %12 = call ptr @pvPortMalloc(i32 noundef 44), !dbg !67
  store ptr %12, ptr %11, align 4, !dbg !68
  %13 = load ptr, ptr %11, align 4, !dbg !69
  %14 = icmp ne ptr %13, null, !dbg !70
  br i1 %14, label %15, label %24, !dbg !69

15:                                               ; preds = %5
  %16 = load ptr, ptr %11, align 4, !dbg !71
  %17 = getelementptr inbounds %struct.tmrTimerControl, ptr %16, i32 0, i32 6, !dbg !72
  store i8 0, ptr %17, align 4, !dbg !73
  %18 = load ptr, ptr %6, align 4, !dbg !74
  %19 = load i32, ptr %7, align 4, !dbg !75
  %20 = load i32, ptr %8, align 4, !dbg !76
  %21 = load ptr, ptr %9, align 4, !dbg !77
  %22 = load ptr, ptr %10, align 4, !dbg !78
  %23 = load ptr, ptr %11, align 4, !dbg !79
  call void @prvInitialiseNewTimer(ptr noundef %18, i32 noundef %19, i32 noundef %20, ptr noundef %21, ptr noundef %22, ptr noundef %23), !dbg !80
  br label %24, !dbg !81

24:                                               ; preds = %15, %5
  %25 = load ptr, ptr %11, align 4, !dbg !82
  ret ptr %25, !dbg !83
}

declare dso_local ptr @pvPortMalloc(i32 noundef) #1

; Function Attrs: noinline nounwind
define internal void @prvInitialiseNewTimer(ptr noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5) #0 !dbg !84 {
  %7 = alloca ptr, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 4
  %11 = alloca ptr, align 4
  %12 = alloca ptr, align 4
  store ptr %0, ptr %7, align 4
  store i32 %1, ptr %8, align 4
  store i32 %2, ptr %9, align 4
  store ptr %3, ptr %10, align 4
  store ptr %4, ptr %11, align 4
  store ptr %5, ptr %12, align 4
  call void @prvCheckForValidListAndQueue(), !dbg !85
  %13 = load ptr, ptr %7, align 4, !dbg !86
  %14 = load ptr, ptr %12, align 4, !dbg !87
  %15 = getelementptr inbounds %struct.tmrTimerControl, ptr %14, i32 0, i32 0, !dbg !88
  store ptr %13, ptr %15, align 4, !dbg !89
  %16 = load i32, ptr %8, align 4, !dbg !90
  %17 = load ptr, ptr %12, align 4, !dbg !91
  %18 = getelementptr inbounds %struct.tmrTimerControl, ptr %17, i32 0, i32 2, !dbg !92
  store i32 %16, ptr %18, align 4, !dbg !93
  %19 = load ptr, ptr %10, align 4, !dbg !94
  %20 = load ptr, ptr %12, align 4, !dbg !95
  %21 = getelementptr inbounds %struct.tmrTimerControl, ptr %20, i32 0, i32 3, !dbg !96
  store ptr %19, ptr %21, align 4, !dbg !97
  %22 = load ptr, ptr %11, align 4, !dbg !98
  %23 = load ptr, ptr %12, align 4, !dbg !99
  %24 = getelementptr inbounds %struct.tmrTimerControl, ptr %23, i32 0, i32 4, !dbg !100
  store ptr %22, ptr %24, align 4, !dbg !101
  %25 = load ptr, ptr %12, align 4, !dbg !102
  %26 = getelementptr inbounds %struct.tmrTimerControl, ptr %25, i32 0, i32 1, !dbg !103
  call void @vListInitialiseItem(ptr noundef %26), !dbg !104
  %27 = load i32, ptr %9, align 4, !dbg !105
  %28 = icmp ne i32 %27, 0, !dbg !106
  br i1 %28, label %29, label %36, !dbg !105

29:                                               ; preds = %6
  %30 = load ptr, ptr %12, align 4, !dbg !107
  %31 = getelementptr inbounds %struct.tmrTimerControl, ptr %30, i32 0, i32 6, !dbg !108
  %32 = load i8, ptr %31, align 4, !dbg !109
  %33 = zext i8 %32 to i32, !dbg !109
  %34 = or i32 %33, 4, !dbg !109
  %35 = trunc i32 %34 to i8, !dbg !109
  store i8 %35, ptr %31, align 4, !dbg !109
  br label %36, !dbg !110

36:                                               ; preds = %29, %6
  ret void, !dbg !111
}

; Function Attrs: noinline nounwind
define dso_local ptr @xTimerCreateStatic(ptr noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5) #0 !dbg !112 {
  %7 = alloca ptr, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 4
  %11 = alloca ptr, align 4
  %12 = alloca ptr, align 4
  %13 = alloca ptr, align 4
  store ptr %0, ptr %7, align 4
  store i32 %1, ptr %8, align 4
  store i32 %2, ptr %9, align 4
  store ptr %3, ptr %10, align 4
  store ptr %4, ptr %11, align 4
  store ptr %5, ptr %12, align 4
  %14 = load ptr, ptr %12, align 4, !dbg !113
  store ptr %14, ptr %13, align 4, !dbg !114
  %15 = load ptr, ptr %13, align 4, !dbg !115
  %16 = icmp ne ptr %15, null, !dbg !116
  br i1 %16, label %17, label %26, !dbg !115

17:                                               ; preds = %6
  %18 = load ptr, ptr %13, align 4, !dbg !117
  %19 = getelementptr inbounds %struct.tmrTimerControl, ptr %18, i32 0, i32 6, !dbg !118
  store i8 2, ptr %19, align 4, !dbg !119
  %20 = load ptr, ptr %7, align 4, !dbg !120
  %21 = load i32, ptr %8, align 4, !dbg !121
  %22 = load i32, ptr %9, align 4, !dbg !122
  %23 = load ptr, ptr %10, align 4, !dbg !123
  %24 = load ptr, ptr %11, align 4, !dbg !124
  %25 = load ptr, ptr %13, align 4, !dbg !125
  call void @prvInitialiseNewTimer(ptr noundef %20, i32 noundef %21, i32 noundef %22, ptr noundef %23, ptr noundef %24, ptr noundef %25), !dbg !126
  br label %26, !dbg !127

26:                                               ; preds = %17, %6
  %27 = load ptr, ptr %13, align 4, !dbg !128
  ret ptr %27, !dbg !129
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTimerGenericCommand(ptr noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3, i32 noundef %4) #0 !dbg !130 {
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca %struct.tmrTimerQueueMessage, align 4
  store ptr %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store ptr %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  store i32 0, ptr %11, align 4, !dbg !131
  %13 = load ptr, ptr @xTimerQueue, align 4, !dbg !132
  %14 = icmp ne ptr %13, null, !dbg !133
  br i1 %14, label %15, label %42, !dbg !132

15:                                               ; preds = %5
  %16 = load i32, ptr %7, align 4, !dbg !134
  %17 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %12, i32 0, i32 0, !dbg !135
  store i32 %16, ptr %17, align 4, !dbg !136
  %18 = load i32, ptr %8, align 4, !dbg !137
  %19 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %12, i32 0, i32 1, !dbg !138
  %20 = getelementptr inbounds %struct.tmrTimerParameters, ptr %19, i32 0, i32 0, !dbg !139
  store i32 %18, ptr %20, align 4, !dbg !140
  %21 = load ptr, ptr %6, align 4, !dbg !141
  %22 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %12, i32 0, i32 1, !dbg !142
  %23 = getelementptr inbounds %struct.tmrTimerParameters, ptr %22, i32 0, i32 1, !dbg !143
  store ptr %21, ptr %23, align 4, !dbg !144
  %24 = load i32, ptr %7, align 4, !dbg !145
  %25 = icmp slt i32 %24, 6, !dbg !146
  br i1 %25, label %26, label %37, !dbg !145

26:                                               ; preds = %15
  %27 = call i32 @xTaskGetSchedulerState(), !dbg !147
  %28 = icmp eq i32 %27, 2, !dbg !148
  br i1 %28, label %29, label %33, !dbg !147

29:                                               ; preds = %26
  %30 = load ptr, ptr @xTimerQueue, align 4, !dbg !149
  %31 = load i32, ptr %10, align 4, !dbg !149
  %32 = call i32 @xQueueGenericSend(ptr noundef %30, ptr noundef %12, i32 noundef %31, i32 noundef 0), !dbg !149
  store i32 %32, ptr %11, align 4, !dbg !150
  br label %36, !dbg !151

33:                                               ; preds = %26
  %34 = load ptr, ptr @xTimerQueue, align 4, !dbg !152
  %35 = call i32 @xQueueGenericSend(ptr noundef %34, ptr noundef %12, i32 noundef 0, i32 noundef 0), !dbg !152
  store i32 %35, ptr %11, align 4, !dbg !153
  br label %36

36:                                               ; preds = %33, %29
  br label %41, !dbg !154

37:                                               ; preds = %15
  %38 = load ptr, ptr @xTimerQueue, align 4, !dbg !155
  %39 = load ptr, ptr %9, align 4, !dbg !155
  %40 = call i32 @xQueueGenericSendFromISR(ptr noundef %38, ptr noundef %12, ptr noundef %39, i32 noundef 0), !dbg !155
  store i32 %40, ptr %11, align 4, !dbg !156
  br label %41

41:                                               ; preds = %37, %36
  br label %43, !dbg !157

42:                                               ; preds = %5
  br label %43

43:                                               ; preds = %42, %41
  %44 = load i32, ptr %11, align 4, !dbg !158
  ret i32 %44, !dbg !159
}

declare dso_local i32 @xTaskGetSchedulerState() #1

declare dso_local i32 @xQueueGenericSend(ptr noundef, ptr noundef, i32 noundef, i32 noundef) #1

declare dso_local i32 @xQueueGenericSendFromISR(ptr noundef, ptr noundef, ptr noundef, i32 noundef) #1

; Function Attrs: noinline nounwind
define dso_local ptr @xTimerGetTimerDaemonTaskHandle() #0 !dbg !160 {
  %1 = load ptr, ptr @xTimerTaskHandle, align 4, !dbg !161
  ret ptr %1, !dbg !162
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTimerGetPeriod(ptr noundef %0) #0 !dbg !163 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %4 = load ptr, ptr %2, align 4, !dbg !164
  store ptr %4, ptr %3, align 4, !dbg !165
  %5 = load ptr, ptr %3, align 4, !dbg !166
  %6 = getelementptr inbounds %struct.tmrTimerControl, ptr %5, i32 0, i32 2, !dbg !167
  %7 = load i32, ptr %6, align 4, !dbg !167
  ret i32 %7, !dbg !168
}

; Function Attrs: noinline nounwind
define dso_local void @vTimerSetReloadMode(ptr noundef %0, i32 noundef %1) #0 !dbg !169 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %6 = load ptr, ptr %3, align 4, !dbg !170
  store ptr %6, ptr %5, align 4, !dbg !171
  call void @vPortEnterCritical(), !dbg !172
  %7 = load i32, ptr %4, align 4, !dbg !173
  %8 = icmp ne i32 %7, 0, !dbg !174
  br i1 %8, label %9, label %16, !dbg !173

9:                                                ; preds = %2
  %10 = load ptr, ptr %5, align 4, !dbg !175
  %11 = getelementptr inbounds %struct.tmrTimerControl, ptr %10, i32 0, i32 6, !dbg !176
  %12 = load i8, ptr %11, align 4, !dbg !177
  %13 = zext i8 %12 to i32, !dbg !177
  %14 = or i32 %13, 4, !dbg !177
  %15 = trunc i32 %14 to i8, !dbg !177
  store i8 %15, ptr %11, align 4, !dbg !177
  br label %23, !dbg !178

16:                                               ; preds = %2
  %17 = load ptr, ptr %5, align 4, !dbg !179
  %18 = getelementptr inbounds %struct.tmrTimerControl, ptr %17, i32 0, i32 6, !dbg !180
  %19 = load i8, ptr %18, align 4, !dbg !181
  %20 = zext i8 %19 to i32, !dbg !181
  %21 = and i32 %20, 251, !dbg !181
  %22 = trunc i32 %21 to i8, !dbg !181
  store i8 %22, ptr %18, align 4, !dbg !181
  br label %23

23:                                               ; preds = %16, %9
  call void @vPortExitCritical(), !dbg !182
  ret void, !dbg !183
}

declare dso_local void @vPortEnterCritical() #1

declare dso_local void @vPortExitCritical() #1

; Function Attrs: noinline nounwind
define dso_local i32 @uxTimerGetReloadMode(ptr noundef %0) #0 !dbg !184 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !185
  store ptr %5, ptr %3, align 4, !dbg !186
  call void @vPortEnterCritical(), !dbg !187
  %6 = load ptr, ptr %3, align 4, !dbg !188
  %7 = getelementptr inbounds %struct.tmrTimerControl, ptr %6, i32 0, i32 6, !dbg !189
  %8 = load i8, ptr %7, align 4, !dbg !189
  %9 = zext i8 %8 to i32, !dbg !188
  %10 = and i32 %9, 4, !dbg !190
  %11 = icmp eq i32 %10, 0, !dbg !191
  br i1 %11, label %12, label %13, !dbg !192

12:                                               ; preds = %1
  store i32 0, ptr %4, align 4, !dbg !193
  br label %14, !dbg !194

13:                                               ; preds = %1
  store i32 1, ptr %4, align 4, !dbg !195
  br label %14

14:                                               ; preds = %13, %12
  call void @vPortExitCritical(), !dbg !196
  %15 = load i32, ptr %4, align 4, !dbg !197
  ret i32 %15, !dbg !198
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTimerGetExpiryTime(ptr noundef %0) #0 !dbg !199 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !200
  store ptr %5, ptr %3, align 4, !dbg !201
  %6 = load ptr, ptr %3, align 4, !dbg !202
  %7 = getelementptr inbounds %struct.tmrTimerControl, ptr %6, i32 0, i32 1, !dbg !202
  %8 = getelementptr inbounds %struct.xLIST_ITEM, ptr %7, i32 0, i32 0, !dbg !202
  %9 = load i32, ptr %8, align 4, !dbg !202
  store i32 %9, ptr %4, align 4, !dbg !203
  %10 = load i32, ptr %4, align 4, !dbg !204
  ret i32 %10, !dbg !205
}

; Function Attrs: noinline nounwind
define dso_local ptr @pcTimerGetName(ptr noundef %0) #0 !dbg !206 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %4 = load ptr, ptr %2, align 4, !dbg !207
  store ptr %4, ptr %3, align 4, !dbg !208
  %5 = load ptr, ptr %3, align 4, !dbg !209
  %6 = getelementptr inbounds %struct.tmrTimerControl, ptr %5, i32 0, i32 0, !dbg !210
  %7 = load ptr, ptr %6, align 4, !dbg !210
  ret ptr %7, !dbg !211
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTimerIsTimerActive(ptr noundef %0) #0 !dbg !212 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !213
  store ptr %5, ptr %4, align 4, !dbg !214
  call void @vPortEnterCritical(), !dbg !215
  %6 = load ptr, ptr %4, align 4, !dbg !216
  %7 = getelementptr inbounds %struct.tmrTimerControl, ptr %6, i32 0, i32 6, !dbg !217
  %8 = load i8, ptr %7, align 4, !dbg !217
  %9 = zext i8 %8 to i32, !dbg !216
  %10 = and i32 %9, 1, !dbg !218
  %11 = icmp eq i32 %10, 0, !dbg !219
  br i1 %11, label %12, label %13, !dbg !220

12:                                               ; preds = %1
  store i32 0, ptr %3, align 4, !dbg !221
  br label %14, !dbg !222

13:                                               ; preds = %1
  store i32 1, ptr %3, align 4, !dbg !223
  br label %14

14:                                               ; preds = %13, %12
  call void @vPortExitCritical(), !dbg !224
  %15 = load i32, ptr %3, align 4, !dbg !225
  ret i32 %15, !dbg !226
}

; Function Attrs: noinline nounwind
define dso_local ptr @pvTimerGetTimerID(ptr noundef %0) #0 !dbg !227 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !228
  store ptr %5, ptr %3, align 4, !dbg !229
  call void @vPortEnterCritical(), !dbg !230
  %6 = load ptr, ptr %3, align 4, !dbg !231
  %7 = getelementptr inbounds %struct.tmrTimerControl, ptr %6, i32 0, i32 3, !dbg !232
  %8 = load ptr, ptr %7, align 4, !dbg !232
  store ptr %8, ptr %4, align 4, !dbg !233
  call void @vPortExitCritical(), !dbg !234
  %9 = load ptr, ptr %4, align 4, !dbg !235
  ret ptr %9, !dbg !236
}

; Function Attrs: noinline nounwind
define dso_local void @vTimerSetTimerID(ptr noundef %0, ptr noundef %1) #0 !dbg !237 {
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store ptr %1, ptr %4, align 4
  %6 = load ptr, ptr %3, align 4, !dbg !238
  store ptr %6, ptr %5, align 4, !dbg !239
  call void @vPortEnterCritical(), !dbg !240
  %7 = load ptr, ptr %4, align 4, !dbg !241
  %8 = load ptr, ptr %5, align 4, !dbg !242
  %9 = getelementptr inbounds %struct.tmrTimerControl, ptr %8, i32 0, i32 3, !dbg !243
  store ptr %7, ptr %9, align 4, !dbg !244
  call void @vPortExitCritical(), !dbg !245
  ret void, !dbg !246
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTimerPendFunctionCallFromISR(ptr noundef %0, ptr noundef %1, i32 noundef %2, ptr noundef %3) #0 !dbg !247 {
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 4
  %9 = alloca %struct.tmrTimerQueueMessage, align 4
  %10 = alloca i32, align 4
  store ptr %0, ptr %5, align 4
  store ptr %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store ptr %3, ptr %8, align 4
  %11 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %9, i32 0, i32 0, !dbg !248
  store i32 -2, ptr %11, align 4, !dbg !249
  %12 = load ptr, ptr %5, align 4, !dbg !250
  %13 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %9, i32 0, i32 1, !dbg !251
  %14 = getelementptr inbounds %struct.tmrCallbackParameters, ptr %13, i32 0, i32 0, !dbg !252
  store ptr %12, ptr %14, align 4, !dbg !253
  %15 = load ptr, ptr %6, align 4, !dbg !254
  %16 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %9, i32 0, i32 1, !dbg !255
  %17 = getelementptr inbounds %struct.tmrCallbackParameters, ptr %16, i32 0, i32 1, !dbg !256
  store ptr %15, ptr %17, align 4, !dbg !257
  %18 = load i32, ptr %7, align 4, !dbg !258
  %19 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %9, i32 0, i32 1, !dbg !259
  %20 = getelementptr inbounds %struct.tmrCallbackParameters, ptr %19, i32 0, i32 2, !dbg !260
  store i32 %18, ptr %20, align 4, !dbg !261
  %21 = load ptr, ptr @xTimerQueue, align 4, !dbg !262
  %22 = load ptr, ptr %8, align 4, !dbg !262
  %23 = call i32 @xQueueGenericSendFromISR(ptr noundef %21, ptr noundef %9, ptr noundef %22, i32 noundef 0), !dbg !262
  store i32 %23, ptr %10, align 4, !dbg !263
  %24 = load i32, ptr %10, align 4, !dbg !264
  ret i32 %24, !dbg !265
}

; Function Attrs: noinline nounwind
define dso_local i32 @xTimerPendFunctionCall(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 !dbg !266 {
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca %struct.tmrTimerQueueMessage, align 4
  %10 = alloca i32, align 4
  store ptr %0, ptr %5, align 4
  store ptr %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %11 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %9, i32 0, i32 0, !dbg !267
  store i32 -1, ptr %11, align 4, !dbg !268
  %12 = load ptr, ptr %5, align 4, !dbg !269
  %13 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %9, i32 0, i32 1, !dbg !270
  %14 = getelementptr inbounds %struct.tmrCallbackParameters, ptr %13, i32 0, i32 0, !dbg !271
  store ptr %12, ptr %14, align 4, !dbg !272
  %15 = load ptr, ptr %6, align 4, !dbg !273
  %16 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %9, i32 0, i32 1, !dbg !274
  %17 = getelementptr inbounds %struct.tmrCallbackParameters, ptr %16, i32 0, i32 1, !dbg !275
  store ptr %15, ptr %17, align 4, !dbg !276
  %18 = load i32, ptr %7, align 4, !dbg !277
  %19 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %9, i32 0, i32 1, !dbg !278
  %20 = getelementptr inbounds %struct.tmrCallbackParameters, ptr %19, i32 0, i32 2, !dbg !279
  store i32 %18, ptr %20, align 4, !dbg !280
  %21 = load ptr, ptr @xTimerQueue, align 4, !dbg !281
  %22 = load i32, ptr %8, align 4, !dbg !281
  %23 = call i32 @xQueueGenericSend(ptr noundef %21, ptr noundef %9, i32 noundef %22, i32 noundef 0), !dbg !281
  store i32 %23, ptr %10, align 4, !dbg !282
  %24 = load i32, ptr %10, align 4, !dbg !283
  ret i32 %24, !dbg !284
}

; Function Attrs: noinline nounwind
define dso_local i32 @uxTimerGetTimerNumber(ptr noundef %0) #0 !dbg !285 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %3 = load ptr, ptr %2, align 4, !dbg !286
  %4 = getelementptr inbounds %struct.tmrTimerControl, ptr %3, i32 0, i32 5, !dbg !287
  %5 = load i32, ptr %4, align 4, !dbg !287
  ret i32 %5, !dbg !288
}

; Function Attrs: noinline nounwind
define dso_local void @vTimerSetTimerNumber(ptr noundef %0, i32 noundef %1) #0 !dbg !289 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %4, align 4, !dbg !290
  %6 = load ptr, ptr %3, align 4, !dbg !291
  %7 = getelementptr inbounds %struct.tmrTimerControl, ptr %6, i32 0, i32 5, !dbg !292
  store i32 %5, ptr %7, align 4, !dbg !293
  ret void, !dbg !294
}

declare dso_local void @vListInitialiseItem(ptr noundef) #1

; Function Attrs: noinline nounwind
define internal i32 @prvGetNextExpireTime(ptr noundef %0) #0 !dbg !295 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  %4 = load ptr, ptr @pxCurrentTimerList, align 4, !dbg !296
  %5 = getelementptr inbounds %struct.xLIST, ptr %4, i32 0, i32 0, !dbg !296
  %6 = load volatile i32, ptr %5, align 4, !dbg !296
  %7 = icmp eq i32 %6, 0, !dbg !296
  %8 = zext i1 %7 to i64, !dbg !296
  %9 = select i1 %7, i32 1, i32 0, !dbg !296
  %10 = load ptr, ptr %2, align 4, !dbg !297
  store i32 %9, ptr %10, align 4, !dbg !298
  %11 = load ptr, ptr %2, align 4, !dbg !299
  %12 = load i32, ptr %11, align 4, !dbg !300
  %13 = icmp eq i32 %12, 0, !dbg !301
  br i1 %13, label %14, label %21, !dbg !300

14:                                               ; preds = %1
  %15 = load ptr, ptr @pxCurrentTimerList, align 4, !dbg !302
  %16 = getelementptr inbounds %struct.xLIST, ptr %15, i32 0, i32 2, !dbg !302
  %17 = getelementptr inbounds %struct.xMINI_LIST_ITEM, ptr %16, i32 0, i32 1, !dbg !302
  %18 = load ptr, ptr %17, align 4, !dbg !302
  %19 = getelementptr inbounds %struct.xLIST_ITEM, ptr %18, i32 0, i32 0, !dbg !302
  %20 = load i32, ptr %19, align 4, !dbg !302
  store i32 %20, ptr %3, align 4, !dbg !303
  br label %22, !dbg !304

21:                                               ; preds = %1
  store i32 0, ptr %3, align 4, !dbg !305
  br label %22

22:                                               ; preds = %21, %14
  %23 = load i32, ptr %3, align 4, !dbg !306
  ret i32 %23, !dbg !307
}

; Function Attrs: noinline nounwind
define internal void @prvProcessTimerOrBlockTask(i32 noundef %0, i32 noundef %1) #0 !dbg !308 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  call void @vTaskSuspendAll(), !dbg !309
  %7 = call i32 @prvSampleTimeNow(ptr noundef %6), !dbg !310
  store i32 %7, ptr %5, align 4, !dbg !311
  %8 = load i32, ptr %6, align 4, !dbg !312
  %9 = icmp eq i32 %8, 0, !dbg !313
  br i1 %9, label %10, label %43, !dbg !312

10:                                               ; preds = %2
  %11 = load i32, ptr %4, align 4, !dbg !314
  %12 = icmp eq i32 %11, 0, !dbg !315
  br i1 %12, label %13, label %21, !dbg !316

13:                                               ; preds = %10
  %14 = load i32, ptr %3, align 4, !dbg !317
  %15 = load i32, ptr %5, align 4, !dbg !318
  %16 = icmp ule i32 %14, %15, !dbg !319
  br i1 %16, label %17, label %21, !dbg !320

17:                                               ; preds = %13
  %18 = call i32 @xTaskResumeAll(), !dbg !321
  %19 = load i32, ptr %3, align 4, !dbg !322
  %20 = load i32, ptr %5, align 4, !dbg !323
  call void @prvProcessExpiredTimer(i32 noundef %19, i32 noundef %20), !dbg !324
  br label %42, !dbg !325

21:                                               ; preds = %13, %10
  %22 = load i32, ptr %4, align 4, !dbg !326
  %23 = icmp ne i32 %22, 0, !dbg !327
  br i1 %23, label %24, label %31, !dbg !326

24:                                               ; preds = %21
  %25 = load ptr, ptr @pxOverflowTimerList, align 4, !dbg !328
  %26 = getelementptr inbounds %struct.xLIST, ptr %25, i32 0, i32 0, !dbg !328
  %27 = load volatile i32, ptr %26, align 4, !dbg !328
  %28 = icmp eq i32 %27, 0, !dbg !328
  %29 = zext i1 %28 to i64, !dbg !328
  %30 = select i1 %28, i32 1, i32 0, !dbg !328
  store i32 %30, ptr %4, align 4, !dbg !329
  br label %31, !dbg !330

31:                                               ; preds = %24, %21
  %32 = load ptr, ptr @xTimerQueue, align 4, !dbg !331
  %33 = load i32, ptr %3, align 4, !dbg !332
  %34 = load i32, ptr %5, align 4, !dbg !333
  %35 = sub i32 %33, %34, !dbg !334
  %36 = load i32, ptr %4, align 4, !dbg !335
  call void @vQueueWaitForMessageRestricted(ptr noundef %32, i32 noundef %35, i32 noundef %36), !dbg !336
  %37 = call i32 @xTaskResumeAll(), !dbg !337
  %38 = icmp eq i32 %37, 0, !dbg !338
  br i1 %38, label %39, label %40, !dbg !337

39:                                               ; preds = %31
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !339
  call void asm sideeffect "dsb", "~{memory}"() #2, !dbg !339, !srcloc !340
  call void asm sideeffect "isb", ""() #2, !dbg !339, !srcloc !341
  br label %41, !dbg !342

40:                                               ; preds = %31
  br label %41

41:                                               ; preds = %40, %39
  br label %42

42:                                               ; preds = %41, %17
  br label %45, !dbg !343

43:                                               ; preds = %2
  %44 = call i32 @xTaskResumeAll(), !dbg !344
  br label %45

45:                                               ; preds = %43, %42
  ret void, !dbg !345
}

; Function Attrs: noinline nounwind
define internal void @prvProcessReceivedCommands() #0 !dbg !346 {
  %1 = alloca %struct.tmrTimerQueueMessage, align 4
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  br label %6, !dbg !347

6:                                                ; preds = %150, %0
  %7 = load ptr, ptr @xTimerQueue, align 4, !dbg !348
  %8 = call i32 @xQueueReceive(ptr noundef %7, ptr noundef %1, i32 noundef 0), !dbg !349
  %9 = icmp ne i32 %8, 0, !dbg !350
  br i1 %9, label %10, label %151, !dbg !347

10:                                               ; preds = %6
  %11 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %1, i32 0, i32 0, !dbg !351
  %12 = load i32, ptr %11, align 4, !dbg !351
  %13 = icmp slt i32 %12, 0, !dbg !352
  br i1 %13, label %14, label %25, !dbg !353

14:                                               ; preds = %10
  %15 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %1, i32 0, i32 1, !dbg !354
  store ptr %15, ptr %5, align 4, !dbg !355
  %16 = load ptr, ptr %5, align 4, !dbg !356
  %17 = getelementptr inbounds %struct.tmrCallbackParameters, ptr %16, i32 0, i32 0, !dbg !357
  %18 = load ptr, ptr %17, align 4, !dbg !357
  %19 = load ptr, ptr %5, align 4, !dbg !358
  %20 = getelementptr inbounds %struct.tmrCallbackParameters, ptr %19, i32 0, i32 1, !dbg !359
  %21 = load ptr, ptr %20, align 4, !dbg !359
  %22 = load ptr, ptr %5, align 4, !dbg !360
  %23 = getelementptr inbounds %struct.tmrCallbackParameters, ptr %22, i32 0, i32 2, !dbg !361
  %24 = load i32, ptr %23, align 4, !dbg !361
  call void %18(ptr noundef %21, i32 noundef %24), !dbg !356
  br label %26, !dbg !362

25:                                               ; preds = %10
  br label %26

26:                                               ; preds = %25, %14
  %27 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %1, i32 0, i32 0, !dbg !363
  %28 = load i32, ptr %27, align 4, !dbg !363
  %29 = icmp sge i32 %28, 0, !dbg !364
  br i1 %29, label %30, label %150, !dbg !365

30:                                               ; preds = %26
  %31 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %1, i32 0, i32 1, !dbg !366
  %32 = getelementptr inbounds %struct.tmrTimerParameters, ptr %31, i32 0, i32 1, !dbg !367
  %33 = load ptr, ptr %32, align 4, !dbg !367
  store ptr %33, ptr %2, align 4, !dbg !368
  %34 = load ptr, ptr %2, align 4, !dbg !369
  %35 = getelementptr inbounds %struct.tmrTimerControl, ptr %34, i32 0, i32 1, !dbg !369
  %36 = getelementptr inbounds %struct.xLIST_ITEM, ptr %35, i32 0, i32 4, !dbg !369
  %37 = load ptr, ptr %36, align 4, !dbg !369
  %38 = icmp eq ptr %37, null, !dbg !369
  %39 = zext i1 %38 to i64, !dbg !369
  %40 = select i1 %38, i32 1, i32 0, !dbg !369
  %41 = icmp eq i32 %40, 0, !dbg !370
  br i1 %41, label %42, label %46, !dbg !369

42:                                               ; preds = %30
  %43 = load ptr, ptr %2, align 4, !dbg !371
  %44 = getelementptr inbounds %struct.tmrTimerControl, ptr %43, i32 0, i32 1, !dbg !372
  %45 = call i32 @uxListRemove(ptr noundef %44), !dbg !373
  br label %47, !dbg !374

46:                                               ; preds = %30
  br label %47

47:                                               ; preds = %46, %42
  %48 = call i32 @prvSampleTimeNow(ptr noundef %3), !dbg !375
  store i32 %48, ptr %4, align 4, !dbg !376
  %49 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %1, i32 0, i32 0, !dbg !377
  %50 = load i32, ptr %49, align 4, !dbg !377
  switch i32 %50, label %148 [
    i32 1, label %51
    i32 6, label %51
    i32 2, label %51
    i32 7, label %51
    i32 3, label %103
    i32 8, label %103
    i32 4, label %110
    i32 9, label %110
    i32 5, label %131
  ], !dbg !378

51:                                               ; preds = %47, %47, %47, %47
  %52 = load ptr, ptr %2, align 4, !dbg !379
  %53 = getelementptr inbounds %struct.tmrTimerControl, ptr %52, i32 0, i32 6, !dbg !380
  %54 = load i8, ptr %53, align 4, !dbg !381
  %55 = zext i8 %54 to i32, !dbg !381
  %56 = or i32 %55, 1, !dbg !381
  %57 = trunc i32 %56 to i8, !dbg !381
  store i8 %57, ptr %53, align 4, !dbg !381
  %58 = load ptr, ptr %2, align 4, !dbg !382
  %59 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %1, i32 0, i32 1, !dbg !383
  %60 = getelementptr inbounds %struct.tmrTimerParameters, ptr %59, i32 0, i32 0, !dbg !384
  %61 = load i32, ptr %60, align 4, !dbg !384
  %62 = load ptr, ptr %2, align 4, !dbg !385
  %63 = getelementptr inbounds %struct.tmrTimerControl, ptr %62, i32 0, i32 2, !dbg !386
  %64 = load i32, ptr %63, align 4, !dbg !386
  %65 = add i32 %61, %64, !dbg !387
  %66 = load i32, ptr %4, align 4, !dbg !388
  %67 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %1, i32 0, i32 1, !dbg !389
  %68 = getelementptr inbounds %struct.tmrTimerParameters, ptr %67, i32 0, i32 0, !dbg !390
  %69 = load i32, ptr %68, align 4, !dbg !390
  %70 = call i32 @prvInsertTimerInActiveList(ptr noundef %58, i32 noundef %65, i32 noundef %66, i32 noundef %69), !dbg !391
  %71 = icmp ne i32 %70, 0, !dbg !392
  br i1 %71, label %72, label %101, !dbg !391

72:                                               ; preds = %51
  %73 = load ptr, ptr %2, align 4, !dbg !393
  %74 = getelementptr inbounds %struct.tmrTimerControl, ptr %73, i32 0, i32 6, !dbg !394
  %75 = load i8, ptr %74, align 4, !dbg !394
  %76 = zext i8 %75 to i32, !dbg !393
  %77 = and i32 %76, 4, !dbg !395
  %78 = icmp ne i32 %77, 0, !dbg !396
  br i1 %78, label %79, label %89, !dbg !397

79:                                               ; preds = %72
  %80 = load ptr, ptr %2, align 4, !dbg !398
  %81 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %1, i32 0, i32 1, !dbg !399
  %82 = getelementptr inbounds %struct.tmrTimerParameters, ptr %81, i32 0, i32 0, !dbg !400
  %83 = load i32, ptr %82, align 4, !dbg !400
  %84 = load ptr, ptr %2, align 4, !dbg !401
  %85 = getelementptr inbounds %struct.tmrTimerControl, ptr %84, i32 0, i32 2, !dbg !402
  %86 = load i32, ptr %85, align 4, !dbg !402
  %87 = add i32 %83, %86, !dbg !403
  %88 = load i32, ptr %4, align 4, !dbg !404
  call void @prvReloadTimer(ptr noundef %80, i32 noundef %87, i32 noundef %88), !dbg !405
  br label %96, !dbg !406

89:                                               ; preds = %72
  %90 = load ptr, ptr %2, align 4, !dbg !407
  %91 = getelementptr inbounds %struct.tmrTimerControl, ptr %90, i32 0, i32 6, !dbg !408
  %92 = load i8, ptr %91, align 4, !dbg !409
  %93 = zext i8 %92 to i32, !dbg !409
  %94 = and i32 %93, 254, !dbg !409
  %95 = trunc i32 %94 to i8, !dbg !409
  store i8 %95, ptr %91, align 4, !dbg !409
  br label %96

96:                                               ; preds = %89, %79
  %97 = load ptr, ptr %2, align 4, !dbg !410
  %98 = getelementptr inbounds %struct.tmrTimerControl, ptr %97, i32 0, i32 4, !dbg !411
  %99 = load ptr, ptr %98, align 4, !dbg !411
  %100 = load ptr, ptr %2, align 4, !dbg !412
  call void %99(ptr noundef %100), !dbg !410
  br label %102, !dbg !413

101:                                              ; preds = %51
  br label %102

102:                                              ; preds = %101, %96
  br label %149, !dbg !414

103:                                              ; preds = %47, %47
  %104 = load ptr, ptr %2, align 4, !dbg !415
  %105 = getelementptr inbounds %struct.tmrTimerControl, ptr %104, i32 0, i32 6, !dbg !416
  %106 = load i8, ptr %105, align 4, !dbg !417
  %107 = zext i8 %106 to i32, !dbg !417
  %108 = and i32 %107, 254, !dbg !417
  %109 = trunc i32 %108 to i8, !dbg !417
  store i8 %109, ptr %105, align 4, !dbg !417
  br label %149, !dbg !418

110:                                              ; preds = %47, %47
  %111 = load ptr, ptr %2, align 4, !dbg !419
  %112 = getelementptr inbounds %struct.tmrTimerControl, ptr %111, i32 0, i32 6, !dbg !420
  %113 = load i8, ptr %112, align 4, !dbg !421
  %114 = zext i8 %113 to i32, !dbg !421
  %115 = or i32 %114, 1, !dbg !421
  %116 = trunc i32 %115 to i8, !dbg !421
  store i8 %116, ptr %112, align 4, !dbg !421
  %117 = getelementptr inbounds %struct.tmrTimerQueueMessage, ptr %1, i32 0, i32 1, !dbg !422
  %118 = getelementptr inbounds %struct.tmrTimerParameters, ptr %117, i32 0, i32 0, !dbg !423
  %119 = load i32, ptr %118, align 4, !dbg !423
  %120 = load ptr, ptr %2, align 4, !dbg !424
  %121 = getelementptr inbounds %struct.tmrTimerControl, ptr %120, i32 0, i32 2, !dbg !425
  store i32 %119, ptr %121, align 4, !dbg !426
  %122 = load ptr, ptr %2, align 4, !dbg !427
  %123 = load i32, ptr %4, align 4, !dbg !428
  %124 = load ptr, ptr %2, align 4, !dbg !429
  %125 = getelementptr inbounds %struct.tmrTimerControl, ptr %124, i32 0, i32 2, !dbg !430
  %126 = load i32, ptr %125, align 4, !dbg !430
  %127 = add i32 %123, %126, !dbg !431
  %128 = load i32, ptr %4, align 4, !dbg !432
  %129 = load i32, ptr %4, align 4, !dbg !433
  %130 = call i32 @prvInsertTimerInActiveList(ptr noundef %122, i32 noundef %127, i32 noundef %128, i32 noundef %129), !dbg !434
  br label %149, !dbg !435

131:                                              ; preds = %47
  %132 = load ptr, ptr %2, align 4, !dbg !436
  %133 = getelementptr inbounds %struct.tmrTimerControl, ptr %132, i32 0, i32 6, !dbg !437
  %134 = load i8, ptr %133, align 4, !dbg !437
  %135 = zext i8 %134 to i32, !dbg !436
  %136 = and i32 %135, 2, !dbg !438
  %137 = icmp eq i32 %136, 0, !dbg !439
  br i1 %137, label %138, label %140, !dbg !440

138:                                              ; preds = %131
  %139 = load ptr, ptr %2, align 4, !dbg !441
  call void @vPortFree(ptr noundef %139), !dbg !442
  br label %147, !dbg !443

140:                                              ; preds = %131
  %141 = load ptr, ptr %2, align 4, !dbg !444
  %142 = getelementptr inbounds %struct.tmrTimerControl, ptr %141, i32 0, i32 6, !dbg !445
  %143 = load i8, ptr %142, align 4, !dbg !446
  %144 = zext i8 %143 to i32, !dbg !446
  %145 = and i32 %144, 254, !dbg !446
  %146 = trunc i32 %145 to i8, !dbg !446
  store i8 %146, ptr %142, align 4, !dbg !446
  br label %147

147:                                              ; preds = %140, %138
  br label %149, !dbg !447

148:                                              ; preds = %47
  br label %149, !dbg !448

149:                                              ; preds = %148, %147, %110, %103, %102
  br label %150, !dbg !449

150:                                              ; preds = %149, %26
  br label %6, !dbg !347, !llvm.loop !450

151:                                              ; preds = %6
  ret void, !dbg !453
}

declare dso_local void @vTaskSuspendAll() #1

; Function Attrs: noinline nounwind
define internal i32 @prvSampleTimeNow(ptr noundef %0) #0 !dbg !454 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  %4 = call i32 @xTaskGetTickCount(), !dbg !455
  store i32 %4, ptr %3, align 4, !dbg !456
  %5 = load i32, ptr %3, align 4, !dbg !457
  %6 = load i32, ptr @prvSampleTimeNow.xLastTime, align 4, !dbg !458
  %7 = icmp ult i32 %5, %6, !dbg !459
  br i1 %7, label %8, label %10, !dbg !457

8:                                                ; preds = %1
  call void @prvSwitchTimerLists(), !dbg !460
  %9 = load ptr, ptr %2, align 4, !dbg !461
  store i32 1, ptr %9, align 4, !dbg !462
  br label %12, !dbg !463

10:                                               ; preds = %1
  %11 = load ptr, ptr %2, align 4, !dbg !464
  store i32 0, ptr %11, align 4, !dbg !465
  br label %12

12:                                               ; preds = %10, %8
  %13 = load i32, ptr %3, align 4, !dbg !466
  store i32 %13, ptr @prvSampleTimeNow.xLastTime, align 4, !dbg !467
  %14 = load i32, ptr %3, align 4, !dbg !468
  ret i32 %14, !dbg !469
}

declare dso_local i32 @xTaskResumeAll() #1

; Function Attrs: noinline nounwind
define internal void @prvProcessExpiredTimer(i32 noundef %0, i32 noundef %1) #0 !dbg !470 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %6 = load ptr, ptr @pxCurrentTimerList, align 4, !dbg !471
  %7 = getelementptr inbounds %struct.xLIST, ptr %6, i32 0, i32 2, !dbg !471
  %8 = getelementptr inbounds %struct.xMINI_LIST_ITEM, ptr %7, i32 0, i32 1, !dbg !471
  %9 = load ptr, ptr %8, align 4, !dbg !471
  %10 = getelementptr inbounds %struct.xLIST_ITEM, ptr %9, i32 0, i32 3, !dbg !471
  %11 = load ptr, ptr %10, align 4, !dbg !471
  store ptr %11, ptr %5, align 4, !dbg !472
  %12 = load ptr, ptr %5, align 4, !dbg !473
  %13 = getelementptr inbounds %struct.tmrTimerControl, ptr %12, i32 0, i32 1, !dbg !474
  %14 = call i32 @uxListRemove(ptr noundef %13), !dbg !475
  %15 = load ptr, ptr %5, align 4, !dbg !476
  %16 = getelementptr inbounds %struct.tmrTimerControl, ptr %15, i32 0, i32 6, !dbg !477
  %17 = load i8, ptr %16, align 4, !dbg !477
  %18 = zext i8 %17 to i32, !dbg !476
  %19 = and i32 %18, 4, !dbg !478
  %20 = icmp ne i32 %19, 0, !dbg !479
  br i1 %20, label %21, label %25, !dbg !480

21:                                               ; preds = %2
  %22 = load ptr, ptr %5, align 4, !dbg !481
  %23 = load i32, ptr %3, align 4, !dbg !482
  %24 = load i32, ptr %4, align 4, !dbg !483
  call void @prvReloadTimer(ptr noundef %22, i32 noundef %23, i32 noundef %24), !dbg !484
  br label %32, !dbg !485

25:                                               ; preds = %2
  %26 = load ptr, ptr %5, align 4, !dbg !486
  %27 = getelementptr inbounds %struct.tmrTimerControl, ptr %26, i32 0, i32 6, !dbg !487
  %28 = load i8, ptr %27, align 4, !dbg !488
  %29 = zext i8 %28 to i32, !dbg !488
  %30 = and i32 %29, 254, !dbg !488
  %31 = trunc i32 %30 to i8, !dbg !488
  store i8 %31, ptr %27, align 4, !dbg !488
  br label %32

32:                                               ; preds = %25, %21
  %33 = load ptr, ptr %5, align 4, !dbg !489
  %34 = getelementptr inbounds %struct.tmrTimerControl, ptr %33, i32 0, i32 4, !dbg !490
  %35 = load ptr, ptr %34, align 4, !dbg !490
  %36 = load ptr, ptr %5, align 4, !dbg !491
  call void %35(ptr noundef %36), !dbg !489
  ret void, !dbg !492
}

declare dso_local void @vQueueWaitForMessageRestricted(ptr noundef, i32 noundef, i32 noundef) #1

declare dso_local i32 @xTaskGetTickCount() #1

; Function Attrs: noinline nounwind
define internal void @prvSwitchTimerLists() #0 !dbg !493 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 4
  br label %3, !dbg !494

3:                                                ; preds = %11, %0
  %4 = load ptr, ptr @pxCurrentTimerList, align 4, !dbg !495
  %5 = getelementptr inbounds %struct.xLIST, ptr %4, i32 0, i32 0, !dbg !495
  %6 = load volatile i32, ptr %5, align 4, !dbg !495
  %7 = icmp eq i32 %6, 0, !dbg !495
  %8 = zext i1 %7 to i64, !dbg !495
  %9 = select i1 %7, i32 1, i32 0, !dbg !495
  %10 = icmp eq i32 %9, 0, !dbg !496
  br i1 %10, label %11, label %19, !dbg !494

11:                                               ; preds = %3
  %12 = load ptr, ptr @pxCurrentTimerList, align 4, !dbg !497
  %13 = getelementptr inbounds %struct.xLIST, ptr %12, i32 0, i32 2, !dbg !497
  %14 = getelementptr inbounds %struct.xMINI_LIST_ITEM, ptr %13, i32 0, i32 1, !dbg !497
  %15 = load ptr, ptr %14, align 4, !dbg !497
  %16 = getelementptr inbounds %struct.xLIST_ITEM, ptr %15, i32 0, i32 0, !dbg !497
  %17 = load i32, ptr %16, align 4, !dbg !497
  store i32 %17, ptr %1, align 4, !dbg !498
  %18 = load i32, ptr %1, align 4, !dbg !499
  call void @prvProcessExpiredTimer(i32 noundef %18, i32 noundef -1), !dbg !500
  br label %3, !dbg !494, !llvm.loop !501

19:                                               ; preds = %3
  %20 = load ptr, ptr @pxCurrentTimerList, align 4, !dbg !503
  store ptr %20, ptr %2, align 4, !dbg !504
  %21 = load ptr, ptr @pxOverflowTimerList, align 4, !dbg !505
  store ptr %21, ptr @pxCurrentTimerList, align 4, !dbg !506
  %22 = load ptr, ptr %2, align 4, !dbg !507
  store ptr %22, ptr @pxOverflowTimerList, align 4, !dbg !508
  ret void, !dbg !509
}

declare dso_local i32 @uxListRemove(ptr noundef) #1

; Function Attrs: noinline nounwind
define internal void @prvReloadTimer(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 !dbg !510 {
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  br label %7, !dbg !511

7:                                                ; preds = %18, %3
  %8 = load ptr, ptr %4, align 4, !dbg !512
  %9 = load i32, ptr %5, align 4, !dbg !513
  %10 = load ptr, ptr %4, align 4, !dbg !514
  %11 = getelementptr inbounds %struct.tmrTimerControl, ptr %10, i32 0, i32 2, !dbg !515
  %12 = load i32, ptr %11, align 4, !dbg !515
  %13 = add i32 %9, %12, !dbg !516
  %14 = load i32, ptr %6, align 4, !dbg !517
  %15 = load i32, ptr %5, align 4, !dbg !518
  %16 = call i32 @prvInsertTimerInActiveList(ptr noundef %8, i32 noundef %13, i32 noundef %14, i32 noundef %15), !dbg !519
  %17 = icmp ne i32 %16, 0, !dbg !520
  br i1 %17, label %18, label %28, !dbg !511

18:                                               ; preds = %7
  %19 = load ptr, ptr %4, align 4, !dbg !521
  %20 = getelementptr inbounds %struct.tmrTimerControl, ptr %19, i32 0, i32 2, !dbg !522
  %21 = load i32, ptr %20, align 4, !dbg !522
  %22 = load i32, ptr %5, align 4, !dbg !523
  %23 = add i32 %22, %21, !dbg !523
  store i32 %23, ptr %5, align 4, !dbg !523
  %24 = load ptr, ptr %4, align 4, !dbg !524
  %25 = getelementptr inbounds %struct.tmrTimerControl, ptr %24, i32 0, i32 4, !dbg !525
  %26 = load ptr, ptr %25, align 4, !dbg !525
  %27 = load ptr, ptr %4, align 4, !dbg !526
  call void %26(ptr noundef %27), !dbg !524
  br label %7, !dbg !511, !llvm.loop !527

28:                                               ; preds = %7
  ret void, !dbg !529
}

; Function Attrs: noinline nounwind
define internal i32 @prvInsertTimerInActiveList(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 !dbg !530 {
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  store i32 0, ptr %9, align 4, !dbg !531
  %10 = load i32, ptr %6, align 4, !dbg !532
  %11 = load ptr, ptr %5, align 4, !dbg !532
  %12 = getelementptr inbounds %struct.tmrTimerControl, ptr %11, i32 0, i32 1, !dbg !532
  %13 = getelementptr inbounds %struct.xLIST_ITEM, ptr %12, i32 0, i32 0, !dbg !532
  store i32 %10, ptr %13, align 4, !dbg !532
  %14 = load ptr, ptr %5, align 4, !dbg !533
  %15 = load ptr, ptr %5, align 4, !dbg !533
  %16 = getelementptr inbounds %struct.tmrTimerControl, ptr %15, i32 0, i32 1, !dbg !533
  %17 = getelementptr inbounds %struct.xLIST_ITEM, ptr %16, i32 0, i32 3, !dbg !533
  store ptr %14, ptr %17, align 4, !dbg !533
  %18 = load i32, ptr %6, align 4, !dbg !534
  %19 = load i32, ptr %7, align 4, !dbg !535
  %20 = icmp ule i32 %18, %19, !dbg !536
  br i1 %20, label %21, label %35, !dbg !534

21:                                               ; preds = %4
  %22 = load i32, ptr %7, align 4, !dbg !537
  %23 = load i32, ptr %8, align 4, !dbg !538
  %24 = sub i32 %22, %23, !dbg !539
  %25 = load ptr, ptr %5, align 4, !dbg !540
  %26 = getelementptr inbounds %struct.tmrTimerControl, ptr %25, i32 0, i32 2, !dbg !541
  %27 = load i32, ptr %26, align 4, !dbg !541
  %28 = icmp uge i32 %24, %27, !dbg !542
  br i1 %28, label %29, label %30, !dbg !543

29:                                               ; preds = %21
  store i32 1, ptr %9, align 4, !dbg !544
  br label %34, !dbg !545

30:                                               ; preds = %21
  %31 = load ptr, ptr @pxOverflowTimerList, align 4, !dbg !546
  %32 = load ptr, ptr %5, align 4, !dbg !547
  %33 = getelementptr inbounds %struct.tmrTimerControl, ptr %32, i32 0, i32 1, !dbg !548
  call void @vListInsert(ptr noundef %31, ptr noundef %33), !dbg !549
  br label %34

34:                                               ; preds = %30, %29
  br label %49, !dbg !550

35:                                               ; preds = %4
  %36 = load i32, ptr %7, align 4, !dbg !551
  %37 = load i32, ptr %8, align 4, !dbg !552
  %38 = icmp ult i32 %36, %37, !dbg !553
  br i1 %38, label %39, label %44, !dbg !554

39:                                               ; preds = %35
  %40 = load i32, ptr %6, align 4, !dbg !555
  %41 = load i32, ptr %8, align 4, !dbg !556
  %42 = icmp uge i32 %40, %41, !dbg !557
  br i1 %42, label %43, label %44, !dbg !558

43:                                               ; preds = %39
  store i32 1, ptr %9, align 4, !dbg !559
  br label %48, !dbg !560

44:                                               ; preds = %39, %35
  %45 = load ptr, ptr @pxCurrentTimerList, align 4, !dbg !561
  %46 = load ptr, ptr %5, align 4, !dbg !562
  %47 = getelementptr inbounds %struct.tmrTimerControl, ptr %46, i32 0, i32 1, !dbg !563
  call void @vListInsert(ptr noundef %45, ptr noundef %47), !dbg !564
  br label %48

48:                                               ; preds = %44, %43
  br label %49

49:                                               ; preds = %48, %34
  %50 = load i32, ptr %9, align 4, !dbg !565
  ret i32 %50, !dbg !566
}

declare dso_local void @vListInsert(ptr noundef, ptr noundef) #1

declare dso_local i32 @xQueueReceive(ptr noundef, ptr noundef, i32 noundef) #1

declare dso_local void @vPortFree(ptr noundef) #1

declare dso_local void @vListInitialise(ptr noundef) #1

declare dso_local ptr @xQueueGenericCreateStatic(i32 noundef, i32 noundef, ptr noundef, ptr noundef, i8 noundef zeroext) #1

declare dso_local void @vQueueAddToRegistry(ptr noundef, ptr noundef) #1

attributes #0 = { noinline nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #2 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "FreeRTOS/Source/timers.c", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 1, !"min_enum_size", i32 4}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{!"clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)"}
!7 = distinct !DISubprogram(name: "xTimerCreateTimerTask", scope: !1, file: !1, line: 233, type: !8, scopeLine: 234, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!8 = !DISubroutineType(types: !9)
!9 = !{}
!10 = !DILocation(line: 235, column: 20, scope: !7)
!11 = !DILocation(line: 241, column: 9, scope: !7)
!12 = !DILocation(line: 243, column: 13, scope: !7)
!13 = !DILocation(line: 243, column: 25, scope: !7)
!14 = !DILocation(line: 247, column: 36, scope: !7)
!15 = !DILocation(line: 248, column: 35, scope: !7)
!16 = !DILocation(line: 251, column: 21, scope: !7)
!17 = !DILocation(line: 254, column: 59, scope: !7)
!18 = !DILocation(line: 257, column: 59, scope: !7)
!19 = !DILocation(line: 258, column: 59, scope: !7)
!20 = !DILocation(line: 252, column: 40, scope: !7)
!21 = !DILocation(line: 252, column: 38, scope: !7)
!22 = !DILocation(line: 260, column: 25, scope: !7)
!23 = !DILocation(line: 260, column: 42, scope: !7)
!24 = !DILocation(line: 262, column: 33, scope: !7)
!25 = !DILocation(line: 263, column: 21, scope: !7)
!26 = !DILocation(line: 275, column: 9, scope: !7)
!27 = !DILocation(line: 282, column: 16, scope: !7)
!28 = !DILocation(line: 282, column: 9, scope: !7)
!29 = distinct !DISubprogram(name: "prvCheckForValidListAndQueue", scope: !1, file: !1, line: 942, type: !8, scopeLine: 943, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!30 = !DILocation(line: 947, column: 9, scope: !29)
!31 = !DILocation(line: 949, column: 17, scope: !29)
!32 = !DILocation(line: 949, column: 29, scope: !29)
!33 = !DILocation(line: 951, column: 17, scope: !29)
!34 = !DILocation(line: 952, column: 17, scope: !29)
!35 = !DILocation(line: 953, column: 36, scope: !29)
!36 = !DILocation(line: 954, column: 37, scope: !29)
!37 = !DILocation(line: 963, column: 39, scope: !29)
!38 = !DILocation(line: 963, column: 37, scope: !29)
!39 = !DILocation(line: 973, column: 29, scope: !29)
!40 = !DILocation(line: 973, column: 41, scope: !29)
!41 = !DILocation(line: 975, column: 50, scope: !29)
!42 = !DILocation(line: 975, column: 29, scope: !29)
!43 = !DILocation(line: 976, column: 25, scope: !29)
!44 = !DILocation(line: 983, column: 13, scope: !29)
!45 = !DILocation(line: 989, column: 9, scope: !29)
!46 = !DILocation(line: 990, column: 5, scope: !29)
!47 = distinct !DISubprogram(name: "vApplicationGetTimerTaskMemory", scope: !1, file: !1, line: 322, type: !8, scopeLine: 322, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!48 = !DILocation(line: 323, column: 14, scope: !47)
!49 = !DILocation(line: 323, column: 38, scope: !47)
!50 = !DILocation(line: 324, column: 14, scope: !47)
!51 = !DILocation(line: 324, column: 38, scope: !47)
!52 = !DILocation(line: 325, column: 14, scope: !47)
!53 = !DILocation(line: 325, column: 38, scope: !47)
!54 = !DILocation(line: 326, column: 9, scope: !47)
!55 = distinct !DISubprogram(name: "prvTimerTask", scope: !1, file: !1, line: 577, type: !8, scopeLine: 578, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!56 = !DILocation(line: 583, column: 18, scope: !55)
!57 = !DILocation(line: 597, column: 9, scope: !55)
!58 = !DILocation(line: 601, column: 31, scope: !55)
!59 = !DILocation(line: 601, column: 29, scope: !55)
!60 = !DILocation(line: 605, column: 41, scope: !55)
!61 = !DILocation(line: 605, column: 58, scope: !55)
!62 = !DILocation(line: 605, column: 13, scope: !55)
!63 = !DILocation(line: 608, column: 13, scope: !55)
!64 = distinct !{!64, !57, !65}
!65 = !DILocation(line: 609, column: 9, scope: !55)
!66 = distinct !DISubprogram(name: "xTimerCreate", scope: !1, file: !1, line: 288, type: !8, scopeLine: 293, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!67 = !DILocation(line: 296, column: 40, scope: !66)
!68 = !DILocation(line: 296, column: 24, scope: !66)
!69 = !DILocation(line: 298, column: 17, scope: !66)
!70 = !DILocation(line: 298, column: 28, scope: !66)
!71 = !DILocation(line: 303, column: 17, scope: !66)
!72 = !DILocation(line: 303, column: 29, scope: !66)
!73 = !DILocation(line: 303, column: 38, scope: !66)
!74 = !DILocation(line: 304, column: 40, scope: !66)
!75 = !DILocation(line: 304, column: 53, scope: !66)
!76 = !DILocation(line: 304, column: 74, scope: !66)
!77 = !DILocation(line: 304, column: 88, scope: !66)
!78 = !DILocation(line: 304, column: 99, scope: !66)
!79 = !DILocation(line: 304, column: 119, scope: !66)
!80 = !DILocation(line: 304, column: 17, scope: !66)
!81 = !DILocation(line: 305, column: 13, scope: !66)
!82 = !DILocation(line: 307, column: 20, scope: !66)
!83 = !DILocation(line: 307, column: 13, scope: !66)
!84 = distinct !DISubprogram(name: "prvInitialiseNewTimer", scope: !1, file: !1, line: 369, type: !8, scopeLine: 375, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!85 = !DILocation(line: 381, column: 9, scope: !84)
!86 = !DILocation(line: 385, column: 35, scope: !84)
!87 = !DILocation(line: 385, column: 9, scope: !84)
!88 = !DILocation(line: 385, column: 21, scope: !84)
!89 = !DILocation(line: 385, column: 33, scope: !84)
!90 = !DILocation(line: 386, column: 43, scope: !84)
!91 = !DILocation(line: 386, column: 9, scope: !84)
!92 = !DILocation(line: 386, column: 21, scope: !84)
!93 = !DILocation(line: 386, column: 41, scope: !84)
!94 = !DILocation(line: 387, column: 33, scope: !84)
!95 = !DILocation(line: 387, column: 9, scope: !84)
!96 = !DILocation(line: 387, column: 21, scope: !84)
!97 = !DILocation(line: 387, column: 31, scope: !84)
!98 = !DILocation(line: 388, column: 42, scope: !84)
!99 = !DILocation(line: 388, column: 9, scope: !84)
!100 = !DILocation(line: 388, column: 21, scope: !84)
!101 = !DILocation(line: 388, column: 40, scope: !84)
!102 = !DILocation(line: 389, column: 33, scope: !84)
!103 = !DILocation(line: 389, column: 45, scope: !84)
!104 = !DILocation(line: 389, column: 9, scope: !84)
!105 = !DILocation(line: 391, column: 13, scope: !84)
!106 = !DILocation(line: 391, column: 26, scope: !84)
!107 = !DILocation(line: 393, column: 13, scope: !84)
!108 = !DILocation(line: 393, column: 25, scope: !84)
!109 = !DILocation(line: 393, column: 34, scope: !84)
!110 = !DILocation(line: 394, column: 9, scope: !84)
!111 = !DILocation(line: 397, column: 5, scope: !84)
!112 = distinct !DISubprogram(name: "xTimerCreateStatic", scope: !1, file: !1, line: 329, type: !8, scopeLine: 335, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!113 = !DILocation(line: 351, column: 40, scope: !112)
!114 = !DILocation(line: 351, column: 24, scope: !112)
!115 = !DILocation(line: 353, column: 17, scope: !112)
!116 = !DILocation(line: 353, column: 28, scope: !112)
!117 = !DILocation(line: 358, column: 17, scope: !112)
!118 = !DILocation(line: 358, column: 29, scope: !112)
!119 = !DILocation(line: 358, column: 38, scope: !112)
!120 = !DILocation(line: 360, column: 40, scope: !112)
!121 = !DILocation(line: 360, column: 53, scope: !112)
!122 = !DILocation(line: 360, column: 74, scope: !112)
!123 = !DILocation(line: 360, column: 88, scope: !112)
!124 = !DILocation(line: 360, column: 99, scope: !112)
!125 = !DILocation(line: 360, column: 119, scope: !112)
!126 = !DILocation(line: 360, column: 17, scope: !112)
!127 = !DILocation(line: 361, column: 13, scope: !112)
!128 = !DILocation(line: 363, column: 20, scope: !112)
!129 = !DILocation(line: 363, column: 13, scope: !112)
!130 = distinct !DISubprogram(name: "xTimerGenericCommand", scope: !1, file: !1, line: 400, type: !8, scopeLine: 405, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!131 = !DILocation(line: 406, column: 20, scope: !130)
!132 = !DILocation(line: 413, column: 13, scope: !130)
!133 = !DILocation(line: 413, column: 25, scope: !130)
!134 = !DILocation(line: 416, column: 35, scope: !130)
!135 = !DILocation(line: 416, column: 22, scope: !130)
!136 = !DILocation(line: 416, column: 33, scope: !130)
!137 = !DILocation(line: 417, column: 57, scope: !130)
!138 = !DILocation(line: 417, column: 22, scope: !130)
!139 = !DILocation(line: 417, column: 41, scope: !130)
!140 = !DILocation(line: 417, column: 55, scope: !130)
!141 = !DILocation(line: 418, column: 51, scope: !130)
!142 = !DILocation(line: 418, column: 22, scope: !130)
!143 = !DILocation(line: 418, column: 41, scope: !130)
!144 = !DILocation(line: 418, column: 49, scope: !130)
!145 = !DILocation(line: 420, column: 17, scope: !130)
!146 = !DILocation(line: 420, column: 28, scope: !130)
!147 = !DILocation(line: 422, column: 21, scope: !130)
!148 = !DILocation(line: 422, column: 46, scope: !130)
!149 = !DILocation(line: 424, column: 31, scope: !130)
!150 = !DILocation(line: 424, column: 29, scope: !130)
!151 = !DILocation(line: 425, column: 17, scope: !130)
!152 = !DILocation(line: 428, column: 31, scope: !130)
!153 = !DILocation(line: 428, column: 29, scope: !130)
!154 = !DILocation(line: 430, column: 13, scope: !130)
!155 = !DILocation(line: 433, column: 27, scope: !130)
!156 = !DILocation(line: 433, column: 25, scope: !130)
!157 = !DILocation(line: 437, column: 9, scope: !130)
!158 = !DILocation(line: 443, column: 16, scope: !130)
!159 = !DILocation(line: 443, column: 9, scope: !130)
!160 = distinct !DISubprogram(name: "xTimerGetTimerDaemonTaskHandle", scope: !1, file: !1, line: 447, type: !8, scopeLine: 448, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!161 = !DILocation(line: 452, column: 16, scope: !160)
!162 = !DILocation(line: 452, column: 9, scope: !160)
!163 = distinct !DISubprogram(name: "xTimerGetPeriod", scope: !1, file: !1, line: 456, type: !8, scopeLine: 457, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!164 = !DILocation(line: 458, column: 29, scope: !163)
!165 = !DILocation(line: 458, column: 19, scope: !163)
!166 = !DILocation(line: 461, column: 16, scope: !163)
!167 = !DILocation(line: 461, column: 25, scope: !163)
!168 = !DILocation(line: 461, column: 9, scope: !163)
!169 = distinct !DISubprogram(name: "vTimerSetReloadMode", scope: !1, file: !1, line: 465, type: !8, scopeLine: 467, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!170 = !DILocation(line: 468, column: 29, scope: !169)
!171 = !DILocation(line: 468, column: 19, scope: !169)
!172 = !DILocation(line: 471, column: 9, scope: !169)
!173 = !DILocation(line: 473, column: 17, scope: !169)
!174 = !DILocation(line: 473, column: 30, scope: !169)
!175 = !DILocation(line: 475, column: 17, scope: !169)
!176 = !DILocation(line: 475, column: 26, scope: !169)
!177 = !DILocation(line: 475, column: 35, scope: !169)
!178 = !DILocation(line: 476, column: 13, scope: !169)
!179 = !DILocation(line: 479, column: 17, scope: !169)
!180 = !DILocation(line: 479, column: 26, scope: !169)
!181 = !DILocation(line: 479, column: 35, scope: !169)
!182 = !DILocation(line: 482, column: 9, scope: !169)
!183 = !DILocation(line: 483, column: 5, scope: !169)
!184 = distinct !DISubprogram(name: "uxTimerGetReloadMode", scope: !1, file: !1, line: 486, type: !8, scopeLine: 487, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!185 = !DILocation(line: 488, column: 29, scope: !184)
!186 = !DILocation(line: 488, column: 19, scope: !184)
!187 = !DILocation(line: 492, column: 9, scope: !184)
!188 = !DILocation(line: 494, column: 19, scope: !184)
!189 = !DILocation(line: 494, column: 28, scope: !184)
!190 = !DILocation(line: 494, column: 37, scope: !184)
!191 = !DILocation(line: 494, column: 65, scope: !184)
!192 = !DILocation(line: 494, column: 17, scope: !184)
!193 = !DILocation(line: 497, column: 26, scope: !184)
!194 = !DILocation(line: 498, column: 13, scope: !184)
!195 = !DILocation(line: 502, column: 26, scope: !184)
!196 = !DILocation(line: 505, column: 9, scope: !184)
!197 = !DILocation(line: 507, column: 16, scope: !184)
!198 = !DILocation(line: 507, column: 9, scope: !184)
!199 = distinct !DISubprogram(name: "xTimerGetExpiryTime", scope: !1, file: !1, line: 511, type: !8, scopeLine: 512, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!200 = !DILocation(line: 513, column: 29, scope: !199)
!201 = !DILocation(line: 513, column: 19, scope: !199)
!202 = !DILocation(line: 517, column: 19, scope: !199)
!203 = !DILocation(line: 517, column: 17, scope: !199)
!204 = !DILocation(line: 518, column: 16, scope: !199)
!205 = !DILocation(line: 518, column: 9, scope: !199)
!206 = distinct !DISubprogram(name: "pcTimerGetName", scope: !1, file: !1, line: 522, type: !8, scopeLine: 523, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!207 = !DILocation(line: 524, column: 29, scope: !206)
!208 = !DILocation(line: 524, column: 19, scope: !206)
!209 = !DILocation(line: 527, column: 16, scope: !206)
!210 = !DILocation(line: 527, column: 25, scope: !206)
!211 = !DILocation(line: 527, column: 9, scope: !206)
!212 = distinct !DISubprogram(name: "xTimerIsTimerActive", scope: !1, file: !1, line: 993, type: !8, scopeLine: 994, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!213 = !DILocation(line: 996, column: 29, scope: !212)
!214 = !DILocation(line: 996, column: 19, scope: !212)
!215 = !DILocation(line: 1001, column: 9, scope: !212)
!216 = !DILocation(line: 1003, column: 19, scope: !212)
!217 = !DILocation(line: 1003, column: 28, scope: !212)
!218 = !DILocation(line: 1003, column: 37, scope: !212)
!219 = !DILocation(line: 1003, column: 61, scope: !212)
!220 = !DILocation(line: 1003, column: 17, scope: !212)
!221 = !DILocation(line: 1005, column: 25, scope: !212)
!222 = !DILocation(line: 1006, column: 13, scope: !212)
!223 = !DILocation(line: 1009, column: 25, scope: !212)
!224 = !DILocation(line: 1012, column: 9, scope: !212)
!225 = !DILocation(line: 1014, column: 16, scope: !212)
!226 = !DILocation(line: 1014, column: 9, scope: !212)
!227 = distinct !DISubprogram(name: "pvTimerGetTimerID", scope: !1, file: !1, line: 1018, type: !8, scopeLine: 1019, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!228 = !DILocation(line: 1020, column: 35, scope: !227)
!229 = !DILocation(line: 1020, column: 25, scope: !227)
!230 = !DILocation(line: 1025, column: 9, scope: !227)
!231 = !DILocation(line: 1027, column: 24, scope: !227)
!232 = !DILocation(line: 1027, column: 33, scope: !227)
!233 = !DILocation(line: 1027, column: 22, scope: !227)
!234 = !DILocation(line: 1029, column: 9, scope: !227)
!235 = !DILocation(line: 1031, column: 16, scope: !227)
!236 = !DILocation(line: 1031, column: 9, scope: !227)
!237 = distinct !DISubprogram(name: "vTimerSetTimerID", scope: !1, file: !1, line: 1035, type: !8, scopeLine: 1037, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!238 = !DILocation(line: 1038, column: 35, scope: !237)
!239 = !DILocation(line: 1038, column: 25, scope: !237)
!240 = !DILocation(line: 1042, column: 9, scope: !237)
!241 = !DILocation(line: 1044, column: 34, scope: !237)
!242 = !DILocation(line: 1044, column: 13, scope: !237)
!243 = !DILocation(line: 1044, column: 22, scope: !237)
!244 = !DILocation(line: 1044, column: 32, scope: !237)
!245 = !DILocation(line: 1046, column: 9, scope: !237)
!246 = !DILocation(line: 1047, column: 5, scope: !237)
!247 = distinct !DISubprogram(name: "xTimerPendFunctionCallFromISR", scope: !1, file: !1, line: 1052, type: !8, scopeLine: 1056, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!248 = !DILocation(line: 1062, column: 22, scope: !247)
!249 = !DILocation(line: 1062, column: 33, scope: !247)
!250 = !DILocation(line: 1063, column: 65, scope: !247)
!251 = !DILocation(line: 1063, column: 22, scope: !247)
!252 = !DILocation(line: 1063, column: 44, scope: !247)
!253 = !DILocation(line: 1063, column: 63, scope: !247)
!254 = !DILocation(line: 1064, column: 59, scope: !247)
!255 = !DILocation(line: 1064, column: 22, scope: !247)
!256 = !DILocation(line: 1064, column: 44, scope: !247)
!257 = !DILocation(line: 1064, column: 57, scope: !247)
!258 = !DILocation(line: 1065, column: 59, scope: !247)
!259 = !DILocation(line: 1065, column: 22, scope: !247)
!260 = !DILocation(line: 1065, column: 44, scope: !247)
!261 = !DILocation(line: 1065, column: 57, scope: !247)
!262 = !DILocation(line: 1067, column: 23, scope: !247)
!263 = !DILocation(line: 1067, column: 21, scope: !247)
!264 = !DILocation(line: 1071, column: 20, scope: !247)
!265 = !DILocation(line: 1071, column: 13, scope: !247)
!266 = distinct !DISubprogram(name: "xTimerPendFunctionCall", scope: !1, file: !1, line: 1079, type: !8, scopeLine: 1083, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!267 = !DILocation(line: 1094, column: 22, scope: !266)
!268 = !DILocation(line: 1094, column: 33, scope: !266)
!269 = !DILocation(line: 1095, column: 65, scope: !266)
!270 = !DILocation(line: 1095, column: 22, scope: !266)
!271 = !DILocation(line: 1095, column: 44, scope: !266)
!272 = !DILocation(line: 1095, column: 63, scope: !266)
!273 = !DILocation(line: 1096, column: 59, scope: !266)
!274 = !DILocation(line: 1096, column: 22, scope: !266)
!275 = !DILocation(line: 1096, column: 44, scope: !266)
!276 = !DILocation(line: 1096, column: 57, scope: !266)
!277 = !DILocation(line: 1097, column: 59, scope: !266)
!278 = !DILocation(line: 1097, column: 22, scope: !266)
!279 = !DILocation(line: 1097, column: 44, scope: !266)
!280 = !DILocation(line: 1097, column: 57, scope: !266)
!281 = !DILocation(line: 1099, column: 23, scope: !266)
!282 = !DILocation(line: 1099, column: 21, scope: !266)
!283 = !DILocation(line: 1103, column: 20, scope: !266)
!284 = !DILocation(line: 1103, column: 13, scope: !266)
!285 = distinct !DISubprogram(name: "uxTimerGetTimerNumber", scope: !1, file: !1, line: 1111, type: !8, scopeLine: 1112, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!286 = !DILocation(line: 1113, column: 36, scope: !285)
!287 = !DILocation(line: 1113, column: 46, scope: !285)
!288 = !DILocation(line: 1113, column: 13, scope: !285)
!289 = distinct !DISubprogram(name: "vTimerSetTimerNumber", scope: !1, file: !1, line: 1121, type: !8, scopeLine: 1123, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!290 = !DILocation(line: 1124, column: 55, scope: !289)
!291 = !DILocation(line: 1124, column: 29, scope: !289)
!292 = !DILocation(line: 1124, column: 39, scope: !289)
!293 = !DILocation(line: 1124, column: 53, scope: !289)
!294 = !DILocation(line: 1125, column: 9, scope: !289)
!295 = distinct !DISubprogram(name: "prvGetNextExpireTime", scope: !1, file: !1, line: 675, type: !8, scopeLine: 676, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!296 = !DILocation(line: 686, column: 27, scope: !295)
!297 = !DILocation(line: 686, column: 10, scope: !295)
!298 = !DILocation(line: 686, column: 25, scope: !295)
!299 = !DILocation(line: 688, column: 14, scope: !295)
!300 = !DILocation(line: 688, column: 13, scope: !295)
!301 = !DILocation(line: 688, column: 29, scope: !295)
!302 = !DILocation(line: 690, column: 31, scope: !295)
!303 = !DILocation(line: 690, column: 29, scope: !295)
!304 = !DILocation(line: 691, column: 9, scope: !295)
!305 = !DILocation(line: 695, column: 29, scope: !295)
!306 = !DILocation(line: 698, column: 16, scope: !295)
!307 = !DILocation(line: 698, column: 9, scope: !295)
!308 = distinct !DISubprogram(name: "prvProcessTimerOrBlockTask", scope: !1, file: !1, line: 613, type: !8, scopeLine: 615, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!309 = !DILocation(line: 619, column: 9, scope: !308)
!310 = !DILocation(line: 626, column: 24, scope: !308)
!311 = !DILocation(line: 626, column: 22, scope: !308)
!312 = !DILocation(line: 628, column: 17, scope: !308)
!313 = !DILocation(line: 628, column: 41, scope: !308)
!314 = !DILocation(line: 631, column: 23, scope: !308)
!315 = !DILocation(line: 631, column: 37, scope: !308)
!316 = !DILocation(line: 631, column: 50, scope: !308)
!317 = !DILocation(line: 631, column: 55, scope: !308)
!318 = !DILocation(line: 631, column: 74, scope: !308)
!319 = !DILocation(line: 631, column: 71, scope: !308)
!320 = !DILocation(line: 631, column: 21, scope: !308)
!321 = !DILocation(line: 633, column: 30, scope: !308)
!322 = !DILocation(line: 634, column: 45, scope: !308)
!323 = !DILocation(line: 634, column: 62, scope: !308)
!324 = !DILocation(line: 634, column: 21, scope: !308)
!325 = !DILocation(line: 635, column: 17, scope: !308)
!326 = !DILocation(line: 644, column: 25, scope: !308)
!327 = !DILocation(line: 644, column: 39, scope: !308)
!328 = !DILocation(line: 648, column: 41, scope: !308)
!329 = !DILocation(line: 648, column: 39, scope: !308)
!330 = !DILocation(line: 649, column: 21, scope: !308)
!331 = !DILocation(line: 651, column: 53, scope: !308)
!332 = !DILocation(line: 651, column: 68, scope: !308)
!333 = !DILocation(line: 651, column: 86, scope: !308)
!334 = !DILocation(line: 651, column: 84, scope: !308)
!335 = !DILocation(line: 651, column: 98, scope: !308)
!336 = !DILocation(line: 651, column: 21, scope: !308)
!337 = !DILocation(line: 653, column: 25, scope: !308)
!338 = !DILocation(line: 653, column: 42, scope: !308)
!339 = !DILocation(line: 659, column: 25, scope: !308)
!340 = !{i64 2148129821}
!341 = !{i64 2148129891}
!342 = !DILocation(line: 660, column: 21, scope: !308)
!343 = !DILocation(line: 666, column: 13, scope: !308)
!344 = !DILocation(line: 669, column: 26, scope: !308)
!345 = !DILocation(line: 672, column: 5, scope: !308)
!346 = distinct !DISubprogram(name: "prvProcessReceivedCommands", scope: !1, file: !1, line: 769, type: !8, scopeLine: 770, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!347 = !DILocation(line: 776, column: 9, scope: !346)
!348 = !DILocation(line: 776, column: 31, scope: !346)
!349 = !DILocation(line: 776, column: 16, scope: !346)
!350 = !DILocation(line: 776, column: 69, scope: !346)
!351 = !DILocation(line: 782, column: 34, scope: !346)
!352 = !DILocation(line: 782, column: 45, scope: !346)
!353 = !DILocation(line: 782, column: 25, scope: !346)
!354 = !DILocation(line: 784, column: 85, scope: !346)
!355 = !DILocation(line: 784, column: 60, scope: !346)
!356 = !DILocation(line: 791, column: 25, scope: !346)
!357 = !DILocation(line: 791, column: 37, scope: !346)
!358 = !DILocation(line: 791, column: 57, scope: !346)
!359 = !DILocation(line: 791, column: 69, scope: !346)
!360 = !DILocation(line: 791, column: 83, scope: !346)
!361 = !DILocation(line: 791, column: 95, scope: !346)
!362 = !DILocation(line: 792, column: 21, scope: !346)
!363 = !DILocation(line: 802, column: 26, scope: !346)
!364 = !DILocation(line: 802, column: 37, scope: !346)
!365 = !DILocation(line: 802, column: 17, scope: !346)
!366 = !DILocation(line: 806, column: 36, scope: !346)
!367 = !DILocation(line: 806, column: 55, scope: !346)
!368 = !DILocation(line: 806, column: 25, scope: !346)
!369 = !DILocation(line: 808, column: 21, scope: !346)
!370 = !DILocation(line: 808, column: 83, scope: !346)
!371 = !DILocation(line: 811, column: 47, scope: !346)
!372 = !DILocation(line: 811, column: 56, scope: !346)
!373 = !DILocation(line: 811, column: 30, scope: !346)
!374 = !DILocation(line: 812, column: 17, scope: !346)
!375 = !DILocation(line: 826, column: 28, scope: !346)
!376 = !DILocation(line: 826, column: 26, scope: !346)
!377 = !DILocation(line: 828, column: 34, scope: !346)
!378 = !DILocation(line: 828, column: 17, scope: !346)
!379 = !DILocation(line: 835, column: 25, scope: !346)
!380 = !DILocation(line: 835, column: 34, scope: !346)
!381 = !DILocation(line: 835, column: 43, scope: !346)
!382 = !DILocation(line: 837, column: 57, scope: !346)
!383 = !DILocation(line: 837, column: 75, scope: !346)
!384 = !DILocation(line: 837, column: 94, scope: !346)
!385 = !DILocation(line: 837, column: 110, scope: !346)
!386 = !DILocation(line: 837, column: 119, scope: !346)
!387 = !DILocation(line: 837, column: 108, scope: !346)
!388 = !DILocation(line: 837, column: 140, scope: !346)
!389 = !DILocation(line: 837, column: 159, scope: !346)
!390 = !DILocation(line: 837, column: 178, scope: !346)
!391 = !DILocation(line: 837, column: 29, scope: !346)
!392 = !DILocation(line: 837, column: 194, scope: !346)
!393 = !DILocation(line: 841, column: 35, scope: !346)
!394 = !DILocation(line: 841, column: 44, scope: !346)
!395 = !DILocation(line: 841, column: 53, scope: !346)
!396 = !DILocation(line: 841, column: 81, scope: !346)
!397 = !DILocation(line: 841, column: 33, scope: !346)
!398 = !DILocation(line: 843, column: 49, scope: !346)
!399 = !DILocation(line: 843, column: 67, scope: !346)
!400 = !DILocation(line: 843, column: 86, scope: !346)
!401 = !DILocation(line: 843, column: 102, scope: !346)
!402 = !DILocation(line: 843, column: 111, scope: !346)
!403 = !DILocation(line: 843, column: 100, scope: !346)
!404 = !DILocation(line: 843, column: 132, scope: !346)
!405 = !DILocation(line: 843, column: 33, scope: !346)
!406 = !DILocation(line: 844, column: 29, scope: !346)
!407 = !DILocation(line: 847, column: 33, scope: !346)
!408 = !DILocation(line: 847, column: 42, scope: !346)
!409 = !DILocation(line: 847, column: 51, scope: !346)
!410 = !DILocation(line: 852, column: 29, scope: !346)
!411 = !DILocation(line: 852, column: 38, scope: !346)
!412 = !DILocation(line: 852, column: 76, scope: !346)
!413 = !DILocation(line: 853, column: 25, scope: !346)
!414 = !DILocation(line: 859, column: 25, scope: !346)
!415 = !DILocation(line: 864, column: 25, scope: !346)
!416 = !DILocation(line: 864, column: 34, scope: !346)
!417 = !DILocation(line: 864, column: 43, scope: !346)
!418 = !DILocation(line: 865, column: 25, scope: !346)
!419 = !DILocation(line: 869, column: 25, scope: !346)
!420 = !DILocation(line: 869, column: 34, scope: !346)
!421 = !DILocation(line: 869, column: 43, scope: !346)
!422 = !DILocation(line: 870, column: 65, scope: !346)
!423 = !DILocation(line: 870, column: 84, scope: !346)
!424 = !DILocation(line: 870, column: 25, scope: !346)
!425 = !DILocation(line: 870, column: 34, scope: !346)
!426 = !DILocation(line: 870, column: 54, scope: !346)
!427 = !DILocation(line: 879, column: 62, scope: !346)
!428 = !DILocation(line: 879, column: 73, scope: !346)
!429 = !DILocation(line: 879, column: 84, scope: !346)
!430 = !DILocation(line: 879, column: 93, scope: !346)
!431 = !DILocation(line: 879, column: 82, scope: !346)
!432 = !DILocation(line: 879, column: 116, scope: !346)
!433 = !DILocation(line: 879, column: 126, scope: !346)
!434 = !DILocation(line: 879, column: 34, scope: !346)
!435 = !DILocation(line: 880, column: 25, scope: !346)
!436 = !DILocation(line: 888, column: 39, scope: !346)
!437 = !DILocation(line: 888, column: 48, scope: !346)
!438 = !DILocation(line: 888, column: 57, scope: !346)
!439 = !DILocation(line: 888, column: 95, scope: !346)
!440 = !DILocation(line: 888, column: 37, scope: !346)
!441 = !DILocation(line: 890, column: 48, scope: !346)
!442 = !DILocation(line: 890, column: 37, scope: !346)
!443 = !DILocation(line: 891, column: 33, scope: !346)
!444 = !DILocation(line: 894, column: 37, scope: !346)
!445 = !DILocation(line: 894, column: 46, scope: !346)
!446 = !DILocation(line: 894, column: 55, scope: !346)
!447 = !DILocation(line: 906, column: 25, scope: !346)
!448 = !DILocation(line: 910, column: 25, scope: !346)
!449 = !DILocation(line: 912, column: 13, scope: !346)
!450 = distinct !{!450, !347, !451, !452}
!451 = !DILocation(line: 913, column: 9, scope: !346)
!452 = !{!"llvm.loop.mustprogress"}
!453 = !DILocation(line: 914, column: 5, scope: !346)
!454 = distinct !DISubprogram(name: "prvSampleTimeNow", scope: !1, file: !1, line: 702, type: !8, scopeLine: 703, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!455 = !DILocation(line: 707, column: 20, scope: !454)
!456 = !DILocation(line: 707, column: 18, scope: !454)
!457 = !DILocation(line: 709, column: 13, scope: !454)
!458 = !DILocation(line: 709, column: 24, scope: !454)
!459 = !DILocation(line: 709, column: 22, scope: !454)
!460 = !DILocation(line: 711, column: 13, scope: !454)
!461 = !DILocation(line: 712, column: 14, scope: !454)
!462 = !DILocation(line: 712, column: 39, scope: !454)
!463 = !DILocation(line: 713, column: 9, scope: !454)
!464 = !DILocation(line: 716, column: 14, scope: !454)
!465 = !DILocation(line: 716, column: 39, scope: !454)
!466 = !DILocation(line: 719, column: 21, scope: !454)
!467 = !DILocation(line: 719, column: 19, scope: !454)
!468 = !DILocation(line: 721, column: 16, scope: !454)
!469 = !DILocation(line: 721, column: 9, scope: !454)
!470 = distinct !DISubprogram(name: "prvProcessExpiredTimer", scope: !1, file: !1, line: 550, type: !8, scopeLine: 552, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!471 = !DILocation(line: 553, column: 49, scope: !470)
!472 = !DILocation(line: 553, column: 25, scope: !470)
!473 = !DILocation(line: 558, column: 35, scope: !470)
!474 = !DILocation(line: 558, column: 44, scope: !470)
!475 = !DILocation(line: 558, column: 18, scope: !470)
!476 = !DILocation(line: 562, column: 15, scope: !470)
!477 = !DILocation(line: 562, column: 24, scope: !470)
!478 = !DILocation(line: 562, column: 33, scope: !470)
!479 = !DILocation(line: 562, column: 61, scope: !470)
!480 = !DILocation(line: 562, column: 13, scope: !470)
!481 = !DILocation(line: 564, column: 29, scope: !470)
!482 = !DILocation(line: 564, column: 38, scope: !470)
!483 = !DILocation(line: 564, column: 55, scope: !470)
!484 = !DILocation(line: 564, column: 13, scope: !470)
!485 = !DILocation(line: 565, column: 9, scope: !470)
!486 = !DILocation(line: 568, column: 13, scope: !470)
!487 = !DILocation(line: 568, column: 22, scope: !470)
!488 = !DILocation(line: 568, column: 31, scope: !470)
!489 = !DILocation(line: 573, column: 9, scope: !470)
!490 = !DILocation(line: 573, column: 18, scope: !470)
!491 = !DILocation(line: 573, column: 56, scope: !470)
!492 = !DILocation(line: 574, column: 5, scope: !470)
!493 = distinct !DISubprogram(name: "prvSwitchTimerLists", scope: !1, file: !1, line: 917, type: !8, scopeLine: 918, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!494 = !DILocation(line: 926, column: 9, scope: !493)
!495 = !DILocation(line: 926, column: 16, scope: !493)
!496 = !DILocation(line: 926, column: 56, scope: !493)
!497 = !DILocation(line: 928, column: 31, scope: !493)
!498 = !DILocation(line: 928, column: 29, scope: !493)
!499 = !DILocation(line: 933, column: 37, scope: !493)
!500 = !DILocation(line: 933, column: 13, scope: !493)
!501 = distinct !{!501, !494, !502, !452}
!502 = !DILocation(line: 934, column: 9, scope: !493)
!503 = !DILocation(line: 936, column: 18, scope: !493)
!504 = !DILocation(line: 936, column: 16, scope: !493)
!505 = !DILocation(line: 937, column: 30, scope: !493)
!506 = !DILocation(line: 937, column: 28, scope: !493)
!507 = !DILocation(line: 938, column: 31, scope: !493)
!508 = !DILocation(line: 938, column: 29, scope: !493)
!509 = !DILocation(line: 939, column: 5, scope: !493)
!510 = distinct !DISubprogram(name: "prvReloadTimer", scope: !1, file: !1, line: 531, type: !8, scopeLine: 534, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!511 = !DILocation(line: 538, column: 9, scope: !510)
!512 = !DILocation(line: 538, column: 44, scope: !510)
!513 = !DILocation(line: 538, column: 55, scope: !510)
!514 = !DILocation(line: 538, column: 70, scope: !510)
!515 = !DILocation(line: 538, column: 79, scope: !510)
!516 = !DILocation(line: 538, column: 68, scope: !510)
!517 = !DILocation(line: 538, column: 102, scope: !510)
!518 = !DILocation(line: 538, column: 112, scope: !510)
!519 = !DILocation(line: 538, column: 16, scope: !510)
!520 = !DILocation(line: 538, column: 127, scope: !510)
!521 = !DILocation(line: 541, column: 29, scope: !510)
!522 = !DILocation(line: 541, column: 38, scope: !510)
!523 = !DILocation(line: 541, column: 26, scope: !510)
!524 = !DILocation(line: 545, column: 13, scope: !510)
!525 = !DILocation(line: 545, column: 22, scope: !510)
!526 = !DILocation(line: 545, column: 60, scope: !510)
!527 = distinct !{!527, !511, !528, !452}
!528 = !DILocation(line: 546, column: 9, scope: !510)
!529 = !DILocation(line: 547, column: 5, scope: !510)
!530 = distinct !DISubprogram(name: "prvInsertTimerInActiveList", scope: !1, file: !1, line: 725, type: !8, scopeLine: 729, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!531 = !DILocation(line: 730, column: 20, scope: !530)
!532 = !DILocation(line: 732, column: 9, scope: !530)
!533 = !DILocation(line: 733, column: 9, scope: !530)
!534 = !DILocation(line: 735, column: 13, scope: !530)
!535 = !DILocation(line: 735, column: 32, scope: !530)
!536 = !DILocation(line: 735, column: 29, scope: !530)
!537 = !DILocation(line: 739, column: 36, scope: !530)
!538 = !DILocation(line: 739, column: 47, scope: !530)
!539 = !DILocation(line: 739, column: 45, scope: !530)
!540 = !DILocation(line: 739, column: 67, scope: !530)
!541 = !DILocation(line: 739, column: 76, scope: !530)
!542 = !DILocation(line: 739, column: 64, scope: !530)
!543 = !DILocation(line: 739, column: 17, scope: !530)
!544 = !DILocation(line: 743, column: 34, scope: !530)
!545 = !DILocation(line: 744, column: 13, scope: !530)
!546 = !DILocation(line: 747, column: 30, scope: !530)
!547 = !DILocation(line: 747, column: 54, scope: !530)
!548 = !DILocation(line: 747, column: 63, scope: !530)
!549 = !DILocation(line: 747, column: 17, scope: !530)
!550 = !DILocation(line: 749, column: 9, scope: !530)
!551 = !DILocation(line: 752, column: 19, scope: !530)
!552 = !DILocation(line: 752, column: 30, scope: !530)
!553 = !DILocation(line: 752, column: 28, scope: !530)
!554 = !DILocation(line: 752, column: 45, scope: !530)
!555 = !DILocation(line: 752, column: 50, scope: !530)
!556 = !DILocation(line: 752, column: 69, scope: !530)
!557 = !DILocation(line: 752, column: 66, scope: !530)
!558 = !DILocation(line: 752, column: 17, scope: !530)
!559 = !DILocation(line: 757, column: 34, scope: !530)
!560 = !DILocation(line: 758, column: 13, scope: !530)
!561 = !DILocation(line: 761, column: 30, scope: !530)
!562 = !DILocation(line: 761, column: 53, scope: !530)
!563 = !DILocation(line: 761, column: 62, scope: !530)
!564 = !DILocation(line: 761, column: 17, scope: !530)
!565 = !DILocation(line: 765, column: 16, scope: !530)
!566 = !DILocation(line: 765, column: 9, scope: !530)
