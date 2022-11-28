; ModuleID = 'FreeRTOS/Source/queue.c'
source_filename = "FreeRTOS/Source/queue.c"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-unknown-eabi"

%struct.QUEUE_REGISTRY_ITEM = type { ptr, ptr }
%struct.QueueDefinition = type { ptr, ptr, %union.anon, %struct.xLIST, %struct.xLIST, i32, i32, i32, i8, i8, i8, i32, i8 }
%union.anon = type { %struct.QueuePointers }
%struct.QueuePointers = type { ptr, ptr }
%struct.xLIST = type { i32, ptr, %struct.xMINI_LIST_ITEM }
%struct.xMINI_LIST_ITEM = type { i32, ptr, ptr }
%struct.SemaphoreData = type { ptr, i32 }
%struct.xTIME_OUT = type { i32, i32 }
%struct.xLIST_ITEM = type { i32, ptr, ptr, ptr, ptr }

@.str = private unnamed_addr constant [8 x i8] c"exclude\00", section "llvm.metadata"
@.str.1 = private unnamed_addr constant [24 x i8] c"FreeRTOS/Source/queue.c\00", section "llvm.metadata"
@xQueueRegistry = dso_local global [8 x %struct.QUEUE_REGISTRY_ITEM] zeroinitializer, align 4
@llvm.global.annotations = appending global [1 x { ptr, ptr, ptr, i32, ptr }] [{ ptr, ptr, ptr, i32, ptr } { ptr @xQueueGenericCreateStatic, ptr @.str, ptr @.str.1, i32 335, ptr null }], section "llvm.metadata"

; Function Attrs: noinline nounwind
define dso_local i32 @xQueueGenericReset(ptr noundef %0, i32 noundef %1) #0 !dbg !7 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 1, ptr %5, align 4, !dbg !10
  %7 = load ptr, ptr %3, align 4, !dbg !11
  store ptr %7, ptr %6, align 4, !dbg !12
  %8 = load ptr, ptr %6, align 4, !dbg !13
  %9 = icmp ne ptr %8, null, !dbg !14
  br i1 %9, label %10, label %92, !dbg !15

10:                                               ; preds = %2
  %11 = load ptr, ptr %6, align 4, !dbg !16
  %12 = getelementptr inbounds %struct.QueueDefinition, ptr %11, i32 0, i32 6, !dbg !17
  %13 = load i32, ptr %12, align 4, !dbg !17
  %14 = icmp uge i32 %13, 1, !dbg !18
  br i1 %14, label %15, label %92, !dbg !19

15:                                               ; preds = %10
  %16 = load ptr, ptr %6, align 4, !dbg !20
  %17 = getelementptr inbounds %struct.QueueDefinition, ptr %16, i32 0, i32 6, !dbg !21
  %18 = load i32, ptr %17, align 4, !dbg !21
  %19 = udiv i32 -1, %18, !dbg !22
  %20 = load ptr, ptr %6, align 4, !dbg !23
  %21 = getelementptr inbounds %struct.QueueDefinition, ptr %20, i32 0, i32 7, !dbg !24
  %22 = load i32, ptr %21, align 4, !dbg !24
  %23 = icmp uge i32 %19, %22, !dbg !25
  br i1 %23, label %24, label %92, !dbg !26

24:                                               ; preds = %15
  call void @vPortEnterCritical(), !dbg !27
  %25 = load ptr, ptr %6, align 4, !dbg !28
  %26 = getelementptr inbounds %struct.QueueDefinition, ptr %25, i32 0, i32 0, !dbg !29
  %27 = load ptr, ptr %26, align 4, !dbg !29
  %28 = load ptr, ptr %6, align 4, !dbg !30
  %29 = getelementptr inbounds %struct.QueueDefinition, ptr %28, i32 0, i32 6, !dbg !31
  %30 = load i32, ptr %29, align 4, !dbg !31
  %31 = load ptr, ptr %6, align 4, !dbg !32
  %32 = getelementptr inbounds %struct.QueueDefinition, ptr %31, i32 0, i32 7, !dbg !33
  %33 = load i32, ptr %32, align 4, !dbg !33
  %34 = mul i32 %30, %33, !dbg !34
  %35 = getelementptr inbounds i8, ptr %27, i32 %34, !dbg !35
  %36 = load ptr, ptr %6, align 4, !dbg !36
  %37 = getelementptr inbounds %struct.QueueDefinition, ptr %36, i32 0, i32 2, !dbg !37
  %38 = getelementptr inbounds %struct.QueuePointers, ptr %37, i32 0, i32 0, !dbg !38
  store ptr %35, ptr %38, align 4, !dbg !39
  %39 = load ptr, ptr %6, align 4, !dbg !40
  %40 = getelementptr inbounds %struct.QueueDefinition, ptr %39, i32 0, i32 5, !dbg !41
  store volatile i32 0, ptr %40, align 4, !dbg !42
  %41 = load ptr, ptr %6, align 4, !dbg !43
  %42 = getelementptr inbounds %struct.QueueDefinition, ptr %41, i32 0, i32 0, !dbg !44
  %43 = load ptr, ptr %42, align 4, !dbg !44
  %44 = load ptr, ptr %6, align 4, !dbg !45
  %45 = getelementptr inbounds %struct.QueueDefinition, ptr %44, i32 0, i32 1, !dbg !46
  store ptr %43, ptr %45, align 4, !dbg !47
  %46 = load ptr, ptr %6, align 4, !dbg !48
  %47 = getelementptr inbounds %struct.QueueDefinition, ptr %46, i32 0, i32 0, !dbg !49
  %48 = load ptr, ptr %47, align 4, !dbg !49
  %49 = load ptr, ptr %6, align 4, !dbg !50
  %50 = getelementptr inbounds %struct.QueueDefinition, ptr %49, i32 0, i32 6, !dbg !51
  %51 = load i32, ptr %50, align 4, !dbg !51
  %52 = sub i32 %51, 1, !dbg !52
  %53 = load ptr, ptr %6, align 4, !dbg !53
  %54 = getelementptr inbounds %struct.QueueDefinition, ptr %53, i32 0, i32 7, !dbg !54
  %55 = load i32, ptr %54, align 4, !dbg !54
  %56 = mul i32 %52, %55, !dbg !55
  %57 = getelementptr inbounds i8, ptr %48, i32 %56, !dbg !56
  %58 = load ptr, ptr %6, align 4, !dbg !57
  %59 = getelementptr inbounds %struct.QueueDefinition, ptr %58, i32 0, i32 2, !dbg !58
  %60 = getelementptr inbounds %struct.QueuePointers, ptr %59, i32 0, i32 1, !dbg !59
  store ptr %57, ptr %60, align 4, !dbg !60
  %61 = load ptr, ptr %6, align 4, !dbg !61
  %62 = getelementptr inbounds %struct.QueueDefinition, ptr %61, i32 0, i32 8, !dbg !62
  store volatile i8 -1, ptr %62, align 4, !dbg !63
  %63 = load ptr, ptr %6, align 4, !dbg !64
  %64 = getelementptr inbounds %struct.QueueDefinition, ptr %63, i32 0, i32 9, !dbg !65
  store volatile i8 -1, ptr %64, align 1, !dbg !66
  %65 = load i32, ptr %4, align 4, !dbg !67
  %66 = icmp eq i32 %65, 0, !dbg !68
  br i1 %66, label %67, label %86, !dbg !67

67:                                               ; preds = %24
  %68 = load ptr, ptr %6, align 4, !dbg !69
  %69 = getelementptr inbounds %struct.QueueDefinition, ptr %68, i32 0, i32 3, !dbg !69
  %70 = getelementptr inbounds %struct.xLIST, ptr %69, i32 0, i32 0, !dbg !69
  %71 = load volatile i32, ptr %70, align 4, !dbg !69
  %72 = icmp eq i32 %71, 0, !dbg !69
  %73 = zext i1 %72 to i64, !dbg !69
  %74 = select i1 %72, i32 1, i32 0, !dbg !69
  %75 = icmp eq i32 %74, 0, !dbg !70
  br i1 %75, label %76, label %84, !dbg !69

76:                                               ; preds = %67
  %77 = load ptr, ptr %6, align 4, !dbg !71
  %78 = getelementptr inbounds %struct.QueueDefinition, ptr %77, i32 0, i32 3, !dbg !72
  %79 = call i32 @xTaskRemoveFromEventList(ptr noundef %78), !dbg !73
  %80 = icmp ne i32 %79, 0, !dbg !74
  br i1 %80, label %81, label %82, !dbg !73

81:                                               ; preds = %76
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !75
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !75, !srcloc !76
  call void asm sideeffect "isb", ""() #3, !dbg !75, !srcloc !77
  br label %83, !dbg !78

82:                                               ; preds = %76
  br label %83

83:                                               ; preds = %82, %81
  br label %85, !dbg !79

84:                                               ; preds = %67
  br label %85

85:                                               ; preds = %84, %83
  br label %91, !dbg !80

86:                                               ; preds = %24
  %87 = load ptr, ptr %6, align 4, !dbg !81
  %88 = getelementptr inbounds %struct.QueueDefinition, ptr %87, i32 0, i32 3, !dbg !82
  call void @vListInitialise(ptr noundef %88), !dbg !83
  %89 = load ptr, ptr %6, align 4, !dbg !84
  %90 = getelementptr inbounds %struct.QueueDefinition, ptr %89, i32 0, i32 4, !dbg !85
  call void @vListInitialise(ptr noundef %90), !dbg !86
  br label %91

91:                                               ; preds = %86, %85
  call void @vPortExitCritical(), !dbg !87
  br label %93, !dbg !88

92:                                               ; preds = %15, %10, %2
  store i32 0, ptr %5, align 4, !dbg !89
  br label %93

93:                                               ; preds = %92, %91
  %94 = load i32, ptr %5, align 4, !dbg !90
  ret i32 %94, !dbg !91
}

declare dso_local void @vPortEnterCritical() #1

declare dso_local i32 @xTaskRemoveFromEventList(ptr noundef) #1

declare dso_local void @vListInitialise(ptr noundef) #1

declare dso_local void @vPortExitCritical() #1

; Function Attrs: noinline nounwind
define dso_local ptr @xQueueGenericCreateStatic(i32 noundef %0, i32 noundef %1, ptr noundef %2, ptr noundef %3, i8 noundef zeroext %4) #0 !dbg !92 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 4
  %9 = alloca ptr, align 4
  %10 = alloca i8, align 1
  %11 = alloca ptr, align 4
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store ptr %2, ptr %8, align 4
  store ptr %3, ptr %9, align 4
  store i8 %4, ptr %10, align 1
  store ptr null, ptr %11, align 4, !dbg !93
  %12 = load i32, ptr %6, align 4, !dbg !94
  %13 = icmp ugt i32 %12, 0, !dbg !95
  br i1 %13, label %14, label %38, !dbg !96

14:                                               ; preds = %5
  %15 = load ptr, ptr %9, align 4, !dbg !97
  %16 = icmp ne ptr %15, null, !dbg !98
  br i1 %16, label %17, label %38, !dbg !99

17:                                               ; preds = %14
  %18 = load ptr, ptr %8, align 4, !dbg !100
  %19 = icmp ne ptr %18, null, !dbg !101
  br i1 %19, label %20, label %23, !dbg !102

20:                                               ; preds = %17
  %21 = load i32, ptr %7, align 4, !dbg !103
  %22 = icmp eq i32 %21, 0, !dbg !104
  br i1 %22, label %38, label %23, !dbg !105

23:                                               ; preds = %20, %17
  %24 = load ptr, ptr %8, align 4, !dbg !106
  %25 = icmp eq ptr %24, null, !dbg !107
  br i1 %25, label %26, label %29, !dbg !108

26:                                               ; preds = %23
  %27 = load i32, ptr %7, align 4, !dbg !109
  %28 = icmp ne i32 %27, 0, !dbg !110
  br i1 %28, label %38, label %29, !dbg !111

29:                                               ; preds = %26, %23
  %30 = load ptr, ptr %9, align 4, !dbg !112
  store ptr %30, ptr %11, align 4, !dbg !113
  %31 = load ptr, ptr %11, align 4, !dbg !114
  %32 = getelementptr inbounds %struct.QueueDefinition, ptr %31, i32 0, i32 10, !dbg !115
  store i8 1, ptr %32, align 2, !dbg !116
  %33 = load i32, ptr %6, align 4, !dbg !117
  %34 = load i32, ptr %7, align 4, !dbg !118
  %35 = load ptr, ptr %8, align 4, !dbg !119
  %36 = load i8, ptr %10, align 1, !dbg !120
  %37 = load ptr, ptr %11, align 4, !dbg !121
  call void @prvInitialiseNewQueue(i32 noundef %33, i32 noundef %34, ptr noundef %35, i8 noundef zeroext %36, ptr noundef %37), !dbg !122
  br label %39, !dbg !123

38:                                               ; preds = %26, %20, %14, %5
  br label %39

39:                                               ; preds = %38, %29
  %40 = load ptr, ptr %11, align 4, !dbg !124
  ret ptr %40, !dbg !125
}

; Function Attrs: noinline nounwind
define internal void @prvInitialiseNewQueue(i32 noundef %0, i32 noundef %1, ptr noundef %2, i8 noundef zeroext %3, ptr noundef %4) #0 !dbg !126 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 4
  %9 = alloca i8, align 1
  %10 = alloca ptr, align 4
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store ptr %2, ptr %8, align 4
  store i8 %3, ptr %9, align 1
  store ptr %4, ptr %10, align 4
  %11 = load i8, ptr %9, align 1, !dbg !127
  %12 = load i32, ptr %7, align 4, !dbg !128
  %13 = icmp eq i32 %12, 0, !dbg !129
  br i1 %13, label %14, label %18, !dbg !128

14:                                               ; preds = %5
  %15 = load ptr, ptr %10, align 4, !dbg !130
  %16 = load ptr, ptr %10, align 4, !dbg !131
  %17 = getelementptr inbounds %struct.QueueDefinition, ptr %16, i32 0, i32 0, !dbg !132
  store ptr %15, ptr %17, align 4, !dbg !133
  br label %22, !dbg !134

18:                                               ; preds = %5
  %19 = load ptr, ptr %8, align 4, !dbg !135
  %20 = load ptr, ptr %10, align 4, !dbg !136
  %21 = getelementptr inbounds %struct.QueueDefinition, ptr %20, i32 0, i32 0, !dbg !137
  store ptr %19, ptr %21, align 4, !dbg !138
  br label %22

22:                                               ; preds = %18, %14
  %23 = load i32, ptr %6, align 4, !dbg !139
  %24 = load ptr, ptr %10, align 4, !dbg !140
  %25 = getelementptr inbounds %struct.QueueDefinition, ptr %24, i32 0, i32 6, !dbg !141
  store i32 %23, ptr %25, align 4, !dbg !142
  %26 = load i32, ptr %7, align 4, !dbg !143
  %27 = load ptr, ptr %10, align 4, !dbg !144
  %28 = getelementptr inbounds %struct.QueueDefinition, ptr %27, i32 0, i32 7, !dbg !145
  store i32 %26, ptr %28, align 4, !dbg !146
  %29 = load ptr, ptr %10, align 4, !dbg !147
  %30 = call i32 @xQueueGenericReset(ptr noundef %29, i32 noundef 1), !dbg !148
  %31 = load i8, ptr %9, align 1, !dbg !149
  %32 = load ptr, ptr %10, align 4, !dbg !150
  %33 = getelementptr inbounds %struct.QueueDefinition, ptr %32, i32 0, i32 12, !dbg !151
  store i8 %31, ptr %33, align 4, !dbg !152
  ret void, !dbg !153
}

; Function Attrs: noinline nounwind
define dso_local ptr @xQueueGenericCreate(i32 noundef %0, i32 noundef %1, i8 noundef zeroext %2) #0 !dbg !154 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i8, align 1
  %7 = alloca ptr, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i8 %2, ptr %6, align 1
  store ptr null, ptr %7, align 4, !dbg !155
  %10 = load i32, ptr %4, align 4, !dbg !156
  %11 = icmp ugt i32 %10, 0, !dbg !157
  br i1 %11, label %12, label %44, !dbg !158

12:                                               ; preds = %3
  %13 = load i32, ptr %4, align 4, !dbg !159
  %14 = udiv i32 -1, %13, !dbg !160
  %15 = load i32, ptr %5, align 4, !dbg !161
  %16 = icmp uge i32 %14, %15, !dbg !162
  br i1 %16, label %17, label %44, !dbg !163

17:                                               ; preds = %12
  %18 = load i32, ptr %4, align 4, !dbg !164
  %19 = load i32, ptr %5, align 4, !dbg !165
  %20 = mul i32 %18, %19, !dbg !166
  %21 = icmp uge i32 -81, %20, !dbg !167
  br i1 %21, label %22, label %44, !dbg !168

22:                                               ; preds = %17
  %23 = load i32, ptr %4, align 4, !dbg !169
  %24 = load i32, ptr %5, align 4, !dbg !170
  %25 = mul i32 %23, %24, !dbg !171
  store i32 %25, ptr %8, align 4, !dbg !172
  %26 = load i32, ptr %8, align 4, !dbg !173
  %27 = add i32 80, %26, !dbg !174
  %28 = call ptr @pvPortMalloc(i32 noundef %27), !dbg !175
  store ptr %28, ptr %7, align 4, !dbg !176
  %29 = load ptr, ptr %7, align 4, !dbg !177
  %30 = icmp ne ptr %29, null, !dbg !178
  br i1 %30, label %31, label %42, !dbg !177

31:                                               ; preds = %22
  %32 = load ptr, ptr %7, align 4, !dbg !179
  store ptr %32, ptr %9, align 4, !dbg !180
  %33 = load ptr, ptr %9, align 4, !dbg !181
  %34 = getelementptr inbounds i8, ptr %33, i32 80, !dbg !181
  store ptr %34, ptr %9, align 4, !dbg !181
  %35 = load ptr, ptr %7, align 4, !dbg !182
  %36 = getelementptr inbounds %struct.QueueDefinition, ptr %35, i32 0, i32 10, !dbg !183
  store i8 0, ptr %36, align 2, !dbg !184
  %37 = load i32, ptr %4, align 4, !dbg !185
  %38 = load i32, ptr %5, align 4, !dbg !186
  %39 = load ptr, ptr %9, align 4, !dbg !187
  %40 = load i8, ptr %6, align 1, !dbg !188
  %41 = load ptr, ptr %7, align 4, !dbg !189
  call void @prvInitialiseNewQueue(i32 noundef %37, i32 noundef %38, ptr noundef %39, i8 noundef zeroext %40, ptr noundef %41), !dbg !190
  br label %43, !dbg !191

42:                                               ; preds = %22
  br label %43

43:                                               ; preds = %42, %31
  br label %45, !dbg !192

44:                                               ; preds = %17, %12, %3
  br label %45

45:                                               ; preds = %44, %43
  %46 = load ptr, ptr %7, align 4, !dbg !193
  ret ptr %46, !dbg !194
}

declare dso_local ptr @pvPortMalloc(i32 noundef) #1

; Function Attrs: noinline nounwind
define dso_local ptr @xQueueCreateMutex(i8 noundef zeroext %0) #0 !dbg !195 {
  %2 = alloca i8, align 1
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i8 %0, ptr %2, align 1
  store i32 1, ptr %4, align 4, !dbg !196
  store i32 0, ptr %5, align 4, !dbg !197
  %6 = load i8, ptr %2, align 1, !dbg !198
  %7 = call ptr @xQueueGenericCreate(i32 noundef 1, i32 noundef 0, i8 noundef zeroext %6), !dbg !199
  store ptr %7, ptr %3, align 4, !dbg !200
  %8 = load ptr, ptr %3, align 4, !dbg !201
  call void @prvInitialiseMutex(ptr noundef %8), !dbg !202
  %9 = load ptr, ptr %3, align 4, !dbg !203
  ret ptr %9, !dbg !204
}

; Function Attrs: noinline nounwind
define internal void @prvInitialiseMutex(ptr noundef %0) #0 !dbg !205 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %3 = load ptr, ptr %2, align 4, !dbg !206
  %4 = icmp ne ptr %3, null, !dbg !207
  br i1 %4, label %5, label %16, !dbg !206

5:                                                ; preds = %1
  %6 = load ptr, ptr %2, align 4, !dbg !208
  %7 = getelementptr inbounds %struct.QueueDefinition, ptr %6, i32 0, i32 2, !dbg !209
  %8 = getelementptr inbounds %struct.SemaphoreData, ptr %7, i32 0, i32 0, !dbg !210
  store ptr null, ptr %8, align 4, !dbg !211
  %9 = load ptr, ptr %2, align 4, !dbg !212
  %10 = getelementptr inbounds %struct.QueueDefinition, ptr %9, i32 0, i32 0, !dbg !213
  store ptr null, ptr %10, align 4, !dbg !214
  %11 = load ptr, ptr %2, align 4, !dbg !215
  %12 = getelementptr inbounds %struct.QueueDefinition, ptr %11, i32 0, i32 2, !dbg !216
  %13 = getelementptr inbounds %struct.SemaphoreData, ptr %12, i32 0, i32 1, !dbg !217
  store i32 0, ptr %13, align 4, !dbg !218
  %14 = load ptr, ptr %2, align 4, !dbg !219
  %15 = call i32 @xQueueGenericSend(ptr noundef %14, ptr noundef null, i32 noundef 0, i32 noundef 0), !dbg !220
  br label %17, !dbg !221

16:                                               ; preds = %1
  br label %17

17:                                               ; preds = %16, %5
  ret void, !dbg !222
}

; Function Attrs: noinline nounwind
define dso_local ptr @xQueueCreateMutexStatic(i8 noundef zeroext %0, ptr noundef %1) #0 !dbg !223 {
  %3 = alloca i8, align 1
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i8 %0, ptr %3, align 1
  store ptr %1, ptr %4, align 4
  store i32 1, ptr %6, align 4, !dbg !224
  store i32 0, ptr %7, align 4, !dbg !225
  %8 = load i8, ptr %3, align 1, !dbg !226
  %9 = load ptr, ptr %4, align 4, !dbg !227
  %10 = load i8, ptr %3, align 1, !dbg !228
  %11 = call ptr @xQueueGenericCreateStatic(i32 noundef 1, i32 noundef 0, ptr noundef null, ptr noundef %9, i8 noundef zeroext %10), !dbg !229
  store ptr %11, ptr %5, align 4, !dbg !230
  %12 = load ptr, ptr %5, align 4, !dbg !231
  call void @prvInitialiseMutex(ptr noundef %12), !dbg !232
  %13 = load ptr, ptr %5, align 4, !dbg !233
  ret ptr %13, !dbg !234
}

; Function Attrs: noinline nounwind
define dso_local ptr @xQueueGetMutexHolder(ptr noundef %0) #0 !dbg !235 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !236
  store ptr %5, ptr %4, align 4, !dbg !237
  call void @vPortEnterCritical(), !dbg !238
  %6 = load ptr, ptr %4, align 4, !dbg !239
  %7 = getelementptr inbounds %struct.QueueDefinition, ptr %6, i32 0, i32 0, !dbg !240
  %8 = load ptr, ptr %7, align 4, !dbg !240
  %9 = icmp eq ptr %8, null, !dbg !241
  br i1 %9, label %10, label %15, !dbg !239

10:                                               ; preds = %1
  %11 = load ptr, ptr %4, align 4, !dbg !242
  %12 = getelementptr inbounds %struct.QueueDefinition, ptr %11, i32 0, i32 2, !dbg !243
  %13 = getelementptr inbounds %struct.SemaphoreData, ptr %12, i32 0, i32 0, !dbg !244
  %14 = load ptr, ptr %13, align 4, !dbg !244
  store ptr %14, ptr %3, align 4, !dbg !245
  br label %16, !dbg !246

15:                                               ; preds = %1
  store ptr null, ptr %3, align 4, !dbg !247
  br label %16

16:                                               ; preds = %15, %10
  call void @vPortExitCritical(), !dbg !248
  %17 = load ptr, ptr %3, align 4, !dbg !249
  ret ptr %17, !dbg !250
}

; Function Attrs: noinline nounwind
define dso_local ptr @xQueueGetMutexHolderFromISR(ptr noundef %0) #0 !dbg !251 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %4 = load ptr, ptr %2, align 4, !dbg !252
  %5 = getelementptr inbounds %struct.QueueDefinition, ptr %4, i32 0, i32 0, !dbg !253
  %6 = load ptr, ptr %5, align 4, !dbg !253
  %7 = icmp eq ptr %6, null, !dbg !254
  br i1 %7, label %8, label %13, !dbg !255

8:                                                ; preds = %1
  %9 = load ptr, ptr %2, align 4, !dbg !256
  %10 = getelementptr inbounds %struct.QueueDefinition, ptr %9, i32 0, i32 2, !dbg !257
  %11 = getelementptr inbounds %struct.SemaphoreData, ptr %10, i32 0, i32 0, !dbg !258
  %12 = load ptr, ptr %11, align 4, !dbg !258
  store ptr %12, ptr %3, align 4, !dbg !259
  br label %14, !dbg !260

13:                                               ; preds = %1
  store ptr null, ptr %3, align 4, !dbg !261
  br label %14

14:                                               ; preds = %13, %8
  %15 = load ptr, ptr %3, align 4, !dbg !262
  ret ptr %15, !dbg !263
}

; Function Attrs: noinline nounwind
define dso_local i32 @xQueueGiveMutexRecursive(ptr noundef %0) #0 !dbg !264 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !265
  store ptr %5, ptr %4, align 4, !dbg !266
  %6 = load ptr, ptr %4, align 4, !dbg !267
  %7 = getelementptr inbounds %struct.QueueDefinition, ptr %6, i32 0, i32 2, !dbg !268
  %8 = getelementptr inbounds %struct.SemaphoreData, ptr %7, i32 0, i32 0, !dbg !269
  %9 = load ptr, ptr %8, align 4, !dbg !269
  %10 = call ptr @xTaskGetCurrentTaskHandle(), !dbg !270
  %11 = icmp eq ptr %9, %10, !dbg !271
  br i1 %11, label %12, label %28, !dbg !267

12:                                               ; preds = %1
  %13 = load ptr, ptr %4, align 4, !dbg !272
  %14 = getelementptr inbounds %struct.QueueDefinition, ptr %13, i32 0, i32 2, !dbg !273
  %15 = getelementptr inbounds %struct.SemaphoreData, ptr %14, i32 0, i32 1, !dbg !274
  %16 = load i32, ptr %15, align 4, !dbg !275
  %17 = add i32 %16, -1, !dbg !275
  store i32 %17, ptr %15, align 4, !dbg !275
  %18 = load ptr, ptr %4, align 4, !dbg !276
  %19 = getelementptr inbounds %struct.QueueDefinition, ptr %18, i32 0, i32 2, !dbg !277
  %20 = getelementptr inbounds %struct.SemaphoreData, ptr %19, i32 0, i32 1, !dbg !278
  %21 = load i32, ptr %20, align 4, !dbg !278
  %22 = icmp eq i32 %21, 0, !dbg !279
  br i1 %22, label %23, label %26, !dbg !276

23:                                               ; preds = %12
  %24 = load ptr, ptr %4, align 4, !dbg !280
  %25 = call i32 @xQueueGenericSend(ptr noundef %24, ptr noundef null, i32 noundef 0, i32 noundef 0), !dbg !281
  br label %27, !dbg !282

26:                                               ; preds = %12
  br label %27

27:                                               ; preds = %26, %23
  store i32 1, ptr %3, align 4, !dbg !283
  br label %29, !dbg !284

28:                                               ; preds = %1
  store i32 0, ptr %3, align 4, !dbg !285
  br label %29

29:                                               ; preds = %28, %27
  %30 = load i32, ptr %3, align 4, !dbg !286
  ret i32 %30, !dbg !287
}

declare dso_local ptr @xTaskGetCurrentTaskHandle() #1

; Function Attrs: noinline nounwind
define dso_local i32 @xQueueGenericSend(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 !dbg !288 {
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 4
  %7 = alloca ptr, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca %struct.xTIME_OUT, align 4
  %13 = alloca ptr, align 4
  store ptr %0, ptr %6, align 4
  store ptr %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  store i32 0, ptr %10, align 4, !dbg !289
  %14 = load ptr, ptr %6, align 4, !dbg !290
  store ptr %14, ptr %13, align 4, !dbg !291
  br label %15, !dbg !292

15:                                               ; preds = %106, %4
  call void @vPortEnterCritical(), !dbg !293
  %16 = load ptr, ptr %13, align 4, !dbg !294
  %17 = getelementptr inbounds %struct.QueueDefinition, ptr %16, i32 0, i32 5, !dbg !295
  %18 = load volatile i32, ptr %17, align 4, !dbg !295
  %19 = load ptr, ptr %13, align 4, !dbg !296
  %20 = getelementptr inbounds %struct.QueueDefinition, ptr %19, i32 0, i32 6, !dbg !297
  %21 = load i32, ptr %20, align 4, !dbg !297
  %22 = icmp ult i32 %18, %21, !dbg !298
  br i1 %22, label %26, label %23, !dbg !299

23:                                               ; preds = %15
  %24 = load i32, ptr %9, align 4, !dbg !300
  %25 = icmp eq i32 %24, 2, !dbg !301
  br i1 %25, label %26, label %54, !dbg !302

26:                                               ; preds = %23, %15
  %27 = load ptr, ptr %13, align 4, !dbg !303
  %28 = load ptr, ptr %7, align 4, !dbg !304
  %29 = load i32, ptr %9, align 4, !dbg !305
  %30 = call i32 @prvCopyDataToQueue(ptr noundef %27, ptr noundef %28, i32 noundef %29), !dbg !306
  store i32 %30, ptr %11, align 4, !dbg !307
  %31 = load ptr, ptr %13, align 4, !dbg !308
  %32 = getelementptr inbounds %struct.QueueDefinition, ptr %31, i32 0, i32 4, !dbg !308
  %33 = getelementptr inbounds %struct.xLIST, ptr %32, i32 0, i32 0, !dbg !308
  %34 = load volatile i32, ptr %33, align 4, !dbg !308
  %35 = icmp eq i32 %34, 0, !dbg !308
  %36 = zext i1 %35 to i64, !dbg !308
  %37 = select i1 %35, i32 1, i32 0, !dbg !308
  %38 = icmp eq i32 %37, 0, !dbg !309
  br i1 %38, label %39, label %47, !dbg !308

39:                                               ; preds = %26
  %40 = load ptr, ptr %13, align 4, !dbg !310
  %41 = getelementptr inbounds %struct.QueueDefinition, ptr %40, i32 0, i32 4, !dbg !311
  %42 = call i32 @xTaskRemoveFromEventList(ptr noundef %41), !dbg !312
  %43 = icmp ne i32 %42, 0, !dbg !313
  br i1 %43, label %44, label %45, !dbg !312

44:                                               ; preds = %39
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !314
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !314, !srcloc !315
  call void asm sideeffect "isb", ""() #3, !dbg !314, !srcloc !316
  br label %46, !dbg !317

45:                                               ; preds = %39
  br label %46

46:                                               ; preds = %45, %44
  br label %53, !dbg !318

47:                                               ; preds = %26
  %48 = load i32, ptr %11, align 4, !dbg !319
  %49 = icmp ne i32 %48, 0, !dbg !320
  br i1 %49, label %50, label %51, !dbg !319

50:                                               ; preds = %47
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !321
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !321, !srcloc !322
  call void asm sideeffect "isb", ""() #3, !dbg !321, !srcloc !323
  br label %52, !dbg !324

51:                                               ; preds = %47
  br label %52

52:                                               ; preds = %51, %50
  br label %53

53:                                               ; preds = %52, %46
  call void @vPortExitCritical(), !dbg !325
  store i32 1, ptr %5, align 4, !dbg !326
  br label %107, !dbg !326

54:                                               ; preds = %23
  %55 = load i32, ptr %8, align 4, !dbg !327
  %56 = icmp eq i32 %55, 0, !dbg !328
  br i1 %56, label %57, label %58, !dbg !327

57:                                               ; preds = %54
  call void @vPortExitCritical(), !dbg !329
  store i32 0, ptr %5, align 4, !dbg !330
  br label %107, !dbg !330

58:                                               ; preds = %54
  %59 = load i32, ptr %10, align 4, !dbg !331
  %60 = icmp eq i32 %59, 0, !dbg !332
  br i1 %60, label %61, label %62, !dbg !331

61:                                               ; preds = %58
  call void @vTaskInternalSetTimeOutState(ptr noundef %12), !dbg !333
  store i32 1, ptr %10, align 4, !dbg !334
  br label %63, !dbg !335

62:                                               ; preds = %58
  br label %63

63:                                               ; preds = %62, %61
  br label %64

64:                                               ; preds = %63
  br label %65

65:                                               ; preds = %64
  call void @vPortExitCritical(), !dbg !336
  call void @vTaskSuspendAll(), !dbg !337
  call void @vPortEnterCritical(), !dbg !338
  %66 = load ptr, ptr %13, align 4, !dbg !338
  %67 = getelementptr inbounds %struct.QueueDefinition, ptr %66, i32 0, i32 8, !dbg !338
  %68 = load volatile i8, ptr %67, align 4, !dbg !338
  %69 = sext i8 %68 to i32, !dbg !338
  %70 = icmp eq i32 %69, -1, !dbg !338
  br i1 %70, label %71, label %74, !dbg !338

71:                                               ; preds = %65
  %72 = load ptr, ptr %13, align 4, !dbg !338
  %73 = getelementptr inbounds %struct.QueueDefinition, ptr %72, i32 0, i32 8, !dbg !338
  store volatile i8 0, ptr %73, align 4, !dbg !338
  br label %74, !dbg !338

74:                                               ; preds = %71, %65
  %75 = load ptr, ptr %13, align 4, !dbg !338
  %76 = getelementptr inbounds %struct.QueueDefinition, ptr %75, i32 0, i32 9, !dbg !338
  %77 = load volatile i8, ptr %76, align 1, !dbg !338
  %78 = sext i8 %77 to i32, !dbg !338
  %79 = icmp eq i32 %78, -1, !dbg !338
  br i1 %79, label %80, label %83, !dbg !338

80:                                               ; preds = %74
  %81 = load ptr, ptr %13, align 4, !dbg !338
  %82 = getelementptr inbounds %struct.QueueDefinition, ptr %81, i32 0, i32 9, !dbg !338
  store volatile i8 0, ptr %82, align 1, !dbg !338
  br label %83, !dbg !338

83:                                               ; preds = %80, %74
  call void @vPortExitCritical(), !dbg !338
  %84 = call i32 @xTaskCheckForTimeOut(ptr noundef %12, ptr noundef %8), !dbg !339
  %85 = icmp eq i32 %84, 0, !dbg !340
  br i1 %85, label %86, label %103, !dbg !339

86:                                               ; preds = %83
  %87 = load ptr, ptr %13, align 4, !dbg !341
  %88 = call i32 @prvIsQueueFull(ptr noundef %87), !dbg !342
  %89 = icmp ne i32 %88, 0, !dbg !343
  br i1 %89, label %90, label %99, !dbg !342

90:                                               ; preds = %86
  %91 = load ptr, ptr %13, align 4, !dbg !344
  %92 = getelementptr inbounds %struct.QueueDefinition, ptr %91, i32 0, i32 3, !dbg !345
  %93 = load i32, ptr %8, align 4, !dbg !346
  call void @vTaskPlaceOnEventList(ptr noundef %92, i32 noundef %93), !dbg !347
  %94 = load ptr, ptr %13, align 4, !dbg !348
  call void @prvUnlockQueue(ptr noundef %94), !dbg !349
  %95 = call i32 @xTaskResumeAll(), !dbg !350
  %96 = icmp eq i32 %95, 0, !dbg !351
  br i1 %96, label %97, label %98, !dbg !350

97:                                               ; preds = %90
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !352
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !352, !srcloc !353
  call void asm sideeffect "isb", ""() #3, !dbg !352, !srcloc !354
  br label %98, !dbg !355

98:                                               ; preds = %97, %90
  br label %102, !dbg !356

99:                                               ; preds = %86
  %100 = load ptr, ptr %13, align 4, !dbg !357
  call void @prvUnlockQueue(ptr noundef %100), !dbg !358
  %101 = call i32 @xTaskResumeAll(), !dbg !359
  br label %102

102:                                              ; preds = %99, %98
  br label %106, !dbg !360

103:                                              ; preds = %83
  %104 = load ptr, ptr %13, align 4, !dbg !361
  call void @prvUnlockQueue(ptr noundef %104), !dbg !362
  %105 = call i32 @xTaskResumeAll(), !dbg !363
  store i32 0, ptr %5, align 4, !dbg !364
  br label %107, !dbg !364

106:                                              ; preds = %102
  br label %15, !dbg !292, !llvm.loop !365

107:                                              ; preds = %103, %57, %53
  %108 = load i32, ptr %5, align 4, !dbg !367
  ret i32 %108, !dbg !367
}

; Function Attrs: noinline nounwind
define dso_local i32 @xQueueTakeMutexRecursive(ptr noundef %0, i32 noundef %1) #0 !dbg !368 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = load ptr, ptr %3, align 4, !dbg !369
  store ptr %7, ptr %6, align 4, !dbg !370
  %8 = load ptr, ptr %6, align 4, !dbg !371
  %9 = getelementptr inbounds %struct.QueueDefinition, ptr %8, i32 0, i32 2, !dbg !372
  %10 = getelementptr inbounds %struct.SemaphoreData, ptr %9, i32 0, i32 0, !dbg !373
  %11 = load ptr, ptr %10, align 4, !dbg !373
  %12 = call ptr @xTaskGetCurrentTaskHandle(), !dbg !374
  %13 = icmp eq ptr %11, %12, !dbg !375
  br i1 %13, label %14, label %20, !dbg !371

14:                                               ; preds = %2
  %15 = load ptr, ptr %6, align 4, !dbg !376
  %16 = getelementptr inbounds %struct.QueueDefinition, ptr %15, i32 0, i32 2, !dbg !377
  %17 = getelementptr inbounds %struct.SemaphoreData, ptr %16, i32 0, i32 1, !dbg !378
  %18 = load i32, ptr %17, align 4, !dbg !379
  %19 = add i32 %18, 1, !dbg !379
  store i32 %19, ptr %17, align 4, !dbg !379
  store i32 1, ptr %5, align 4, !dbg !380
  br label %34, !dbg !381

20:                                               ; preds = %2
  %21 = load ptr, ptr %6, align 4, !dbg !382
  %22 = load i32, ptr %4, align 4, !dbg !383
  %23 = call i32 @xQueueSemaphoreTake(ptr noundef %21, i32 noundef %22), !dbg !384
  store i32 %23, ptr %5, align 4, !dbg !385
  %24 = load i32, ptr %5, align 4, !dbg !386
  %25 = icmp ne i32 %24, 0, !dbg !387
  br i1 %25, label %26, label %32, !dbg !386

26:                                               ; preds = %20
  %27 = load ptr, ptr %6, align 4, !dbg !388
  %28 = getelementptr inbounds %struct.QueueDefinition, ptr %27, i32 0, i32 2, !dbg !389
  %29 = getelementptr inbounds %struct.SemaphoreData, ptr %28, i32 0, i32 1, !dbg !390
  %30 = load i32, ptr %29, align 4, !dbg !391
  %31 = add i32 %30, 1, !dbg !391
  store i32 %31, ptr %29, align 4, !dbg !391
  br label %33, !dbg !392

32:                                               ; preds = %20
  br label %33

33:                                               ; preds = %32, %26
  br label %34

34:                                               ; preds = %33, %14
  %35 = load i32, ptr %5, align 4, !dbg !393
  ret i32 %35, !dbg !394
}

; Function Attrs: noinline nounwind
define dso_local i32 @xQueueSemaphoreTake(ptr noundef %0, i32 noundef %1) #0 !dbg !395 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca %struct.xTIME_OUT, align 4
  %8 = alloca ptr, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 0, ptr %6, align 4, !dbg !396
  %12 = load ptr, ptr %4, align 4, !dbg !397
  store ptr %12, ptr %8, align 4, !dbg !398
  store i32 0, ptr %9, align 4, !dbg !399
  br label %13, !dbg !400

13:                                               ; preds = %135, %2
  call void @vPortEnterCritical(), !dbg !401
  %14 = load ptr, ptr %8, align 4, !dbg !402
  %15 = getelementptr inbounds %struct.QueueDefinition, ptr %14, i32 0, i32 5, !dbg !403
  %16 = load volatile i32, ptr %15, align 4, !dbg !403
  store i32 %16, ptr %10, align 4, !dbg !404
  %17 = load i32, ptr %10, align 4, !dbg !405
  %18 = icmp ugt i32 %17, 0, !dbg !406
  br i1 %18, label %19, label %53, !dbg !405

19:                                               ; preds = %13
  %20 = load i32, ptr %10, align 4, !dbg !407
  %21 = sub i32 %20, 1, !dbg !408
  %22 = load ptr, ptr %8, align 4, !dbg !409
  %23 = getelementptr inbounds %struct.QueueDefinition, ptr %22, i32 0, i32 5, !dbg !410
  store volatile i32 %21, ptr %23, align 4, !dbg !411
  %24 = load ptr, ptr %8, align 4, !dbg !412
  %25 = getelementptr inbounds %struct.QueueDefinition, ptr %24, i32 0, i32 0, !dbg !413
  %26 = load ptr, ptr %25, align 4, !dbg !413
  %27 = icmp eq ptr %26, null, !dbg !414
  br i1 %27, label %28, label %33, !dbg !412

28:                                               ; preds = %19
  %29 = call ptr @pvTaskIncrementMutexHeldCount(), !dbg !415
  %30 = load ptr, ptr %8, align 4, !dbg !416
  %31 = getelementptr inbounds %struct.QueueDefinition, ptr %30, i32 0, i32 2, !dbg !417
  %32 = getelementptr inbounds %struct.SemaphoreData, ptr %31, i32 0, i32 0, !dbg !418
  store ptr %29, ptr %32, align 4, !dbg !419
  br label %34, !dbg !420

33:                                               ; preds = %19
  br label %34

34:                                               ; preds = %33, %28
  %35 = load ptr, ptr %8, align 4, !dbg !421
  %36 = getelementptr inbounds %struct.QueueDefinition, ptr %35, i32 0, i32 3, !dbg !421
  %37 = getelementptr inbounds %struct.xLIST, ptr %36, i32 0, i32 0, !dbg !421
  %38 = load volatile i32, ptr %37, align 4, !dbg !421
  %39 = icmp eq i32 %38, 0, !dbg !421
  %40 = zext i1 %39 to i64, !dbg !421
  %41 = select i1 %39, i32 1, i32 0, !dbg !421
  %42 = icmp eq i32 %41, 0, !dbg !422
  br i1 %42, label %43, label %51, !dbg !421

43:                                               ; preds = %34
  %44 = load ptr, ptr %8, align 4, !dbg !423
  %45 = getelementptr inbounds %struct.QueueDefinition, ptr %44, i32 0, i32 3, !dbg !424
  %46 = call i32 @xTaskRemoveFromEventList(ptr noundef %45), !dbg !425
  %47 = icmp ne i32 %46, 0, !dbg !426
  br i1 %47, label %48, label %49, !dbg !425

48:                                               ; preds = %43
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !427
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !427, !srcloc !428
  call void asm sideeffect "isb", ""() #3, !dbg !427, !srcloc !429
  br label %50, !dbg !430

49:                                               ; preds = %43
  br label %50

50:                                               ; preds = %49, %48
  br label %52, !dbg !431

51:                                               ; preds = %34
  br label %52

52:                                               ; preds = %51, %50
  call void @vPortExitCritical(), !dbg !432
  store i32 1, ptr %3, align 4, !dbg !433
  br label %136, !dbg !433

53:                                               ; preds = %13
  %54 = load i32, ptr %5, align 4, !dbg !434
  %55 = icmp eq i32 %54, 0, !dbg !435
  br i1 %55, label %56, label %57, !dbg !434

56:                                               ; preds = %53
  call void @vPortExitCritical(), !dbg !436
  store i32 0, ptr %3, align 4, !dbg !437
  br label %136, !dbg !437

57:                                               ; preds = %53
  %58 = load i32, ptr %6, align 4, !dbg !438
  %59 = icmp eq i32 %58, 0, !dbg !439
  br i1 %59, label %60, label %61, !dbg !438

60:                                               ; preds = %57
  call void @vTaskInternalSetTimeOutState(ptr noundef %7), !dbg !440
  store i32 1, ptr %6, align 4, !dbg !441
  br label %62, !dbg !442

61:                                               ; preds = %57
  br label %62

62:                                               ; preds = %61, %60
  br label %63

63:                                               ; preds = %62
  br label %64

64:                                               ; preds = %63
  call void @vPortExitCritical(), !dbg !443
  call void @vTaskSuspendAll(), !dbg !444
  call void @vPortEnterCritical(), !dbg !445
  %65 = load ptr, ptr %8, align 4, !dbg !445
  %66 = getelementptr inbounds %struct.QueueDefinition, ptr %65, i32 0, i32 8, !dbg !445
  %67 = load volatile i8, ptr %66, align 4, !dbg !445
  %68 = sext i8 %67 to i32, !dbg !445
  %69 = icmp eq i32 %68, -1, !dbg !445
  br i1 %69, label %70, label %73, !dbg !445

70:                                               ; preds = %64
  %71 = load ptr, ptr %8, align 4, !dbg !445
  %72 = getelementptr inbounds %struct.QueueDefinition, ptr %71, i32 0, i32 8, !dbg !445
  store volatile i8 0, ptr %72, align 4, !dbg !445
  br label %73, !dbg !445

73:                                               ; preds = %70, %64
  %74 = load ptr, ptr %8, align 4, !dbg !445
  %75 = getelementptr inbounds %struct.QueueDefinition, ptr %74, i32 0, i32 9, !dbg !445
  %76 = load volatile i8, ptr %75, align 1, !dbg !445
  %77 = sext i8 %76 to i32, !dbg !445
  %78 = icmp eq i32 %77, -1, !dbg !445
  br i1 %78, label %79, label %82, !dbg !445

79:                                               ; preds = %73
  %80 = load ptr, ptr %8, align 4, !dbg !445
  %81 = getelementptr inbounds %struct.QueueDefinition, ptr %80, i32 0, i32 9, !dbg !445
  store volatile i8 0, ptr %81, align 1, !dbg !445
  br label %82, !dbg !445

82:                                               ; preds = %79, %73
  call void @vPortExitCritical(), !dbg !445
  %83 = call i32 @xTaskCheckForTimeOut(ptr noundef %7, ptr noundef %5), !dbg !446
  %84 = icmp eq i32 %83, 0, !dbg !447
  br i1 %84, label %85, label %115, !dbg !446

85:                                               ; preds = %82
  %86 = load ptr, ptr %8, align 4, !dbg !448
  %87 = call i32 @prvIsQueueEmpty(ptr noundef %86), !dbg !449
  %88 = icmp ne i32 %87, 0, !dbg !450
  br i1 %88, label %89, label %111, !dbg !449

89:                                               ; preds = %85
  %90 = load ptr, ptr %8, align 4, !dbg !451
  %91 = getelementptr inbounds %struct.QueueDefinition, ptr %90, i32 0, i32 0, !dbg !452
  %92 = load ptr, ptr %91, align 4, !dbg !452
  %93 = icmp eq ptr %92, null, !dbg !453
  br i1 %93, label %94, label %100, !dbg !451

94:                                               ; preds = %89
  call void @vPortEnterCritical(), !dbg !454
  %95 = load ptr, ptr %8, align 4, !dbg !455
  %96 = getelementptr inbounds %struct.QueueDefinition, ptr %95, i32 0, i32 2, !dbg !456
  %97 = getelementptr inbounds %struct.SemaphoreData, ptr %96, i32 0, i32 0, !dbg !457
  %98 = load ptr, ptr %97, align 4, !dbg !457
  %99 = call i32 @xTaskPriorityInherit(ptr noundef %98), !dbg !458
  store i32 %99, ptr %9, align 4, !dbg !459
  call void @vPortExitCritical(), !dbg !460
  br label %101, !dbg !461

100:                                              ; preds = %89
  br label %101

101:                                              ; preds = %100, %94
  %102 = load ptr, ptr %8, align 4, !dbg !462
  %103 = getelementptr inbounds %struct.QueueDefinition, ptr %102, i32 0, i32 4, !dbg !463
  %104 = load i32, ptr %5, align 4, !dbg !464
  call void @vTaskPlaceOnEventList(ptr noundef %103, i32 noundef %104), !dbg !465
  %105 = load ptr, ptr %8, align 4, !dbg !466
  call void @prvUnlockQueue(ptr noundef %105), !dbg !467
  %106 = call i32 @xTaskResumeAll(), !dbg !468
  %107 = icmp eq i32 %106, 0, !dbg !469
  br i1 %107, label %108, label %109, !dbg !468

108:                                              ; preds = %101
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !470
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !470, !srcloc !471
  call void asm sideeffect "isb", ""() #3, !dbg !470, !srcloc !472
  br label %110, !dbg !473

109:                                              ; preds = %101
  br label %110

110:                                              ; preds = %109, %108
  br label %114, !dbg !474

111:                                              ; preds = %85
  %112 = load ptr, ptr %8, align 4, !dbg !475
  call void @prvUnlockQueue(ptr noundef %112), !dbg !476
  %113 = call i32 @xTaskResumeAll(), !dbg !477
  br label %114

114:                                              ; preds = %111, %110
  br label %135, !dbg !478

115:                                              ; preds = %82
  %116 = load ptr, ptr %8, align 4, !dbg !479
  call void @prvUnlockQueue(ptr noundef %116), !dbg !480
  %117 = call i32 @xTaskResumeAll(), !dbg !481
  %118 = load ptr, ptr %8, align 4, !dbg !482
  %119 = call i32 @prvIsQueueEmpty(ptr noundef %118), !dbg !483
  %120 = icmp ne i32 %119, 0, !dbg !484
  br i1 %120, label %121, label %133, !dbg !483

121:                                              ; preds = %115
  %122 = load i32, ptr %9, align 4, !dbg !485
  %123 = icmp ne i32 %122, 0, !dbg !486
  br i1 %123, label %124, label %132, !dbg !485

124:                                              ; preds = %121
  call void @vPortEnterCritical(), !dbg !487
  %125 = load ptr, ptr %8, align 4, !dbg !488
  %126 = call i32 @prvGetDisinheritPriorityAfterTimeout(ptr noundef %125), !dbg !489
  store i32 %126, ptr %11, align 4, !dbg !490
  %127 = load ptr, ptr %8, align 4, !dbg !491
  %128 = getelementptr inbounds %struct.QueueDefinition, ptr %127, i32 0, i32 2, !dbg !492
  %129 = getelementptr inbounds %struct.SemaphoreData, ptr %128, i32 0, i32 0, !dbg !493
  %130 = load ptr, ptr %129, align 4, !dbg !493
  %131 = load i32, ptr %11, align 4, !dbg !494
  call void @vTaskPriorityDisinheritAfterTimeout(ptr noundef %130, i32 noundef %131), !dbg !495
  call void @vPortExitCritical(), !dbg !496
  br label %132, !dbg !497

132:                                              ; preds = %124, %121
  store i32 0, ptr %3, align 4, !dbg !498
  br label %136, !dbg !498

133:                                              ; preds = %115
  br label %134

134:                                              ; preds = %133
  br label %135

135:                                              ; preds = %134, %114
  br label %13, !dbg !400, !llvm.loop !499

136:                                              ; preds = %132, %56, %52
  %137 = load i32, ptr %3, align 4, !dbg !501
  ret i32 %137, !dbg !501
}

; Function Attrs: noinline nounwind
define dso_local ptr @xQueueCreateCountingSemaphoreStatic(i32 noundef %0, i32 noundef %1, ptr noundef %2) #0 !dbg !502 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 4
  %7 = alloca ptr, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store ptr %2, ptr %6, align 4
  store ptr null, ptr %7, align 4, !dbg !503
  %8 = load i32, ptr %4, align 4, !dbg !504
  %9 = icmp ne i32 %8, 0, !dbg !505
  br i1 %9, label %10, label %26, !dbg !506

10:                                               ; preds = %3
  %11 = load i32, ptr %5, align 4, !dbg !507
  %12 = load i32, ptr %4, align 4, !dbg !508
  %13 = icmp ule i32 %11, %12, !dbg !509
  br i1 %13, label %14, label %26, !dbg !510

14:                                               ; preds = %10
  %15 = load i32, ptr %4, align 4, !dbg !511
  %16 = load ptr, ptr %6, align 4, !dbg !512
  %17 = call ptr @xQueueGenericCreateStatic(i32 noundef %15, i32 noundef 0, ptr noundef null, ptr noundef %16, i8 noundef zeroext 2), !dbg !513
  store ptr %17, ptr %7, align 4, !dbg !514
  %18 = load ptr, ptr %7, align 4, !dbg !515
  %19 = icmp ne ptr %18, null, !dbg !516
  br i1 %19, label %20, label %24, !dbg !515

20:                                               ; preds = %14
  %21 = load i32, ptr %5, align 4, !dbg !517
  %22 = load ptr, ptr %7, align 4, !dbg !518
  %23 = getelementptr inbounds %struct.QueueDefinition, ptr %22, i32 0, i32 5, !dbg !519
  store volatile i32 %21, ptr %23, align 4, !dbg !520
  br label %25, !dbg !521

24:                                               ; preds = %14
  br label %25

25:                                               ; preds = %24, %20
  br label %27, !dbg !522

26:                                               ; preds = %10, %3
  br label %27

27:                                               ; preds = %26, %25
  %28 = load ptr, ptr %7, align 4, !dbg !523
  ret ptr %28, !dbg !524
}

; Function Attrs: noinline nounwind
define dso_local ptr @xQueueCreateCountingSemaphore(i32 noundef %0, i32 noundef %1) #0 !dbg !525 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store ptr null, ptr %5, align 4, !dbg !526
  %6 = load i32, ptr %3, align 4, !dbg !527
  %7 = icmp ne i32 %6, 0, !dbg !528
  br i1 %7, label %8, label %23, !dbg !529

8:                                                ; preds = %2
  %9 = load i32, ptr %4, align 4, !dbg !530
  %10 = load i32, ptr %3, align 4, !dbg !531
  %11 = icmp ule i32 %9, %10, !dbg !532
  br i1 %11, label %12, label %23, !dbg !533

12:                                               ; preds = %8
  %13 = load i32, ptr %3, align 4, !dbg !534
  %14 = call ptr @xQueueGenericCreate(i32 noundef %13, i32 noundef 0, i8 noundef zeroext 2), !dbg !535
  store ptr %14, ptr %5, align 4, !dbg !536
  %15 = load ptr, ptr %5, align 4, !dbg !537
  %16 = icmp ne ptr %15, null, !dbg !538
  br i1 %16, label %17, label %21, !dbg !537

17:                                               ; preds = %12
  %18 = load i32, ptr %4, align 4, !dbg !539
  %19 = load ptr, ptr %5, align 4, !dbg !540
  %20 = getelementptr inbounds %struct.QueueDefinition, ptr %19, i32 0, i32 5, !dbg !541
  store volatile i32 %18, ptr %20, align 4, !dbg !542
  br label %22, !dbg !543

21:                                               ; preds = %12
  br label %22

22:                                               ; preds = %21, %17
  br label %24, !dbg !544

23:                                               ; preds = %8, %2
  br label %24

24:                                               ; preds = %23, %22
  %25 = load ptr, ptr %5, align 4, !dbg !545
  ret ptr %25, !dbg !546
}

; Function Attrs: noinline nounwind
define internal i32 @prvCopyDataToQueue(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 !dbg !547 {
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 4
  store ptr %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4, !dbg !548
  %9 = load ptr, ptr %4, align 4, !dbg !549
  %10 = getelementptr inbounds %struct.QueueDefinition, ptr %9, i32 0, i32 5, !dbg !550
  %11 = load volatile i32, ptr %10, align 4, !dbg !550
  store i32 %11, ptr %8, align 4, !dbg !551
  %12 = load ptr, ptr %4, align 4, !dbg !552
  %13 = getelementptr inbounds %struct.QueueDefinition, ptr %12, i32 0, i32 7, !dbg !553
  %14 = load i32, ptr %13, align 4, !dbg !553
  %15 = icmp eq i32 %14, 0, !dbg !554
  br i1 %15, label %16, label %32, !dbg !552

16:                                               ; preds = %3
  %17 = load ptr, ptr %4, align 4, !dbg !555
  %18 = getelementptr inbounds %struct.QueueDefinition, ptr %17, i32 0, i32 0, !dbg !556
  %19 = load ptr, ptr %18, align 4, !dbg !556
  %20 = icmp eq ptr %19, null, !dbg !557
  br i1 %20, label %21, label %30, !dbg !555

21:                                               ; preds = %16
  %22 = load ptr, ptr %4, align 4, !dbg !558
  %23 = getelementptr inbounds %struct.QueueDefinition, ptr %22, i32 0, i32 2, !dbg !559
  %24 = getelementptr inbounds %struct.SemaphoreData, ptr %23, i32 0, i32 0, !dbg !560
  %25 = load ptr, ptr %24, align 4, !dbg !560
  %26 = call i32 @xTaskPriorityDisinherit(ptr noundef %25), !dbg !561
  store i32 %26, ptr %7, align 4, !dbg !562
  %27 = load ptr, ptr %4, align 4, !dbg !563
  %28 = getelementptr inbounds %struct.QueueDefinition, ptr %27, i32 0, i32 2, !dbg !564
  %29 = getelementptr inbounds %struct.SemaphoreData, ptr %28, i32 0, i32 0, !dbg !565
  store ptr null, ptr %29, align 4, !dbg !566
  br label %31, !dbg !567

30:                                               ; preds = %16
  br label %31

31:                                               ; preds = %30, %21
  br label %120, !dbg !568

32:                                               ; preds = %3
  %33 = load i32, ptr %6, align 4, !dbg !569
  %34 = icmp eq i32 %33, 0, !dbg !570
  br i1 %34, label %35, label %66, !dbg !569

35:                                               ; preds = %32
  %36 = load ptr, ptr %4, align 4, !dbg !571
  %37 = getelementptr inbounds %struct.QueueDefinition, ptr %36, i32 0, i32 1, !dbg !572
  %38 = load ptr, ptr %37, align 4, !dbg !572
  %39 = load ptr, ptr %5, align 4, !dbg !573
  %40 = load ptr, ptr %4, align 4, !dbg !574
  %41 = getelementptr inbounds %struct.QueueDefinition, ptr %40, i32 0, i32 7, !dbg !575
  %42 = load i32, ptr %41, align 4, !dbg !575
  call void @llvm.memcpy.p0.p0.i32(ptr align 1 %38, ptr align 1 %39, i32 %42, i1 false), !dbg !576
  %43 = load ptr, ptr %4, align 4, !dbg !577
  %44 = getelementptr inbounds %struct.QueueDefinition, ptr %43, i32 0, i32 7, !dbg !578
  %45 = load i32, ptr %44, align 4, !dbg !578
  %46 = load ptr, ptr %4, align 4, !dbg !579
  %47 = getelementptr inbounds %struct.QueueDefinition, ptr %46, i32 0, i32 1, !dbg !580
  %48 = load ptr, ptr %47, align 4, !dbg !581
  %49 = getelementptr inbounds i8, ptr %48, i32 %45, !dbg !581
  store ptr %49, ptr %47, align 4, !dbg !581
  %50 = load ptr, ptr %4, align 4, !dbg !582
  %51 = getelementptr inbounds %struct.QueueDefinition, ptr %50, i32 0, i32 1, !dbg !583
  %52 = load ptr, ptr %51, align 4, !dbg !583
  %53 = load ptr, ptr %4, align 4, !dbg !584
  %54 = getelementptr inbounds %struct.QueueDefinition, ptr %53, i32 0, i32 2, !dbg !585
  %55 = getelementptr inbounds %struct.QueuePointers, ptr %54, i32 0, i32 0, !dbg !586
  %56 = load ptr, ptr %55, align 4, !dbg !586
  %57 = icmp uge ptr %52, %56, !dbg !587
  br i1 %57, label %58, label %64, !dbg !582

58:                                               ; preds = %35
  %59 = load ptr, ptr %4, align 4, !dbg !588
  %60 = getelementptr inbounds %struct.QueueDefinition, ptr %59, i32 0, i32 0, !dbg !589
  %61 = load ptr, ptr %60, align 4, !dbg !589
  %62 = load ptr, ptr %4, align 4, !dbg !590
  %63 = getelementptr inbounds %struct.QueueDefinition, ptr %62, i32 0, i32 1, !dbg !591
  store ptr %61, ptr %63, align 4, !dbg !592
  br label %65, !dbg !593

64:                                               ; preds = %35
  br label %65

65:                                               ; preds = %64, %58
  br label %119, !dbg !594

66:                                               ; preds = %32
  %67 = load ptr, ptr %4, align 4, !dbg !595
  %68 = getelementptr inbounds %struct.QueueDefinition, ptr %67, i32 0, i32 2, !dbg !596
  %69 = getelementptr inbounds %struct.QueuePointers, ptr %68, i32 0, i32 1, !dbg !597
  %70 = load ptr, ptr %69, align 4, !dbg !597
  %71 = load ptr, ptr %5, align 4, !dbg !598
  %72 = load ptr, ptr %4, align 4, !dbg !599
  %73 = getelementptr inbounds %struct.QueueDefinition, ptr %72, i32 0, i32 7, !dbg !600
  %74 = load i32, ptr %73, align 4, !dbg !600
  call void @llvm.memcpy.p0.p0.i32(ptr align 1 %70, ptr align 1 %71, i32 %74, i1 false), !dbg !601
  %75 = load ptr, ptr %4, align 4, !dbg !602
  %76 = getelementptr inbounds %struct.QueueDefinition, ptr %75, i32 0, i32 7, !dbg !603
  %77 = load i32, ptr %76, align 4, !dbg !603
  %78 = load ptr, ptr %4, align 4, !dbg !604
  %79 = getelementptr inbounds %struct.QueueDefinition, ptr %78, i32 0, i32 2, !dbg !605
  %80 = getelementptr inbounds %struct.QueuePointers, ptr %79, i32 0, i32 1, !dbg !606
  %81 = load ptr, ptr %80, align 4, !dbg !607
  %82 = sub i32 0, %77, !dbg !607
  %83 = getelementptr inbounds i8, ptr %81, i32 %82, !dbg !607
  store ptr %83, ptr %80, align 4, !dbg !607
  %84 = load ptr, ptr %4, align 4, !dbg !608
  %85 = getelementptr inbounds %struct.QueueDefinition, ptr %84, i32 0, i32 2, !dbg !609
  %86 = getelementptr inbounds %struct.QueuePointers, ptr %85, i32 0, i32 1, !dbg !610
  %87 = load ptr, ptr %86, align 4, !dbg !610
  %88 = load ptr, ptr %4, align 4, !dbg !611
  %89 = getelementptr inbounds %struct.QueueDefinition, ptr %88, i32 0, i32 0, !dbg !612
  %90 = load ptr, ptr %89, align 4, !dbg !612
  %91 = icmp ult ptr %87, %90, !dbg !613
  br i1 %91, label %92, label %105, !dbg !608

92:                                               ; preds = %66
  %93 = load ptr, ptr %4, align 4, !dbg !614
  %94 = getelementptr inbounds %struct.QueueDefinition, ptr %93, i32 0, i32 2, !dbg !615
  %95 = getelementptr inbounds %struct.QueuePointers, ptr %94, i32 0, i32 0, !dbg !616
  %96 = load ptr, ptr %95, align 4, !dbg !616
  %97 = load ptr, ptr %4, align 4, !dbg !617
  %98 = getelementptr inbounds %struct.QueueDefinition, ptr %97, i32 0, i32 7, !dbg !618
  %99 = load i32, ptr %98, align 4, !dbg !618
  %100 = sub i32 0, %99, !dbg !619
  %101 = getelementptr inbounds i8, ptr %96, i32 %100, !dbg !619
  %102 = load ptr, ptr %4, align 4, !dbg !620
  %103 = getelementptr inbounds %struct.QueueDefinition, ptr %102, i32 0, i32 2, !dbg !621
  %104 = getelementptr inbounds %struct.QueuePointers, ptr %103, i32 0, i32 1, !dbg !622
  store ptr %101, ptr %104, align 4, !dbg !623
  br label %106, !dbg !624

105:                                              ; preds = %66
  br label %106

106:                                              ; preds = %105, %92
  %107 = load i32, ptr %6, align 4, !dbg !625
  %108 = icmp eq i32 %107, 2, !dbg !626
  br i1 %108, label %109, label %117, !dbg !625

109:                                              ; preds = %106
  %110 = load i32, ptr %8, align 4, !dbg !627
  %111 = icmp ugt i32 %110, 0, !dbg !628
  br i1 %111, label %112, label %115, !dbg !627

112:                                              ; preds = %109
  %113 = load i32, ptr %8, align 4, !dbg !629
  %114 = add i32 %113, -1, !dbg !629
  store i32 %114, ptr %8, align 4, !dbg !629
  br label %116, !dbg !630

115:                                              ; preds = %109
  br label %116

116:                                              ; preds = %115, %112
  br label %118, !dbg !631

117:                                              ; preds = %106
  br label %118

118:                                              ; preds = %117, %116
  br label %119

119:                                              ; preds = %118, %65
  br label %120

120:                                              ; preds = %119, %31
  %121 = load i32, ptr %8, align 4, !dbg !632
  %122 = add i32 %121, 1, !dbg !633
  %123 = load ptr, ptr %4, align 4, !dbg !634
  %124 = getelementptr inbounds %struct.QueueDefinition, ptr %123, i32 0, i32 5, !dbg !635
  store volatile i32 %122, ptr %124, align 4, !dbg !636
  %125 = load i32, ptr %7, align 4, !dbg !637
  ret i32 %125, !dbg !638
}

declare dso_local void @vTaskInternalSetTimeOutState(ptr noundef) #1

declare dso_local void @vTaskSuspendAll() #1

declare dso_local i32 @xTaskCheckForTimeOut(ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind
define internal i32 @prvIsQueueFull(ptr noundef %0) #0 !dbg !639 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  call void @vPortEnterCritical(), !dbg !640
  %4 = load ptr, ptr %2, align 4, !dbg !641
  %5 = getelementptr inbounds %struct.QueueDefinition, ptr %4, i32 0, i32 5, !dbg !642
  %6 = load volatile i32, ptr %5, align 4, !dbg !642
  %7 = load ptr, ptr %2, align 4, !dbg !643
  %8 = getelementptr inbounds %struct.QueueDefinition, ptr %7, i32 0, i32 6, !dbg !644
  %9 = load i32, ptr %8, align 4, !dbg !644
  %10 = icmp eq i32 %6, %9, !dbg !645
  br i1 %10, label %11, label %12, !dbg !641

11:                                               ; preds = %1
  store i32 1, ptr %3, align 4, !dbg !646
  br label %13, !dbg !647

12:                                               ; preds = %1
  store i32 0, ptr %3, align 4, !dbg !648
  br label %13

13:                                               ; preds = %12, %11
  call void @vPortExitCritical(), !dbg !649
  %14 = load i32, ptr %3, align 4, !dbg !650
  ret i32 %14, !dbg !651
}

declare dso_local void @vTaskPlaceOnEventList(ptr noundef, i32 noundef) #1

; Function Attrs: noinline nounwind
define internal void @prvUnlockQueue(ptr noundef %0) #0 !dbg !652 {
  %2 = alloca ptr, align 4
  %3 = alloca i8, align 1
  %4 = alloca i8, align 1
  store ptr %0, ptr %2, align 4
  call void @vPortEnterCritical(), !dbg !653
  %5 = load ptr, ptr %2, align 4, !dbg !654
  %6 = getelementptr inbounds %struct.QueueDefinition, ptr %5, i32 0, i32 9, !dbg !655
  %7 = load volatile i8, ptr %6, align 1, !dbg !655
  store i8 %7, ptr %3, align 1, !dbg !656
  br label %8, !dbg !657

8:                                                ; preds = %30, %1
  %9 = load i8, ptr %3, align 1, !dbg !658
  %10 = sext i8 %9 to i32, !dbg !658
  %11 = icmp sgt i32 %10, 0, !dbg !659
  br i1 %11, label %12, label %33, !dbg !657

12:                                               ; preds = %8
  %13 = load ptr, ptr %2, align 4, !dbg !660
  %14 = getelementptr inbounds %struct.QueueDefinition, ptr %13, i32 0, i32 4, !dbg !660
  %15 = getelementptr inbounds %struct.xLIST, ptr %14, i32 0, i32 0, !dbg !660
  %16 = load volatile i32, ptr %15, align 4, !dbg !660
  %17 = icmp eq i32 %16, 0, !dbg !660
  %18 = zext i1 %17 to i64, !dbg !660
  %19 = select i1 %17, i32 1, i32 0, !dbg !660
  %20 = icmp eq i32 %19, 0, !dbg !661
  br i1 %20, label %21, label %29, !dbg !660

21:                                               ; preds = %12
  %22 = load ptr, ptr %2, align 4, !dbg !662
  %23 = getelementptr inbounds %struct.QueueDefinition, ptr %22, i32 0, i32 4, !dbg !663
  %24 = call i32 @xTaskRemoveFromEventList(ptr noundef %23), !dbg !664
  %25 = icmp ne i32 %24, 0, !dbg !665
  br i1 %25, label %26, label %27, !dbg !664

26:                                               ; preds = %21
  call void @vTaskMissedYield(), !dbg !666
  br label %28, !dbg !667

27:                                               ; preds = %21
  br label %28

28:                                               ; preds = %27, %26
  br label %30, !dbg !668

29:                                               ; preds = %12
  br label %33, !dbg !669

30:                                               ; preds = %28
  %31 = load i8, ptr %3, align 1, !dbg !670
  %32 = add i8 %31, -1, !dbg !670
  store i8 %32, ptr %3, align 1, !dbg !670
  br label %8, !dbg !657, !llvm.loop !671

33:                                               ; preds = %29, %8
  %34 = load ptr, ptr %2, align 4, !dbg !674
  %35 = getelementptr inbounds %struct.QueueDefinition, ptr %34, i32 0, i32 9, !dbg !675
  store volatile i8 -1, ptr %35, align 1, !dbg !676
  call void @vPortExitCritical(), !dbg !677
  call void @vPortEnterCritical(), !dbg !678
  %36 = load ptr, ptr %2, align 4, !dbg !679
  %37 = getelementptr inbounds %struct.QueueDefinition, ptr %36, i32 0, i32 8, !dbg !680
  %38 = load volatile i8, ptr %37, align 4, !dbg !680
  store i8 %38, ptr %4, align 1, !dbg !681
  br label %39, !dbg !682

39:                                               ; preds = %63, %33
  %40 = load i8, ptr %4, align 1, !dbg !683
  %41 = sext i8 %40 to i32, !dbg !683
  %42 = icmp sgt i32 %41, 0, !dbg !684
  br i1 %42, label %43, label %64, !dbg !682

43:                                               ; preds = %39
  %44 = load ptr, ptr %2, align 4, !dbg !685
  %45 = getelementptr inbounds %struct.QueueDefinition, ptr %44, i32 0, i32 3, !dbg !685
  %46 = getelementptr inbounds %struct.xLIST, ptr %45, i32 0, i32 0, !dbg !685
  %47 = load volatile i32, ptr %46, align 4, !dbg !685
  %48 = icmp eq i32 %47, 0, !dbg !685
  %49 = zext i1 %48 to i64, !dbg !685
  %50 = select i1 %48, i32 1, i32 0, !dbg !685
  %51 = icmp eq i32 %50, 0, !dbg !686
  br i1 %51, label %52, label %62, !dbg !685

52:                                               ; preds = %43
  %53 = load ptr, ptr %2, align 4, !dbg !687
  %54 = getelementptr inbounds %struct.QueueDefinition, ptr %53, i32 0, i32 3, !dbg !688
  %55 = call i32 @xTaskRemoveFromEventList(ptr noundef %54), !dbg !689
  %56 = icmp ne i32 %55, 0, !dbg !690
  br i1 %56, label %57, label %58, !dbg !689

57:                                               ; preds = %52
  call void @vTaskMissedYield(), !dbg !691
  br label %59, !dbg !692

58:                                               ; preds = %52
  br label %59

59:                                               ; preds = %58, %57
  %60 = load i8, ptr %4, align 1, !dbg !693
  %61 = add i8 %60, -1, !dbg !693
  store i8 %61, ptr %4, align 1, !dbg !693
  br label %63, !dbg !694

62:                                               ; preds = %43
  br label %64, !dbg !695

63:                                               ; preds = %59
  br label %39, !dbg !682, !llvm.loop !696

64:                                               ; preds = %62, %39
  %65 = load ptr, ptr %2, align 4, !dbg !698
  %66 = getelementptr inbounds %struct.QueueDefinition, ptr %65, i32 0, i32 8, !dbg !699
  store volatile i8 -1, ptr %66, align 4, !dbg !700
  call void @vPortExitCritical(), !dbg !701
  ret void, !dbg !702
}

declare dso_local i32 @xTaskResumeAll() #1

; Function Attrs: noinline nounwind
define dso_local i32 @xQueueGenericSendFromISR(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3) #0 !dbg !703 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 4
  %9 = alloca ptr, align 4
  %10 = alloca ptr, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca ptr, align 4
  %15 = alloca i8, align 1
  %16 = alloca i32, align 4
  store ptr %0, ptr %8, align 4
  store ptr %1, ptr %9, align 4
  store ptr %2, ptr %10, align 4
  store i32 %3, ptr %11, align 4
  %17 = load ptr, ptr %8, align 4, !dbg !704
  store ptr %17, ptr %14, align 4, !dbg !705
  %18 = call { i32, i32 } asm sideeffect "\09mrs $0, basepri\09\09\09\09\09\09\09\09\09\09\09\0A\09mov $1, $2\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $1\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,=r,i,~{memory}"(i32 80) #3, !dbg !706, !srcloc !710
  %19 = extractvalue { i32, i32 } %18, 0, !dbg !706
  %20 = extractvalue { i32, i32 } %18, 1, !dbg !706
  store i32 %19, ptr %6, align 4, !dbg !706
  store i32 %20, ptr %7, align 4, !dbg !706
  %21 = load i32, ptr %6, align 4, !dbg !711
  store i32 %21, ptr %13, align 4, !dbg !712
  %22 = load ptr, ptr %14, align 4, !dbg !713
  %23 = getelementptr inbounds %struct.QueueDefinition, ptr %22, i32 0, i32 5, !dbg !714
  %24 = load volatile i32, ptr %23, align 4, !dbg !714
  %25 = load ptr, ptr %14, align 4, !dbg !715
  %26 = getelementptr inbounds %struct.QueueDefinition, ptr %25, i32 0, i32 6, !dbg !716
  %27 = load i32, ptr %26, align 4, !dbg !716
  %28 = icmp ult i32 %24, %27, !dbg !717
  br i1 %28, label %32, label %29, !dbg !718

29:                                               ; preds = %4
  %30 = load i32, ptr %11, align 4, !dbg !719
  %31 = icmp eq i32 %30, 2, !dbg !720
  br i1 %31, label %32, label %80, !dbg !721

32:                                               ; preds = %29, %4
  %33 = load ptr, ptr %14, align 4, !dbg !722
  %34 = getelementptr inbounds %struct.QueueDefinition, ptr %33, i32 0, i32 9, !dbg !723
  %35 = load volatile i8, ptr %34, align 1, !dbg !723
  store i8 %35, ptr %15, align 1, !dbg !724
  %36 = load ptr, ptr %14, align 4, !dbg !725
  %37 = getelementptr inbounds %struct.QueueDefinition, ptr %36, i32 0, i32 5, !dbg !726
  %38 = load volatile i32, ptr %37, align 4, !dbg !726
  store i32 %38, ptr %16, align 4, !dbg !727
  %39 = load ptr, ptr %14, align 4, !dbg !728
  %40 = load ptr, ptr %9, align 4, !dbg !729
  %41 = load i32, ptr %11, align 4, !dbg !730
  %42 = call i32 @prvCopyDataToQueue(ptr noundef %39, ptr noundef %40, i32 noundef %41), !dbg !731
  %43 = load i8, ptr %15, align 1, !dbg !732
  %44 = sext i8 %43 to i32, !dbg !732
  %45 = icmp eq i32 %44, -1, !dbg !733
  br i1 %45, label %46, label %72, !dbg !732

46:                                               ; preds = %32
  %47 = load ptr, ptr %14, align 4, !dbg !734
  %48 = getelementptr inbounds %struct.QueueDefinition, ptr %47, i32 0, i32 4, !dbg !734
  %49 = getelementptr inbounds %struct.xLIST, ptr %48, i32 0, i32 0, !dbg !734
  %50 = load volatile i32, ptr %49, align 4, !dbg !734
  %51 = icmp eq i32 %50, 0, !dbg !734
  %52 = zext i1 %51 to i64, !dbg !734
  %53 = select i1 %51, i32 1, i32 0, !dbg !734
  %54 = icmp eq i32 %53, 0, !dbg !735
  br i1 %54, label %55, label %69, !dbg !734

55:                                               ; preds = %46
  %56 = load ptr, ptr %14, align 4, !dbg !736
  %57 = getelementptr inbounds %struct.QueueDefinition, ptr %56, i32 0, i32 4, !dbg !737
  %58 = call i32 @xTaskRemoveFromEventList(ptr noundef %57), !dbg !738
  %59 = icmp ne i32 %58, 0, !dbg !739
  br i1 %59, label %60, label %67, !dbg !738

60:                                               ; preds = %55
  %61 = load ptr, ptr %10, align 4, !dbg !740
  %62 = icmp ne ptr %61, null, !dbg !741
  br i1 %62, label %63, label %65, !dbg !740

63:                                               ; preds = %60
  %64 = load ptr, ptr %10, align 4, !dbg !742
  store i32 1, ptr %64, align 4, !dbg !743
  br label %66, !dbg !744

65:                                               ; preds = %60
  br label %66

66:                                               ; preds = %65, %63
  br label %68, !dbg !745

67:                                               ; preds = %55
  br label %68

68:                                               ; preds = %67, %66
  br label %70, !dbg !746

69:                                               ; preds = %46
  br label %70

70:                                               ; preds = %69, %68
  %71 = load i32, ptr %16, align 4, !dbg !747
  br label %79, !dbg !748

72:                                               ; preds = %32
  %73 = load i8, ptr %15, align 1, !dbg !749
  %74 = sext i8 %73 to i32, !dbg !749
  %75 = add nsw i32 %74, 1, !dbg !750
  %76 = trunc i32 %75 to i8, !dbg !751
  %77 = load ptr, ptr %14, align 4, !dbg !752
  %78 = getelementptr inbounds %struct.QueueDefinition, ptr %77, i32 0, i32 9, !dbg !753
  store volatile i8 %76, ptr %78, align 1, !dbg !754
  br label %79

79:                                               ; preds = %72, %70
  store i32 1, ptr %12, align 4, !dbg !755
  br label %81, !dbg !756

80:                                               ; preds = %29
  store i32 0, ptr %12, align 4, !dbg !757
  br label %81

81:                                               ; preds = %80, %79
  %82 = load i32, ptr %13, align 4, !dbg !758
  store i32 %82, ptr %5, align 4
  %83 = load i32, ptr %5, align 4, !dbg !759
  call void asm sideeffect "\09msr basepri, $0\09", "r,~{memory}"(i32 %83) #3, !dbg !762, !srcloc !763
  %84 = load i32, ptr %12, align 4, !dbg !764
  ret i32 %84, !dbg !765
}

; Function Attrs: noinline nounwind
define dso_local i32 @xQueueGiveFromISR(ptr noundef %0, ptr noundef %1) #0 !dbg !766 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 4
  %7 = alloca ptr, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 4
  %11 = alloca i32, align 4
  %12 = alloca i8, align 1
  store ptr %0, ptr %6, align 4
  store ptr %1, ptr %7, align 4
  %13 = load ptr, ptr %6, align 4, !dbg !767
  store ptr %13, ptr %10, align 4, !dbg !768
  %14 = call { i32, i32 } asm sideeffect "\09mrs $0, basepri\09\09\09\09\09\09\09\09\09\09\09\0A\09mov $1, $2\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $1\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,=r,i,~{memory}"(i32 80) #3, !dbg !769, !srcloc !710
  %15 = extractvalue { i32, i32 } %14, 0, !dbg !769
  %16 = extractvalue { i32, i32 } %14, 1, !dbg !769
  store i32 %15, ptr %4, align 4, !dbg !769
  store i32 %16, ptr %5, align 4, !dbg !769
  %17 = load i32, ptr %4, align 4, !dbg !771
  store i32 %17, ptr %9, align 4, !dbg !772
  %18 = load ptr, ptr %10, align 4, !dbg !773
  %19 = getelementptr inbounds %struct.QueueDefinition, ptr %18, i32 0, i32 5, !dbg !774
  %20 = load volatile i32, ptr %19, align 4, !dbg !774
  store i32 %20, ptr %11, align 4, !dbg !775
  %21 = load i32, ptr %11, align 4, !dbg !776
  %22 = load ptr, ptr %10, align 4, !dbg !777
  %23 = getelementptr inbounds %struct.QueueDefinition, ptr %22, i32 0, i32 6, !dbg !778
  %24 = load i32, ptr %23, align 4, !dbg !778
  %25 = icmp ult i32 %21, %24, !dbg !779
  br i1 %25, label %26, label %70, !dbg !776

26:                                               ; preds = %2
  %27 = load ptr, ptr %10, align 4, !dbg !780
  %28 = getelementptr inbounds %struct.QueueDefinition, ptr %27, i32 0, i32 9, !dbg !781
  %29 = load volatile i8, ptr %28, align 1, !dbg !781
  store i8 %29, ptr %12, align 1, !dbg !782
  %30 = load i32, ptr %11, align 4, !dbg !783
  %31 = add i32 %30, 1, !dbg !784
  %32 = load ptr, ptr %10, align 4, !dbg !785
  %33 = getelementptr inbounds %struct.QueueDefinition, ptr %32, i32 0, i32 5, !dbg !786
  store volatile i32 %31, ptr %33, align 4, !dbg !787
  %34 = load i8, ptr %12, align 1, !dbg !788
  %35 = sext i8 %34 to i32, !dbg !788
  %36 = icmp eq i32 %35, -1, !dbg !789
  br i1 %36, label %37, label %62, !dbg !788

37:                                               ; preds = %26
  %38 = load ptr, ptr %10, align 4, !dbg !790
  %39 = getelementptr inbounds %struct.QueueDefinition, ptr %38, i32 0, i32 4, !dbg !790
  %40 = getelementptr inbounds %struct.xLIST, ptr %39, i32 0, i32 0, !dbg !790
  %41 = load volatile i32, ptr %40, align 4, !dbg !790
  %42 = icmp eq i32 %41, 0, !dbg !790
  %43 = zext i1 %42 to i64, !dbg !790
  %44 = select i1 %42, i32 1, i32 0, !dbg !790
  %45 = icmp eq i32 %44, 0, !dbg !791
  br i1 %45, label %46, label %60, !dbg !790

46:                                               ; preds = %37
  %47 = load ptr, ptr %10, align 4, !dbg !792
  %48 = getelementptr inbounds %struct.QueueDefinition, ptr %47, i32 0, i32 4, !dbg !793
  %49 = call i32 @xTaskRemoveFromEventList(ptr noundef %48), !dbg !794
  %50 = icmp ne i32 %49, 0, !dbg !795
  br i1 %50, label %51, label %58, !dbg !794

51:                                               ; preds = %46
  %52 = load ptr, ptr %7, align 4, !dbg !796
  %53 = icmp ne ptr %52, null, !dbg !797
  br i1 %53, label %54, label %56, !dbg !796

54:                                               ; preds = %51
  %55 = load ptr, ptr %7, align 4, !dbg !798
  store i32 1, ptr %55, align 4, !dbg !799
  br label %57, !dbg !800

56:                                               ; preds = %51
  br label %57

57:                                               ; preds = %56, %54
  br label %59, !dbg !801

58:                                               ; preds = %46
  br label %59

59:                                               ; preds = %58, %57
  br label %61, !dbg !802

60:                                               ; preds = %37
  br label %61

61:                                               ; preds = %60, %59
  br label %69, !dbg !803

62:                                               ; preds = %26
  %63 = load i8, ptr %12, align 1, !dbg !804
  %64 = sext i8 %63 to i32, !dbg !804
  %65 = add nsw i32 %64, 1, !dbg !805
  %66 = trunc i32 %65 to i8, !dbg !806
  %67 = load ptr, ptr %10, align 4, !dbg !807
  %68 = getelementptr inbounds %struct.QueueDefinition, ptr %67, i32 0, i32 9, !dbg !808
  store volatile i8 %66, ptr %68, align 1, !dbg !809
  br label %69

69:                                               ; preds = %62, %61
  store i32 1, ptr %8, align 4, !dbg !810
  br label %71, !dbg !811

70:                                               ; preds = %2
  store i32 0, ptr %8, align 4, !dbg !812
  br label %71

71:                                               ; preds = %70, %69
  %72 = load i32, ptr %9, align 4, !dbg !813
  store i32 %72, ptr %3, align 4
  %73 = load i32, ptr %3, align 4, !dbg !814
  call void asm sideeffect "\09msr basepri, $0\09", "r,~{memory}"(i32 %73) #3, !dbg !816, !srcloc !763
  %74 = load i32, ptr %8, align 4, !dbg !817
  ret i32 %74, !dbg !818
}

; Function Attrs: noinline nounwind
define dso_local i32 @xQueueReceive(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 !dbg !819 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca %struct.xTIME_OUT, align 4
  %10 = alloca ptr, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %5, align 4
  store ptr %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 0, ptr %8, align 4, !dbg !820
  %12 = load ptr, ptr %5, align 4, !dbg !821
  store ptr %12, ptr %10, align 4, !dbg !822
  br label %13, !dbg !823

13:                                               ; preds = %103, %3
  call void @vPortEnterCritical(), !dbg !824
  %14 = load ptr, ptr %10, align 4, !dbg !825
  %15 = getelementptr inbounds %struct.QueueDefinition, ptr %14, i32 0, i32 5, !dbg !826
  %16 = load volatile i32, ptr %15, align 4, !dbg !826
  store i32 %16, ptr %11, align 4, !dbg !827
  %17 = load i32, ptr %11, align 4, !dbg !828
  %18 = icmp ugt i32 %17, 0, !dbg !829
  br i1 %18, label %19, label %44, !dbg !828

19:                                               ; preds = %13
  %20 = load ptr, ptr %10, align 4, !dbg !830
  %21 = load ptr, ptr %6, align 4, !dbg !831
  call void @prvCopyDataFromQueue(ptr noundef %20, ptr noundef %21), !dbg !832
  %22 = load i32, ptr %11, align 4, !dbg !833
  %23 = sub i32 %22, 1, !dbg !834
  %24 = load ptr, ptr %10, align 4, !dbg !835
  %25 = getelementptr inbounds %struct.QueueDefinition, ptr %24, i32 0, i32 5, !dbg !836
  store volatile i32 %23, ptr %25, align 4, !dbg !837
  %26 = load ptr, ptr %10, align 4, !dbg !838
  %27 = getelementptr inbounds %struct.QueueDefinition, ptr %26, i32 0, i32 3, !dbg !838
  %28 = getelementptr inbounds %struct.xLIST, ptr %27, i32 0, i32 0, !dbg !838
  %29 = load volatile i32, ptr %28, align 4, !dbg !838
  %30 = icmp eq i32 %29, 0, !dbg !838
  %31 = zext i1 %30 to i64, !dbg !838
  %32 = select i1 %30, i32 1, i32 0, !dbg !838
  %33 = icmp eq i32 %32, 0, !dbg !839
  br i1 %33, label %34, label %42, !dbg !838

34:                                               ; preds = %19
  %35 = load ptr, ptr %10, align 4, !dbg !840
  %36 = getelementptr inbounds %struct.QueueDefinition, ptr %35, i32 0, i32 3, !dbg !841
  %37 = call i32 @xTaskRemoveFromEventList(ptr noundef %36), !dbg !842
  %38 = icmp ne i32 %37, 0, !dbg !843
  br i1 %38, label %39, label %40, !dbg !842

39:                                               ; preds = %34
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !844
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !844, !srcloc !845
  call void asm sideeffect "isb", ""() #3, !dbg !844, !srcloc !846
  br label %41, !dbg !847

40:                                               ; preds = %34
  br label %41

41:                                               ; preds = %40, %39
  br label %43, !dbg !848

42:                                               ; preds = %19
  br label %43

43:                                               ; preds = %42, %41
  call void @vPortExitCritical(), !dbg !849
  store i32 1, ptr %4, align 4, !dbg !850
  br label %104, !dbg !850

44:                                               ; preds = %13
  %45 = load i32, ptr %7, align 4, !dbg !851
  %46 = icmp eq i32 %45, 0, !dbg !852
  br i1 %46, label %47, label %48, !dbg !851

47:                                               ; preds = %44
  call void @vPortExitCritical(), !dbg !853
  store i32 0, ptr %4, align 4, !dbg !854
  br label %104, !dbg !854

48:                                               ; preds = %44
  %49 = load i32, ptr %8, align 4, !dbg !855
  %50 = icmp eq i32 %49, 0, !dbg !856
  br i1 %50, label %51, label %52, !dbg !855

51:                                               ; preds = %48
  call void @vTaskInternalSetTimeOutState(ptr noundef %9), !dbg !857
  store i32 1, ptr %8, align 4, !dbg !858
  br label %53, !dbg !859

52:                                               ; preds = %48
  br label %53

53:                                               ; preds = %52, %51
  br label %54

54:                                               ; preds = %53
  br label %55

55:                                               ; preds = %54
  call void @vPortExitCritical(), !dbg !860
  call void @vTaskSuspendAll(), !dbg !861
  call void @vPortEnterCritical(), !dbg !862
  %56 = load ptr, ptr %10, align 4, !dbg !862
  %57 = getelementptr inbounds %struct.QueueDefinition, ptr %56, i32 0, i32 8, !dbg !862
  %58 = load volatile i8, ptr %57, align 4, !dbg !862
  %59 = sext i8 %58 to i32, !dbg !862
  %60 = icmp eq i32 %59, -1, !dbg !862
  br i1 %60, label %61, label %64, !dbg !862

61:                                               ; preds = %55
  %62 = load ptr, ptr %10, align 4, !dbg !862
  %63 = getelementptr inbounds %struct.QueueDefinition, ptr %62, i32 0, i32 8, !dbg !862
  store volatile i8 0, ptr %63, align 4, !dbg !862
  br label %64, !dbg !862

64:                                               ; preds = %61, %55
  %65 = load ptr, ptr %10, align 4, !dbg !862
  %66 = getelementptr inbounds %struct.QueueDefinition, ptr %65, i32 0, i32 9, !dbg !862
  %67 = load volatile i8, ptr %66, align 1, !dbg !862
  %68 = sext i8 %67 to i32, !dbg !862
  %69 = icmp eq i32 %68, -1, !dbg !862
  br i1 %69, label %70, label %73, !dbg !862

70:                                               ; preds = %64
  %71 = load ptr, ptr %10, align 4, !dbg !862
  %72 = getelementptr inbounds %struct.QueueDefinition, ptr %71, i32 0, i32 9, !dbg !862
  store volatile i8 0, ptr %72, align 1, !dbg !862
  br label %73, !dbg !862

73:                                               ; preds = %70, %64
  call void @vPortExitCritical(), !dbg !862
  %74 = call i32 @xTaskCheckForTimeOut(ptr noundef %9, ptr noundef %7), !dbg !863
  %75 = icmp eq i32 %74, 0, !dbg !864
  br i1 %75, label %76, label %94, !dbg !863

76:                                               ; preds = %73
  %77 = load ptr, ptr %10, align 4, !dbg !865
  %78 = call i32 @prvIsQueueEmpty(ptr noundef %77), !dbg !866
  %79 = icmp ne i32 %78, 0, !dbg !867
  br i1 %79, label %80, label %90, !dbg !866

80:                                               ; preds = %76
  %81 = load ptr, ptr %10, align 4, !dbg !868
  %82 = getelementptr inbounds %struct.QueueDefinition, ptr %81, i32 0, i32 4, !dbg !869
  %83 = load i32, ptr %7, align 4, !dbg !870
  call void @vTaskPlaceOnEventList(ptr noundef %82, i32 noundef %83), !dbg !871
  %84 = load ptr, ptr %10, align 4, !dbg !872
  call void @prvUnlockQueue(ptr noundef %84), !dbg !873
  %85 = call i32 @xTaskResumeAll(), !dbg !874
  %86 = icmp eq i32 %85, 0, !dbg !875
  br i1 %86, label %87, label %88, !dbg !874

87:                                               ; preds = %80
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !876
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !876, !srcloc !877
  call void asm sideeffect "isb", ""() #3, !dbg !876, !srcloc !878
  br label %89, !dbg !879

88:                                               ; preds = %80
  br label %89

89:                                               ; preds = %88, %87
  br label %93, !dbg !880

90:                                               ; preds = %76
  %91 = load ptr, ptr %10, align 4, !dbg !881
  call void @prvUnlockQueue(ptr noundef %91), !dbg !882
  %92 = call i32 @xTaskResumeAll(), !dbg !883
  br label %93

93:                                               ; preds = %90, %89
  br label %103, !dbg !884

94:                                               ; preds = %73
  %95 = load ptr, ptr %10, align 4, !dbg !885
  call void @prvUnlockQueue(ptr noundef %95), !dbg !886
  %96 = call i32 @xTaskResumeAll(), !dbg !887
  %97 = load ptr, ptr %10, align 4, !dbg !888
  %98 = call i32 @prvIsQueueEmpty(ptr noundef %97), !dbg !889
  %99 = icmp ne i32 %98, 0, !dbg !890
  br i1 %99, label %100, label %101, !dbg !889

100:                                              ; preds = %94
  store i32 0, ptr %4, align 4, !dbg !891
  br label %104, !dbg !891

101:                                              ; preds = %94
  br label %102

102:                                              ; preds = %101
  br label %103

103:                                              ; preds = %102, %93
  br label %13, !dbg !823, !llvm.loop !892

104:                                              ; preds = %100, %47, %43
  %105 = load i32, ptr %4, align 4, !dbg !894
  ret i32 %105, !dbg !894
}

; Function Attrs: noinline nounwind
define internal void @prvCopyDataFromQueue(ptr noundef %0, ptr noundef %1) #0 !dbg !895 {
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store ptr %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 4, !dbg !896
  %6 = getelementptr inbounds %struct.QueueDefinition, ptr %5, i32 0, i32 7, !dbg !897
  %7 = load i32, ptr %6, align 4, !dbg !897
  %8 = icmp ne i32 %7, 0, !dbg !898
  br i1 %8, label %9, label %44, !dbg !896

9:                                                ; preds = %2
  %10 = load ptr, ptr %3, align 4, !dbg !899
  %11 = getelementptr inbounds %struct.QueueDefinition, ptr %10, i32 0, i32 7, !dbg !900
  %12 = load i32, ptr %11, align 4, !dbg !900
  %13 = load ptr, ptr %3, align 4, !dbg !901
  %14 = getelementptr inbounds %struct.QueueDefinition, ptr %13, i32 0, i32 2, !dbg !902
  %15 = getelementptr inbounds %struct.QueuePointers, ptr %14, i32 0, i32 1, !dbg !903
  %16 = load ptr, ptr %15, align 4, !dbg !904
  %17 = getelementptr inbounds i8, ptr %16, i32 %12, !dbg !904
  store ptr %17, ptr %15, align 4, !dbg !904
  %18 = load ptr, ptr %3, align 4, !dbg !905
  %19 = getelementptr inbounds %struct.QueueDefinition, ptr %18, i32 0, i32 2, !dbg !906
  %20 = getelementptr inbounds %struct.QueuePointers, ptr %19, i32 0, i32 1, !dbg !907
  %21 = load ptr, ptr %20, align 4, !dbg !907
  %22 = load ptr, ptr %3, align 4, !dbg !908
  %23 = getelementptr inbounds %struct.QueueDefinition, ptr %22, i32 0, i32 2, !dbg !909
  %24 = getelementptr inbounds %struct.QueuePointers, ptr %23, i32 0, i32 0, !dbg !910
  %25 = load ptr, ptr %24, align 4, !dbg !910
  %26 = icmp uge ptr %21, %25, !dbg !911
  br i1 %26, label %27, label %34, !dbg !905

27:                                               ; preds = %9
  %28 = load ptr, ptr %3, align 4, !dbg !912
  %29 = getelementptr inbounds %struct.QueueDefinition, ptr %28, i32 0, i32 0, !dbg !913
  %30 = load ptr, ptr %29, align 4, !dbg !913
  %31 = load ptr, ptr %3, align 4, !dbg !914
  %32 = getelementptr inbounds %struct.QueueDefinition, ptr %31, i32 0, i32 2, !dbg !915
  %33 = getelementptr inbounds %struct.QueuePointers, ptr %32, i32 0, i32 1, !dbg !916
  store ptr %30, ptr %33, align 4, !dbg !917
  br label %35, !dbg !918

34:                                               ; preds = %9
  br label %35

35:                                               ; preds = %34, %27
  %36 = load ptr, ptr %4, align 4, !dbg !919
  %37 = load ptr, ptr %3, align 4, !dbg !920
  %38 = getelementptr inbounds %struct.QueueDefinition, ptr %37, i32 0, i32 2, !dbg !921
  %39 = getelementptr inbounds %struct.QueuePointers, ptr %38, i32 0, i32 1, !dbg !922
  %40 = load ptr, ptr %39, align 4, !dbg !922
  %41 = load ptr, ptr %3, align 4, !dbg !923
  %42 = getelementptr inbounds %struct.QueueDefinition, ptr %41, i32 0, i32 7, !dbg !924
  %43 = load i32, ptr %42, align 4, !dbg !924
  call void @llvm.memcpy.p0.p0.i32(ptr align 1 %36, ptr align 1 %40, i32 %43, i1 false), !dbg !925
  br label %44, !dbg !926

44:                                               ; preds = %35, %2
  ret void, !dbg !927
}

; Function Attrs: noinline nounwind
define internal i32 @prvIsQueueEmpty(ptr noundef %0) #0 !dbg !928 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  call void @vPortEnterCritical(), !dbg !929
  %4 = load ptr, ptr %2, align 4, !dbg !930
  %5 = getelementptr inbounds %struct.QueueDefinition, ptr %4, i32 0, i32 5, !dbg !931
  %6 = load volatile i32, ptr %5, align 4, !dbg !931
  %7 = icmp eq i32 %6, 0, !dbg !932
  br i1 %7, label %8, label %9, !dbg !930

8:                                                ; preds = %1
  store i32 1, ptr %3, align 4, !dbg !933
  br label %10, !dbg !934

9:                                                ; preds = %1
  store i32 0, ptr %3, align 4, !dbg !935
  br label %10

10:                                               ; preds = %9, %8
  call void @vPortExitCritical(), !dbg !936
  %11 = load i32, ptr %3, align 4, !dbg !937
  ret i32 %11, !dbg !938
}

declare dso_local ptr @pvTaskIncrementMutexHeldCount() #1

declare dso_local i32 @xTaskPriorityInherit(ptr noundef) #1

; Function Attrs: noinline nounwind
define internal i32 @prvGetDisinheritPriorityAfterTimeout(ptr noundef %0) #0 !dbg !939 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  %4 = load ptr, ptr %2, align 4, !dbg !940
  %5 = getelementptr inbounds %struct.QueueDefinition, ptr %4, i32 0, i32 4, !dbg !940
  %6 = getelementptr inbounds %struct.xLIST, ptr %5, i32 0, i32 0, !dbg !940
  %7 = load volatile i32, ptr %6, align 4, !dbg !940
  %8 = icmp ugt i32 %7, 0, !dbg !941
  br i1 %8, label %9, label %18, !dbg !940

9:                                                ; preds = %1
  %10 = load ptr, ptr %2, align 4, !dbg !942
  %11 = getelementptr inbounds %struct.QueueDefinition, ptr %10, i32 0, i32 4, !dbg !942
  %12 = getelementptr inbounds %struct.xLIST, ptr %11, i32 0, i32 2, !dbg !942
  %13 = getelementptr inbounds %struct.xMINI_LIST_ITEM, ptr %12, i32 0, i32 1, !dbg !942
  %14 = load ptr, ptr %13, align 4, !dbg !942
  %15 = getelementptr inbounds %struct.xLIST_ITEM, ptr %14, i32 0, i32 0, !dbg !942
  %16 = load i32, ptr %15, align 4, !dbg !942
  %17 = sub i32 56, %16, !dbg !943
  store i32 %17, ptr %3, align 4, !dbg !944
  br label %19, !dbg !945

18:                                               ; preds = %1
  store i32 0, ptr %3, align 4, !dbg !946
  br label %19

19:                                               ; preds = %18, %9
  %20 = load i32, ptr %3, align 4, !dbg !947
  ret i32 %20, !dbg !948
}

declare dso_local void @vTaskPriorityDisinheritAfterTimeout(ptr noundef, i32 noundef) #1

; Function Attrs: noinline nounwind
define dso_local i32 @xQueuePeek(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 !dbg !949 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca %struct.xTIME_OUT, align 4
  %10 = alloca ptr, align 4
  %11 = alloca ptr, align 4
  %12 = alloca i32, align 4
  store ptr %0, ptr %5, align 4
  store ptr %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 0, ptr %8, align 4, !dbg !950
  %13 = load ptr, ptr %5, align 4, !dbg !951
  store ptr %13, ptr %11, align 4, !dbg !952
  br label %14, !dbg !953

14:                                               ; preds = %108, %3
  call void @vPortEnterCritical(), !dbg !954
  %15 = load ptr, ptr %11, align 4, !dbg !955
  %16 = getelementptr inbounds %struct.QueueDefinition, ptr %15, i32 0, i32 5, !dbg !956
  %17 = load volatile i32, ptr %16, align 4, !dbg !956
  store i32 %17, ptr %12, align 4, !dbg !957
  %18 = load i32, ptr %12, align 4, !dbg !958
  %19 = icmp ugt i32 %18, 0, !dbg !959
  br i1 %19, label %20, label %49, !dbg !958

20:                                               ; preds = %14
  %21 = load ptr, ptr %11, align 4, !dbg !960
  %22 = getelementptr inbounds %struct.QueueDefinition, ptr %21, i32 0, i32 2, !dbg !961
  %23 = getelementptr inbounds %struct.QueuePointers, ptr %22, i32 0, i32 1, !dbg !962
  %24 = load ptr, ptr %23, align 4, !dbg !962
  store ptr %24, ptr %10, align 4, !dbg !963
  %25 = load ptr, ptr %11, align 4, !dbg !964
  %26 = load ptr, ptr %6, align 4, !dbg !965
  call void @prvCopyDataFromQueue(ptr noundef %25, ptr noundef %26), !dbg !966
  %27 = load ptr, ptr %10, align 4, !dbg !967
  %28 = load ptr, ptr %11, align 4, !dbg !968
  %29 = getelementptr inbounds %struct.QueueDefinition, ptr %28, i32 0, i32 2, !dbg !969
  %30 = getelementptr inbounds %struct.QueuePointers, ptr %29, i32 0, i32 1, !dbg !970
  store ptr %27, ptr %30, align 4, !dbg !971
  %31 = load ptr, ptr %11, align 4, !dbg !972
  %32 = getelementptr inbounds %struct.QueueDefinition, ptr %31, i32 0, i32 4, !dbg !972
  %33 = getelementptr inbounds %struct.xLIST, ptr %32, i32 0, i32 0, !dbg !972
  %34 = load volatile i32, ptr %33, align 4, !dbg !972
  %35 = icmp eq i32 %34, 0, !dbg !972
  %36 = zext i1 %35 to i64, !dbg !972
  %37 = select i1 %35, i32 1, i32 0, !dbg !972
  %38 = icmp eq i32 %37, 0, !dbg !973
  br i1 %38, label %39, label %47, !dbg !972

39:                                               ; preds = %20
  %40 = load ptr, ptr %11, align 4, !dbg !974
  %41 = getelementptr inbounds %struct.QueueDefinition, ptr %40, i32 0, i32 4, !dbg !975
  %42 = call i32 @xTaskRemoveFromEventList(ptr noundef %41), !dbg !976
  %43 = icmp ne i32 %42, 0, !dbg !977
  br i1 %43, label %44, label %45, !dbg !976

44:                                               ; preds = %39
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !978
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !978, !srcloc !979
  call void asm sideeffect "isb", ""() #3, !dbg !978, !srcloc !980
  br label %46, !dbg !981

45:                                               ; preds = %39
  br label %46

46:                                               ; preds = %45, %44
  br label %48, !dbg !982

47:                                               ; preds = %20
  br label %48

48:                                               ; preds = %47, %46
  call void @vPortExitCritical(), !dbg !983
  store i32 1, ptr %4, align 4, !dbg !984
  br label %109, !dbg !984

49:                                               ; preds = %14
  %50 = load i32, ptr %7, align 4, !dbg !985
  %51 = icmp eq i32 %50, 0, !dbg !986
  br i1 %51, label %52, label %53, !dbg !985

52:                                               ; preds = %49
  call void @vPortExitCritical(), !dbg !987
  store i32 0, ptr %4, align 4, !dbg !988
  br label %109, !dbg !988

53:                                               ; preds = %49
  %54 = load i32, ptr %8, align 4, !dbg !989
  %55 = icmp eq i32 %54, 0, !dbg !990
  br i1 %55, label %56, label %57, !dbg !989

56:                                               ; preds = %53
  call void @vTaskInternalSetTimeOutState(ptr noundef %9), !dbg !991
  store i32 1, ptr %8, align 4, !dbg !992
  br label %58, !dbg !993

57:                                               ; preds = %53
  br label %58

58:                                               ; preds = %57, %56
  br label %59

59:                                               ; preds = %58
  br label %60

60:                                               ; preds = %59
  call void @vPortExitCritical(), !dbg !994
  call void @vTaskSuspendAll(), !dbg !995
  call void @vPortEnterCritical(), !dbg !996
  %61 = load ptr, ptr %11, align 4, !dbg !996
  %62 = getelementptr inbounds %struct.QueueDefinition, ptr %61, i32 0, i32 8, !dbg !996
  %63 = load volatile i8, ptr %62, align 4, !dbg !996
  %64 = sext i8 %63 to i32, !dbg !996
  %65 = icmp eq i32 %64, -1, !dbg !996
  br i1 %65, label %66, label %69, !dbg !996

66:                                               ; preds = %60
  %67 = load ptr, ptr %11, align 4, !dbg !996
  %68 = getelementptr inbounds %struct.QueueDefinition, ptr %67, i32 0, i32 8, !dbg !996
  store volatile i8 0, ptr %68, align 4, !dbg !996
  br label %69, !dbg !996

69:                                               ; preds = %66, %60
  %70 = load ptr, ptr %11, align 4, !dbg !996
  %71 = getelementptr inbounds %struct.QueueDefinition, ptr %70, i32 0, i32 9, !dbg !996
  %72 = load volatile i8, ptr %71, align 1, !dbg !996
  %73 = sext i8 %72 to i32, !dbg !996
  %74 = icmp eq i32 %73, -1, !dbg !996
  br i1 %74, label %75, label %78, !dbg !996

75:                                               ; preds = %69
  %76 = load ptr, ptr %11, align 4, !dbg !996
  %77 = getelementptr inbounds %struct.QueueDefinition, ptr %76, i32 0, i32 9, !dbg !996
  store volatile i8 0, ptr %77, align 1, !dbg !996
  br label %78, !dbg !996

78:                                               ; preds = %75, %69
  call void @vPortExitCritical(), !dbg !996
  %79 = call i32 @xTaskCheckForTimeOut(ptr noundef %9, ptr noundef %7), !dbg !997
  %80 = icmp eq i32 %79, 0, !dbg !998
  br i1 %80, label %81, label %99, !dbg !997

81:                                               ; preds = %78
  %82 = load ptr, ptr %11, align 4, !dbg !999
  %83 = call i32 @prvIsQueueEmpty(ptr noundef %82), !dbg !1000
  %84 = icmp ne i32 %83, 0, !dbg !1001
  br i1 %84, label %85, label %95, !dbg !1000

85:                                               ; preds = %81
  %86 = load ptr, ptr %11, align 4, !dbg !1002
  %87 = getelementptr inbounds %struct.QueueDefinition, ptr %86, i32 0, i32 4, !dbg !1003
  %88 = load i32, ptr %7, align 4, !dbg !1004
  call void @vTaskPlaceOnEventList(ptr noundef %87, i32 noundef %88), !dbg !1005
  %89 = load ptr, ptr %11, align 4, !dbg !1006
  call void @prvUnlockQueue(ptr noundef %89), !dbg !1007
  %90 = call i32 @xTaskResumeAll(), !dbg !1008
  %91 = icmp eq i32 %90, 0, !dbg !1009
  br i1 %91, label %92, label %93, !dbg !1008

92:                                               ; preds = %85
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !1010
  call void asm sideeffect "dsb", "~{memory}"() #3, !dbg !1010, !srcloc !1011
  call void asm sideeffect "isb", ""() #3, !dbg !1010, !srcloc !1012
  br label %94, !dbg !1013

93:                                               ; preds = %85
  br label %94

94:                                               ; preds = %93, %92
  br label %98, !dbg !1014

95:                                               ; preds = %81
  %96 = load ptr, ptr %11, align 4, !dbg !1015
  call void @prvUnlockQueue(ptr noundef %96), !dbg !1016
  %97 = call i32 @xTaskResumeAll(), !dbg !1017
  br label %98

98:                                               ; preds = %95, %94
  br label %108, !dbg !1018

99:                                               ; preds = %78
  %100 = load ptr, ptr %11, align 4, !dbg !1019
  call void @prvUnlockQueue(ptr noundef %100), !dbg !1020
  %101 = call i32 @xTaskResumeAll(), !dbg !1021
  %102 = load ptr, ptr %11, align 4, !dbg !1022
  %103 = call i32 @prvIsQueueEmpty(ptr noundef %102), !dbg !1023
  %104 = icmp ne i32 %103, 0, !dbg !1024
  br i1 %104, label %105, label %106, !dbg !1023

105:                                              ; preds = %99
  store i32 0, ptr %4, align 4, !dbg !1025
  br label %109, !dbg !1025

106:                                              ; preds = %99
  br label %107

107:                                              ; preds = %106
  br label %108

108:                                              ; preds = %107, %98
  br label %14, !dbg !953, !llvm.loop !1026

109:                                              ; preds = %105, %52, %48
  %110 = load i32, ptr %4, align 4, !dbg !1028
  ret i32 %110, !dbg !1028
}

; Function Attrs: noinline nounwind
define dso_local i32 @xQueueReceiveFromISR(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 !dbg !1029 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 4
  %8 = alloca ptr, align 4
  %9 = alloca ptr, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca ptr, align 4
  %13 = alloca i32, align 4
  %14 = alloca i8, align 1
  store ptr %0, ptr %7, align 4
  store ptr %1, ptr %8, align 4
  store ptr %2, ptr %9, align 4
  %15 = load ptr, ptr %7, align 4, !dbg !1030
  store ptr %15, ptr %12, align 4, !dbg !1031
  %16 = call { i32, i32 } asm sideeffect "\09mrs $0, basepri\09\09\09\09\09\09\09\09\09\09\09\0A\09mov $1, $2\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $1\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,=r,i,~{memory}"(i32 80) #3, !dbg !1032, !srcloc !710
  %17 = extractvalue { i32, i32 } %16, 0, !dbg !1032
  %18 = extractvalue { i32, i32 } %16, 1, !dbg !1032
  store i32 %17, ptr %5, align 4, !dbg !1032
  store i32 %18, ptr %6, align 4, !dbg !1032
  %19 = load i32, ptr %5, align 4, !dbg !1034
  store i32 %19, ptr %11, align 4, !dbg !1035
  %20 = load ptr, ptr %12, align 4, !dbg !1036
  %21 = getelementptr inbounds %struct.QueueDefinition, ptr %20, i32 0, i32 5, !dbg !1037
  %22 = load volatile i32, ptr %21, align 4, !dbg !1037
  store i32 %22, ptr %13, align 4, !dbg !1038
  %23 = load i32, ptr %13, align 4, !dbg !1039
  %24 = icmp ugt i32 %23, 0, !dbg !1040
  br i1 %24, label %25, label %71, !dbg !1039

25:                                               ; preds = %3
  %26 = load ptr, ptr %12, align 4, !dbg !1041
  %27 = getelementptr inbounds %struct.QueueDefinition, ptr %26, i32 0, i32 8, !dbg !1042
  %28 = load volatile i8, ptr %27, align 4, !dbg !1042
  store i8 %28, ptr %14, align 1, !dbg !1043
  %29 = load ptr, ptr %12, align 4, !dbg !1044
  %30 = load ptr, ptr %8, align 4, !dbg !1045
  call void @prvCopyDataFromQueue(ptr noundef %29, ptr noundef %30), !dbg !1046
  %31 = load i32, ptr %13, align 4, !dbg !1047
  %32 = sub i32 %31, 1, !dbg !1048
  %33 = load ptr, ptr %12, align 4, !dbg !1049
  %34 = getelementptr inbounds %struct.QueueDefinition, ptr %33, i32 0, i32 5, !dbg !1050
  store volatile i32 %32, ptr %34, align 4, !dbg !1051
  %35 = load i8, ptr %14, align 1, !dbg !1052
  %36 = sext i8 %35 to i32, !dbg !1052
  %37 = icmp eq i32 %36, -1, !dbg !1053
  br i1 %37, label %38, label %63, !dbg !1052

38:                                               ; preds = %25
  %39 = load ptr, ptr %12, align 4, !dbg !1054
  %40 = getelementptr inbounds %struct.QueueDefinition, ptr %39, i32 0, i32 3, !dbg !1054
  %41 = getelementptr inbounds %struct.xLIST, ptr %40, i32 0, i32 0, !dbg !1054
  %42 = load volatile i32, ptr %41, align 4, !dbg !1054
  %43 = icmp eq i32 %42, 0, !dbg !1054
  %44 = zext i1 %43 to i64, !dbg !1054
  %45 = select i1 %43, i32 1, i32 0, !dbg !1054
  %46 = icmp eq i32 %45, 0, !dbg !1055
  br i1 %46, label %47, label %61, !dbg !1054

47:                                               ; preds = %38
  %48 = load ptr, ptr %12, align 4, !dbg !1056
  %49 = getelementptr inbounds %struct.QueueDefinition, ptr %48, i32 0, i32 3, !dbg !1057
  %50 = call i32 @xTaskRemoveFromEventList(ptr noundef %49), !dbg !1058
  %51 = icmp ne i32 %50, 0, !dbg !1059
  br i1 %51, label %52, label %59, !dbg !1058

52:                                               ; preds = %47
  %53 = load ptr, ptr %9, align 4, !dbg !1060
  %54 = icmp ne ptr %53, null, !dbg !1061
  br i1 %54, label %55, label %57, !dbg !1060

55:                                               ; preds = %52
  %56 = load ptr, ptr %9, align 4, !dbg !1062
  store i32 1, ptr %56, align 4, !dbg !1063
  br label %58, !dbg !1064

57:                                               ; preds = %52
  br label %58

58:                                               ; preds = %57, %55
  br label %60, !dbg !1065

59:                                               ; preds = %47
  br label %60

60:                                               ; preds = %59, %58
  br label %62, !dbg !1066

61:                                               ; preds = %38
  br label %62

62:                                               ; preds = %61, %60
  br label %70, !dbg !1067

63:                                               ; preds = %25
  %64 = load i8, ptr %14, align 1, !dbg !1068
  %65 = sext i8 %64 to i32, !dbg !1068
  %66 = add nsw i32 %65, 1, !dbg !1069
  %67 = trunc i32 %66 to i8, !dbg !1070
  %68 = load ptr, ptr %12, align 4, !dbg !1071
  %69 = getelementptr inbounds %struct.QueueDefinition, ptr %68, i32 0, i32 8, !dbg !1072
  store volatile i8 %67, ptr %69, align 4, !dbg !1073
  br label %70

70:                                               ; preds = %63, %62
  store i32 1, ptr %10, align 4, !dbg !1074
  br label %72, !dbg !1075

71:                                               ; preds = %3
  store i32 0, ptr %10, align 4, !dbg !1076
  br label %72

72:                                               ; preds = %71, %70
  %73 = load i32, ptr %11, align 4, !dbg !1077
  store i32 %73, ptr %4, align 4
  %74 = load i32, ptr %4, align 4, !dbg !1078
  call void asm sideeffect "\09msr basepri, $0\09", "r,~{memory}"(i32 %74) #3, !dbg !1080, !srcloc !763
  %75 = load i32, ptr %10, align 4, !dbg !1081
  ret i32 %75, !dbg !1082
}

; Function Attrs: noinline nounwind
define dso_local i32 @xQueuePeekFromISR(ptr noundef %0, ptr noundef %1) #0 !dbg !1083 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 4
  %7 = alloca ptr, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 4
  %11 = alloca ptr, align 4
  store ptr %0, ptr %6, align 4
  store ptr %1, ptr %7, align 4
  %12 = load ptr, ptr %6, align 4, !dbg !1084
  store ptr %12, ptr %11, align 4, !dbg !1085
  %13 = call { i32, i32 } asm sideeffect "\09mrs $0, basepri\09\09\09\09\09\09\09\09\09\09\09\0A\09mov $1, $2\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $1\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,=r,i,~{memory}"(i32 80) #3, !dbg !1086, !srcloc !710
  %14 = extractvalue { i32, i32 } %13, 0, !dbg !1086
  %15 = extractvalue { i32, i32 } %13, 1, !dbg !1086
  store i32 %14, ptr %4, align 4, !dbg !1086
  store i32 %15, ptr %5, align 4, !dbg !1086
  %16 = load i32, ptr %4, align 4, !dbg !1088
  store i32 %16, ptr %9, align 4, !dbg !1089
  %17 = load ptr, ptr %11, align 4, !dbg !1090
  %18 = getelementptr inbounds %struct.QueueDefinition, ptr %17, i32 0, i32 5, !dbg !1091
  %19 = load volatile i32, ptr %18, align 4, !dbg !1091
  %20 = icmp ugt i32 %19, 0, !dbg !1092
  br i1 %20, label %21, label %32, !dbg !1090

21:                                               ; preds = %2
  %22 = load ptr, ptr %11, align 4, !dbg !1093
  %23 = getelementptr inbounds %struct.QueueDefinition, ptr %22, i32 0, i32 2, !dbg !1094
  %24 = getelementptr inbounds %struct.QueuePointers, ptr %23, i32 0, i32 1, !dbg !1095
  %25 = load ptr, ptr %24, align 4, !dbg !1095
  store ptr %25, ptr %10, align 4, !dbg !1096
  %26 = load ptr, ptr %11, align 4, !dbg !1097
  %27 = load ptr, ptr %7, align 4, !dbg !1098
  call void @prvCopyDataFromQueue(ptr noundef %26, ptr noundef %27), !dbg !1099
  %28 = load ptr, ptr %10, align 4, !dbg !1100
  %29 = load ptr, ptr %11, align 4, !dbg !1101
  %30 = getelementptr inbounds %struct.QueueDefinition, ptr %29, i32 0, i32 2, !dbg !1102
  %31 = getelementptr inbounds %struct.QueuePointers, ptr %30, i32 0, i32 1, !dbg !1103
  store ptr %28, ptr %31, align 4, !dbg !1104
  store i32 1, ptr %8, align 4, !dbg !1105
  br label %33, !dbg !1106

32:                                               ; preds = %2
  store i32 0, ptr %8, align 4, !dbg !1107
  br label %33

33:                                               ; preds = %32, %21
  %34 = load i32, ptr %9, align 4, !dbg !1108
  store i32 %34, ptr %3, align 4
  %35 = load i32, ptr %3, align 4, !dbg !1109
  call void asm sideeffect "\09msr basepri, $0\09", "r,~{memory}"(i32 %35) #3, !dbg !1111, !srcloc !763
  %36 = load i32, ptr %8, align 4, !dbg !1112
  ret i32 %36, !dbg !1113
}

; Function Attrs: noinline nounwind
define dso_local i32 @uxQueueMessagesWaiting(ptr noundef %0) #0 !dbg !1114 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  call void @vPortEnterCritical(), !dbg !1115
  %4 = load ptr, ptr %2, align 4, !dbg !1116
  %5 = getelementptr inbounds %struct.QueueDefinition, ptr %4, i32 0, i32 5, !dbg !1117
  %6 = load volatile i32, ptr %5, align 4, !dbg !1117
  store i32 %6, ptr %3, align 4, !dbg !1118
  call void @vPortExitCritical(), !dbg !1119
  %7 = load i32, ptr %3, align 4, !dbg !1120
  ret i32 %7, !dbg !1121
}

; Function Attrs: noinline nounwind
define dso_local i32 @uxQueueSpacesAvailable(ptr noundef %0) #0 !dbg !1122 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !1123
  store ptr %5, ptr %4, align 4, !dbg !1124
  call void @vPortEnterCritical(), !dbg !1125
  %6 = load ptr, ptr %4, align 4, !dbg !1126
  %7 = getelementptr inbounds %struct.QueueDefinition, ptr %6, i32 0, i32 6, !dbg !1127
  %8 = load i32, ptr %7, align 4, !dbg !1127
  %9 = load ptr, ptr %4, align 4, !dbg !1128
  %10 = getelementptr inbounds %struct.QueueDefinition, ptr %9, i32 0, i32 5, !dbg !1129
  %11 = load volatile i32, ptr %10, align 4, !dbg !1129
  %12 = sub i32 %8, %11, !dbg !1130
  store i32 %12, ptr %3, align 4, !dbg !1131
  call void @vPortExitCritical(), !dbg !1132
  %13 = load i32, ptr %3, align 4, !dbg !1133
  ret i32 %13, !dbg !1134
}

; Function Attrs: noinline nounwind
define dso_local i32 @uxQueueMessagesWaitingFromISR(ptr noundef %0) #0 !dbg !1135 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !1136
  store ptr %5, ptr %4, align 4, !dbg !1137
  %6 = load ptr, ptr %4, align 4, !dbg !1138
  %7 = getelementptr inbounds %struct.QueueDefinition, ptr %6, i32 0, i32 5, !dbg !1139
  %8 = load volatile i32, ptr %7, align 4, !dbg !1139
  store i32 %8, ptr %3, align 4, !dbg !1140
  %9 = load i32, ptr %3, align 4, !dbg !1141
  ret i32 %9, !dbg !1142
}

; Function Attrs: noinline nounwind
define dso_local void @vQueueDelete(ptr noundef %0) #0 !dbg !1143 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %4 = load ptr, ptr %2, align 4, !dbg !1144
  store ptr %4, ptr %3, align 4, !dbg !1145
  %5 = load ptr, ptr %3, align 4, !dbg !1146
  call void @vQueueUnregisterQueue(ptr noundef %5), !dbg !1147
  %6 = load ptr, ptr %3, align 4, !dbg !1148
  %7 = getelementptr inbounds %struct.QueueDefinition, ptr %6, i32 0, i32 10, !dbg !1149
  %8 = load i8, ptr %7, align 2, !dbg !1149
  %9 = zext i8 %8 to i32, !dbg !1148
  %10 = icmp eq i32 %9, 0, !dbg !1150
  br i1 %10, label %11, label %13, !dbg !1148

11:                                               ; preds = %1
  %12 = load ptr, ptr %3, align 4, !dbg !1151
  call void @vPortFree(ptr noundef %12), !dbg !1152
  br label %14, !dbg !1153

13:                                               ; preds = %1
  br label %14

14:                                               ; preds = %13, %11
  ret void, !dbg !1154
}

; Function Attrs: noinline nounwind
define dso_local void @vQueueUnregisterQueue(ptr noundef %0) #0 !dbg !1155 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  store i32 0, ptr %3, align 4, !dbg !1156
  br label %4, !dbg !1157

4:                                                ; preds = %23, %1
  %5 = load i32, ptr %3, align 4, !dbg !1158
  %6 = icmp ult i32 %5, 8, !dbg !1159
  br i1 %6, label %7, label %26, !dbg !1160

7:                                                ; preds = %4
  %8 = load i32, ptr %3, align 4, !dbg !1161
  %9 = getelementptr inbounds [8 x %struct.QUEUE_REGISTRY_ITEM], ptr @xQueueRegistry, i32 0, i32 %8, !dbg !1162
  %10 = getelementptr inbounds %struct.QUEUE_REGISTRY_ITEM, ptr %9, i32 0, i32 1, !dbg !1163
  %11 = load ptr, ptr %10, align 4, !dbg !1163
  %12 = load ptr, ptr %2, align 4, !dbg !1164
  %13 = icmp eq ptr %11, %12, !dbg !1165
  br i1 %13, label %14, label %21, !dbg !1162

14:                                               ; preds = %7
  %15 = load i32, ptr %3, align 4, !dbg !1166
  %16 = getelementptr inbounds [8 x %struct.QUEUE_REGISTRY_ITEM], ptr @xQueueRegistry, i32 0, i32 %15, !dbg !1167
  %17 = getelementptr inbounds %struct.QUEUE_REGISTRY_ITEM, ptr %16, i32 0, i32 0, !dbg !1168
  store ptr null, ptr %17, align 4, !dbg !1169
  %18 = load i32, ptr %3, align 4, !dbg !1170
  %19 = getelementptr inbounds [8 x %struct.QUEUE_REGISTRY_ITEM], ptr @xQueueRegistry, i32 0, i32 %18, !dbg !1171
  %20 = getelementptr inbounds %struct.QUEUE_REGISTRY_ITEM, ptr %19, i32 0, i32 1, !dbg !1172
  store ptr null, ptr %20, align 4, !dbg !1173
  br label %26, !dbg !1174

21:                                               ; preds = %7
  br label %22

22:                                               ; preds = %21
  br label %23, !dbg !1175

23:                                               ; preds = %22
  %24 = load i32, ptr %3, align 4, !dbg !1176
  %25 = add i32 %24, 1, !dbg !1176
  store i32 %25, ptr %3, align 4, !dbg !1176
  br label %4, !dbg !1160, !llvm.loop !1177

26:                                               ; preds = %14, %4
  ret void, !dbg !1178
}

declare dso_local void @vPortFree(ptr noundef) #1

; Function Attrs: noinline nounwind
define dso_local i32 @uxQueueGetQueueNumber(ptr noundef %0) #0 !dbg !1179 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %3 = load ptr, ptr %2, align 4, !dbg !1180
  %4 = getelementptr inbounds %struct.QueueDefinition, ptr %3, i32 0, i32 11, !dbg !1181
  %5 = load i32, ptr %4, align 4, !dbg !1181
  ret i32 %5, !dbg !1182
}

; Function Attrs: noinline nounwind
define dso_local void @vQueueSetQueueNumber(ptr noundef %0, i32 noundef %1) #0 !dbg !1183 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %4, align 4, !dbg !1184
  %6 = load ptr, ptr %3, align 4, !dbg !1185
  %7 = getelementptr inbounds %struct.QueueDefinition, ptr %6, i32 0, i32 11, !dbg !1186
  store i32 %5, ptr %7, align 4, !dbg !1187
  ret void, !dbg !1188
}

; Function Attrs: noinline nounwind
define dso_local zeroext i8 @ucQueueGetQueueType(ptr noundef %0) #0 !dbg !1189 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %3 = load ptr, ptr %2, align 4, !dbg !1190
  %4 = getelementptr inbounds %struct.QueueDefinition, ptr %3, i32 0, i32 12, !dbg !1191
  %5 = load i8, ptr %4, align 4, !dbg !1191
  ret i8 %5, !dbg !1192
}

; Function Attrs: noinline nounwind
define dso_local i32 @xQueueIsQueueEmptyFromISR(ptr noundef %0) #0 !dbg !1193 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !1194
  store ptr %5, ptr %4, align 4, !dbg !1195
  %6 = load ptr, ptr %4, align 4, !dbg !1196
  %7 = getelementptr inbounds %struct.QueueDefinition, ptr %6, i32 0, i32 5, !dbg !1197
  %8 = load volatile i32, ptr %7, align 4, !dbg !1197
  %9 = icmp eq i32 %8, 0, !dbg !1198
  br i1 %9, label %10, label %11, !dbg !1196

10:                                               ; preds = %1
  store i32 1, ptr %3, align 4, !dbg !1199
  br label %12, !dbg !1200

11:                                               ; preds = %1
  store i32 0, ptr %3, align 4, !dbg !1201
  br label %12

12:                                               ; preds = %11, %10
  %13 = load i32, ptr %3, align 4, !dbg !1202
  ret i32 %13, !dbg !1203
}

; Function Attrs: noinline nounwind
define dso_local i32 @xQueueIsQueueFullFromISR(ptr noundef %0) #0 !dbg !1204 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !1205
  store ptr %5, ptr %4, align 4, !dbg !1206
  %6 = load ptr, ptr %4, align 4, !dbg !1207
  %7 = getelementptr inbounds %struct.QueueDefinition, ptr %6, i32 0, i32 5, !dbg !1208
  %8 = load volatile i32, ptr %7, align 4, !dbg !1208
  %9 = load ptr, ptr %4, align 4, !dbg !1209
  %10 = getelementptr inbounds %struct.QueueDefinition, ptr %9, i32 0, i32 6, !dbg !1210
  %11 = load i32, ptr %10, align 4, !dbg !1210
  %12 = icmp eq i32 %8, %11, !dbg !1211
  br i1 %12, label %13, label %14, !dbg !1207

13:                                               ; preds = %1
  store i32 1, ptr %3, align 4, !dbg !1212
  br label %15, !dbg !1213

14:                                               ; preds = %1
  store i32 0, ptr %3, align 4, !dbg !1214
  br label %15

15:                                               ; preds = %14, %13
  %16 = load i32, ptr %3, align 4, !dbg !1215
  ret i32 %16, !dbg !1216
}

; Function Attrs: noinline nounwind
define dso_local void @vQueueAddToRegistry(ptr noundef %0, ptr noundef %1) #0 !dbg !1217 {
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store ptr %1, ptr %4, align 4
  store ptr null, ptr %6, align 4, !dbg !1218
  %7 = load ptr, ptr %4, align 4, !dbg !1219
  %8 = icmp ne ptr %7, null, !dbg !1220
  br i1 %8, label %9, label %42, !dbg !1219

9:                                                ; preds = %2
  store i32 0, ptr %5, align 4, !dbg !1221
  br label %10, !dbg !1222

10:                                               ; preds = %38, %9
  %11 = load i32, ptr %5, align 4, !dbg !1223
  %12 = icmp ult i32 %11, 8, !dbg !1224
  br i1 %12, label %13, label %41, !dbg !1225

13:                                               ; preds = %10
  %14 = load ptr, ptr %3, align 4, !dbg !1226
  %15 = load i32, ptr %5, align 4, !dbg !1227
  %16 = getelementptr inbounds [8 x %struct.QUEUE_REGISTRY_ITEM], ptr @xQueueRegistry, i32 0, i32 %15, !dbg !1228
  %17 = getelementptr inbounds %struct.QUEUE_REGISTRY_ITEM, ptr %16, i32 0, i32 1, !dbg !1229
  %18 = load ptr, ptr %17, align 4, !dbg !1229
  %19 = icmp eq ptr %14, %18, !dbg !1230
  br i1 %19, label %20, label %23, !dbg !1226

20:                                               ; preds = %13
  %21 = load i32, ptr %5, align 4, !dbg !1231
  %22 = getelementptr inbounds [8 x %struct.QUEUE_REGISTRY_ITEM], ptr @xQueueRegistry, i32 0, i32 %21, !dbg !1232
  store ptr %22, ptr %6, align 4, !dbg !1233
  br label %41, !dbg !1234

23:                                               ; preds = %13
  %24 = load ptr, ptr %6, align 4, !dbg !1235
  %25 = icmp eq ptr %24, null, !dbg !1236
  br i1 %25, label %26, label %35, !dbg !1237

26:                                               ; preds = %23
  %27 = load i32, ptr %5, align 4, !dbg !1238
  %28 = getelementptr inbounds [8 x %struct.QUEUE_REGISTRY_ITEM], ptr @xQueueRegistry, i32 0, i32 %27, !dbg !1239
  %29 = getelementptr inbounds %struct.QUEUE_REGISTRY_ITEM, ptr %28, i32 0, i32 0, !dbg !1240
  %30 = load ptr, ptr %29, align 4, !dbg !1240
  %31 = icmp eq ptr %30, null, !dbg !1241
  br i1 %31, label %32, label %35, !dbg !1242

32:                                               ; preds = %26
  %33 = load i32, ptr %5, align 4, !dbg !1243
  %34 = getelementptr inbounds [8 x %struct.QUEUE_REGISTRY_ITEM], ptr @xQueueRegistry, i32 0, i32 %33, !dbg !1244
  store ptr %34, ptr %6, align 4, !dbg !1245
  br label %36, !dbg !1246

35:                                               ; preds = %26, %23
  br label %36

36:                                               ; preds = %35, %32
  br label %37

37:                                               ; preds = %36
  br label %38, !dbg !1247

38:                                               ; preds = %37
  %39 = load i32, ptr %5, align 4, !dbg !1248
  %40 = add i32 %39, 1, !dbg !1248
  store i32 %40, ptr %5, align 4, !dbg !1248
  br label %10, !dbg !1225, !llvm.loop !1249

41:                                               ; preds = %20, %10
  br label %42, !dbg !1250

42:                                               ; preds = %41, %2
  %43 = load ptr, ptr %6, align 4, !dbg !1251
  %44 = icmp ne ptr %43, null, !dbg !1252
  br i1 %44, label %45, label %52, !dbg !1251

45:                                               ; preds = %42
  %46 = load ptr, ptr %4, align 4, !dbg !1253
  %47 = load ptr, ptr %6, align 4, !dbg !1254
  %48 = getelementptr inbounds %struct.QUEUE_REGISTRY_ITEM, ptr %47, i32 0, i32 0, !dbg !1255
  store ptr %46, ptr %48, align 4, !dbg !1256
  %49 = load ptr, ptr %3, align 4, !dbg !1257
  %50 = load ptr, ptr %6, align 4, !dbg !1258
  %51 = getelementptr inbounds %struct.QUEUE_REGISTRY_ITEM, ptr %50, i32 0, i32 1, !dbg !1259
  store ptr %49, ptr %51, align 4, !dbg !1260
  br label %52, !dbg !1261

52:                                               ; preds = %45, %42
  ret void, !dbg !1262
}

; Function Attrs: noinline nounwind
define dso_local ptr @pcQueueGetName(ptr noundef %0) #0 !dbg !1263 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  store ptr null, ptr %4, align 4, !dbg !1264
  store i32 0, ptr %3, align 4, !dbg !1265
  br label %5, !dbg !1266

5:                                                ; preds = %22, %1
  %6 = load i32, ptr %3, align 4, !dbg !1267
  %7 = icmp ult i32 %6, 8, !dbg !1268
  br i1 %7, label %8, label %25, !dbg !1269

8:                                                ; preds = %5
  %9 = load i32, ptr %3, align 4, !dbg !1270
  %10 = getelementptr inbounds [8 x %struct.QUEUE_REGISTRY_ITEM], ptr @xQueueRegistry, i32 0, i32 %9, !dbg !1271
  %11 = getelementptr inbounds %struct.QUEUE_REGISTRY_ITEM, ptr %10, i32 0, i32 1, !dbg !1272
  %12 = load ptr, ptr %11, align 4, !dbg !1272
  %13 = load ptr, ptr %2, align 4, !dbg !1273
  %14 = icmp eq ptr %12, %13, !dbg !1274
  br i1 %14, label %15, label %20, !dbg !1271

15:                                               ; preds = %8
  %16 = load i32, ptr %3, align 4, !dbg !1275
  %17 = getelementptr inbounds [8 x %struct.QUEUE_REGISTRY_ITEM], ptr @xQueueRegistry, i32 0, i32 %16, !dbg !1276
  %18 = getelementptr inbounds %struct.QUEUE_REGISTRY_ITEM, ptr %17, i32 0, i32 0, !dbg !1277
  %19 = load ptr, ptr %18, align 4, !dbg !1277
  store ptr %19, ptr %4, align 4, !dbg !1278
  br label %25, !dbg !1279

20:                                               ; preds = %8
  br label %21

21:                                               ; preds = %20
  br label %22, !dbg !1280

22:                                               ; preds = %21
  %23 = load i32, ptr %3, align 4, !dbg !1281
  %24 = add i32 %23, 1, !dbg !1281
  store i32 %24, ptr %3, align 4, !dbg !1281
  br label %5, !dbg !1269, !llvm.loop !1282

25:                                               ; preds = %15, %5
  %26 = load ptr, ptr %4, align 4, !dbg !1283
  ret ptr %26, !dbg !1284
}

; Function Attrs: noinline nounwind
define dso_local void @vQueueWaitForMessageRestricted(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 !dbg !1285 {
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 4
  store ptr %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %8 = load ptr, ptr %4, align 4, !dbg !1286
  store ptr %8, ptr %7, align 4, !dbg !1287
  call void @vPortEnterCritical(), !dbg !1288
  %9 = load ptr, ptr %7, align 4, !dbg !1288
  %10 = getelementptr inbounds %struct.QueueDefinition, ptr %9, i32 0, i32 8, !dbg !1288
  %11 = load volatile i8, ptr %10, align 4, !dbg !1288
  %12 = sext i8 %11 to i32, !dbg !1288
  %13 = icmp eq i32 %12, -1, !dbg !1288
  br i1 %13, label %14, label %17, !dbg !1288

14:                                               ; preds = %3
  %15 = load ptr, ptr %7, align 4, !dbg !1288
  %16 = getelementptr inbounds %struct.QueueDefinition, ptr %15, i32 0, i32 8, !dbg !1288
  store volatile i8 0, ptr %16, align 4, !dbg !1288
  br label %17, !dbg !1288

17:                                               ; preds = %14, %3
  %18 = load ptr, ptr %7, align 4, !dbg !1288
  %19 = getelementptr inbounds %struct.QueueDefinition, ptr %18, i32 0, i32 9, !dbg !1288
  %20 = load volatile i8, ptr %19, align 1, !dbg !1288
  %21 = sext i8 %20 to i32, !dbg !1288
  %22 = icmp eq i32 %21, -1, !dbg !1288
  br i1 %22, label %23, label %26, !dbg !1288

23:                                               ; preds = %17
  %24 = load ptr, ptr %7, align 4, !dbg !1288
  %25 = getelementptr inbounds %struct.QueueDefinition, ptr %24, i32 0, i32 9, !dbg !1288
  store volatile i8 0, ptr %25, align 1, !dbg !1288
  br label %26, !dbg !1288

26:                                               ; preds = %23, %17
  call void @vPortExitCritical(), !dbg !1288
  %27 = load ptr, ptr %7, align 4, !dbg !1289
  %28 = getelementptr inbounds %struct.QueueDefinition, ptr %27, i32 0, i32 5, !dbg !1290
  %29 = load volatile i32, ptr %28, align 4, !dbg !1290
  %30 = icmp eq i32 %29, 0, !dbg !1291
  br i1 %30, label %31, label %36, !dbg !1289

31:                                               ; preds = %26
  %32 = load ptr, ptr %7, align 4, !dbg !1292
  %33 = getelementptr inbounds %struct.QueueDefinition, ptr %32, i32 0, i32 4, !dbg !1293
  %34 = load i32, ptr %5, align 4, !dbg !1294
  %35 = load i32, ptr %6, align 4, !dbg !1295
  call void @vTaskPlaceOnEventListRestricted(ptr noundef %33, i32 noundef %34, i32 noundef %35), !dbg !1296
  br label %37, !dbg !1297

36:                                               ; preds = %26
  br label %37

37:                                               ; preds = %36, %31
  %38 = load ptr, ptr %7, align 4, !dbg !1298
  call void @prvUnlockQueue(ptr noundef %38), !dbg !1299
  ret void, !dbg !1300
}

declare dso_local void @vTaskPlaceOnEventListRestricted(ptr noundef, i32 noundef, i32 noundef) #1

declare dso_local i32 @xTaskPriorityDisinherit(ptr noundef) #1

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i32(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i32, i1 immarg) #2

declare dso_local void @vTaskMissedYield() #1

attributes #0 = { noinline nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #2 = { argmemonly nocallback nofree nounwind willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "FreeRTOS/Source/queue.c", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 1, !"min_enum_size", i32 4}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{!"clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)"}
!7 = distinct !DISubprogram(name: "xQueueGenericReset", scope: !1, file: !1, line: 266, type: !8, scopeLine: 268, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!8 = !DISubroutineType(types: !9)
!9 = !{}
!10 = !DILocation(line: 269, column: 16, scope: !7)
!11 = !DILocation(line: 270, column: 31, scope: !7)
!12 = !DILocation(line: 270, column: 21, scope: !7)
!13 = !DILocation(line: 274, column: 11, scope: !7)
!14 = !DILocation(line: 274, column: 19, scope: !7)
!15 = !DILocation(line: 274, column: 29, scope: !7)
!16 = !DILocation(line: 275, column: 11, scope: !7)
!17 = !DILocation(line: 275, column: 20, scope: !7)
!18 = !DILocation(line: 275, column: 29, scope: !7)
!19 = !DILocation(line: 275, column: 37, scope: !7)
!20 = !DILocation(line: 277, column: 24, scope: !7)
!21 = !DILocation(line: 277, column: 33, scope: !7)
!22 = !DILocation(line: 277, column: 22, scope: !7)
!23 = !DILocation(line: 277, column: 47, scope: !7)
!24 = !DILocation(line: 277, column: 56, scope: !7)
!25 = !DILocation(line: 277, column: 44, scope: !7)
!26 = !DILocation(line: 274, column: 9, scope: !7)
!27 = !DILocation(line: 279, column: 9, scope: !7)
!28 = !DILocation(line: 281, column: 40, scope: !7)
!29 = !DILocation(line: 281, column: 49, scope: !7)
!30 = !DILocation(line: 281, column: 60, scope: !7)
!31 = !DILocation(line: 281, column: 69, scope: !7)
!32 = !DILocation(line: 281, column: 80, scope: !7)
!33 = !DILocation(line: 281, column: 89, scope: !7)
!34 = !DILocation(line: 281, column: 78, scope: !7)
!35 = !DILocation(line: 281, column: 56, scope: !7)
!36 = !DILocation(line: 281, column: 13, scope: !7)
!37 = !DILocation(line: 281, column: 22, scope: !7)
!38 = !DILocation(line: 281, column: 31, scope: !7)
!39 = !DILocation(line: 281, column: 38, scope: !7)
!40 = !DILocation(line: 282, column: 13, scope: !7)
!41 = !DILocation(line: 282, column: 22, scope: !7)
!42 = !DILocation(line: 282, column: 40, scope: !7)
!43 = !DILocation(line: 283, column: 34, scope: !7)
!44 = !DILocation(line: 283, column: 43, scope: !7)
!45 = !DILocation(line: 283, column: 13, scope: !7)
!46 = !DILocation(line: 283, column: 22, scope: !7)
!47 = !DILocation(line: 283, column: 32, scope: !7)
!48 = !DILocation(line: 284, column: 44, scope: !7)
!49 = !DILocation(line: 284, column: 53, scope: !7)
!50 = !DILocation(line: 284, column: 66, scope: !7)
!51 = !DILocation(line: 284, column: 75, scope: !7)
!52 = !DILocation(line: 284, column: 84, scope: !7)
!53 = !DILocation(line: 284, column: 93, scope: !7)
!54 = !DILocation(line: 284, column: 102, scope: !7)
!55 = !DILocation(line: 284, column: 91, scope: !7)
!56 = !DILocation(line: 284, column: 60, scope: !7)
!57 = !DILocation(line: 284, column: 13, scope: !7)
!58 = !DILocation(line: 284, column: 22, scope: !7)
!59 = !DILocation(line: 284, column: 31, scope: !7)
!60 = !DILocation(line: 284, column: 42, scope: !7)
!61 = !DILocation(line: 285, column: 13, scope: !7)
!62 = !DILocation(line: 285, column: 22, scope: !7)
!63 = !DILocation(line: 285, column: 30, scope: !7)
!64 = !DILocation(line: 286, column: 13, scope: !7)
!65 = !DILocation(line: 286, column: 22, scope: !7)
!66 = !DILocation(line: 286, column: 30, scope: !7)
!67 = !DILocation(line: 288, column: 17, scope: !7)
!68 = !DILocation(line: 288, column: 27, scope: !7)
!69 = !DILocation(line: 295, column: 21, scope: !7)
!70 = !DILocation(line: 295, column: 76, scope: !7)
!71 = !DILocation(line: 297, column: 54, scope: !7)
!72 = !DILocation(line: 297, column: 63, scope: !7)
!73 = !DILocation(line: 297, column: 25, scope: !7)
!74 = !DILocation(line: 297, column: 87, scope: !7)
!75 = !DILocation(line: 299, column: 25, scope: !7)
!76 = !{i64 2148169974}
!77 = !{i64 2148170044}
!78 = !DILocation(line: 300, column: 21, scope: !7)
!79 = !DILocation(line: 305, column: 17, scope: !7)
!80 = !DILocation(line: 310, column: 13, scope: !7)
!81 = !DILocation(line: 314, column: 37, scope: !7)
!82 = !DILocation(line: 314, column: 46, scope: !7)
!83 = !DILocation(line: 314, column: 17, scope: !7)
!84 = !DILocation(line: 315, column: 37, scope: !7)
!85 = !DILocation(line: 315, column: 46, scope: !7)
!86 = !DILocation(line: 315, column: 17, scope: !7)
!87 = !DILocation(line: 318, column: 9, scope: !7)
!88 = !DILocation(line: 319, column: 5, scope: !7)
!89 = !DILocation(line: 322, column: 17, scope: !7)
!90 = !DILocation(line: 329, column: 12, scope: !7)
!91 = !DILocation(line: 329, column: 5, scope: !7)
!92 = distinct !DISubprogram(name: "xQueueGenericCreateStatic", scope: !1, file: !1, line: 335, type: !8, scopeLine: 340, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!93 = !DILocation(line: 341, column: 19, scope: !92)
!94 = !DILocation(line: 347, column: 15, scope: !92)
!95 = !DILocation(line: 347, column: 29, scope: !92)
!96 = !DILocation(line: 347, column: 51, scope: !92)
!97 = !DILocation(line: 348, column: 15, scope: !92)
!98 = !DILocation(line: 348, column: 29, scope: !92)
!99 = !DILocation(line: 348, column: 39, scope: !92)
!100 = !DILocation(line: 352, column: 20, scope: !92)
!101 = !DILocation(line: 352, column: 36, scope: !92)
!102 = !DILocation(line: 352, column: 46, scope: !92)
!103 = !DILocation(line: 352, column: 51, scope: !92)
!104 = !DILocation(line: 352, column: 62, scope: !92)
!105 = !DILocation(line: 352, column: 73, scope: !92)
!106 = !DILocation(line: 353, column: 20, scope: !92)
!107 = !DILocation(line: 353, column: 36, scope: !92)
!108 = !DILocation(line: 353, column: 46, scope: !92)
!109 = !DILocation(line: 353, column: 51, scope: !92)
!110 = !DILocation(line: 353, column: 62, scope: !92)
!111 = !DILocation(line: 347, column: 13, scope: !92)
!112 = !DILocation(line: 371, column: 40, scope: !92)
!113 = !DILocation(line: 371, column: 24, scope: !92)
!114 = !DILocation(line: 378, column: 21, scope: !92)
!115 = !DILocation(line: 378, column: 33, scope: !92)
!116 = !DILocation(line: 378, column: 55, scope: !92)
!117 = !DILocation(line: 382, column: 36, scope: !92)
!118 = !DILocation(line: 382, column: 51, scope: !92)
!119 = !DILocation(line: 382, column: 63, scope: !92)
!120 = !DILocation(line: 382, column: 80, scope: !92)
!121 = !DILocation(line: 382, column: 93, scope: !92)
!122 = !DILocation(line: 382, column: 13, scope: !92)
!123 = !DILocation(line: 383, column: 9, scope: !92)
!124 = !DILocation(line: 390, column: 16, scope: !92)
!125 = !DILocation(line: 390, column: 9, scope: !92)
!126 = distinct !DISubprogram(name: "prvInitialiseNewQueue", scope: !1, file: !1, line: 464, type: !8, scopeLine: 469, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!127 = !DILocation(line: 472, column: 14, scope: !126)
!128 = !DILocation(line: 474, column: 9, scope: !126)
!129 = !DILocation(line: 474, column: 20, scope: !126)
!130 = !DILocation(line: 480, column: 43, scope: !126)
!131 = !DILocation(line: 480, column: 9, scope: !126)
!132 = !DILocation(line: 480, column: 21, scope: !126)
!133 = !DILocation(line: 480, column: 28, scope: !126)
!134 = !DILocation(line: 481, column: 5, scope: !126)
!135 = !DILocation(line: 485, column: 43, scope: !126)
!136 = !DILocation(line: 485, column: 9, scope: !126)
!137 = !DILocation(line: 485, column: 21, scope: !126)
!138 = !DILocation(line: 485, column: 28, scope: !126)
!139 = !DILocation(line: 490, column: 28, scope: !126)
!140 = !DILocation(line: 490, column: 5, scope: !126)
!141 = !DILocation(line: 490, column: 17, scope: !126)
!142 = !DILocation(line: 490, column: 26, scope: !126)
!143 = !DILocation(line: 491, column: 30, scope: !126)
!144 = !DILocation(line: 491, column: 5, scope: !126)
!145 = !DILocation(line: 491, column: 17, scope: !126)
!146 = !DILocation(line: 491, column: 28, scope: !126)
!147 = !DILocation(line: 492, column: 34, scope: !126)
!148 = !DILocation(line: 492, column: 14, scope: !126)
!149 = !DILocation(line: 496, column: 39, scope: !126)
!150 = !DILocation(line: 496, column: 13, scope: !126)
!151 = !DILocation(line: 496, column: 25, scope: !126)
!152 = !DILocation(line: 496, column: 37, scope: !126)
!153 = !DILocation(line: 507, column: 1, scope: !126)
!154 = distinct !DISubprogram(name: "xQueueGenericCreate", scope: !1, file: !1, line: 398, type: !8, scopeLine: 401, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!155 = !DILocation(line: 402, column: 19, scope: !154)
!156 = !DILocation(line: 406, column: 15, scope: !154)
!157 = !DILocation(line: 406, column: 29, scope: !154)
!158 = !DILocation(line: 406, column: 51, scope: !154)
!159 = !DILocation(line: 408, column: 28, scope: !154)
!160 = !DILocation(line: 408, column: 26, scope: !154)
!161 = !DILocation(line: 408, column: 47, scope: !154)
!162 = !DILocation(line: 408, column: 44, scope: !154)
!163 = !DILocation(line: 408, column: 60, scope: !154)
!164 = !DILocation(line: 410, column: 53, scope: !154)
!165 = !DILocation(line: 410, column: 69, scope: !154)
!166 = !DILocation(line: 410, column: 67, scope: !154)
!167 = !DILocation(line: 410, column: 48, scope: !154)
!168 = !DILocation(line: 406, column: 13, scope: !154)
!169 = !DILocation(line: 415, column: 46, scope: !154)
!170 = !DILocation(line: 415, column: 62, scope: !154)
!171 = !DILocation(line: 415, column: 60, scope: !154)
!172 = !DILocation(line: 415, column: 31, scope: !154)
!173 = !DILocation(line: 426, column: 74, scope: !154)
!174 = !DILocation(line: 426, column: 72, scope: !154)
!175 = !DILocation(line: 426, column: 40, scope: !154)
!176 = !DILocation(line: 426, column: 24, scope: !154)
!177 = !DILocation(line: 428, column: 17, scope: !154)
!178 = !DILocation(line: 428, column: 28, scope: !154)
!179 = !DILocation(line: 432, column: 49, scope: !154)
!180 = !DILocation(line: 432, column: 33, scope: !154)
!181 = !DILocation(line: 433, column: 33, scope: !154)
!182 = !DILocation(line: 440, column: 25, scope: !154)
!183 = !DILocation(line: 440, column: 37, scope: !154)
!184 = !DILocation(line: 440, column: 59, scope: !154)
!185 = !DILocation(line: 444, column: 40, scope: !154)
!186 = !DILocation(line: 444, column: 55, scope: !154)
!187 = !DILocation(line: 444, column: 67, scope: !154)
!188 = !DILocation(line: 444, column: 84, scope: !154)
!189 = !DILocation(line: 444, column: 97, scope: !154)
!190 = !DILocation(line: 444, column: 17, scope: !154)
!191 = !DILocation(line: 445, column: 13, scope: !154)
!192 = !DILocation(line: 451, column: 9, scope: !154)
!193 = !DILocation(line: 458, column: 16, scope: !154)
!194 = !DILocation(line: 458, column: 9, scope: !154)
!195 = distinct !DISubprogram(name: "xQueueCreateMutex", scope: !1, file: !1, line: 542, type: !8, scopeLine: 543, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!196 = !DILocation(line: 545, column: 27, scope: !195)
!197 = !DILocation(line: 545, column: 62, scope: !195)
!198 = !DILocation(line: 547, column: 70, scope: !195)
!199 = !DILocation(line: 547, column: 21, scope: !195)
!200 = !DILocation(line: 547, column: 19, scope: !195)
!201 = !DILocation(line: 548, column: 43, scope: !195)
!202 = !DILocation(line: 548, column: 9, scope: !195)
!203 = !DILocation(line: 550, column: 16, scope: !195)
!204 = !DILocation(line: 550, column: 9, scope: !195)
!205 = distinct !DISubprogram(name: "prvInitialiseMutex", scope: !1, file: !1, line: 512, type: !8, scopeLine: 513, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!206 = !DILocation(line: 514, column: 13, scope: !205)
!207 = !DILocation(line: 514, column: 24, scope: !205)
!208 = !DILocation(line: 520, column: 13, scope: !205)
!209 = !DILocation(line: 520, column: 25, scope: !205)
!210 = !DILocation(line: 520, column: 38, scope: !205)
!211 = !DILocation(line: 520, column: 51, scope: !205)
!212 = !DILocation(line: 521, column: 13, scope: !205)
!213 = !DILocation(line: 521, column: 25, scope: !205)
!214 = !DILocation(line: 521, column: 37, scope: !205)
!215 = !DILocation(line: 524, column: 13, scope: !205)
!216 = !DILocation(line: 524, column: 25, scope: !205)
!217 = !DILocation(line: 524, column: 38, scope: !205)
!218 = !DILocation(line: 524, column: 59, scope: !205)
!219 = !DILocation(line: 529, column: 41, scope: !205)
!220 = !DILocation(line: 529, column: 22, scope: !205)
!221 = !DILocation(line: 530, column: 9, scope: !205)
!222 = !DILocation(line: 535, column: 5, scope: !205)
!223 = distinct !DISubprogram(name: "xQueueCreateMutexStatic", scope: !1, file: !1, line: 558, type: !8, scopeLine: 560, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!224 = !DILocation(line: 562, column: 27, scope: !223)
!225 = !DILocation(line: 562, column: 62, scope: !223)
!226 = !DILocation(line: 566, column: 18, scope: !223)
!227 = !DILocation(line: 568, column: 82, scope: !223)
!228 = !DILocation(line: 568, column: 97, scope: !223)
!229 = !DILocation(line: 568, column: 21, scope: !223)
!230 = !DILocation(line: 568, column: 19, scope: !223)
!231 = !DILocation(line: 569, column: 43, scope: !223)
!232 = !DILocation(line: 569, column: 9, scope: !223)
!233 = !DILocation(line: 571, column: 16, scope: !223)
!234 = !DILocation(line: 571, column: 9, scope: !223)
!235 = distinct !DISubprogram(name: "xQueueGetMutexHolder", scope: !1, file: !1, line: 579, type: !8, scopeLine: 580, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!236 = !DILocation(line: 582, column: 53, scope: !235)
!237 = !DILocation(line: 582, column: 25, scope: !235)
!238 = !DILocation(line: 591, column: 9, scope: !235)
!239 = !DILocation(line: 593, column: 17, scope: !235)
!240 = !DILocation(line: 593, column: 30, scope: !235)
!241 = !DILocation(line: 593, column: 42, scope: !235)
!242 = !DILocation(line: 595, column: 28, scope: !235)
!243 = !DILocation(line: 595, column: 41, scope: !235)
!244 = !DILocation(line: 595, column: 54, scope: !235)
!245 = !DILocation(line: 595, column: 26, scope: !235)
!246 = !DILocation(line: 596, column: 13, scope: !235)
!247 = !DILocation(line: 599, column: 26, scope: !235)
!248 = !DILocation(line: 602, column: 9, scope: !235)
!249 = !DILocation(line: 604, column: 16, scope: !235)
!250 = !DILocation(line: 604, column: 9, scope: !235)
!251 = distinct !DISubprogram(name: "xQueueGetMutexHolderFromISR", scope: !1, file: !1, line: 612, type: !8, scopeLine: 613, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!252 = !DILocation(line: 621, column: 29, scope: !251)
!253 = !DILocation(line: 621, column: 43, scope: !251)
!254 = !DILocation(line: 621, column: 55, scope: !251)
!255 = !DILocation(line: 621, column: 13, scope: !251)
!256 = !DILocation(line: 623, column: 40, scope: !251)
!257 = !DILocation(line: 623, column: 54, scope: !251)
!258 = !DILocation(line: 623, column: 67, scope: !251)
!259 = !DILocation(line: 623, column: 22, scope: !251)
!260 = !DILocation(line: 624, column: 9, scope: !251)
!261 = !DILocation(line: 627, column: 22, scope: !251)
!262 = !DILocation(line: 630, column: 16, scope: !251)
!263 = !DILocation(line: 630, column: 9, scope: !251)
!264 = distinct !DISubprogram(name: "xQueueGiveMutexRecursive", scope: !1, file: !1, line: 638, type: !8, scopeLine: 639, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!265 = !DILocation(line: 641, column: 49, scope: !264)
!266 = !DILocation(line: 641, column: 25, scope: !264)
!267 = !DILocation(line: 651, column: 13, scope: !264)
!268 = !DILocation(line: 651, column: 22, scope: !264)
!269 = !DILocation(line: 651, column: 35, scope: !264)
!270 = !DILocation(line: 651, column: 51, scope: !264)
!271 = !DILocation(line: 651, column: 48, scope: !264)
!272 = !DILocation(line: 660, column: 15, scope: !264)
!273 = !DILocation(line: 660, column: 24, scope: !264)
!274 = !DILocation(line: 660, column: 37, scope: !264)
!275 = !DILocation(line: 660, column: 59, scope: !264)
!276 = !DILocation(line: 663, column: 17, scope: !264)
!277 = !DILocation(line: 663, column: 26, scope: !264)
!278 = !DILocation(line: 663, column: 39, scope: !264)
!279 = !DILocation(line: 663, column: 60, scope: !264)
!280 = !DILocation(line: 667, column: 45, scope: !264)
!281 = !DILocation(line: 667, column: 26, scope: !264)
!282 = !DILocation(line: 668, column: 13, scope: !264)
!283 = !DILocation(line: 674, column: 21, scope: !264)
!284 = !DILocation(line: 675, column: 9, scope: !264)
!285 = !DILocation(line: 680, column: 21, scope: !264)
!286 = !DILocation(line: 685, column: 16, scope: !264)
!287 = !DILocation(line: 685, column: 9, scope: !264)
!288 = distinct !DISubprogram(name: "xQueueGenericSend", scope: !1, file: !1, line: 805, type: !8, scopeLine: 809, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!289 = !DILocation(line: 810, column: 16, scope: !288)
!290 = !DILocation(line: 812, column: 31, scope: !288)
!291 = !DILocation(line: 812, column: 21, scope: !288)
!292 = !DILocation(line: 826, column: 5, scope: !288)
!293 = !DILocation(line: 828, column: 9, scope: !288)
!294 = !DILocation(line: 834, column: 19, scope: !288)
!295 = !DILocation(line: 834, column: 28, scope: !288)
!296 = !DILocation(line: 834, column: 48, scope: !288)
!297 = !DILocation(line: 834, column: 57, scope: !288)
!298 = !DILocation(line: 834, column: 46, scope: !288)
!299 = !DILocation(line: 834, column: 68, scope: !288)
!300 = !DILocation(line: 834, column: 73, scope: !288)
!301 = !DILocation(line: 834, column: 87, scope: !288)
!302 = !DILocation(line: 834, column: 17, scope: !288)
!303 = !DILocation(line: 900, column: 62, scope: !288)
!304 = !DILocation(line: 900, column: 71, scope: !288)
!305 = !DILocation(line: 900, column: 86, scope: !288)
!306 = !DILocation(line: 900, column: 42, scope: !288)
!307 = !DILocation(line: 900, column: 40, scope: !288)
!308 = !DILocation(line: 904, column: 29, scope: !288)
!309 = !DILocation(line: 904, column: 87, scope: !288)
!310 = !DILocation(line: 906, column: 62, scope: !288)
!311 = !DILocation(line: 906, column: 71, scope: !288)
!312 = !DILocation(line: 906, column: 33, scope: !288)
!313 = !DILocation(line: 906, column: 98, scope: !288)
!314 = !DILocation(line: 912, column: 33, scope: !288)
!315 = !{i64 2148171805}
!316 = !{i64 2148171875}
!317 = !DILocation(line: 913, column: 29, scope: !288)
!318 = !DILocation(line: 918, column: 25, scope: !288)
!319 = !DILocation(line: 919, column: 34, scope: !288)
!320 = !DILocation(line: 919, column: 49, scope: !288)
!321 = !DILocation(line: 925, column: 29, scope: !288)
!322 = !{i64 2148172453}
!323 = !{i64 2148172523}
!324 = !DILocation(line: 926, column: 25, scope: !288)
!325 = !DILocation(line: 934, column: 17, scope: !288)
!326 = !DILocation(line: 935, column: 17, scope: !288)
!327 = !DILocation(line: 939, column: 21, scope: !288)
!328 = !DILocation(line: 939, column: 34, scope: !288)
!329 = !DILocation(line: 943, column: 21, scope: !288)
!330 = !DILocation(line: 948, column: 21, scope: !288)
!331 = !DILocation(line: 950, column: 26, scope: !288)
!332 = !DILocation(line: 950, column: 40, scope: !288)
!333 = !DILocation(line: 954, column: 21, scope: !288)
!334 = !DILocation(line: 955, column: 35, scope: !288)
!335 = !DILocation(line: 956, column: 17, scope: !288)
!336 = !DILocation(line: 964, column: 9, scope: !288)
!337 = !DILocation(line: 969, column: 9, scope: !288)
!338 = !DILocation(line: 970, column: 9, scope: !288)
!339 = !DILocation(line: 973, column: 13, scope: !288)
!340 = !DILocation(line: 973, column: 62, scope: !288)
!341 = !DILocation(line: 975, column: 33, scope: !288)
!342 = !DILocation(line: 975, column: 17, scope: !288)
!343 = !DILocation(line: 975, column: 43, scope: !288)
!344 = !DILocation(line: 978, column: 43, scope: !288)
!345 = !DILocation(line: 978, column: 52, scope: !288)
!346 = !DILocation(line: 978, column: 75, scope: !288)
!347 = !DILocation(line: 978, column: 17, scope: !288)
!348 = !DILocation(line: 985, column: 33, scope: !288)
!349 = !DILocation(line: 985, column: 17, scope: !288)
!350 = !DILocation(line: 992, column: 21, scope: !288)
!351 = !DILocation(line: 992, column: 38, scope: !288)
!352 = !DILocation(line: 994, column: 21, scope: !288)
!353 = !{i64 2148174221}
!354 = !{i64 2148174291}
!355 = !DILocation(line: 995, column: 17, scope: !288)
!356 = !DILocation(line: 996, column: 13, scope: !288)
!357 = !DILocation(line: 1000, column: 33, scope: !288)
!358 = !DILocation(line: 1000, column: 17, scope: !288)
!359 = !DILocation(line: 1001, column: 26, scope: !288)
!360 = !DILocation(line: 1003, column: 9, scope: !288)
!361 = !DILocation(line: 1007, column: 29, scope: !288)
!362 = !DILocation(line: 1007, column: 13, scope: !288)
!363 = !DILocation(line: 1008, column: 22, scope: !288)
!364 = !DILocation(line: 1011, column: 13, scope: !288)
!365 = distinct !{!365, !292, !366}
!366 = !DILocation(line: 1013, column: 5, scope: !288)
!367 = !DILocation(line: 1014, column: 1, scope: !288)
!368 = distinct !DISubprogram(name: "xQueueTakeMutexRecursive", scope: !1, file: !1, line: 693, type: !8, scopeLine: 695, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!369 = !DILocation(line: 697, column: 49, scope: !368)
!370 = !DILocation(line: 697, column: 25, scope: !368)
!371 = !DILocation(line: 706, column: 13, scope: !368)
!372 = !DILocation(line: 706, column: 22, scope: !368)
!373 = !DILocation(line: 706, column: 35, scope: !368)
!374 = !DILocation(line: 706, column: 51, scope: !368)
!375 = !DILocation(line: 706, column: 48, scope: !368)
!376 = !DILocation(line: 708, column: 15, scope: !368)
!377 = !DILocation(line: 708, column: 24, scope: !368)
!378 = !DILocation(line: 708, column: 37, scope: !368)
!379 = !DILocation(line: 708, column: 59, scope: !368)
!380 = !DILocation(line: 709, column: 21, scope: !368)
!381 = !DILocation(line: 710, column: 9, scope: !368)
!382 = !DILocation(line: 713, column: 44, scope: !368)
!383 = !DILocation(line: 713, column: 53, scope: !368)
!384 = !DILocation(line: 713, column: 23, scope: !368)
!385 = !DILocation(line: 713, column: 21, scope: !368)
!386 = !DILocation(line: 718, column: 17, scope: !368)
!387 = !DILocation(line: 718, column: 25, scope: !368)
!388 = !DILocation(line: 720, column: 19, scope: !368)
!389 = !DILocation(line: 720, column: 28, scope: !368)
!390 = !DILocation(line: 720, column: 41, scope: !368)
!391 = !DILocation(line: 720, column: 63, scope: !368)
!392 = !DILocation(line: 721, column: 13, scope: !368)
!393 = !DILocation(line: 728, column: 16, scope: !368)
!394 = !DILocation(line: 728, column: 9, scope: !368)
!395 = distinct !DISubprogram(name: "xQueueSemaphoreTake", scope: !1, file: !1, line: 1495, type: !8, scopeLine: 1497, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!396 = !DILocation(line: 1498, column: 16, scope: !395)
!397 = !DILocation(line: 1500, column: 31, scope: !395)
!398 = !DILocation(line: 1500, column: 21, scope: !395)
!399 = !DILocation(line: 1503, column: 20, scope: !395)
!400 = !DILocation(line: 1523, column: 5, scope: !395)
!401 = !DILocation(line: 1525, column: 9, scope: !395)
!402 = !DILocation(line: 1529, column: 50, scope: !395)
!403 = !DILocation(line: 1529, column: 59, scope: !395)
!404 = !DILocation(line: 1529, column: 31, scope: !395)
!405 = !DILocation(line: 1533, column: 17, scope: !395)
!406 = !DILocation(line: 1533, column: 34, scope: !395)
!407 = !DILocation(line: 1539, column: 46, scope: !395)
!408 = !DILocation(line: 1539, column: 63, scope: !395)
!409 = !DILocation(line: 1539, column: 17, scope: !395)
!410 = !DILocation(line: 1539, column: 26, scope: !395)
!411 = !DILocation(line: 1539, column: 44, scope: !395)
!412 = !DILocation(line: 1543, column: 29, scope: !395)
!413 = !DILocation(line: 1543, column: 38, scope: !395)
!414 = !DILocation(line: 1543, column: 50, scope: !395)
!415 = !DILocation(line: 1547, column: 66, scope: !395)
!416 = !DILocation(line: 1547, column: 29, scope: !395)
!417 = !DILocation(line: 1547, column: 38, scope: !395)
!418 = !DILocation(line: 1547, column: 51, scope: !395)
!419 = !DILocation(line: 1547, column: 64, scope: !395)
!420 = !DILocation(line: 1548, column: 25, scope: !395)
!421 = !DILocation(line: 1558, column: 21, scope: !395)
!422 = !DILocation(line: 1558, column: 76, scope: !395)
!423 = !DILocation(line: 1560, column: 54, scope: !395)
!424 = !DILocation(line: 1560, column: 63, scope: !395)
!425 = !DILocation(line: 1560, column: 25, scope: !395)
!426 = !DILocation(line: 1560, column: 87, scope: !395)
!427 = !DILocation(line: 1562, column: 25, scope: !395)
!428 = !{i64 2148178631}
!429 = !{i64 2148178701}
!430 = !DILocation(line: 1563, column: 21, scope: !395)
!431 = !DILocation(line: 1568, column: 17, scope: !395)
!432 = !DILocation(line: 1574, column: 17, scope: !395)
!433 = !DILocation(line: 1575, column: 17, scope: !395)
!434 = !DILocation(line: 1579, column: 21, scope: !395)
!435 = !DILocation(line: 1579, column: 34, scope: !395)
!436 = !DILocation(line: 1592, column: 21, scope: !395)
!437 = !DILocation(line: 1594, column: 21, scope: !395)
!438 = !DILocation(line: 1596, column: 26, scope: !395)
!439 = !DILocation(line: 1596, column: 40, scope: !395)
!440 = !DILocation(line: 1600, column: 21, scope: !395)
!441 = !DILocation(line: 1601, column: 35, scope: !395)
!442 = !DILocation(line: 1602, column: 17, scope: !395)
!443 = !DILocation(line: 1610, column: 9, scope: !395)
!444 = !DILocation(line: 1615, column: 9, scope: !395)
!445 = !DILocation(line: 1616, column: 9, scope: !395)
!446 = !DILocation(line: 1619, column: 13, scope: !395)
!447 = !DILocation(line: 1619, column: 62, scope: !395)
!448 = !DILocation(line: 1625, column: 34, scope: !395)
!449 = !DILocation(line: 1625, column: 17, scope: !395)
!450 = !DILocation(line: 1625, column: 44, scope: !395)
!451 = !DILocation(line: 1631, column: 29, scope: !395)
!452 = !DILocation(line: 1631, column: 38, scope: !395)
!453 = !DILocation(line: 1631, column: 50, scope: !395)
!454 = !DILocation(line: 1633, column: 29, scope: !395)
!455 = !DILocation(line: 1635, column: 78, scope: !395)
!456 = !DILocation(line: 1635, column: 87, scope: !395)
!457 = !DILocation(line: 1635, column: 100, scope: !395)
!458 = !DILocation(line: 1635, column: 56, scope: !395)
!459 = !DILocation(line: 1635, column: 54, scope: !395)
!460 = !DILocation(line: 1637, column: 29, scope: !395)
!461 = !DILocation(line: 1638, column: 25, scope: !395)
!462 = !DILocation(line: 1646, column: 43, scope: !395)
!463 = !DILocation(line: 1646, column: 52, scope: !395)
!464 = !DILocation(line: 1646, column: 78, scope: !395)
!465 = !DILocation(line: 1646, column: 17, scope: !395)
!466 = !DILocation(line: 1647, column: 33, scope: !395)
!467 = !DILocation(line: 1647, column: 17, scope: !395)
!468 = !DILocation(line: 1649, column: 21, scope: !395)
!469 = !DILocation(line: 1649, column: 38, scope: !395)
!470 = !DILocation(line: 1651, column: 21, scope: !395)
!471 = !{i64 2148180508}
!472 = !{i64 2148180578}
!473 = !DILocation(line: 1652, column: 17, scope: !395)
!474 = !DILocation(line: 1657, column: 13, scope: !395)
!475 = !DILocation(line: 1662, column: 33, scope: !395)
!476 = !DILocation(line: 1662, column: 17, scope: !395)
!477 = !DILocation(line: 1663, column: 26, scope: !395)
!478 = !DILocation(line: 1665, column: 9, scope: !395)
!479 = !DILocation(line: 1669, column: 29, scope: !395)
!480 = !DILocation(line: 1669, column: 13, scope: !395)
!481 = !DILocation(line: 1670, column: 22, scope: !395)
!482 = !DILocation(line: 1676, column: 34, scope: !395)
!483 = !DILocation(line: 1676, column: 17, scope: !395)
!484 = !DILocation(line: 1676, column: 44, scope: !395)
!485 = !DILocation(line: 1683, column: 29, scope: !395)
!486 = !DILocation(line: 1683, column: 50, scope: !395)
!487 = !DILocation(line: 1685, column: 29, scope: !395)
!488 = !DILocation(line: 1694, column: 98, scope: !395)
!489 = !DILocation(line: 1694, column: 60, scope: !395)
!490 = !DILocation(line: 1694, column: 58, scope: !395)
!491 = !DILocation(line: 1695, column: 70, scope: !395)
!492 = !DILocation(line: 1695, column: 79, scope: !395)
!493 = !DILocation(line: 1695, column: 92, scope: !395)
!494 = !DILocation(line: 1695, column: 106, scope: !395)
!495 = !DILocation(line: 1695, column: 33, scope: !395)
!496 = !DILocation(line: 1697, column: 29, scope: !395)
!497 = !DILocation(line: 1698, column: 25, scope: !395)
!498 = !DILocation(line: 1703, column: 17, scope: !395)
!499 = distinct !{!499, !400, !500}
!500 = !DILocation(line: 1710, column: 5, scope: !395)
!501 = !DILocation(line: 1711, column: 1, scope: !395)
!502 = distinct !DISubprogram(name: "xQueueCreateCountingSemaphoreStatic", scope: !1, file: !1, line: 736, type: !8, scopeLine: 739, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!503 = !DILocation(line: 740, column: 23, scope: !502)
!504 = !DILocation(line: 742, column: 15, scope: !502)
!505 = !DILocation(line: 742, column: 26, scope: !502)
!506 = !DILocation(line: 742, column: 33, scope: !502)
!507 = !DILocation(line: 743, column: 15, scope: !502)
!508 = !DILocation(line: 743, column: 33, scope: !502)
!509 = !DILocation(line: 743, column: 30, scope: !502)
!510 = !DILocation(line: 742, column: 13, scope: !502)
!511 = !DILocation(line: 745, column: 50, scope: !502)
!512 = !DILocation(line: 745, column: 102, scope: !502)
!513 = !DILocation(line: 745, column: 23, scope: !502)
!514 = !DILocation(line: 745, column: 21, scope: !502)
!515 = !DILocation(line: 747, column: 17, scope: !502)
!516 = !DILocation(line: 747, column: 25, scope: !502)
!517 = !DILocation(line: 749, column: 64, scope: !502)
!518 = !DILocation(line: 749, column: 33, scope: !502)
!519 = !DILocation(line: 749, column: 44, scope: !502)
!520 = !DILocation(line: 749, column: 62, scope: !502)
!521 = !DILocation(line: 752, column: 13, scope: !502)
!522 = !DILocation(line: 757, column: 9, scope: !502)
!523 = !DILocation(line: 764, column: 16, scope: !502)
!524 = !DILocation(line: 764, column: 9, scope: !502)
!525 = distinct !DISubprogram(name: "xQueueCreateCountingSemaphore", scope: !1, file: !1, line: 772, type: !8, scopeLine: 774, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!526 = !DILocation(line: 775, column: 23, scope: !525)
!527 = !DILocation(line: 777, column: 15, scope: !525)
!528 = !DILocation(line: 777, column: 26, scope: !525)
!529 = !DILocation(line: 777, column: 33, scope: !525)
!530 = !DILocation(line: 778, column: 15, scope: !525)
!531 = !DILocation(line: 778, column: 33, scope: !525)
!532 = !DILocation(line: 778, column: 30, scope: !525)
!533 = !DILocation(line: 777, column: 13, scope: !525)
!534 = !DILocation(line: 780, column: 44, scope: !525)
!535 = !DILocation(line: 780, column: 23, scope: !525)
!536 = !DILocation(line: 780, column: 21, scope: !525)
!537 = !DILocation(line: 782, column: 17, scope: !525)
!538 = !DILocation(line: 782, column: 25, scope: !525)
!539 = !DILocation(line: 784, column: 64, scope: !525)
!540 = !DILocation(line: 784, column: 33, scope: !525)
!541 = !DILocation(line: 784, column: 44, scope: !525)
!542 = !DILocation(line: 784, column: 62, scope: !525)
!543 = !DILocation(line: 787, column: 13, scope: !525)
!544 = !DILocation(line: 792, column: 9, scope: !525)
!545 = !DILocation(line: 799, column: 16, scope: !525)
!546 = !DILocation(line: 799, column: 9, scope: !525)
!547 = distinct !DISubprogram(name: "prvCopyDataToQueue", scope: !1, file: !1, line: 2160, type: !8, scopeLine: 2163, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!548 = !DILocation(line: 2164, column: 16, scope: !547)
!549 = !DILocation(line: 2169, column: 25, scope: !547)
!550 = !DILocation(line: 2169, column: 34, scope: !547)
!551 = !DILocation(line: 2169, column: 23, scope: !547)
!552 = !DILocation(line: 2171, column: 9, scope: !547)
!553 = !DILocation(line: 2171, column: 18, scope: !547)
!554 = !DILocation(line: 2171, column: 29, scope: !547)
!555 = !DILocation(line: 2175, column: 21, scope: !547)
!556 = !DILocation(line: 2175, column: 30, scope: !547)
!557 = !DILocation(line: 2175, column: 42, scope: !547)
!558 = !DILocation(line: 2178, column: 56, scope: !547)
!559 = !DILocation(line: 2178, column: 65, scope: !547)
!560 = !DILocation(line: 2178, column: 78, scope: !547)
!561 = !DILocation(line: 2178, column: 31, scope: !547)
!562 = !DILocation(line: 2178, column: 29, scope: !547)
!563 = !DILocation(line: 2179, column: 21, scope: !547)
!564 = !DILocation(line: 2179, column: 30, scope: !547)
!565 = !DILocation(line: 2179, column: 43, scope: !547)
!566 = !DILocation(line: 2179, column: 56, scope: !547)
!567 = !DILocation(line: 2180, column: 17, scope: !547)
!568 = !DILocation(line: 2187, column: 5, scope: !547)
!569 = !DILocation(line: 2188, column: 14, scope: !547)
!570 = !DILocation(line: 2188, column: 24, scope: !547)
!571 = !DILocation(line: 2190, column: 37, scope: !547)
!572 = !DILocation(line: 2190, column: 46, scope: !547)
!573 = !DILocation(line: 2190, column: 57, scope: !547)
!574 = !DILocation(line: 2190, column: 83, scope: !547)
!575 = !DILocation(line: 2190, column: 92, scope: !547)
!576 = !DILocation(line: 2190, column: 18, scope: !547)
!577 = !DILocation(line: 2191, column: 31, scope: !547)
!578 = !DILocation(line: 2191, column: 40, scope: !547)
!579 = !DILocation(line: 2191, column: 9, scope: !547)
!580 = !DILocation(line: 2191, column: 18, scope: !547)
!581 = !DILocation(line: 2191, column: 28, scope: !547)
!582 = !DILocation(line: 2193, column: 13, scope: !547)
!583 = !DILocation(line: 2193, column: 22, scope: !547)
!584 = !DILocation(line: 2193, column: 35, scope: !547)
!585 = !DILocation(line: 2193, column: 44, scope: !547)
!586 = !DILocation(line: 2193, column: 53, scope: !547)
!587 = !DILocation(line: 2193, column: 32, scope: !547)
!588 = !DILocation(line: 2195, column: 34, scope: !547)
!589 = !DILocation(line: 2195, column: 43, scope: !547)
!590 = !DILocation(line: 2195, column: 13, scope: !547)
!591 = !DILocation(line: 2195, column: 22, scope: !547)
!592 = !DILocation(line: 2195, column: 32, scope: !547)
!593 = !DILocation(line: 2196, column: 9, scope: !547)
!594 = !DILocation(line: 2201, column: 5, scope: !547)
!595 = !DILocation(line: 2204, column: 37, scope: !547)
!596 = !DILocation(line: 2204, column: 46, scope: !547)
!597 = !DILocation(line: 2204, column: 55, scope: !547)
!598 = !DILocation(line: 2204, column: 67, scope: !547)
!599 = !DILocation(line: 2204, column: 93, scope: !547)
!600 = !DILocation(line: 2204, column: 102, scope: !547)
!601 = !DILocation(line: 2204, column: 18, scope: !547)
!602 = !DILocation(line: 2205, column: 41, scope: !547)
!603 = !DILocation(line: 2205, column: 50, scope: !547)
!604 = !DILocation(line: 2205, column: 9, scope: !547)
!605 = !DILocation(line: 2205, column: 18, scope: !547)
!606 = !DILocation(line: 2205, column: 27, scope: !547)
!607 = !DILocation(line: 2205, column: 38, scope: !547)
!608 = !DILocation(line: 2207, column: 13, scope: !547)
!609 = !DILocation(line: 2207, column: 22, scope: !547)
!610 = !DILocation(line: 2207, column: 31, scope: !547)
!611 = !DILocation(line: 2207, column: 44, scope: !547)
!612 = !DILocation(line: 2207, column: 53, scope: !547)
!613 = !DILocation(line: 2207, column: 42, scope: !547)
!614 = !DILocation(line: 2209, column: 46, scope: !547)
!615 = !DILocation(line: 2209, column: 55, scope: !547)
!616 = !DILocation(line: 2209, column: 64, scope: !547)
!617 = !DILocation(line: 2209, column: 73, scope: !547)
!618 = !DILocation(line: 2209, column: 82, scope: !547)
!619 = !DILocation(line: 2209, column: 71, scope: !547)
!620 = !DILocation(line: 2209, column: 13, scope: !547)
!621 = !DILocation(line: 2209, column: 22, scope: !547)
!622 = !DILocation(line: 2209, column: 31, scope: !547)
!623 = !DILocation(line: 2209, column: 42, scope: !547)
!624 = !DILocation(line: 2210, column: 9, scope: !547)
!625 = !DILocation(line: 2216, column: 13, scope: !547)
!626 = !DILocation(line: 2216, column: 23, scope: !547)
!627 = !DILocation(line: 2218, column: 17, scope: !547)
!628 = !DILocation(line: 2218, column: 35, scope: !547)
!629 = !DILocation(line: 2224, column: 17, scope: !547)
!630 = !DILocation(line: 2225, column: 13, scope: !547)
!631 = !DILocation(line: 2230, column: 9, scope: !547)
!632 = !DILocation(line: 2237, column: 34, scope: !547)
!633 = !DILocation(line: 2237, column: 52, scope: !547)
!634 = !DILocation(line: 2237, column: 5, scope: !547)
!635 = !DILocation(line: 2237, column: 14, scope: !547)
!636 = !DILocation(line: 2237, column: 32, scope: !547)
!637 = !DILocation(line: 2239, column: 12, scope: !547)
!638 = !DILocation(line: 2239, column: 5, scope: !547)
!639 = distinct !DISubprogram(name: "prvIsQueueFull", scope: !1, file: !1, line: 2425, type: !8, scopeLine: 2426, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!640 = !DILocation(line: 2429, column: 5, scope: !639)
!641 = !DILocation(line: 2431, column: 13, scope: !639)
!642 = !DILocation(line: 2431, column: 22, scope: !639)
!643 = !DILocation(line: 2431, column: 43, scope: !639)
!644 = !DILocation(line: 2431, column: 52, scope: !639)
!645 = !DILocation(line: 2431, column: 40, scope: !639)
!646 = !DILocation(line: 2433, column: 21, scope: !639)
!647 = !DILocation(line: 2434, column: 9, scope: !639)
!648 = !DILocation(line: 2437, column: 21, scope: !639)
!649 = !DILocation(line: 2440, column: 5, scope: !639)
!650 = !DILocation(line: 2442, column: 12, scope: !639)
!651 = !DILocation(line: 2442, column: 5, scope: !639)
!652 = distinct !DISubprogram(name: "prvUnlockQueue", scope: !1, file: !1, line: 2264, type: !8, scopeLine: 2265, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!653 = !DILocation(line: 2272, column: 5, scope: !652)
!654 = !DILocation(line: 2274, column: 26, scope: !652)
!655 = !DILocation(line: 2274, column: 35, scope: !652)
!656 = !DILocation(line: 2274, column: 16, scope: !652)
!657 = !DILocation(line: 2277, column: 9, scope: !652)
!658 = !DILocation(line: 2277, column: 16, scope: !652)
!659 = !DILocation(line: 2277, column: 24, scope: !652)
!660 = !DILocation(line: 2325, column: 25, scope: !652)
!661 = !DILocation(line: 2325, column: 83, scope: !652)
!662 = !DILocation(line: 2327, column: 58, scope: !652)
!663 = !DILocation(line: 2327, column: 67, scope: !652)
!664 = !DILocation(line: 2327, column: 29, scope: !652)
!665 = !DILocation(line: 2327, column: 94, scope: !652)
!666 = !DILocation(line: 2331, column: 29, scope: !652)
!667 = !DILocation(line: 2332, column: 25, scope: !652)
!668 = !DILocation(line: 2337, column: 21, scope: !652)
!669 = !DILocation(line: 2340, column: 25, scope: !652)
!670 = !DILocation(line: 2345, column: 13, scope: !652)
!671 = distinct !{!671, !657, !672, !673}
!672 = !DILocation(line: 2346, column: 9, scope: !652)
!673 = !{!"llvm.loop.mustprogress"}
!674 = !DILocation(line: 2348, column: 9, scope: !652)
!675 = !DILocation(line: 2348, column: 18, scope: !652)
!676 = !DILocation(line: 2348, column: 26, scope: !652)
!677 = !DILocation(line: 2350, column: 5, scope: !652)
!678 = !DILocation(line: 2353, column: 5, scope: !652)
!679 = !DILocation(line: 2355, column: 26, scope: !652)
!680 = !DILocation(line: 2355, column: 35, scope: !652)
!681 = !DILocation(line: 2355, column: 16, scope: !652)
!682 = !DILocation(line: 2357, column: 9, scope: !652)
!683 = !DILocation(line: 2357, column: 16, scope: !652)
!684 = !DILocation(line: 2357, column: 24, scope: !652)
!685 = !DILocation(line: 2359, column: 17, scope: !652)
!686 = !DILocation(line: 2359, column: 72, scope: !652)
!687 = !DILocation(line: 2361, column: 50, scope: !652)
!688 = !DILocation(line: 2361, column: 59, scope: !652)
!689 = !DILocation(line: 2361, column: 21, scope: !652)
!690 = !DILocation(line: 2361, column: 83, scope: !652)
!691 = !DILocation(line: 2363, column: 21, scope: !652)
!692 = !DILocation(line: 2364, column: 17, scope: !652)
!693 = !DILocation(line: 2370, column: 17, scope: !652)
!694 = !DILocation(line: 2371, column: 13, scope: !652)
!695 = !DILocation(line: 2374, column: 17, scope: !652)
!696 = distinct !{!696, !682, !697, !673}
!697 = !DILocation(line: 2376, column: 9, scope: !652)
!698 = !DILocation(line: 2378, column: 9, scope: !652)
!699 = !DILocation(line: 2378, column: 18, scope: !652)
!700 = !DILocation(line: 2378, column: 26, scope: !652)
!701 = !DILocation(line: 2380, column: 5, scope: !652)
!702 = !DILocation(line: 2381, column: 1, scope: !652)
!703 = distinct !DISubprogram(name: "xQueueGenericSendFromISR", scope: !1, file: !1, line: 1017, type: !8, scopeLine: 1021, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!704 = !DILocation(line: 1024, column: 31, scope: !703)
!705 = !DILocation(line: 1024, column: 21, scope: !703)
!706 = !DILocation(line: 216, column: 9, scope: !707, inlinedAt: !709)
!707 = distinct !DISubprogram(name: "ulPortRaiseBASEPRI", scope: !708, file: !708, line: 212, type: !8, scopeLine: 213, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!708 = !DIFile(filename: "FreeRTOS/Source/portable/GCC/ARM_CM3/portmacro.h", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!709 = distinct !DILocation(line: 1051, column: 30, scope: !703)
!710 = !{i64 443758, i64 443805, i64 443847, i64 443893, i64 443930}
!711 = !DILocation(line: 228, column: 16, scope: !707, inlinedAt: !709)
!712 = !DILocation(line: 1051, column: 28, scope: !703)
!713 = !DILocation(line: 1053, column: 15, scope: !703)
!714 = !DILocation(line: 1053, column: 24, scope: !703)
!715 = !DILocation(line: 1053, column: 44, scope: !703)
!716 = !DILocation(line: 1053, column: 53, scope: !703)
!717 = !DILocation(line: 1053, column: 42, scope: !703)
!718 = !DILocation(line: 1053, column: 64, scope: !703)
!719 = !DILocation(line: 1053, column: 69, scope: !703)
!720 = !DILocation(line: 1053, column: 83, scope: !703)
!721 = !DILocation(line: 1053, column: 13, scope: !703)
!722 = !DILocation(line: 1055, column: 36, scope: !703)
!723 = !DILocation(line: 1055, column: 45, scope: !703)
!724 = !DILocation(line: 1055, column: 26, scope: !703)
!725 = !DILocation(line: 1056, column: 59, scope: !703)
!726 = !DILocation(line: 1056, column: 68, scope: !703)
!727 = !DILocation(line: 1056, column: 31, scope: !703)
!728 = !DILocation(line: 1065, column: 42, scope: !703)
!729 = !DILocation(line: 1065, column: 51, scope: !703)
!730 = !DILocation(line: 1065, column: 66, scope: !703)
!731 = !DILocation(line: 1065, column: 22, scope: !703)
!732 = !DILocation(line: 1069, column: 17, scope: !703)
!733 = !DILocation(line: 1069, column: 25, scope: !703)
!734 = !DILocation(line: 1131, column: 29, scope: !703)
!735 = !DILocation(line: 1131, column: 87, scope: !703)
!736 = !DILocation(line: 1133, column: 62, scope: !703)
!737 = !DILocation(line: 1133, column: 71, scope: !703)
!738 = !DILocation(line: 1133, column: 33, scope: !703)
!739 = !DILocation(line: 1133, column: 98, scope: !703)
!740 = !DILocation(line: 1137, column: 37, scope: !703)
!741 = !DILocation(line: 1137, column: 63, scope: !703)
!742 = !DILocation(line: 1139, column: 38, scope: !703)
!743 = !DILocation(line: 1139, column: 64, scope: !703)
!744 = !DILocation(line: 1140, column: 33, scope: !703)
!745 = !DILocation(line: 1145, column: 29, scope: !703)
!746 = !DILocation(line: 1150, column: 25, scope: !703)
!747 = !DILocation(line: 1157, column: 34, scope: !703)
!748 = !DILocation(line: 1160, column: 13, scope: !703)
!749 = !DILocation(line: 1167, column: 49, scope: !703)
!750 = !DILocation(line: 1167, column: 57, scope: !703)
!751 = !DILocation(line: 1167, column: 36, scope: !703)
!752 = !DILocation(line: 1167, column: 17, scope: !703)
!753 = !DILocation(line: 1167, column: 26, scope: !703)
!754 = !DILocation(line: 1167, column: 34, scope: !703)
!755 = !DILocation(line: 1170, column: 21, scope: !703)
!756 = !DILocation(line: 1171, column: 9, scope: !703)
!757 = !DILocation(line: 1175, column: 21, scope: !703)
!758 = !DILocation(line: 1178, column: 5, scope: !703)
!759 = !DILocation(line: 236, column: 40, scope: !760, inlinedAt: !761)
!760 = distinct !DISubprogram(name: "vPortSetBASEPRI", scope: !708, file: !708, line: 232, type: !8, scopeLine: 233, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!761 = distinct !DILocation(line: 1178, column: 5, scope: !703)
!762 = !DILocation(line: 234, column: 9, scope: !760, inlinedAt: !761)
!763 = !{i64 444437}
!764 = !DILocation(line: 1180, column: 12, scope: !703)
!765 = !DILocation(line: 1180, column: 5, scope: !703)
!766 = distinct !DISubprogram(name: "xQueueGiveFromISR", scope: !1, file: !1, line: 1184, type: !8, scopeLine: 1186, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!767 = !DILocation(line: 1189, column: 31, scope: !766)
!768 = !DILocation(line: 1189, column: 21, scope: !766)
!769 = !DILocation(line: 216, column: 9, scope: !707, inlinedAt: !770)
!770 = distinct !DILocation(line: 1224, column: 30, scope: !766)
!771 = !DILocation(line: 228, column: 16, scope: !707, inlinedAt: !770)
!772 = !DILocation(line: 1224, column: 28, scope: !766)
!773 = !DILocation(line: 1226, column: 47, scope: !766)
!774 = !DILocation(line: 1226, column: 56, scope: !766)
!775 = !DILocation(line: 1226, column: 27, scope: !766)
!776 = !DILocation(line: 1231, column: 13, scope: !766)
!777 = !DILocation(line: 1231, column: 33, scope: !766)
!778 = !DILocation(line: 1231, column: 42, scope: !766)
!779 = !DILocation(line: 1231, column: 31, scope: !766)
!780 = !DILocation(line: 1233, column: 36, scope: !766)
!781 = !DILocation(line: 1233, column: 45, scope: !766)
!782 = !DILocation(line: 1233, column: 26, scope: !766)
!783 = !DILocation(line: 1243, column: 42, scope: !766)
!784 = !DILocation(line: 1243, column: 60, scope: !766)
!785 = !DILocation(line: 1243, column: 13, scope: !766)
!786 = !DILocation(line: 1243, column: 22, scope: !766)
!787 = !DILocation(line: 1243, column: 40, scope: !766)
!788 = !DILocation(line: 1247, column: 17, scope: !766)
!789 = !DILocation(line: 1247, column: 25, scope: !766)
!790 = !DILocation(line: 1302, column: 29, scope: !766)
!791 = !DILocation(line: 1302, column: 87, scope: !766)
!792 = !DILocation(line: 1304, column: 62, scope: !766)
!793 = !DILocation(line: 1304, column: 71, scope: !766)
!794 = !DILocation(line: 1304, column: 33, scope: !766)
!795 = !DILocation(line: 1304, column: 98, scope: !766)
!796 = !DILocation(line: 1308, column: 37, scope: !766)
!797 = !DILocation(line: 1308, column: 63, scope: !766)
!798 = !DILocation(line: 1310, column: 38, scope: !766)
!799 = !DILocation(line: 1310, column: 64, scope: !766)
!800 = !DILocation(line: 1311, column: 33, scope: !766)
!801 = !DILocation(line: 1316, column: 29, scope: !766)
!802 = !DILocation(line: 1321, column: 25, scope: !766)
!803 = !DILocation(line: 1328, column: 13, scope: !766)
!804 = !DILocation(line: 1335, column: 49, scope: !766)
!805 = !DILocation(line: 1335, column: 57, scope: !766)
!806 = !DILocation(line: 1335, column: 36, scope: !766)
!807 = !DILocation(line: 1335, column: 17, scope: !766)
!808 = !DILocation(line: 1335, column: 26, scope: !766)
!809 = !DILocation(line: 1335, column: 34, scope: !766)
!810 = !DILocation(line: 1338, column: 21, scope: !766)
!811 = !DILocation(line: 1339, column: 9, scope: !766)
!812 = !DILocation(line: 1343, column: 21, scope: !766)
!813 = !DILocation(line: 1346, column: 5, scope: !766)
!814 = !DILocation(line: 236, column: 40, scope: !760, inlinedAt: !815)
!815 = distinct !DILocation(line: 1346, column: 5, scope: !766)
!816 = !DILocation(line: 234, column: 9, scope: !760, inlinedAt: !815)
!817 = !DILocation(line: 1348, column: 12, scope: !766)
!818 = !DILocation(line: 1348, column: 5, scope: !766)
!819 = distinct !DISubprogram(name: "xQueueReceive", scope: !1, file: !1, line: 1352, type: !8, scopeLine: 1355, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!820 = !DILocation(line: 1356, column: 16, scope: !819)
!821 = !DILocation(line: 1358, column: 31, scope: !819)
!822 = !DILocation(line: 1358, column: 21, scope: !819)
!823 = !DILocation(line: 1377, column: 5, scope: !819)
!824 = !DILocation(line: 1379, column: 9, scope: !819)
!825 = !DILocation(line: 1381, column: 51, scope: !819)
!826 = !DILocation(line: 1381, column: 60, scope: !819)
!827 = !DILocation(line: 1381, column: 31, scope: !819)
!828 = !DILocation(line: 1385, column: 17, scope: !819)
!829 = !DILocation(line: 1385, column: 35, scope: !819)
!830 = !DILocation(line: 1388, column: 39, scope: !819)
!831 = !DILocation(line: 1388, column: 48, scope: !819)
!832 = !DILocation(line: 1388, column: 17, scope: !819)
!833 = !DILocation(line: 1390, column: 46, scope: !819)
!834 = !DILocation(line: 1390, column: 64, scope: !819)
!835 = !DILocation(line: 1390, column: 17, scope: !819)
!836 = !DILocation(line: 1390, column: 26, scope: !819)
!837 = !DILocation(line: 1390, column: 44, scope: !819)
!838 = !DILocation(line: 1395, column: 21, scope: !819)
!839 = !DILocation(line: 1395, column: 76, scope: !819)
!840 = !DILocation(line: 1397, column: 54, scope: !819)
!841 = !DILocation(line: 1397, column: 63, scope: !819)
!842 = !DILocation(line: 1397, column: 25, scope: !819)
!843 = !DILocation(line: 1397, column: 87, scope: !819)
!844 = !DILocation(line: 1399, column: 25, scope: !819)
!845 = !{i64 2148175885}
!846 = !{i64 2148175955}
!847 = !DILocation(line: 1400, column: 21, scope: !819)
!848 = !DILocation(line: 1405, column: 17, scope: !819)
!849 = !DILocation(line: 1411, column: 17, scope: !819)
!850 = !DILocation(line: 1412, column: 17, scope: !819)
!851 = !DILocation(line: 1416, column: 21, scope: !819)
!852 = !DILocation(line: 1416, column: 34, scope: !819)
!853 = !DILocation(line: 1420, column: 21, scope: !819)
!854 = !DILocation(line: 1422, column: 21, scope: !819)
!855 = !DILocation(line: 1424, column: 26, scope: !819)
!856 = !DILocation(line: 1424, column: 40, scope: !819)
!857 = !DILocation(line: 1428, column: 21, scope: !819)
!858 = !DILocation(line: 1429, column: 35, scope: !819)
!859 = !DILocation(line: 1430, column: 17, scope: !819)
!860 = !DILocation(line: 1438, column: 9, scope: !819)
!861 = !DILocation(line: 1443, column: 9, scope: !819)
!862 = !DILocation(line: 1444, column: 9, scope: !819)
!863 = !DILocation(line: 1447, column: 13, scope: !819)
!864 = !DILocation(line: 1447, column: 62, scope: !819)
!865 = !DILocation(line: 1451, column: 34, scope: !819)
!866 = !DILocation(line: 1451, column: 17, scope: !819)
!867 = !DILocation(line: 1451, column: 44, scope: !819)
!868 = !DILocation(line: 1454, column: 43, scope: !819)
!869 = !DILocation(line: 1454, column: 52, scope: !819)
!870 = !DILocation(line: 1454, column: 78, scope: !819)
!871 = !DILocation(line: 1454, column: 17, scope: !819)
!872 = !DILocation(line: 1455, column: 33, scope: !819)
!873 = !DILocation(line: 1455, column: 17, scope: !819)
!874 = !DILocation(line: 1457, column: 21, scope: !819)
!875 = !DILocation(line: 1457, column: 38, scope: !819)
!876 = !DILocation(line: 1459, column: 21, scope: !819)
!877 = !{i64 2148177653}
!878 = !{i64 2148177723}
!879 = !DILocation(line: 1460, column: 17, scope: !819)
!880 = !DILocation(line: 1465, column: 13, scope: !819)
!881 = !DILocation(line: 1470, column: 33, scope: !819)
!882 = !DILocation(line: 1470, column: 17, scope: !819)
!883 = !DILocation(line: 1471, column: 26, scope: !819)
!884 = !DILocation(line: 1473, column: 9, scope: !819)
!885 = !DILocation(line: 1478, column: 29, scope: !819)
!886 = !DILocation(line: 1478, column: 13, scope: !819)
!887 = !DILocation(line: 1479, column: 22, scope: !819)
!888 = !DILocation(line: 1481, column: 34, scope: !819)
!889 = !DILocation(line: 1481, column: 17, scope: !819)
!890 = !DILocation(line: 1481, column: 44, scope: !819)
!891 = !DILocation(line: 1484, column: 17, scope: !819)
!892 = distinct !{!892, !823, !893}
!893 = !DILocation(line: 1491, column: 5, scope: !819)
!894 = !DILocation(line: 1492, column: 1, scope: !819)
!895 = distinct !DISubprogram(name: "prvCopyDataFromQueue", scope: !1, file: !1, line: 2243, type: !8, scopeLine: 2245, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!896 = !DILocation(line: 2246, column: 9, scope: !895)
!897 = !DILocation(line: 2246, column: 18, scope: !895)
!898 = !DILocation(line: 2246, column: 29, scope: !895)
!899 = !DILocation(line: 2248, column: 41, scope: !895)
!900 = !DILocation(line: 2248, column: 50, scope: !895)
!901 = !DILocation(line: 2248, column: 9, scope: !895)
!902 = !DILocation(line: 2248, column: 18, scope: !895)
!903 = !DILocation(line: 2248, column: 27, scope: !895)
!904 = !DILocation(line: 2248, column: 38, scope: !895)
!905 = !DILocation(line: 2250, column: 13, scope: !895)
!906 = !DILocation(line: 2250, column: 22, scope: !895)
!907 = !DILocation(line: 2250, column: 31, scope: !895)
!908 = !DILocation(line: 2250, column: 45, scope: !895)
!909 = !DILocation(line: 2250, column: 54, scope: !895)
!910 = !DILocation(line: 2250, column: 63, scope: !895)
!911 = !DILocation(line: 2250, column: 42, scope: !895)
!912 = !DILocation(line: 2252, column: 44, scope: !895)
!913 = !DILocation(line: 2252, column: 53, scope: !895)
!914 = !DILocation(line: 2252, column: 13, scope: !895)
!915 = !DILocation(line: 2252, column: 22, scope: !895)
!916 = !DILocation(line: 2252, column: 31, scope: !895)
!917 = !DILocation(line: 2252, column: 42, scope: !895)
!918 = !DILocation(line: 2253, column: 9, scope: !895)
!919 = !DILocation(line: 2259, column: 37, scope: !895)
!920 = !DILocation(line: 2259, column: 58, scope: !895)
!921 = !DILocation(line: 2259, column: 67, scope: !895)
!922 = !DILocation(line: 2259, column: 76, scope: !895)
!923 = !DILocation(line: 2259, column: 99, scope: !895)
!924 = !DILocation(line: 2259, column: 108, scope: !895)
!925 = !DILocation(line: 2259, column: 18, scope: !895)
!926 = !DILocation(line: 2260, column: 5, scope: !895)
!927 = !DILocation(line: 2261, column: 1, scope: !895)
!928 = distinct !DISubprogram(name: "prvIsQueueEmpty", scope: !1, file: !1, line: 2384, type: !8, scopeLine: 2385, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!929 = !DILocation(line: 2388, column: 5, scope: !928)
!930 = !DILocation(line: 2390, column: 13, scope: !928)
!931 = !DILocation(line: 2390, column: 22, scope: !928)
!932 = !DILocation(line: 2390, column: 40, scope: !928)
!933 = !DILocation(line: 2392, column: 21, scope: !928)
!934 = !DILocation(line: 2393, column: 9, scope: !928)
!935 = !DILocation(line: 2396, column: 21, scope: !928)
!936 = !DILocation(line: 2399, column: 5, scope: !928)
!937 = !DILocation(line: 2401, column: 12, scope: !928)
!938 = !DILocation(line: 2401, column: 5, scope: !928)
!939 = distinct !DISubprogram(name: "prvGetDisinheritPriorityAfterTimeout", scope: !1, file: !1, line: 2135, type: !8, scopeLine: 2136, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!940 = !DILocation(line: 2145, column: 13, scope: !939)
!941 = !DILocation(line: 2145, column: 77, scope: !939)
!942 = !DILocation(line: 2147, column: 102, scope: !939)
!943 = !DILocation(line: 2147, column: 84, scope: !939)
!944 = !DILocation(line: 2147, column: 45, scope: !939)
!945 = !DILocation(line: 2148, column: 9, scope: !939)
!946 = !DILocation(line: 2151, column: 45, scope: !939)
!947 = !DILocation(line: 2154, column: 16, scope: !939)
!948 = !DILocation(line: 2154, column: 9, scope: !939)
!949 = distinct !DISubprogram(name: "xQueuePeek", scope: !1, file: !1, line: 1714, type: !8, scopeLine: 1717, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!950 = !DILocation(line: 1718, column: 16, scope: !949)
!951 = !DILocation(line: 1721, column: 31, scope: !949)
!952 = !DILocation(line: 1721, column: 21, scope: !949)
!953 = !DILocation(line: 1740, column: 5, scope: !949)
!954 = !DILocation(line: 1742, column: 9, scope: !949)
!955 = !DILocation(line: 1744, column: 51, scope: !949)
!956 = !DILocation(line: 1744, column: 60, scope: !949)
!957 = !DILocation(line: 1744, column: 31, scope: !949)
!958 = !DILocation(line: 1748, column: 17, scope: !949)
!959 = !DILocation(line: 1748, column: 35, scope: !949)
!960 = !DILocation(line: 1753, column: 42, scope: !949)
!961 = !DILocation(line: 1753, column: 51, scope: !949)
!962 = !DILocation(line: 1753, column: 60, scope: !949)
!963 = !DILocation(line: 1753, column: 40, scope: !949)
!964 = !DILocation(line: 1755, column: 39, scope: !949)
!965 = !DILocation(line: 1755, column: 48, scope: !949)
!966 = !DILocation(line: 1755, column: 17, scope: !949)
!967 = !DILocation(line: 1759, column: 48, scope: !949)
!968 = !DILocation(line: 1759, column: 17, scope: !949)
!969 = !DILocation(line: 1759, column: 26, scope: !949)
!970 = !DILocation(line: 1759, column: 35, scope: !949)
!971 = !DILocation(line: 1759, column: 46, scope: !949)
!972 = !DILocation(line: 1763, column: 21, scope: !949)
!973 = !DILocation(line: 1763, column: 79, scope: !949)
!974 = !DILocation(line: 1765, column: 54, scope: !949)
!975 = !DILocation(line: 1765, column: 63, scope: !949)
!976 = !DILocation(line: 1765, column: 25, scope: !949)
!977 = !DILocation(line: 1765, column: 90, scope: !949)
!978 = !DILocation(line: 1768, column: 25, scope: !949)
!979 = !{i64 2148181546}
!980 = !{i64 2148181616}
!981 = !DILocation(line: 1769, column: 21, scope: !949)
!982 = !DILocation(line: 1774, column: 17, scope: !949)
!983 = !DILocation(line: 1780, column: 17, scope: !949)
!984 = !DILocation(line: 1781, column: 17, scope: !949)
!985 = !DILocation(line: 1785, column: 21, scope: !949)
!986 = !DILocation(line: 1785, column: 34, scope: !949)
!987 = !DILocation(line: 1789, column: 21, scope: !949)
!988 = !DILocation(line: 1791, column: 21, scope: !949)
!989 = !DILocation(line: 1793, column: 26, scope: !949)
!990 = !DILocation(line: 1793, column: 40, scope: !949)
!991 = !DILocation(line: 1798, column: 21, scope: !949)
!992 = !DILocation(line: 1799, column: 35, scope: !949)
!993 = !DILocation(line: 1800, column: 17, scope: !949)
!994 = !DILocation(line: 1808, column: 9, scope: !949)
!995 = !DILocation(line: 1813, column: 9, scope: !949)
!996 = !DILocation(line: 1814, column: 9, scope: !949)
!997 = !DILocation(line: 1817, column: 13, scope: !949)
!998 = !DILocation(line: 1817, column: 62, scope: !949)
!999 = !DILocation(line: 1821, column: 34, scope: !949)
!1000 = !DILocation(line: 1821, column: 17, scope: !949)
!1001 = !DILocation(line: 1821, column: 44, scope: !949)
!1002 = !DILocation(line: 1824, column: 43, scope: !949)
!1003 = !DILocation(line: 1824, column: 52, scope: !949)
!1004 = !DILocation(line: 1824, column: 78, scope: !949)
!1005 = !DILocation(line: 1824, column: 17, scope: !949)
!1006 = !DILocation(line: 1825, column: 33, scope: !949)
!1007 = !DILocation(line: 1825, column: 17, scope: !949)
!1008 = !DILocation(line: 1827, column: 21, scope: !949)
!1009 = !DILocation(line: 1827, column: 38, scope: !949)
!1010 = !DILocation(line: 1829, column: 21, scope: !949)
!1011 = !{i64 2148183314}
!1012 = !{i64 2148183384}
!1013 = !DILocation(line: 1830, column: 17, scope: !949)
!1014 = !DILocation(line: 1835, column: 13, scope: !949)
!1015 = !DILocation(line: 1840, column: 33, scope: !949)
!1016 = !DILocation(line: 1840, column: 17, scope: !949)
!1017 = !DILocation(line: 1841, column: 26, scope: !949)
!1018 = !DILocation(line: 1843, column: 9, scope: !949)
!1019 = !DILocation(line: 1848, column: 29, scope: !949)
!1020 = !DILocation(line: 1848, column: 13, scope: !949)
!1021 = !DILocation(line: 1849, column: 22, scope: !949)
!1022 = !DILocation(line: 1851, column: 34, scope: !949)
!1023 = !DILocation(line: 1851, column: 17, scope: !949)
!1024 = !DILocation(line: 1851, column: 44, scope: !949)
!1025 = !DILocation(line: 1854, column: 17, scope: !949)
!1026 = distinct !{!1026, !953, !1027}
!1027 = !DILocation(line: 1861, column: 5, scope: !949)
!1028 = !DILocation(line: 1862, column: 1, scope: !949)
!1029 = distinct !DISubprogram(name: "xQueueReceiveFromISR", scope: !1, file: !1, line: 1865, type: !8, scopeLine: 1868, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1030 = !DILocation(line: 1871, column: 31, scope: !1029)
!1031 = !DILocation(line: 1871, column: 21, scope: !1029)
!1032 = !DILocation(line: 216, column: 9, scope: !707, inlinedAt: !1033)
!1033 = distinct !DILocation(line: 1892, column: 30, scope: !1029)
!1034 = !DILocation(line: 228, column: 16, scope: !707, inlinedAt: !1033)
!1035 = !DILocation(line: 1892, column: 28, scope: !1029)
!1036 = !DILocation(line: 1894, column: 47, scope: !1029)
!1037 = !DILocation(line: 1894, column: 56, scope: !1029)
!1038 = !DILocation(line: 1894, column: 27, scope: !1029)
!1039 = !DILocation(line: 1897, column: 13, scope: !1029)
!1040 = !DILocation(line: 1897, column: 31, scope: !1029)
!1041 = !DILocation(line: 1899, column: 36, scope: !1029)
!1042 = !DILocation(line: 1899, column: 45, scope: !1029)
!1043 = !DILocation(line: 1899, column: 26, scope: !1029)
!1044 = !DILocation(line: 1903, column: 35, scope: !1029)
!1045 = !DILocation(line: 1903, column: 44, scope: !1029)
!1046 = !DILocation(line: 1903, column: 13, scope: !1029)
!1047 = !DILocation(line: 1904, column: 42, scope: !1029)
!1048 = !DILocation(line: 1904, column: 60, scope: !1029)
!1049 = !DILocation(line: 1904, column: 13, scope: !1029)
!1050 = !DILocation(line: 1904, column: 22, scope: !1029)
!1051 = !DILocation(line: 1904, column: 40, scope: !1029)
!1052 = !DILocation(line: 1910, column: 17, scope: !1029)
!1053 = !DILocation(line: 1910, column: 25, scope: !1029)
!1054 = !DILocation(line: 1912, column: 21, scope: !1029)
!1055 = !DILocation(line: 1912, column: 76, scope: !1029)
!1056 = !DILocation(line: 1914, column: 54, scope: !1029)
!1057 = !DILocation(line: 1914, column: 63, scope: !1029)
!1058 = !DILocation(line: 1914, column: 25, scope: !1029)
!1059 = !DILocation(line: 1914, column: 87, scope: !1029)
!1060 = !DILocation(line: 1918, column: 29, scope: !1029)
!1061 = !DILocation(line: 1918, column: 55, scope: !1029)
!1062 = !DILocation(line: 1920, column: 30, scope: !1029)
!1063 = !DILocation(line: 1920, column: 56, scope: !1029)
!1064 = !DILocation(line: 1921, column: 25, scope: !1029)
!1065 = !DILocation(line: 1926, column: 21, scope: !1029)
!1066 = !DILocation(line: 1931, column: 17, scope: !1029)
!1067 = !DILocation(line: 1936, column: 13, scope: !1029)
!1068 = !DILocation(line: 1943, column: 49, scope: !1029)
!1069 = !DILocation(line: 1943, column: 57, scope: !1029)
!1070 = !DILocation(line: 1943, column: 36, scope: !1029)
!1071 = !DILocation(line: 1943, column: 17, scope: !1029)
!1072 = !DILocation(line: 1943, column: 26, scope: !1029)
!1073 = !DILocation(line: 1943, column: 34, scope: !1029)
!1074 = !DILocation(line: 1946, column: 21, scope: !1029)
!1075 = !DILocation(line: 1947, column: 9, scope: !1029)
!1076 = !DILocation(line: 1950, column: 21, scope: !1029)
!1077 = !DILocation(line: 1954, column: 5, scope: !1029)
!1078 = !DILocation(line: 236, column: 40, scope: !760, inlinedAt: !1079)
!1079 = distinct !DILocation(line: 1954, column: 5, scope: !1029)
!1080 = !DILocation(line: 234, column: 9, scope: !760, inlinedAt: !1079)
!1081 = !DILocation(line: 1956, column: 12, scope: !1029)
!1082 = !DILocation(line: 1956, column: 5, scope: !1029)
!1083 = distinct !DISubprogram(name: "xQueuePeekFromISR", scope: !1, file: !1, line: 1960, type: !8, scopeLine: 1962, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1084 = !DILocation(line: 1966, column: 31, scope: !1083)
!1085 = !DILocation(line: 1966, column: 21, scope: !1083)
!1086 = !DILocation(line: 216, column: 9, scope: !707, inlinedAt: !1087)
!1087 = distinct !DILocation(line: 1988, column: 30, scope: !1083)
!1088 = !DILocation(line: 228, column: 16, scope: !707, inlinedAt: !1087)
!1089 = !DILocation(line: 1988, column: 28, scope: !1083)
!1090 = !DILocation(line: 1991, column: 13, scope: !1083)
!1091 = !DILocation(line: 1991, column: 22, scope: !1083)
!1092 = !DILocation(line: 1991, column: 40, scope: !1083)
!1093 = !DILocation(line: 1997, column: 38, scope: !1083)
!1094 = !DILocation(line: 1997, column: 47, scope: !1083)
!1095 = !DILocation(line: 1997, column: 56, scope: !1083)
!1096 = !DILocation(line: 1997, column: 36, scope: !1083)
!1097 = !DILocation(line: 1998, column: 35, scope: !1083)
!1098 = !DILocation(line: 1998, column: 44, scope: !1083)
!1099 = !DILocation(line: 1998, column: 13, scope: !1083)
!1100 = !DILocation(line: 1999, column: 44, scope: !1083)
!1101 = !DILocation(line: 1999, column: 13, scope: !1083)
!1102 = !DILocation(line: 1999, column: 22, scope: !1083)
!1103 = !DILocation(line: 1999, column: 31, scope: !1083)
!1104 = !DILocation(line: 1999, column: 42, scope: !1083)
!1105 = !DILocation(line: 2001, column: 21, scope: !1083)
!1106 = !DILocation(line: 2002, column: 9, scope: !1083)
!1107 = !DILocation(line: 2005, column: 21, scope: !1083)
!1108 = !DILocation(line: 2009, column: 5, scope: !1083)
!1109 = !DILocation(line: 236, column: 40, scope: !760, inlinedAt: !1110)
!1110 = distinct !DILocation(line: 2009, column: 5, scope: !1083)
!1111 = !DILocation(line: 234, column: 9, scope: !760, inlinedAt: !1110)
!1112 = !DILocation(line: 2011, column: 12, scope: !1083)
!1113 = !DILocation(line: 2011, column: 5, scope: !1083)
!1114 = distinct !DISubprogram(name: "uxQueueMessagesWaiting", scope: !1, file: !1, line: 2015, type: !8, scopeLine: 2016, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1115 = !DILocation(line: 2021, column: 5, scope: !1114)
!1116 = !DILocation(line: 2023, column: 36, scope: !1114)
!1117 = !DILocation(line: 2023, column: 46, scope: !1114)
!1118 = !DILocation(line: 2023, column: 18, scope: !1114)
!1119 = !DILocation(line: 2025, column: 5, scope: !1114)
!1120 = !DILocation(line: 2027, column: 12, scope: !1114)
!1121 = !DILocation(line: 2027, column: 5, scope: !1114)
!1122 = distinct !DISubprogram(name: "uxQueueSpacesAvailable", scope: !1, file: !1, line: 2031, type: !8, scopeLine: 2032, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1123 = !DILocation(line: 2034, column: 31, scope: !1122)
!1124 = !DILocation(line: 2034, column: 21, scope: !1122)
!1125 = !DILocation(line: 2038, column: 5, scope: !1122)
!1126 = !DILocation(line: 2040, column: 20, scope: !1122)
!1127 = !DILocation(line: 2040, column: 29, scope: !1122)
!1128 = !DILocation(line: 2040, column: 40, scope: !1122)
!1129 = !DILocation(line: 2040, column: 49, scope: !1122)
!1130 = !DILocation(line: 2040, column: 38, scope: !1122)
!1131 = !DILocation(line: 2040, column: 18, scope: !1122)
!1132 = !DILocation(line: 2042, column: 5, scope: !1122)
!1133 = !DILocation(line: 2044, column: 12, scope: !1122)
!1134 = !DILocation(line: 2044, column: 5, scope: !1122)
!1135 = distinct !DISubprogram(name: "uxQueueMessagesWaitingFromISR", scope: !1, file: !1, line: 2048, type: !8, scopeLine: 2049, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1136 = !DILocation(line: 2051, column: 31, scope: !1135)
!1137 = !DILocation(line: 2051, column: 21, scope: !1135)
!1138 = !DILocation(line: 2054, column: 16, scope: !1135)
!1139 = !DILocation(line: 2054, column: 25, scope: !1135)
!1140 = !DILocation(line: 2054, column: 14, scope: !1135)
!1141 = !DILocation(line: 2056, column: 12, scope: !1135)
!1142 = !DILocation(line: 2056, column: 5, scope: !1135)
!1143 = distinct !DISubprogram(name: "vQueueDelete", scope: !1, file: !1, line: 2060, type: !8, scopeLine: 2061, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1144 = !DILocation(line: 2062, column: 31, scope: !1143)
!1145 = !DILocation(line: 2062, column: 21, scope: !1143)
!1146 = !DILocation(line: 2069, column: 36, scope: !1143)
!1147 = !DILocation(line: 2069, column: 13, scope: !1143)
!1148 = !DILocation(line: 2083, column: 17, scope: !1143)
!1149 = !DILocation(line: 2083, column: 26, scope: !1143)
!1150 = !DILocation(line: 2083, column: 48, scope: !1143)
!1151 = !DILocation(line: 2085, column: 28, scope: !1143)
!1152 = !DILocation(line: 2085, column: 17, scope: !1143)
!1153 = !DILocation(line: 2086, column: 13, scope: !1143)
!1154 = !DILocation(line: 2099, column: 1, scope: !1143)
!1155 = distinct !DISubprogram(name: "vQueueUnregisterQueue", scope: !1, file: !1, line: 2834, type: !8, scopeLine: 2835, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1156 = !DILocation(line: 2842, column: 17, scope: !1155)
!1157 = !DILocation(line: 2842, column: 14, scope: !1155)
!1158 = !DILocation(line: 2842, column: 39, scope: !1155)
!1159 = !DILocation(line: 2842, column: 42, scope: !1155)
!1160 = !DILocation(line: 2842, column: 9, scope: !1155)
!1161 = !DILocation(line: 2844, column: 33, scope: !1155)
!1162 = !DILocation(line: 2844, column: 17, scope: !1155)
!1163 = !DILocation(line: 2844, column: 38, scope: !1155)
!1164 = !DILocation(line: 2844, column: 49, scope: !1155)
!1165 = !DILocation(line: 2844, column: 46, scope: !1155)
!1166 = !DILocation(line: 2847, column: 33, scope: !1155)
!1167 = !DILocation(line: 2847, column: 17, scope: !1155)
!1168 = !DILocation(line: 2847, column: 38, scope: !1155)
!1169 = !DILocation(line: 2847, column: 50, scope: !1155)
!1170 = !DILocation(line: 2852, column: 33, scope: !1155)
!1171 = !DILocation(line: 2852, column: 17, scope: !1155)
!1172 = !DILocation(line: 2852, column: 38, scope: !1155)
!1173 = !DILocation(line: 2852, column: 46, scope: !1155)
!1174 = !DILocation(line: 2853, column: 17, scope: !1155)
!1175 = !DILocation(line: 2859, column: 9, scope: !1155)
!1176 = !DILocation(line: 2842, column: 89, scope: !1155)
!1177 = distinct !{!1177, !1160, !1175, !673}
!1178 = !DILocation(line: 2860, column: 5, scope: !1155)
!1179 = distinct !DISubprogram(name: "uxQueueGetQueueNumber", scope: !1, file: !1, line: 2104, type: !8, scopeLine: 2105, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1180 = !DILocation(line: 2106, column: 32, scope: !1179)
!1181 = !DILocation(line: 2106, column: 42, scope: !1179)
!1182 = !DILocation(line: 2106, column: 9, scope: !1179)
!1183 = distinct !DISubprogram(name: "vQueueSetQueueNumber", scope: !1, file: !1, line: 2114, type: !8, scopeLine: 2116, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1184 = !DILocation(line: 2117, column: 51, scope: !1183)
!1185 = !DILocation(line: 2117, column: 25, scope: !1183)
!1186 = !DILocation(line: 2117, column: 35, scope: !1183)
!1187 = !DILocation(line: 2117, column: 49, scope: !1183)
!1188 = !DILocation(line: 2118, column: 5, scope: !1183)
!1189 = distinct !DISubprogram(name: "ucQueueGetQueueType", scope: !1, file: !1, line: 2125, type: !8, scopeLine: 2126, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1190 = !DILocation(line: 2127, column: 32, scope: !1189)
!1191 = !DILocation(line: 2127, column: 42, scope: !1189)
!1192 = !DILocation(line: 2127, column: 9, scope: !1189)
!1193 = distinct !DISubprogram(name: "xQueueIsQueueEmptyFromISR", scope: !1, file: !1, line: 2405, type: !8, scopeLine: 2406, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1194 = !DILocation(line: 2408, column: 31, scope: !1193)
!1195 = !DILocation(line: 2408, column: 21, scope: !1193)
!1196 = !DILocation(line: 2412, column: 9, scope: !1193)
!1197 = !DILocation(line: 2412, column: 18, scope: !1193)
!1198 = !DILocation(line: 2412, column: 36, scope: !1193)
!1199 = !DILocation(line: 2414, column: 17, scope: !1193)
!1200 = !DILocation(line: 2415, column: 5, scope: !1193)
!1201 = !DILocation(line: 2418, column: 17, scope: !1193)
!1202 = !DILocation(line: 2421, column: 12, scope: !1193)
!1203 = !DILocation(line: 2421, column: 5, scope: !1193)
!1204 = distinct !DISubprogram(name: "xQueueIsQueueFullFromISR", scope: !1, file: !1, line: 2446, type: !8, scopeLine: 2447, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1205 = !DILocation(line: 2449, column: 31, scope: !1204)
!1206 = !DILocation(line: 2449, column: 21, scope: !1204)
!1207 = !DILocation(line: 2453, column: 9, scope: !1204)
!1208 = !DILocation(line: 2453, column: 18, scope: !1204)
!1209 = !DILocation(line: 2453, column: 39, scope: !1204)
!1210 = !DILocation(line: 2453, column: 48, scope: !1204)
!1211 = !DILocation(line: 2453, column: 36, scope: !1204)
!1212 = !DILocation(line: 2455, column: 17, scope: !1204)
!1213 = !DILocation(line: 2456, column: 5, scope: !1204)
!1214 = !DILocation(line: 2459, column: 17, scope: !1204)
!1215 = !DILocation(line: 2462, column: 12, scope: !1204)
!1216 = !DILocation(line: 2462, column: 5, scope: !1204)
!1217 = distinct !DISubprogram(name: "vQueueAddToRegistry", scope: !1, file: !1, line: 2755, type: !8, scopeLine: 2757, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1218 = !DILocation(line: 2762, column: 31, scope: !1217)
!1219 = !DILocation(line: 2764, column: 13, scope: !1217)
!1220 = !DILocation(line: 2764, column: 25, scope: !1217)
!1221 = !DILocation(line: 2768, column: 21, scope: !1217)
!1222 = !DILocation(line: 2768, column: 18, scope: !1217)
!1223 = !DILocation(line: 2768, column: 43, scope: !1217)
!1224 = !DILocation(line: 2768, column: 46, scope: !1217)
!1225 = !DILocation(line: 2768, column: 13, scope: !1217)
!1226 = !DILocation(line: 2771, column: 21, scope: !1217)
!1227 = !DILocation(line: 2771, column: 47, scope: !1217)
!1228 = !DILocation(line: 2771, column: 31, scope: !1217)
!1229 = !DILocation(line: 2771, column: 52, scope: !1217)
!1230 = !DILocation(line: 2771, column: 28, scope: !1217)
!1231 = !DILocation(line: 2773, column: 57, scope: !1217)
!1232 = !DILocation(line: 2773, column: 41, scope: !1217)
!1233 = !DILocation(line: 2773, column: 36, scope: !1217)
!1234 = !DILocation(line: 2774, column: 21, scope: !1217)
!1235 = !DILocation(line: 2777, column: 28, scope: !1217)
!1236 = !DILocation(line: 2777, column: 43, scope: !1217)
!1237 = !DILocation(line: 2777, column: 53, scope: !1217)
!1238 = !DILocation(line: 2777, column: 74, scope: !1217)
!1239 = !DILocation(line: 2777, column: 58, scope: !1217)
!1240 = !DILocation(line: 2777, column: 79, scope: !1217)
!1241 = !DILocation(line: 2777, column: 91, scope: !1217)
!1242 = !DILocation(line: 2777, column: 26, scope: !1217)
!1243 = !DILocation(line: 2779, column: 57, scope: !1217)
!1244 = !DILocation(line: 2779, column: 41, scope: !1217)
!1245 = !DILocation(line: 2779, column: 36, scope: !1217)
!1246 = !DILocation(line: 2780, column: 17, scope: !1217)
!1247 = !DILocation(line: 2785, column: 13, scope: !1217)
!1248 = !DILocation(line: 2768, column: 93, scope: !1217)
!1249 = distinct !{!1249, !1225, !1247, !673}
!1250 = !DILocation(line: 2786, column: 9, scope: !1217)
!1251 = !DILocation(line: 2788, column: 13, scope: !1217)
!1252 = !DILocation(line: 2788, column: 28, scope: !1217)
!1253 = !DILocation(line: 2791, column: 43, scope: !1217)
!1254 = !DILocation(line: 2791, column: 13, scope: !1217)
!1255 = !DILocation(line: 2791, column: 29, scope: !1217)
!1256 = !DILocation(line: 2791, column: 41, scope: !1217)
!1257 = !DILocation(line: 2792, column: 39, scope: !1217)
!1258 = !DILocation(line: 2792, column: 13, scope: !1217)
!1259 = !DILocation(line: 2792, column: 29, scope: !1217)
!1260 = !DILocation(line: 2792, column: 37, scope: !1217)
!1261 = !DILocation(line: 2795, column: 9, scope: !1217)
!1262 = !DILocation(line: 2796, column: 5, scope: !1217)
!1263 = distinct !DISubprogram(name: "pcQueueGetName", scope: !1, file: !1, line: 2803, type: !8, scopeLine: 2804, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1264 = !DILocation(line: 2806, column: 22, scope: !1263)
!1265 = !DILocation(line: 2813, column: 17, scope: !1263)
!1266 = !DILocation(line: 2813, column: 14, scope: !1263)
!1267 = !DILocation(line: 2813, column: 39, scope: !1263)
!1268 = !DILocation(line: 2813, column: 42, scope: !1263)
!1269 = !DILocation(line: 2813, column: 9, scope: !1263)
!1270 = !DILocation(line: 2815, column: 33, scope: !1263)
!1271 = !DILocation(line: 2815, column: 17, scope: !1263)
!1272 = !DILocation(line: 2815, column: 38, scope: !1263)
!1273 = !DILocation(line: 2815, column: 49, scope: !1263)
!1274 = !DILocation(line: 2815, column: 46, scope: !1263)
!1275 = !DILocation(line: 2817, column: 44, scope: !1263)
!1276 = !DILocation(line: 2817, column: 28, scope: !1263)
!1277 = !DILocation(line: 2817, column: 49, scope: !1263)
!1278 = !DILocation(line: 2817, column: 26, scope: !1263)
!1279 = !DILocation(line: 2818, column: 17, scope: !1263)
!1280 = !DILocation(line: 2824, column: 9, scope: !1263)
!1281 = !DILocation(line: 2813, column: 89, scope: !1263)
!1282 = distinct !{!1282, !1269, !1280, !673}
!1283 = !DILocation(line: 2826, column: 16, scope: !1263)
!1284 = !DILocation(line: 2826, column: 9, scope: !1263)
!1285 = distinct !DISubprogram(name: "vQueueWaitForMessageRestricted", scope: !1, file: !1, line: 2867, type: !8, scopeLine: 2870, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!1286 = !DILocation(line: 2871, column: 35, scope: !1285)
!1287 = !DILocation(line: 2871, column: 25, scope: !1285)
!1288 = !DILocation(line: 2887, column: 9, scope: !1285)
!1289 = !DILocation(line: 2889, column: 13, scope: !1285)
!1290 = !DILocation(line: 2889, column: 22, scope: !1285)
!1291 = !DILocation(line: 2889, column: 40, scope: !1285)
!1292 = !DILocation(line: 2892, column: 49, scope: !1285)
!1293 = !DILocation(line: 2892, column: 58, scope: !1285)
!1294 = !DILocation(line: 2892, column: 84, scope: !1285)
!1295 = !DILocation(line: 2892, column: 98, scope: !1285)
!1296 = !DILocation(line: 2892, column: 13, scope: !1285)
!1297 = !DILocation(line: 2893, column: 9, scope: !1285)
!1298 = !DILocation(line: 2899, column: 25, scope: !1285)
!1299 = !DILocation(line: 2899, column: 9, scope: !1285)
!1300 = !DILocation(line: 2900, column: 5, scope: !1285)
