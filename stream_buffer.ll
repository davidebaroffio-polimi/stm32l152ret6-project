; ModuleID = 'FreeRTOS/Source/stream_buffer.c'
source_filename = "FreeRTOS/Source/stream_buffer.c"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-unknown-eabi"

%struct.StreamBufferDef_t = type { i32, i32, i32, i32, ptr, ptr, ptr, i8, i32 }
%struct.xTIME_OUT = type { i32, i32 }

; Function Attrs: noinline nounwind
define dso_local ptr @xStreamBufferGenericCreate(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 !dbg !7 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 4
  %8 = alloca i8, align 1
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %9 = load i32, ptr %6, align 4, !dbg !10
  %10 = icmp eq i32 %9, 1, !dbg !11
  br i1 %10, label %11, label %12, !dbg !10

11:                                               ; preds = %3
  store i8 1, ptr %8, align 1, !dbg !12
  br label %13, !dbg !13

12:                                               ; preds = %3
  store i8 0, ptr %8, align 1, !dbg !14
  br label %13

13:                                               ; preds = %12, %11
  %14 = load i32, ptr %5, align 4, !dbg !15
  %15 = icmp eq i32 %14, 0, !dbg !16
  br i1 %15, label %16, label %17, !dbg !15

16:                                               ; preds = %13
  store i32 1, ptr %5, align 4, !dbg !17
  br label %17, !dbg !18

17:                                               ; preds = %16, %13
  %18 = load i32, ptr %4, align 4, !dbg !19
  %19 = load i32, ptr %4, align 4, !dbg !20
  %20 = add i32 %19, 1, !dbg !21
  %21 = add i32 %20, 36, !dbg !22
  %22 = icmp ult i32 %18, %21, !dbg !23
  br i1 %22, label %23, label %29, !dbg !19

23:                                               ; preds = %17
  %24 = load i32, ptr %4, align 4, !dbg !24
  %25 = add i32 %24, 1, !dbg !24
  store i32 %25, ptr %4, align 4, !dbg !24
  %26 = load i32, ptr %4, align 4, !dbg !25
  %27 = add i32 %26, 36, !dbg !26
  %28 = call ptr @pvPortMalloc(i32 noundef %27), !dbg !27
  store ptr %28, ptr %7, align 4, !dbg !28
  br label %30, !dbg !29

29:                                               ; preds = %17
  store ptr null, ptr %7, align 4, !dbg !30
  br label %30

30:                                               ; preds = %29, %23
  %31 = load ptr, ptr %7, align 4, !dbg !31
  %32 = icmp ne ptr %31, null, !dbg !32
  br i1 %32, label %33, label %40, !dbg !31

33:                                               ; preds = %30
  %34 = load ptr, ptr %7, align 4, !dbg !33
  %35 = load ptr, ptr %7, align 4, !dbg !34
  %36 = getelementptr inbounds i8, ptr %35, i32 36, !dbg !35
  %37 = load i32, ptr %4, align 4, !dbg !36
  %38 = load i32, ptr %5, align 4, !dbg !37
  %39 = load i8, ptr %8, align 1, !dbg !38
  call void @prvInitialiseNewStreamBuffer(ptr noundef %34, ptr noundef %36, i32 noundef %37, i32 noundef %38, i8 noundef zeroext %39), !dbg !39
  br label %41, !dbg !40

40:                                               ; preds = %30
  br label %41

41:                                               ; preds = %40, %33
  %42 = load ptr, ptr %7, align 4, !dbg !41
  ret ptr %42, !dbg !42
}

declare dso_local ptr @pvPortMalloc(i32 noundef) #1

; Function Attrs: noinline nounwind
define internal void @prvInitialiseNewStreamBuffer(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3, i8 noundef zeroext %4) #0 !dbg !43 {
  %6 = alloca ptr, align 4
  %7 = alloca ptr, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i8, align 1
  store ptr %0, ptr %6, align 4
  store ptr %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  store i8 %4, ptr %10, align 1
  %11 = load ptr, ptr %6, align 4, !dbg !44
  call void @llvm.memset.p0.i32(ptr align 1 %11, i8 0, i32 36, i1 false), !dbg !45
  %12 = load ptr, ptr %7, align 4, !dbg !46
  %13 = load ptr, ptr %6, align 4, !dbg !47
  %14 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %13, i32 0, i32 6, !dbg !48
  store ptr %12, ptr %14, align 4, !dbg !49
  %15 = load i32, ptr %8, align 4, !dbg !50
  %16 = load ptr, ptr %6, align 4, !dbg !51
  %17 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %16, i32 0, i32 2, !dbg !52
  store i32 %15, ptr %17, align 4, !dbg !53
  %18 = load i32, ptr %9, align 4, !dbg !54
  %19 = load ptr, ptr %6, align 4, !dbg !55
  %20 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %19, i32 0, i32 3, !dbg !56
  store i32 %18, ptr %20, align 4, !dbg !57
  %21 = load i8, ptr %10, align 1, !dbg !58
  %22 = load ptr, ptr %6, align 4, !dbg !59
  %23 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %22, i32 0, i32 7, !dbg !60
  store i8 %21, ptr %23, align 4, !dbg !61
  ret void, !dbg !62
}

; Function Attrs: noinline nounwind
define dso_local ptr @xStreamBufferGenericCreateStatic(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3, ptr noundef %4) #0 !dbg !63 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 4
  %10 = alloca ptr, align 4
  %11 = alloca ptr, align 4
  %12 = alloca ptr, align 4
  %13 = alloca i8, align 1
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store ptr %3, ptr %9, align 4
  store ptr %4, ptr %10, align 4
  %14 = load ptr, ptr %10, align 4, !dbg !64
  store ptr %14, ptr %11, align 4, !dbg !65
  %15 = load i32, ptr %7, align 4, !dbg !66
  %16 = icmp eq i32 %15, 0, !dbg !67
  br i1 %16, label %17, label %18, !dbg !66

17:                                               ; preds = %5
  store i32 1, ptr %7, align 4, !dbg !68
  br label %18, !dbg !69

18:                                               ; preds = %17, %5
  %19 = load i32, ptr %8, align 4, !dbg !70
  %20 = icmp ne i32 %19, 0, !dbg !71
  br i1 %20, label %21, label %22, !dbg !70

21:                                               ; preds = %18
  store i8 3, ptr %13, align 1, !dbg !72
  br label %23, !dbg !73

22:                                               ; preds = %18
  store i8 2, ptr %13, align 1, !dbg !74
  br label %23

23:                                               ; preds = %22, %21
  %24 = load ptr, ptr %9, align 4, !dbg !75
  %25 = icmp ne ptr %24, null, !dbg !76
  br i1 %25, label %26, label %42, !dbg !77

26:                                               ; preds = %23
  %27 = load ptr, ptr %10, align 4, !dbg !78
  %28 = icmp ne ptr %27, null, !dbg !79
  br i1 %28, label %29, label %42, !dbg !80

29:                                               ; preds = %26
  %30 = load ptr, ptr %11, align 4, !dbg !81
  %31 = load ptr, ptr %9, align 4, !dbg !82
  %32 = load i32, ptr %6, align 4, !dbg !83
  %33 = load i32, ptr %7, align 4, !dbg !84
  %34 = load i8, ptr %13, align 1, !dbg !85
  call void @prvInitialiseNewStreamBuffer(ptr noundef %30, ptr noundef %31, i32 noundef %32, i32 noundef %33, i8 noundef zeroext %34), !dbg !86
  %35 = load ptr, ptr %11, align 4, !dbg !87
  %36 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %35, i32 0, i32 7, !dbg !88
  %37 = load i8, ptr %36, align 4, !dbg !89
  %38 = zext i8 %37 to i32, !dbg !89
  %39 = or i32 %38, 2, !dbg !89
  %40 = trunc i32 %39 to i8, !dbg !89
  store i8 %40, ptr %36, align 4, !dbg !89
  %41 = load ptr, ptr %10, align 4, !dbg !90
  store ptr %41, ptr %12, align 4, !dbg !91
  br label %43, !dbg !92

42:                                               ; preds = %26, %23
  store ptr null, ptr %12, align 4, !dbg !93
  br label %43

43:                                               ; preds = %42, %29
  %44 = load ptr, ptr %12, align 4, !dbg !94
  ret ptr %44, !dbg !95
}

; Function Attrs: noinline nounwind
define dso_local void @vStreamBufferDelete(ptr noundef %0) #0 !dbg !96 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %4 = load ptr, ptr %2, align 4, !dbg !97
  store ptr %4, ptr %3, align 4, !dbg !98
  %5 = load ptr, ptr %3, align 4, !dbg !99
  %6 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %5, i32 0, i32 7, !dbg !100
  %7 = load i8, ptr %6, align 4, !dbg !100
  %8 = zext i8 %7 to i32, !dbg !99
  %9 = and i32 %8, 2, !dbg !101
  %10 = icmp eq i32 %9, 0, !dbg !102
  br i1 %10, label %11, label %13, !dbg !103

11:                                               ; preds = %1
  %12 = load ptr, ptr %3, align 4, !dbg !104
  call void @vPortFree(ptr noundef %12), !dbg !105
  br label %15, !dbg !106

13:                                               ; preds = %1
  %14 = load ptr, ptr %3, align 4, !dbg !107
  call void @llvm.memset.p0.i32(ptr align 4 %14, i8 0, i32 36, i1 false), !dbg !108
  br label %15

15:                                               ; preds = %13, %11
  ret void, !dbg !109
}

declare dso_local void @vPortFree(ptr noundef) #1

; Function Attrs: argmemonly nocallback nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i32(ptr nocapture writeonly, i8, i32, i1 immarg) #2

; Function Attrs: noinline nounwind
define dso_local i32 @xStreamBufferReset(ptr noundef %0) #0 !dbg !110 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  %6 = load ptr, ptr %2, align 4, !dbg !111
  store ptr %6, ptr %3, align 4, !dbg !112
  store i32 0, ptr %4, align 4, !dbg !113
  %7 = load ptr, ptr %3, align 4, !dbg !114
  %8 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %7, i32 0, i32 8, !dbg !115
  %9 = load i32, ptr %8, align 4, !dbg !115
  store i32 %9, ptr %5, align 4, !dbg !116
  call void @vPortEnterCritical(), !dbg !117
  %10 = load ptr, ptr %3, align 4, !dbg !118
  %11 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %10, i32 0, i32 4, !dbg !119
  %12 = load volatile ptr, ptr %11, align 4, !dbg !119
  %13 = icmp eq ptr %12, null, !dbg !120
  br i1 %13, label %14, label %37, !dbg !118

14:                                               ; preds = %1
  %15 = load ptr, ptr %3, align 4, !dbg !121
  %16 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %15, i32 0, i32 5, !dbg !122
  %17 = load volatile ptr, ptr %16, align 4, !dbg !122
  %18 = icmp eq ptr %17, null, !dbg !123
  br i1 %18, label %19, label %36, !dbg !121

19:                                               ; preds = %14
  %20 = load ptr, ptr %3, align 4, !dbg !124
  %21 = load ptr, ptr %3, align 4, !dbg !125
  %22 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %21, i32 0, i32 6, !dbg !126
  %23 = load ptr, ptr %22, align 4, !dbg !126
  %24 = load ptr, ptr %3, align 4, !dbg !127
  %25 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %24, i32 0, i32 2, !dbg !128
  %26 = load i32, ptr %25, align 4, !dbg !128
  %27 = load ptr, ptr %3, align 4, !dbg !129
  %28 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %27, i32 0, i32 3, !dbg !130
  %29 = load i32, ptr %28, align 4, !dbg !130
  %30 = load ptr, ptr %3, align 4, !dbg !131
  %31 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %30, i32 0, i32 7, !dbg !132
  %32 = load i8, ptr %31, align 4, !dbg !132
  call void @prvInitialiseNewStreamBuffer(ptr noundef %20, ptr noundef %23, i32 noundef %26, i32 noundef %29, i8 noundef zeroext %32), !dbg !133
  store i32 1, ptr %4, align 4, !dbg !134
  %33 = load i32, ptr %5, align 4, !dbg !135
  %34 = load ptr, ptr %3, align 4, !dbg !136
  %35 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %34, i32 0, i32 8, !dbg !137
  store i32 %33, ptr %35, align 4, !dbg !138
  br label %36, !dbg !139

36:                                               ; preds = %19, %14
  br label %37, !dbg !140

37:                                               ; preds = %36, %1
  call void @vPortExitCritical(), !dbg !141
  %38 = load i32, ptr %4, align 4, !dbg !142
  ret i32 %38, !dbg !143
}

declare dso_local void @vPortEnterCritical() #1

declare dso_local void @vPortExitCritical() #1

; Function Attrs: noinline nounwind
define dso_local i32 @xStreamBufferSetTriggerLevel(ptr noundef %0, i32 noundef %1) #0 !dbg !144 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = load ptr, ptr %3, align 4, !dbg !145
  store ptr %7, ptr %5, align 4, !dbg !146
  %8 = load i32, ptr %4, align 4, !dbg !147
  %9 = icmp eq i32 %8, 0, !dbg !148
  br i1 %9, label %10, label %11, !dbg !147

10:                                               ; preds = %2
  store i32 1, ptr %4, align 4, !dbg !149
  br label %11, !dbg !150

11:                                               ; preds = %10, %2
  %12 = load i32, ptr %4, align 4, !dbg !151
  %13 = load ptr, ptr %5, align 4, !dbg !152
  %14 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %13, i32 0, i32 2, !dbg !153
  %15 = load i32, ptr %14, align 4, !dbg !153
  %16 = icmp ult i32 %12, %15, !dbg !154
  br i1 %16, label %17, label %21, !dbg !151

17:                                               ; preds = %11
  %18 = load i32, ptr %4, align 4, !dbg !155
  %19 = load ptr, ptr %5, align 4, !dbg !156
  %20 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %19, i32 0, i32 3, !dbg !157
  store i32 %18, ptr %20, align 4, !dbg !158
  store i32 1, ptr %6, align 4, !dbg !159
  br label %22, !dbg !160

21:                                               ; preds = %11
  store i32 0, ptr %6, align 4, !dbg !161
  br label %22

22:                                               ; preds = %21, %17
  %23 = load i32, ptr %6, align 4, !dbg !162
  ret i32 %23, !dbg !163
}

; Function Attrs: noinline nounwind
define dso_local i32 @xStreamBufferSpacesAvailable(ptr noundef %0) #0 !dbg !164 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  %6 = load ptr, ptr %2, align 4, !dbg !165
  store ptr %6, ptr %3, align 4, !dbg !166
  br label %7, !dbg !167

7:                                                ; preds = %23, %1
  %8 = load ptr, ptr %3, align 4, !dbg !168
  %9 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %8, i32 0, i32 0, !dbg !169
  %10 = load volatile i32, ptr %9, align 4, !dbg !169
  store i32 %10, ptr %5, align 4, !dbg !170
  %11 = load ptr, ptr %3, align 4, !dbg !171
  %12 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %11, i32 0, i32 2, !dbg !172
  %13 = load i32, ptr %12, align 4, !dbg !172
  %14 = load ptr, ptr %3, align 4, !dbg !173
  %15 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %14, i32 0, i32 0, !dbg !174
  %16 = load volatile i32, ptr %15, align 4, !dbg !174
  %17 = add i32 %13, %16, !dbg !175
  store i32 %17, ptr %4, align 4, !dbg !176
  %18 = load ptr, ptr %3, align 4, !dbg !177
  %19 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %18, i32 0, i32 1, !dbg !178
  %20 = load volatile i32, ptr %19, align 4, !dbg !178
  %21 = load i32, ptr %4, align 4, !dbg !179
  %22 = sub i32 %21, %20, !dbg !179
  store i32 %22, ptr %4, align 4, !dbg !179
  br label %23, !dbg !180

23:                                               ; preds = %7
  %24 = load i32, ptr %5, align 4, !dbg !181
  %25 = load ptr, ptr %3, align 4, !dbg !182
  %26 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %25, i32 0, i32 0, !dbg !183
  %27 = load volatile i32, ptr %26, align 4, !dbg !183
  %28 = icmp ne i32 %24, %27, !dbg !184
  br i1 %28, label %7, label %29, !dbg !180, !llvm.loop !185

29:                                               ; preds = %23
  %30 = load i32, ptr %4, align 4, !dbg !188
  %31 = sub i32 %30, 1, !dbg !188
  store i32 %31, ptr %4, align 4, !dbg !188
  %32 = load i32, ptr %4, align 4, !dbg !189
  %33 = load ptr, ptr %3, align 4, !dbg !190
  %34 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %33, i32 0, i32 2, !dbg !191
  %35 = load i32, ptr %34, align 4, !dbg !191
  %36 = icmp uge i32 %32, %35, !dbg !192
  br i1 %36, label %37, label %43, !dbg !189

37:                                               ; preds = %29
  %38 = load ptr, ptr %3, align 4, !dbg !193
  %39 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %38, i32 0, i32 2, !dbg !194
  %40 = load i32, ptr %39, align 4, !dbg !194
  %41 = load i32, ptr %4, align 4, !dbg !195
  %42 = sub i32 %41, %40, !dbg !195
  store i32 %42, ptr %4, align 4, !dbg !195
  br label %44, !dbg !196

43:                                               ; preds = %29
  br label %44

44:                                               ; preds = %43, %37
  %45 = load i32, ptr %4, align 4, !dbg !197
  ret i32 %45, !dbg !198
}

; Function Attrs: noinline nounwind
define dso_local i32 @xStreamBufferBytesAvailable(ptr noundef %0) #0 !dbg !199 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !200
  store ptr %5, ptr %3, align 4, !dbg !201
  %6 = load ptr, ptr %3, align 4, !dbg !202
  %7 = call i32 @prvBytesInBuffer(ptr noundef %6), !dbg !203
  store i32 %7, ptr %4, align 4, !dbg !204
  %8 = load i32, ptr %4, align 4, !dbg !205
  ret i32 %8, !dbg !206
}

; Function Attrs: noinline nounwind
define internal i32 @prvBytesInBuffer(ptr noundef %0) #0 !dbg !207 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  %4 = load ptr, ptr %2, align 4, !dbg !208
  %5 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %4, i32 0, i32 2, !dbg !209
  %6 = load i32, ptr %5, align 4, !dbg !209
  %7 = load ptr, ptr %2, align 4, !dbg !210
  %8 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %7, i32 0, i32 1, !dbg !211
  %9 = load volatile i32, ptr %8, align 4, !dbg !211
  %10 = add i32 %6, %9, !dbg !212
  store i32 %10, ptr %3, align 4, !dbg !213
  %11 = load ptr, ptr %2, align 4, !dbg !214
  %12 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %11, i32 0, i32 0, !dbg !215
  %13 = load volatile i32, ptr %12, align 4, !dbg !215
  %14 = load i32, ptr %3, align 4, !dbg !216
  %15 = sub i32 %14, %13, !dbg !216
  store i32 %15, ptr %3, align 4, !dbg !216
  %16 = load i32, ptr %3, align 4, !dbg !217
  %17 = load ptr, ptr %2, align 4, !dbg !218
  %18 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %17, i32 0, i32 2, !dbg !219
  %19 = load i32, ptr %18, align 4, !dbg !219
  %20 = icmp uge i32 %16, %19, !dbg !220
  br i1 %20, label %21, label %27, !dbg !217

21:                                               ; preds = %1
  %22 = load ptr, ptr %2, align 4, !dbg !221
  %23 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %22, i32 0, i32 2, !dbg !222
  %24 = load i32, ptr %23, align 4, !dbg !222
  %25 = load i32, ptr %3, align 4, !dbg !223
  %26 = sub i32 %25, %24, !dbg !223
  store i32 %26, ptr %3, align 4, !dbg !223
  br label %28, !dbg !224

27:                                               ; preds = %1
  br label %28

28:                                               ; preds = %27, %21
  %29 = load i32, ptr %3, align 4, !dbg !225
  ret i32 %29, !dbg !226
}

; Function Attrs: noinline nounwind
define dso_local i32 @xStreamBufferSend(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 !dbg !227 {
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca %struct.xTIME_OUT, align 4
  %14 = alloca i32, align 4
  store ptr %0, ptr %5, align 4
  store ptr %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %15 = load ptr, ptr %5, align 4, !dbg !228
  store ptr %15, ptr %9, align 4, !dbg !229
  store i32 0, ptr %11, align 4, !dbg !230
  %16 = load i32, ptr %7, align 4, !dbg !231
  store i32 %16, ptr %12, align 4, !dbg !232
  store i32 0, ptr %14, align 4, !dbg !233
  %17 = load ptr, ptr %9, align 4, !dbg !234
  %18 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %17, i32 0, i32 2, !dbg !235
  %19 = load i32, ptr %18, align 4, !dbg !235
  %20 = sub i32 %19, 1, !dbg !236
  store i32 %20, ptr %14, align 4, !dbg !237
  %21 = load ptr, ptr %9, align 4, !dbg !238
  %22 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %21, i32 0, i32 7, !dbg !239
  %23 = load i8, ptr %22, align 4, !dbg !239
  %24 = zext i8 %23 to i32, !dbg !238
  %25 = and i32 %24, 1, !dbg !240
  %26 = icmp ne i32 %25, 0, !dbg !241
  br i1 %26, label %27, label %36, !dbg !242

27:                                               ; preds = %4
  %28 = load i32, ptr %12, align 4, !dbg !243
  %29 = add i32 %28, 4, !dbg !243
  store i32 %29, ptr %12, align 4, !dbg !243
  %30 = load i32, ptr %12, align 4, !dbg !244
  %31 = load i32, ptr %14, align 4, !dbg !245
  %32 = icmp ugt i32 %30, %31, !dbg !246
  br i1 %32, label %33, label %34, !dbg !244

33:                                               ; preds = %27
  store i32 0, ptr %8, align 4, !dbg !247
  br label %35, !dbg !248

34:                                               ; preds = %27
  br label %35

35:                                               ; preds = %34, %33
  br label %44, !dbg !249

36:                                               ; preds = %4
  %37 = load i32, ptr %12, align 4, !dbg !250
  %38 = load i32, ptr %14, align 4, !dbg !251
  %39 = icmp ugt i32 %37, %38, !dbg !252
  br i1 %39, label %40, label %42, !dbg !250

40:                                               ; preds = %36
  %41 = load i32, ptr %14, align 4, !dbg !253
  store i32 %41, ptr %12, align 4, !dbg !254
  br label %43, !dbg !255

42:                                               ; preds = %36
  br label %43

43:                                               ; preds = %42, %40
  br label %44

44:                                               ; preds = %43, %35
  %45 = load i32, ptr %8, align 4, !dbg !256
  %46 = icmp ne i32 %45, 0, !dbg !257
  br i1 %46, label %47, label %69, !dbg !256

47:                                               ; preds = %44
  call void @vTaskSetTimeOutState(ptr noundef %13), !dbg !258
  br label %48, !dbg !259

48:                                               ; preds = %65, %47
  call void @vPortEnterCritical(), !dbg !260
  %49 = load ptr, ptr %9, align 4, !dbg !261
  %50 = call i32 @xStreamBufferSpacesAvailable(ptr noundef %49), !dbg !262
  store i32 %50, ptr %11, align 4, !dbg !263
  %51 = load i32, ptr %11, align 4, !dbg !264
  %52 = load i32, ptr %12, align 4, !dbg !265
  %53 = icmp ult i32 %51, %52, !dbg !266
  br i1 %53, label %54, label %59, !dbg !264

54:                                               ; preds = %48
  %55 = call i32 @xTaskGenericNotifyStateClear(ptr noundef null, i32 noundef 0), !dbg !267
  %56 = call ptr @xTaskGetCurrentTaskHandle(), !dbg !268
  %57 = load ptr, ptr %9, align 4, !dbg !269
  %58 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %57, i32 0, i32 5, !dbg !270
  store volatile ptr %56, ptr %58, align 4, !dbg !271
  br label %60, !dbg !272

59:                                               ; preds = %48
  call void @vPortExitCritical(), !dbg !273
  br label %68, !dbg !274

60:                                               ; preds = %54
  call void @vPortExitCritical(), !dbg !275
  %61 = load i32, ptr %8, align 4, !dbg !276
  %62 = call i32 @xTaskGenericNotifyWait(i32 noundef 0, i32 noundef 0, i32 noundef 0, ptr noundef null, i32 noundef %61), !dbg !276
  %63 = load ptr, ptr %9, align 4, !dbg !277
  %64 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %63, i32 0, i32 5, !dbg !278
  store volatile ptr null, ptr %64, align 4, !dbg !279
  br label %65, !dbg !280

65:                                               ; preds = %60
  %66 = call i32 @xTaskCheckForTimeOut(ptr noundef %13, ptr noundef %8), !dbg !281
  %67 = icmp eq i32 %66, 0, !dbg !282
  br i1 %67, label %48, label %68, !dbg !280, !llvm.loop !283

68:                                               ; preds = %65, %59
  br label %70, !dbg !285

69:                                               ; preds = %44
  br label %70

70:                                               ; preds = %69, %68
  %71 = load i32, ptr %11, align 4, !dbg !286
  %72 = icmp eq i32 %71, 0, !dbg !287
  br i1 %72, label %73, label %76, !dbg !286

73:                                               ; preds = %70
  %74 = load ptr, ptr %9, align 4, !dbg !288
  %75 = call i32 @xStreamBufferSpacesAvailable(ptr noundef %74), !dbg !289
  store i32 %75, ptr %11, align 4, !dbg !290
  br label %77, !dbg !291

76:                                               ; preds = %70
  br label %77

77:                                               ; preds = %76, %73
  %78 = load ptr, ptr %9, align 4, !dbg !292
  %79 = load ptr, ptr %6, align 4, !dbg !293
  %80 = load i32, ptr %7, align 4, !dbg !294
  %81 = load i32, ptr %11, align 4, !dbg !295
  %82 = load i32, ptr %12, align 4, !dbg !296
  %83 = call i32 @prvWriteMessageToBuffer(ptr noundef %78, ptr noundef %79, i32 noundef %80, i32 noundef %81, i32 noundef %82), !dbg !297
  store i32 %83, ptr %10, align 4, !dbg !298
  %84 = load i32, ptr %10, align 4, !dbg !299
  %85 = icmp ugt i32 %84, 0, !dbg !300
  br i1 %85, label %86, label %109, !dbg !299

86:                                               ; preds = %77
  %87 = load ptr, ptr %9, align 4, !dbg !301
  %88 = call i32 @prvBytesInBuffer(ptr noundef %87), !dbg !302
  %89 = load ptr, ptr %9, align 4, !dbg !303
  %90 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %89, i32 0, i32 3, !dbg !304
  %91 = load i32, ptr %90, align 4, !dbg !304
  %92 = icmp uge i32 %88, %91, !dbg !305
  br i1 %92, label %93, label %107, !dbg !302

93:                                               ; preds = %86
  call void @vTaskSuspendAll(), !dbg !306
  %94 = load ptr, ptr %9, align 4, !dbg !306
  %95 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %94, i32 0, i32 4, !dbg !306
  %96 = load volatile ptr, ptr %95, align 4, !dbg !306
  %97 = icmp ne ptr %96, null, !dbg !306
  br i1 %97, label %98, label %105, !dbg !306

98:                                               ; preds = %93
  %99 = load ptr, ptr %9, align 4, !dbg !306
  %100 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %99, i32 0, i32 4, !dbg !306
  %101 = load volatile ptr, ptr %100, align 4, !dbg !306
  %102 = call i32 @xTaskGenericNotify(ptr noundef %101, i32 noundef 0, i32 noundef 0, i32 noundef 0, ptr noundef null), !dbg !306
  %103 = load ptr, ptr %9, align 4, !dbg !306
  %104 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %103, i32 0, i32 4, !dbg !306
  store volatile ptr null, ptr %104, align 4, !dbg !306
  br label %105, !dbg !306

105:                                              ; preds = %98, %93
  %106 = call i32 @xTaskResumeAll(), !dbg !306
  br label %108, !dbg !307

107:                                              ; preds = %86
  br label %108

108:                                              ; preds = %107, %105
  br label %110, !dbg !308

109:                                              ; preds = %77
  br label %110

110:                                              ; preds = %109, %108
  %111 = load i32, ptr %10, align 4, !dbg !309
  ret i32 %111, !dbg !310
}

declare dso_local void @vTaskSetTimeOutState(ptr noundef) #1

declare dso_local i32 @xTaskGenericNotifyStateClear(ptr noundef, i32 noundef) #1

declare dso_local ptr @xTaskGetCurrentTaskHandle() #1

declare dso_local i32 @xTaskGenericNotifyWait(i32 noundef, i32 noundef, i32 noundef, ptr noundef, i32 noundef) #1

declare dso_local i32 @xTaskCheckForTimeOut(ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind
define internal i32 @prvWriteMessageToBuffer(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4) #0 !dbg !311 {
  %6 = alloca ptr, align 4
  %7 = alloca ptr, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %6, align 4
  store ptr %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  %12 = load ptr, ptr %6, align 4, !dbg !312
  %13 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %12, i32 0, i32 1, !dbg !313
  %14 = load volatile i32, ptr %13, align 4, !dbg !313
  store i32 %14, ptr %11, align 4, !dbg !314
  %15 = load ptr, ptr %6, align 4, !dbg !315
  %16 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %15, i32 0, i32 7, !dbg !316
  %17 = load i8, ptr %16, align 4, !dbg !316
  %18 = zext i8 %17 to i32, !dbg !315
  %19 = and i32 %18, 1, !dbg !317
  %20 = icmp ne i32 %19, 0, !dbg !318
  br i1 %20, label %21, label %31, !dbg !319

21:                                               ; preds = %5
  %22 = load i32, ptr %9, align 4, !dbg !320
  %23 = load i32, ptr %10, align 4, !dbg !321
  %24 = icmp uge i32 %22, %23, !dbg !322
  br i1 %24, label %25, label %29, !dbg !320

25:                                               ; preds = %21
  %26 = load ptr, ptr %6, align 4, !dbg !323
  %27 = load i32, ptr %11, align 4, !dbg !324
  %28 = call i32 @prvWriteBytesToBuffer(ptr noundef %26, ptr noundef %8, i32 noundef 4, i32 noundef %27), !dbg !325
  store i32 %28, ptr %11, align 4, !dbg !326
  br label %30, !dbg !327

29:                                               ; preds = %21
  store i32 0, ptr %8, align 4, !dbg !328
  br label %30

30:                                               ; preds = %29, %25
  br label %41, !dbg !329

31:                                               ; preds = %5
  %32 = load i32, ptr %8, align 4, !dbg !330
  %33 = load i32, ptr %9, align 4, !dbg !330
  %34 = icmp ult i32 %32, %33, !dbg !330
  br i1 %34, label %35, label %37, !dbg !330

35:                                               ; preds = %31
  %36 = load i32, ptr %8, align 4, !dbg !330
  br label %39, !dbg !330

37:                                               ; preds = %31
  %38 = load i32, ptr %9, align 4, !dbg !330
  br label %39, !dbg !330

39:                                               ; preds = %37, %35
  %40 = phi i32 [ %36, %35 ], [ %38, %37 ], !dbg !330
  store i32 %40, ptr %8, align 4, !dbg !331
  br label %41

41:                                               ; preds = %39, %30
  %42 = load i32, ptr %8, align 4, !dbg !332
  %43 = icmp ne i32 %42, 0, !dbg !333
  br i1 %43, label %44, label %52, !dbg !332

44:                                               ; preds = %41
  %45 = load ptr, ptr %6, align 4, !dbg !334
  %46 = load ptr, ptr %7, align 4, !dbg !335
  %47 = load i32, ptr %8, align 4, !dbg !336
  %48 = load i32, ptr %11, align 4, !dbg !337
  %49 = call i32 @prvWriteBytesToBuffer(ptr noundef %45, ptr noundef %46, i32 noundef %47, i32 noundef %48), !dbg !338
  %50 = load ptr, ptr %6, align 4, !dbg !339
  %51 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %50, i32 0, i32 1, !dbg !340
  store volatile i32 %49, ptr %51, align 4, !dbg !341
  br label %52, !dbg !342

52:                                               ; preds = %44, %41
  %53 = load i32, ptr %8, align 4, !dbg !343
  ret i32 %53, !dbg !344
}

declare dso_local void @vTaskSuspendAll() #1

declare dso_local i32 @xTaskGenericNotify(ptr noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef) #1

declare dso_local i32 @xTaskResumeAll() #1

; Function Attrs: noinline nounwind
define dso_local i32 @xStreamBufferSendFromISR(ptr noundef %0, ptr noundef %1, i32 noundef %2, ptr noundef %3) #0 !dbg !345 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 4
  %9 = alloca ptr, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 4
  %12 = alloca ptr, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store ptr %0, ptr %8, align 4
  store ptr %1, ptr %9, align 4
  store i32 %2, ptr %10, align 4
  store ptr %3, ptr %11, align 4
  %17 = load ptr, ptr %8, align 4, !dbg !346
  store ptr %17, ptr %12, align 4, !dbg !347
  %18 = load i32, ptr %10, align 4, !dbg !348
  store i32 %18, ptr %15, align 4, !dbg !349
  %19 = load ptr, ptr %12, align 4, !dbg !350
  %20 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %19, i32 0, i32 7, !dbg !351
  %21 = load i8, ptr %20, align 4, !dbg !351
  %22 = zext i8 %21 to i32, !dbg !350
  %23 = and i32 %22, 1, !dbg !352
  %24 = icmp ne i32 %23, 0, !dbg !353
  br i1 %24, label %25, label %28, !dbg !354

25:                                               ; preds = %4
  %26 = load i32, ptr %15, align 4, !dbg !355
  %27 = add i32 %26, 4, !dbg !355
  store i32 %27, ptr %15, align 4, !dbg !355
  br label %29, !dbg !356

28:                                               ; preds = %4
  br label %29

29:                                               ; preds = %28, %25
  %30 = load ptr, ptr %12, align 4, !dbg !357
  %31 = call i32 @xStreamBufferSpacesAvailable(ptr noundef %30), !dbg !358
  store i32 %31, ptr %14, align 4, !dbg !359
  %32 = load ptr, ptr %12, align 4, !dbg !360
  %33 = load ptr, ptr %9, align 4, !dbg !361
  %34 = load i32, ptr %10, align 4, !dbg !362
  %35 = load i32, ptr %14, align 4, !dbg !363
  %36 = load i32, ptr %15, align 4, !dbg !364
  %37 = call i32 @prvWriteMessageToBuffer(ptr noundef %32, ptr noundef %33, i32 noundef %34, i32 noundef %35, i32 noundef %36), !dbg !365
  store i32 %37, ptr %13, align 4, !dbg !366
  %38 = load i32, ptr %13, align 4, !dbg !367
  %39 = icmp ugt i32 %38, 0, !dbg !368
  br i1 %39, label %40, label %69, !dbg !367

40:                                               ; preds = %29
  %41 = load ptr, ptr %12, align 4, !dbg !369
  %42 = call i32 @prvBytesInBuffer(ptr noundef %41), !dbg !370
  %43 = load ptr, ptr %12, align 4, !dbg !371
  %44 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %43, i32 0, i32 3, !dbg !372
  %45 = load i32, ptr %44, align 4, !dbg !372
  %46 = icmp uge i32 %42, %45, !dbg !373
  br i1 %46, label %47, label %67, !dbg !370

47:                                               ; preds = %40
  %48 = call { i32, i32 } asm sideeffect "\09mrs $0, basepri\09\09\09\09\09\09\09\09\09\09\09\0A\09mov $1, $2\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $1\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,=r,i,~{memory}"(i32 80) #4, !dbg !374, !srcloc !378
  %49 = extractvalue { i32, i32 } %48, 0, !dbg !374
  %50 = extractvalue { i32, i32 } %48, 1, !dbg !374
  store i32 %49, ptr %6, align 4, !dbg !374
  store i32 %50, ptr %7, align 4, !dbg !374
  %51 = load i32, ptr %6, align 4, !dbg !379
  store i32 %51, ptr %16, align 4, !dbg !380
  %52 = load ptr, ptr %12, align 4, !dbg !380
  %53 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %52, i32 0, i32 4, !dbg !380
  %54 = load volatile ptr, ptr %53, align 4, !dbg !380
  %55 = icmp ne ptr %54, null, !dbg !380
  br i1 %55, label %56, label %64, !dbg !380

56:                                               ; preds = %47
  %57 = load ptr, ptr %12, align 4, !dbg !380
  %58 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %57, i32 0, i32 4, !dbg !380
  %59 = load volatile ptr, ptr %58, align 4, !dbg !380
  %60 = load ptr, ptr %11, align 4, !dbg !380
  %61 = call i32 @xTaskGenericNotifyFromISR(ptr noundef %59, i32 noundef 0, i32 noundef 0, i32 noundef 0, ptr noundef null, ptr noundef %60), !dbg !380
  %62 = load ptr, ptr %12, align 4, !dbg !380
  %63 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %62, i32 0, i32 4, !dbg !380
  store volatile ptr null, ptr %63, align 4, !dbg !380
  br label %64, !dbg !380

64:                                               ; preds = %56, %47
  %65 = load i32, ptr %16, align 4, !dbg !380
  store i32 %65, ptr %5, align 4
  %66 = load i32, ptr %5, align 4, !dbg !381
  call void asm sideeffect "\09msr basepri, $0\09", "r,~{memory}"(i32 %66) #4, !dbg !384, !srcloc !385
  br label %68, !dbg !386

67:                                               ; preds = %40
  br label %68

68:                                               ; preds = %67, %64
  br label %70, !dbg !387

69:                                               ; preds = %29
  br label %70

70:                                               ; preds = %69, %68
  %71 = load i32, ptr %13, align 4, !dbg !388
  ret i32 %71, !dbg !389
}

declare dso_local i32 @xTaskGenericNotifyFromISR(ptr noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind
define dso_local i32 @xStreamBufferReceive(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 !dbg !390 {
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store ptr %0, ptr %5, align 4
  store ptr %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %13 = load ptr, ptr %5, align 4, !dbg !391
  store ptr %13, ptr %9, align 4, !dbg !392
  store i32 0, ptr %10, align 4, !dbg !393
  %14 = load ptr, ptr %9, align 4, !dbg !394
  %15 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %14, i32 0, i32 7, !dbg !395
  %16 = load i8, ptr %15, align 4, !dbg !395
  %17 = zext i8 %16 to i32, !dbg !394
  %18 = and i32 %17, 1, !dbg !396
  %19 = icmp ne i32 %18, 0, !dbg !397
  br i1 %19, label %20, label %21, !dbg !398

20:                                               ; preds = %4
  store i32 4, ptr %12, align 4, !dbg !399
  br label %22, !dbg !400

21:                                               ; preds = %4
  store i32 0, ptr %12, align 4, !dbg !401
  br label %22

22:                                               ; preds = %21, %20
  %23 = load i32, ptr %8, align 4, !dbg !402
  %24 = icmp ne i32 %23, 0, !dbg !403
  br i1 %24, label %25, label %50, !dbg !402

25:                                               ; preds = %22
  call void @vPortEnterCritical(), !dbg !404
  %26 = load ptr, ptr %9, align 4, !dbg !405
  %27 = call i32 @prvBytesInBuffer(ptr noundef %26), !dbg !406
  store i32 %27, ptr %11, align 4, !dbg !407
  %28 = load i32, ptr %11, align 4, !dbg !408
  %29 = load i32, ptr %12, align 4, !dbg !409
  %30 = icmp ule i32 %28, %29, !dbg !410
  br i1 %30, label %31, label %36, !dbg !408

31:                                               ; preds = %25
  %32 = call i32 @xTaskGenericNotifyStateClear(ptr noundef null, i32 noundef 0), !dbg !411
  %33 = call ptr @xTaskGetCurrentTaskHandle(), !dbg !412
  %34 = load ptr, ptr %9, align 4, !dbg !413
  %35 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %34, i32 0, i32 4, !dbg !414
  store volatile ptr %33, ptr %35, align 4, !dbg !415
  br label %37, !dbg !416

36:                                               ; preds = %25
  br label %37

37:                                               ; preds = %36, %31
  call void @vPortExitCritical(), !dbg !417
  %38 = load i32, ptr %11, align 4, !dbg !418
  %39 = load i32, ptr %12, align 4, !dbg !419
  %40 = icmp ule i32 %38, %39, !dbg !420
  br i1 %40, label %41, label %48, !dbg !418

41:                                               ; preds = %37
  %42 = load i32, ptr %8, align 4, !dbg !421
  %43 = call i32 @xTaskGenericNotifyWait(i32 noundef 0, i32 noundef 0, i32 noundef 0, ptr noundef null, i32 noundef %42), !dbg !421
  %44 = load ptr, ptr %9, align 4, !dbg !422
  %45 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %44, i32 0, i32 4, !dbg !423
  store volatile ptr null, ptr %45, align 4, !dbg !424
  %46 = load ptr, ptr %9, align 4, !dbg !425
  %47 = call i32 @prvBytesInBuffer(ptr noundef %46), !dbg !426
  store i32 %47, ptr %11, align 4, !dbg !427
  br label %49, !dbg !428

48:                                               ; preds = %37
  br label %49

49:                                               ; preds = %48, %41
  br label %53, !dbg !429

50:                                               ; preds = %22
  %51 = load ptr, ptr %9, align 4, !dbg !430
  %52 = call i32 @prvBytesInBuffer(ptr noundef %51), !dbg !431
  store i32 %52, ptr %11, align 4, !dbg !432
  br label %53

53:                                               ; preds = %50, %49
  %54 = load i32, ptr %11, align 4, !dbg !433
  %55 = load i32, ptr %12, align 4, !dbg !434
  %56 = icmp ugt i32 %54, %55, !dbg !435
  br i1 %56, label %57, label %81, !dbg !433

57:                                               ; preds = %53
  %58 = load ptr, ptr %9, align 4, !dbg !436
  %59 = load ptr, ptr %6, align 4, !dbg !437
  %60 = load i32, ptr %7, align 4, !dbg !438
  %61 = load i32, ptr %11, align 4, !dbg !439
  %62 = call i32 @prvReadMessageFromBuffer(ptr noundef %58, ptr noundef %59, i32 noundef %60, i32 noundef %61), !dbg !440
  store i32 %62, ptr %10, align 4, !dbg !441
  %63 = load i32, ptr %10, align 4, !dbg !442
  %64 = icmp ne i32 %63, 0, !dbg !443
  br i1 %64, label %65, label %79, !dbg !442

65:                                               ; preds = %57
  call void @vTaskSuspendAll(), !dbg !444
  %66 = load ptr, ptr %9, align 4, !dbg !444
  %67 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %66, i32 0, i32 5, !dbg !444
  %68 = load volatile ptr, ptr %67, align 4, !dbg !444
  %69 = icmp ne ptr %68, null, !dbg !444
  br i1 %69, label %70, label %77, !dbg !444

70:                                               ; preds = %65
  %71 = load ptr, ptr %9, align 4, !dbg !444
  %72 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %71, i32 0, i32 5, !dbg !444
  %73 = load volatile ptr, ptr %72, align 4, !dbg !444
  %74 = call i32 @xTaskGenericNotify(ptr noundef %73, i32 noundef 0, i32 noundef 0, i32 noundef 0, ptr noundef null), !dbg !444
  %75 = load ptr, ptr %9, align 4, !dbg !444
  %76 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %75, i32 0, i32 5, !dbg !444
  store volatile ptr null, ptr %76, align 4, !dbg !444
  br label %77, !dbg !444

77:                                               ; preds = %70, %65
  %78 = call i32 @xTaskResumeAll(), !dbg !444
  br label %80, !dbg !445

79:                                               ; preds = %57
  br label %80

80:                                               ; preds = %79, %77
  br label %82, !dbg !446

81:                                               ; preds = %53
  br label %82

82:                                               ; preds = %81, %80
  %83 = load i32, ptr %10, align 4, !dbg !447
  ret i32 %83, !dbg !448
}

; Function Attrs: noinline nounwind
define internal i32 @prvReadMessageFromBuffer(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 !dbg !449 {
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store ptr %0, ptr %5, align 4
  store ptr %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %13 = load ptr, ptr %5, align 4, !dbg !450
  %14 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %13, i32 0, i32 0, !dbg !451
  %15 = load volatile i32, ptr %14, align 4, !dbg !451
  store i32 %15, ptr %12, align 4, !dbg !452
  %16 = load ptr, ptr %5, align 4, !dbg !453
  %17 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %16, i32 0, i32 7, !dbg !454
  %18 = load i8, ptr %17, align 4, !dbg !454
  %19 = zext i8 %18 to i32, !dbg !453
  %20 = and i32 %19, 1, !dbg !455
  %21 = icmp ne i32 %20, 0, !dbg !456
  br i1 %21, label %22, label %35, !dbg !457

22:                                               ; preds = %4
  %23 = load ptr, ptr %5, align 4, !dbg !458
  %24 = load i32, ptr %12, align 4, !dbg !459
  %25 = call i32 @prvReadBytesFromBuffer(ptr noundef %23, ptr noundef %11, i32 noundef 4, i32 noundef %24), !dbg !460
  store i32 %25, ptr %12, align 4, !dbg !461
  %26 = load i32, ptr %11, align 4, !dbg !462
  store i32 %26, ptr %10, align 4, !dbg !463
  %27 = load i32, ptr %8, align 4, !dbg !464
  %28 = sub i32 %27, 4, !dbg !464
  store i32 %28, ptr %8, align 4, !dbg !464
  %29 = load i32, ptr %10, align 4, !dbg !465
  %30 = load i32, ptr %7, align 4, !dbg !466
  %31 = icmp ugt i32 %29, %30, !dbg !467
  br i1 %31, label %32, label %33, !dbg !465

32:                                               ; preds = %22
  store i32 0, ptr %10, align 4, !dbg !468
  br label %34, !dbg !469

33:                                               ; preds = %22
  br label %34

34:                                               ; preds = %33, %32
  br label %37, !dbg !470

35:                                               ; preds = %4
  %36 = load i32, ptr %7, align 4, !dbg !471
  store i32 %36, ptr %10, align 4, !dbg !472
  br label %37

37:                                               ; preds = %35, %34
  %38 = load i32, ptr %10, align 4, !dbg !473
  %39 = load i32, ptr %8, align 4, !dbg !473
  %40 = icmp ult i32 %38, %39, !dbg !473
  br i1 %40, label %41, label %43, !dbg !473

41:                                               ; preds = %37
  %42 = load i32, ptr %10, align 4, !dbg !473
  br label %45, !dbg !473

43:                                               ; preds = %37
  %44 = load i32, ptr %8, align 4, !dbg !473
  br label %45, !dbg !473

45:                                               ; preds = %43, %41
  %46 = phi i32 [ %42, %41 ], [ %44, %43 ], !dbg !473
  store i32 %46, ptr %9, align 4, !dbg !474
  %47 = load i32, ptr %9, align 4, !dbg !475
  %48 = icmp ne i32 %47, 0, !dbg !476
  br i1 %48, label %49, label %57, !dbg !475

49:                                               ; preds = %45
  %50 = load ptr, ptr %5, align 4, !dbg !477
  %51 = load ptr, ptr %6, align 4, !dbg !478
  %52 = load i32, ptr %9, align 4, !dbg !479
  %53 = load i32, ptr %12, align 4, !dbg !480
  %54 = call i32 @prvReadBytesFromBuffer(ptr noundef %50, ptr noundef %51, i32 noundef %52, i32 noundef %53), !dbg !481
  %55 = load ptr, ptr %5, align 4, !dbg !482
  %56 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %55, i32 0, i32 0, !dbg !483
  store volatile i32 %54, ptr %56, align 4, !dbg !484
  br label %57, !dbg !485

57:                                               ; preds = %49, %45
  %58 = load i32, ptr %9, align 4, !dbg !486
  ret i32 %58, !dbg !487
}

; Function Attrs: noinline nounwind
define dso_local i32 @xStreamBufferNextMessageLengthBytes(ptr noundef %0) #0 !dbg !488 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  %7 = load ptr, ptr %2, align 4, !dbg !489
  store ptr %7, ptr %3, align 4, !dbg !490
  %8 = load ptr, ptr %3, align 4, !dbg !491
  %9 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %8, i32 0, i32 7, !dbg !492
  %10 = load i8, ptr %9, align 4, !dbg !492
  %11 = zext i8 %10 to i32, !dbg !491
  %12 = and i32 %11, 1, !dbg !493
  %13 = icmp ne i32 %12, 0, !dbg !494
  br i1 %13, label %14, label %28, !dbg !495

14:                                               ; preds = %1
  %15 = load ptr, ptr %3, align 4, !dbg !496
  %16 = call i32 @prvBytesInBuffer(ptr noundef %15), !dbg !497
  store i32 %16, ptr %5, align 4, !dbg !498
  %17 = load i32, ptr %5, align 4, !dbg !499
  %18 = icmp ugt i32 %17, 4, !dbg !500
  br i1 %18, label %19, label %26, !dbg !499

19:                                               ; preds = %14
  %20 = load ptr, ptr %3, align 4, !dbg !501
  %21 = load ptr, ptr %3, align 4, !dbg !502
  %22 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %21, i32 0, i32 0, !dbg !503
  %23 = load volatile i32, ptr %22, align 4, !dbg !503
  %24 = call i32 @prvReadBytesFromBuffer(ptr noundef %20, ptr noundef %6, i32 noundef 4, i32 noundef %23), !dbg !504
  %25 = load i32, ptr %6, align 4, !dbg !505
  store i32 %25, ptr %4, align 4, !dbg !506
  br label %27, !dbg !507

26:                                               ; preds = %14
  store i32 0, ptr %4, align 4, !dbg !508
  br label %27

27:                                               ; preds = %26, %19
  br label %29, !dbg !509

28:                                               ; preds = %1
  store i32 0, ptr %4, align 4, !dbg !510
  br label %29

29:                                               ; preds = %28, %27
  %30 = load i32, ptr %4, align 4, !dbg !511
  ret i32 %30, !dbg !512
}

; Function Attrs: noinline nounwind
define internal i32 @prvReadBytesFromBuffer(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 !dbg !513 {
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %5, align 4
  store ptr %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %10 = load ptr, ptr %5, align 4, !dbg !514
  %11 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %10, i32 0, i32 2, !dbg !514
  %12 = load i32, ptr %11, align 4, !dbg !514
  %13 = load i32, ptr %8, align 4, !dbg !514
  %14 = sub i32 %12, %13, !dbg !514
  %15 = load i32, ptr %7, align 4, !dbg !514
  %16 = icmp ult i32 %14, %15, !dbg !514
  br i1 %16, label %17, label %23, !dbg !514

17:                                               ; preds = %4
  %18 = load ptr, ptr %5, align 4, !dbg !514
  %19 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %18, i32 0, i32 2, !dbg !514
  %20 = load i32, ptr %19, align 4, !dbg !514
  %21 = load i32, ptr %8, align 4, !dbg !514
  %22 = sub i32 %20, %21, !dbg !514
  br label %25, !dbg !514

23:                                               ; preds = %4
  %24 = load i32, ptr %7, align 4, !dbg !514
  br label %25, !dbg !514

25:                                               ; preds = %23, %17
  %26 = phi i32 [ %22, %17 ], [ %24, %23 ], !dbg !514
  store i32 %26, ptr %9, align 4, !dbg !515
  %27 = load ptr, ptr %6, align 4, !dbg !516
  %28 = load ptr, ptr %5, align 4, !dbg !517
  %29 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %28, i32 0, i32 6, !dbg !518
  %30 = load ptr, ptr %29, align 4, !dbg !518
  %31 = load i32, ptr %8, align 4, !dbg !519
  %32 = getelementptr inbounds i8, ptr %30, i32 %31, !dbg !517
  %33 = load i32, ptr %9, align 4, !dbg !520
  call void @llvm.memcpy.p0.p0.i32(ptr align 1 %27, ptr align 1 %32, i32 %33, i1 false), !dbg !521
  %34 = load i32, ptr %7, align 4, !dbg !522
  %35 = load i32, ptr %9, align 4, !dbg !523
  %36 = icmp ugt i32 %34, %35, !dbg !524
  br i1 %36, label %37, label %47, !dbg !522

37:                                               ; preds = %25
  %38 = load ptr, ptr %6, align 4, !dbg !525
  %39 = load i32, ptr %9, align 4, !dbg !526
  %40 = getelementptr inbounds i8, ptr %38, i32 %39, !dbg !525
  %41 = load ptr, ptr %5, align 4, !dbg !527
  %42 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %41, i32 0, i32 6, !dbg !528
  %43 = load ptr, ptr %42, align 4, !dbg !528
  %44 = load i32, ptr %7, align 4, !dbg !529
  %45 = load i32, ptr %9, align 4, !dbg !530
  %46 = sub i32 %44, %45, !dbg !531
  call void @llvm.memcpy.p0.p0.i32(ptr align 1 %40, ptr align 1 %43, i32 %46, i1 false), !dbg !532
  br label %48, !dbg !533

47:                                               ; preds = %25
  br label %48

48:                                               ; preds = %47, %37
  %49 = load i32, ptr %7, align 4, !dbg !534
  %50 = load i32, ptr %8, align 4, !dbg !535
  %51 = add i32 %50, %49, !dbg !535
  store i32 %51, ptr %8, align 4, !dbg !535
  %52 = load i32, ptr %8, align 4, !dbg !536
  %53 = load ptr, ptr %5, align 4, !dbg !537
  %54 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %53, i32 0, i32 2, !dbg !538
  %55 = load i32, ptr %54, align 4, !dbg !538
  %56 = icmp uge i32 %52, %55, !dbg !539
  br i1 %56, label %57, label %63, !dbg !536

57:                                               ; preds = %48
  %58 = load ptr, ptr %5, align 4, !dbg !540
  %59 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %58, i32 0, i32 2, !dbg !541
  %60 = load i32, ptr %59, align 4, !dbg !541
  %61 = load i32, ptr %8, align 4, !dbg !542
  %62 = sub i32 %61, %60, !dbg !542
  store i32 %62, ptr %8, align 4, !dbg !542
  br label %63, !dbg !543

63:                                               ; preds = %57, %48
  %64 = load i32, ptr %8, align 4, !dbg !544
  ret i32 %64, !dbg !545
}

; Function Attrs: noinline nounwind
define dso_local i32 @xStreamBufferReceiveFromISR(ptr noundef %0, ptr noundef %1, i32 noundef %2, ptr noundef %3) #0 !dbg !546 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 4
  %9 = alloca ptr, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 4
  %12 = alloca ptr, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store ptr %0, ptr %8, align 4
  store ptr %1, ptr %9, align 4
  store i32 %2, ptr %10, align 4
  store ptr %3, ptr %11, align 4
  %17 = load ptr, ptr %8, align 4, !dbg !547
  store ptr %17, ptr %12, align 4, !dbg !548
  store i32 0, ptr %13, align 4, !dbg !549
  %18 = load ptr, ptr %12, align 4, !dbg !550
  %19 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %18, i32 0, i32 7, !dbg !551
  %20 = load i8, ptr %19, align 4, !dbg !551
  %21 = zext i8 %20 to i32, !dbg !550
  %22 = and i32 %21, 1, !dbg !552
  %23 = icmp ne i32 %22, 0, !dbg !553
  br i1 %23, label %24, label %25, !dbg !554

24:                                               ; preds = %4
  store i32 4, ptr %15, align 4, !dbg !555
  br label %26, !dbg !556

25:                                               ; preds = %4
  store i32 0, ptr %15, align 4, !dbg !557
  br label %26

26:                                               ; preds = %25, %24
  %27 = load ptr, ptr %12, align 4, !dbg !558
  %28 = call i32 @prvBytesInBuffer(ptr noundef %27), !dbg !559
  store i32 %28, ptr %14, align 4, !dbg !560
  %29 = load i32, ptr %14, align 4, !dbg !561
  %30 = load i32, ptr %15, align 4, !dbg !562
  %31 = icmp ugt i32 %29, %30, !dbg !563
  br i1 %31, label %32, label %62, !dbg !561

32:                                               ; preds = %26
  %33 = load ptr, ptr %12, align 4, !dbg !564
  %34 = load ptr, ptr %9, align 4, !dbg !565
  %35 = load i32, ptr %10, align 4, !dbg !566
  %36 = load i32, ptr %14, align 4, !dbg !567
  %37 = call i32 @prvReadMessageFromBuffer(ptr noundef %33, ptr noundef %34, i32 noundef %35, i32 noundef %36), !dbg !568
  store i32 %37, ptr %13, align 4, !dbg !569
  %38 = load i32, ptr %13, align 4, !dbg !570
  %39 = icmp ne i32 %38, 0, !dbg !571
  br i1 %39, label %40, label %60, !dbg !570

40:                                               ; preds = %32
  %41 = call { i32, i32 } asm sideeffect "\09mrs $0, basepri\09\09\09\09\09\09\09\09\09\09\09\0A\09mov $1, $2\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $1\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,=r,i,~{memory}"(i32 80) #4, !dbg !572, !srcloc !378
  %42 = extractvalue { i32, i32 } %41, 0, !dbg !572
  %43 = extractvalue { i32, i32 } %41, 1, !dbg !572
  store i32 %42, ptr %6, align 4, !dbg !572
  store i32 %43, ptr %7, align 4, !dbg !572
  %44 = load i32, ptr %6, align 4, !dbg !574
  store i32 %44, ptr %16, align 4, !dbg !575
  %45 = load ptr, ptr %12, align 4, !dbg !575
  %46 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %45, i32 0, i32 5, !dbg !575
  %47 = load volatile ptr, ptr %46, align 4, !dbg !575
  %48 = icmp ne ptr %47, null, !dbg !575
  br i1 %48, label %49, label %57, !dbg !575

49:                                               ; preds = %40
  %50 = load ptr, ptr %12, align 4, !dbg !575
  %51 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %50, i32 0, i32 5, !dbg !575
  %52 = load volatile ptr, ptr %51, align 4, !dbg !575
  %53 = load ptr, ptr %11, align 4, !dbg !575
  %54 = call i32 @xTaskGenericNotifyFromISR(ptr noundef %52, i32 noundef 0, i32 noundef 0, i32 noundef 0, ptr noundef null, ptr noundef %53), !dbg !575
  %55 = load ptr, ptr %12, align 4, !dbg !575
  %56 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %55, i32 0, i32 5, !dbg !575
  store volatile ptr null, ptr %56, align 4, !dbg !575
  br label %57, !dbg !575

57:                                               ; preds = %49, %40
  %58 = load i32, ptr %16, align 4, !dbg !575
  store i32 %58, ptr %5, align 4
  %59 = load i32, ptr %5, align 4, !dbg !576
  call void asm sideeffect "\09msr basepri, $0\09", "r,~{memory}"(i32 %59) #4, !dbg !578, !srcloc !385
  br label %61, !dbg !579

60:                                               ; preds = %32
  br label %61

61:                                               ; preds = %60, %57
  br label %63, !dbg !580

62:                                               ; preds = %26
  br label %63

63:                                               ; preds = %62, %61
  %64 = load i32, ptr %13, align 4, !dbg !581
  ret i32 %64, !dbg !582
}

; Function Attrs: noinline nounwind
define dso_local i32 @xStreamBufferIsEmpty(ptr noundef %0) #0 !dbg !583 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  %6 = load ptr, ptr %2, align 4, !dbg !584
  store ptr %6, ptr %3, align 4, !dbg !585
  %7 = load ptr, ptr %3, align 4, !dbg !586
  %8 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %7, i32 0, i32 0, !dbg !587
  %9 = load volatile i32, ptr %8, align 4, !dbg !587
  store i32 %9, ptr %5, align 4, !dbg !588
  %10 = load ptr, ptr %3, align 4, !dbg !589
  %11 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %10, i32 0, i32 1, !dbg !590
  %12 = load volatile i32, ptr %11, align 4, !dbg !590
  %13 = load i32, ptr %5, align 4, !dbg !591
  %14 = icmp eq i32 %12, %13, !dbg !592
  br i1 %14, label %15, label %16, !dbg !589

15:                                               ; preds = %1
  store i32 1, ptr %4, align 4, !dbg !593
  br label %17, !dbg !594

16:                                               ; preds = %1
  store i32 0, ptr %4, align 4, !dbg !595
  br label %17

17:                                               ; preds = %16, %15
  %18 = load i32, ptr %4, align 4, !dbg !596
  ret i32 %18, !dbg !597
}

; Function Attrs: noinline nounwind
define dso_local i32 @xStreamBufferIsFull(ptr noundef %0) #0 !dbg !598 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %6 = load ptr, ptr %2, align 4, !dbg !599
  store ptr %6, ptr %5, align 4, !dbg !600
  %7 = load ptr, ptr %5, align 4, !dbg !601
  %8 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %7, i32 0, i32 7, !dbg !602
  %9 = load i8, ptr %8, align 4, !dbg !602
  %10 = zext i8 %9 to i32, !dbg !601
  %11 = and i32 %10, 1, !dbg !603
  %12 = icmp ne i32 %11, 0, !dbg !604
  br i1 %12, label %13, label %14, !dbg !605

13:                                               ; preds = %1
  store i32 4, ptr %4, align 4, !dbg !606
  br label %15, !dbg !607

14:                                               ; preds = %1
  store i32 0, ptr %4, align 4, !dbg !608
  br label %15

15:                                               ; preds = %14, %13
  %16 = load ptr, ptr %2, align 4, !dbg !609
  %17 = call i32 @xStreamBufferSpacesAvailable(ptr noundef %16), !dbg !610
  %18 = load i32, ptr %4, align 4, !dbg !611
  %19 = icmp ule i32 %17, %18, !dbg !612
  br i1 %19, label %20, label %21, !dbg !610

20:                                               ; preds = %15
  store i32 1, ptr %3, align 4, !dbg !613
  br label %22, !dbg !614

21:                                               ; preds = %15
  store i32 0, ptr %3, align 4, !dbg !615
  br label %22

22:                                               ; preds = %21, %20
  %23 = load i32, ptr %3, align 4, !dbg !616
  ret i32 %23, !dbg !617
}

; Function Attrs: noinline nounwind
define dso_local i32 @xStreamBufferSendCompletedFromISR(ptr noundef %0, ptr noundef %1) #0 !dbg !618 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 4
  %7 = alloca ptr, align 4
  %8 = alloca ptr, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store ptr %0, ptr %6, align 4
  store ptr %1, ptr %7, align 4
  %11 = load ptr, ptr %6, align 4, !dbg !619
  store ptr %11, ptr %8, align 4, !dbg !620
  %12 = call { i32, i32 } asm sideeffect "\09mrs $0, basepri\09\09\09\09\09\09\09\09\09\09\09\0A\09mov $1, $2\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $1\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,=r,i,~{memory}"(i32 80) #4, !dbg !621, !srcloc !378
  %13 = extractvalue { i32, i32 } %12, 0, !dbg !621
  %14 = extractvalue { i32, i32 } %12, 1, !dbg !621
  store i32 %13, ptr %4, align 4, !dbg !621
  store i32 %14, ptr %5, align 4, !dbg !621
  %15 = load i32, ptr %4, align 4, !dbg !623
  store i32 %15, ptr %10, align 4, !dbg !624
  %16 = load ptr, ptr %8, align 4, !dbg !625
  %17 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %16, i32 0, i32 4, !dbg !626
  %18 = load volatile ptr, ptr %17, align 4, !dbg !626
  %19 = icmp ne ptr %18, null, !dbg !627
  br i1 %19, label %20, label %28, !dbg !628

20:                                               ; preds = %2
  %21 = load ptr, ptr %8, align 4, !dbg !629
  %22 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %21, i32 0, i32 4, !dbg !629
  %23 = load volatile ptr, ptr %22, align 4, !dbg !629
  %24 = load ptr, ptr %7, align 4, !dbg !629
  %25 = call i32 @xTaskGenericNotifyFromISR(ptr noundef %23, i32 noundef 0, i32 noundef 0, i32 noundef 0, ptr noundef null, ptr noundef %24), !dbg !629
  %26 = load ptr, ptr %8, align 4, !dbg !630
  %27 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %26, i32 0, i32 4, !dbg !631
  store volatile ptr null, ptr %27, align 4, !dbg !632
  store i32 1, ptr %9, align 4, !dbg !633
  br label %29, !dbg !634

28:                                               ; preds = %2
  store i32 0, ptr %9, align 4, !dbg !635
  br label %29

29:                                               ; preds = %28, %20
  %30 = load i32, ptr %10, align 4, !dbg !636
  store i32 %30, ptr %3, align 4
  %31 = load i32, ptr %3, align 4, !dbg !637
  call void asm sideeffect "\09msr basepri, $0\09", "r,~{memory}"(i32 %31) #4, !dbg !639, !srcloc !385
  %32 = load i32, ptr %9, align 4, !dbg !640
  ret i32 %32, !dbg !641
}

; Function Attrs: noinline nounwind
define dso_local i32 @xStreamBufferReceiveCompletedFromISR(ptr noundef %0, ptr noundef %1) #0 !dbg !642 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 4
  %7 = alloca ptr, align 4
  %8 = alloca ptr, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store ptr %0, ptr %6, align 4
  store ptr %1, ptr %7, align 4
  %11 = load ptr, ptr %6, align 4, !dbg !643
  store ptr %11, ptr %8, align 4, !dbg !644
  %12 = call { i32, i32 } asm sideeffect "\09mrs $0, basepri\09\09\09\09\09\09\09\09\09\09\09\0A\09mov $1, $2\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $1\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,=r,i,~{memory}"(i32 80) #4, !dbg !645, !srcloc !378
  %13 = extractvalue { i32, i32 } %12, 0, !dbg !645
  %14 = extractvalue { i32, i32 } %12, 1, !dbg !645
  store i32 %13, ptr %4, align 4, !dbg !645
  store i32 %14, ptr %5, align 4, !dbg !645
  %15 = load i32, ptr %4, align 4, !dbg !647
  store i32 %15, ptr %10, align 4, !dbg !648
  %16 = load ptr, ptr %8, align 4, !dbg !649
  %17 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %16, i32 0, i32 5, !dbg !650
  %18 = load volatile ptr, ptr %17, align 4, !dbg !650
  %19 = icmp ne ptr %18, null, !dbg !651
  br i1 %19, label %20, label %28, !dbg !652

20:                                               ; preds = %2
  %21 = load ptr, ptr %8, align 4, !dbg !653
  %22 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %21, i32 0, i32 5, !dbg !653
  %23 = load volatile ptr, ptr %22, align 4, !dbg !653
  %24 = load ptr, ptr %7, align 4, !dbg !653
  %25 = call i32 @xTaskGenericNotifyFromISR(ptr noundef %23, i32 noundef 0, i32 noundef 0, i32 noundef 0, ptr noundef null, ptr noundef %24), !dbg !653
  %26 = load ptr, ptr %8, align 4, !dbg !654
  %27 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %26, i32 0, i32 5, !dbg !655
  store volatile ptr null, ptr %27, align 4, !dbg !656
  store i32 1, ptr %9, align 4, !dbg !657
  br label %29, !dbg !658

28:                                               ; preds = %2
  store i32 0, ptr %9, align 4, !dbg !659
  br label %29

29:                                               ; preds = %28, %20
  %30 = load i32, ptr %10, align 4, !dbg !660
  store i32 %30, ptr %3, align 4
  %31 = load i32, ptr %3, align 4, !dbg !661
  call void asm sideeffect "\09msr basepri, $0\09", "r,~{memory}"(i32 %31) #4, !dbg !663, !srcloc !385
  %32 = load i32, ptr %9, align 4, !dbg !664
  ret i32 %32, !dbg !665
}

; Function Attrs: noinline nounwind
define dso_local i32 @uxStreamBufferGetStreamBufferNumber(ptr noundef %0) #0 !dbg !666 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %3 = load ptr, ptr %2, align 4, !dbg !667
  %4 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %3, i32 0, i32 8, !dbg !668
  %5 = load i32, ptr %4, align 4, !dbg !668
  ret i32 %5, !dbg !669
}

; Function Attrs: noinline nounwind
define dso_local void @vStreamBufferSetStreamBufferNumber(ptr noundef %0, i32 noundef %1) #0 !dbg !670 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %4, align 4, !dbg !671
  %6 = load ptr, ptr %3, align 4, !dbg !672
  %7 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %6, i32 0, i32 8, !dbg !673
  store i32 %5, ptr %7, align 4, !dbg !674
  ret void, !dbg !675
}

; Function Attrs: noinline nounwind
define dso_local zeroext i8 @ucStreamBufferGetStreamBufferType(ptr noundef %0) #0 !dbg !676 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %3 = load ptr, ptr %2, align 4, !dbg !677
  %4 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %3, i32 0, i32 7, !dbg !678
  %5 = load i8, ptr %4, align 4, !dbg !678
  %6 = zext i8 %5 to i32, !dbg !677
  %7 = and i32 %6, 1, !dbg !679
  %8 = trunc i32 %7 to i8, !dbg !680
  ret i8 %8, !dbg !681
}

; Function Attrs: noinline nounwind
define internal i32 @prvWriteBytesToBuffer(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 !dbg !682 {
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %5, align 4
  store ptr %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %10 = load ptr, ptr %5, align 4, !dbg !683
  %11 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %10, i32 0, i32 2, !dbg !683
  %12 = load i32, ptr %11, align 4, !dbg !683
  %13 = load i32, ptr %8, align 4, !dbg !683
  %14 = sub i32 %12, %13, !dbg !683
  %15 = load i32, ptr %7, align 4, !dbg !683
  %16 = icmp ult i32 %14, %15, !dbg !683
  br i1 %16, label %17, label %23, !dbg !683

17:                                               ; preds = %4
  %18 = load ptr, ptr %5, align 4, !dbg !683
  %19 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %18, i32 0, i32 2, !dbg !683
  %20 = load i32, ptr %19, align 4, !dbg !683
  %21 = load i32, ptr %8, align 4, !dbg !683
  %22 = sub i32 %20, %21, !dbg !683
  br label %25, !dbg !683

23:                                               ; preds = %4
  %24 = load i32, ptr %7, align 4, !dbg !683
  br label %25, !dbg !683

25:                                               ; preds = %23, %17
  %26 = phi i32 [ %22, %17 ], [ %24, %23 ], !dbg !683
  store i32 %26, ptr %9, align 4, !dbg !684
  %27 = load ptr, ptr %5, align 4, !dbg !685
  %28 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %27, i32 0, i32 6, !dbg !686
  %29 = load ptr, ptr %28, align 4, !dbg !686
  %30 = load i32, ptr %8, align 4, !dbg !687
  %31 = getelementptr inbounds i8, ptr %29, i32 %30, !dbg !685
  %32 = load ptr, ptr %6, align 4, !dbg !688
  %33 = load i32, ptr %9, align 4, !dbg !689
  call void @llvm.memcpy.p0.p0.i32(ptr align 1 %31, ptr align 1 %32, i32 %33, i1 false), !dbg !690
  %34 = load i32, ptr %7, align 4, !dbg !691
  %35 = load i32, ptr %9, align 4, !dbg !692
  %36 = icmp ugt i32 %34, %35, !dbg !693
  br i1 %36, label %37, label %47, !dbg !691

37:                                               ; preds = %25
  %38 = load ptr, ptr %5, align 4, !dbg !694
  %39 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %38, i32 0, i32 6, !dbg !695
  %40 = load ptr, ptr %39, align 4, !dbg !695
  %41 = load ptr, ptr %6, align 4, !dbg !696
  %42 = load i32, ptr %9, align 4, !dbg !697
  %43 = getelementptr inbounds i8, ptr %41, i32 %42, !dbg !696
  %44 = load i32, ptr %7, align 4, !dbg !698
  %45 = load i32, ptr %9, align 4, !dbg !699
  %46 = sub i32 %44, %45, !dbg !700
  call void @llvm.memcpy.p0.p0.i32(ptr align 1 %40, ptr align 1 %43, i32 %46, i1 false), !dbg !701
  br label %48, !dbg !702

47:                                               ; preds = %25
  br label %48

48:                                               ; preds = %47, %37
  %49 = load i32, ptr %7, align 4, !dbg !703
  %50 = load i32, ptr %8, align 4, !dbg !704
  %51 = add i32 %50, %49, !dbg !704
  store i32 %51, ptr %8, align 4, !dbg !704
  %52 = load i32, ptr %8, align 4, !dbg !705
  %53 = load ptr, ptr %5, align 4, !dbg !706
  %54 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %53, i32 0, i32 2, !dbg !707
  %55 = load i32, ptr %54, align 4, !dbg !707
  %56 = icmp uge i32 %52, %55, !dbg !708
  br i1 %56, label %57, label %63, !dbg !705

57:                                               ; preds = %48
  %58 = load ptr, ptr %5, align 4, !dbg !709
  %59 = getelementptr inbounds %struct.StreamBufferDef_t, ptr %58, i32 0, i32 2, !dbg !710
  %60 = load i32, ptr %59, align 4, !dbg !710
  %61 = load i32, ptr %8, align 4, !dbg !711
  %62 = sub i32 %61, %60, !dbg !711
  store i32 %62, ptr %8, align 4, !dbg !711
  br label %64, !dbg !712

63:                                               ; preds = %48
  br label %64

64:                                               ; preds = %63, %57
  %65 = load i32, ptr %8, align 4, !dbg !713
  ret i32 %65, !dbg !714
}

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i32(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i32, i1 immarg) #3

attributes #0 = { noinline nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #2 = { argmemonly nocallback nofree nounwind willreturn writeonly }
attributes #3 = { argmemonly nocallback nofree nounwind willreturn }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "FreeRTOS/Source/stream_buffer.c", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 1, !"min_enum_size", i32 4}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{!"clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)"}
!7 = distinct !DISubprogram(name: "xStreamBufferGenericCreate", scope: !1, file: !1, line: 235, type: !8, scopeLine: 238, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!8 = !DISubroutineType(types: !9)
!9 = !{}
!10 = !DILocation(line: 246, column: 13, scope: !7)
!11 = !DILocation(line: 246, column: 30, scope: !7)
!12 = !DILocation(line: 249, column: 21, scope: !7)
!13 = !DILocation(line: 251, column: 9, scope: !7)
!14 = !DILocation(line: 255, column: 21, scope: !7)
!15 = !DILocation(line: 263, column: 13, scope: !7)
!16 = !DILocation(line: 263, column: 32, scope: !7)
!17 = !DILocation(line: 265, column: 32, scope: !7)
!18 = !DILocation(line: 266, column: 9, scope: !7)
!19 = !DILocation(line: 276, column: 13, scope: !7)
!20 = !DILocation(line: 276, column: 34, scope: !7)
!21 = !DILocation(line: 276, column: 51, scope: !7)
!22 = !DILocation(line: 276, column: 55, scope: !7)
!23 = !DILocation(line: 276, column: 30, scope: !7)
!24 = !DILocation(line: 278, column: 29, scope: !7)
!25 = !DILocation(line: 279, column: 62, scope: !7)
!26 = !DILocation(line: 279, column: 79, scope: !7)
!27 = !DILocation(line: 279, column: 48, scope: !7)
!28 = !DILocation(line: 279, column: 32, scope: !7)
!29 = !DILocation(line: 280, column: 9, scope: !7)
!30 = !DILocation(line: 283, column: 32, scope: !7)
!31 = !DILocation(line: 286, column: 13, scope: !7)
!32 = !DILocation(line: 286, column: 32, scope: !7)
!33 = !DILocation(line: 288, column: 64, scope: !7)
!34 = !DILocation(line: 289, column: 43, scope: !7)
!35 = !DILocation(line: 289, column: 62, scope: !7)
!36 = !DILocation(line: 290, column: 43, scope: !7)
!37 = !DILocation(line: 291, column: 43, scope: !7)
!38 = !DILocation(line: 292, column: 43, scope: !7)
!39 = !DILocation(line: 288, column: 13, scope: !7)
!40 = !DILocation(line: 295, column: 9, scope: !7)
!41 = !DILocation(line: 301, column: 41, scope: !7)
!42 = !DILocation(line: 301, column: 9, scope: !7)
!43 = distinct !DISubprogram(name: "prvInitialiseNewStreamBuffer", scope: !1, file: !1, line: 1252, type: !8, scopeLine: 1257, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!44 = !DILocation(line: 1271, column: 33, scope: !43)
!45 = !DILocation(line: 1271, column: 14, scope: !43)
!46 = !DILocation(line: 1272, column: 33, scope: !43)
!47 = !DILocation(line: 1272, column: 5, scope: !43)
!48 = !DILocation(line: 1272, column: 21, scope: !43)
!49 = !DILocation(line: 1272, column: 31, scope: !43)
!50 = !DILocation(line: 1273, column: 31, scope: !43)
!51 = !DILocation(line: 1273, column: 5, scope: !43)
!52 = !DILocation(line: 1273, column: 21, scope: !43)
!53 = !DILocation(line: 1273, column: 29, scope: !43)
!54 = !DILocation(line: 1274, column: 42, scope: !43)
!55 = !DILocation(line: 1274, column: 5, scope: !43)
!56 = !DILocation(line: 1274, column: 21, scope: !43)
!57 = !DILocation(line: 1274, column: 40, scope: !43)
!58 = !DILocation(line: 1275, column: 31, scope: !43)
!59 = !DILocation(line: 1275, column: 5, scope: !43)
!60 = !DILocation(line: 1275, column: 21, scope: !43)
!61 = !DILocation(line: 1275, column: 29, scope: !43)
!62 = !DILocation(line: 1276, column: 1, scope: !43)
!63 = distinct !DISubprogram(name: "xStreamBufferGenericCreateStatic", scope: !1, file: !1, line: 309, type: !8, scopeLine: 314, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!64 = !DILocation(line: 315, column: 70, scope: !63)
!65 = !DILocation(line: 315, column: 32, scope: !63)
!66 = !DILocation(line: 325, column: 13, scope: !63)
!67 = !DILocation(line: 325, column: 32, scope: !63)
!68 = !DILocation(line: 327, column: 32, scope: !63)
!69 = !DILocation(line: 328, column: 9, scope: !63)
!70 = !DILocation(line: 330, column: 13, scope: !63)
!71 = !DILocation(line: 330, column: 30, scope: !63)
!72 = !DILocation(line: 333, column: 21, scope: !63)
!73 = !DILocation(line: 334, column: 9, scope: !63)
!74 = !DILocation(line: 338, column: 21, scope: !63)
!75 = !DILocation(line: 357, column: 15, scope: !63)
!76 = !DILocation(line: 357, column: 42, scope: !63)
!77 = !DILocation(line: 357, column: 52, scope: !63)
!78 = !DILocation(line: 357, column: 57, scope: !63)
!79 = !DILocation(line: 357, column: 78, scope: !63)
!80 = !DILocation(line: 357, column: 13, scope: !63)
!81 = !DILocation(line: 359, column: 43, scope: !63)
!82 = !DILocation(line: 360, column: 43, scope: !63)
!83 = !DILocation(line: 361, column: 43, scope: !63)
!84 = !DILocation(line: 362, column: 43, scope: !63)
!85 = !DILocation(line: 363, column: 43, scope: !63)
!86 = !DILocation(line: 359, column: 13, scope: !63)
!87 = !DILocation(line: 367, column: 13, scope: !63)
!88 = !DILocation(line: 367, column: 29, scope: !63)
!89 = !DILocation(line: 367, column: 37, scope: !63)
!90 = !DILocation(line: 371, column: 48, scope: !63)
!91 = !DILocation(line: 371, column: 21, scope: !63)
!92 = !DILocation(line: 372, column: 9, scope: !63)
!93 = !DILocation(line: 375, column: 21, scope: !63)
!94 = !DILocation(line: 379, column: 16, scope: !63)
!95 = !DILocation(line: 379, column: 9, scope: !63)
!96 = distinct !DISubprogram(name: "vStreamBufferDelete", scope: !1, file: !1, line: 385, type: !8, scopeLine: 386, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!97 = !DILocation(line: 387, column: 39, scope: !96)
!98 = !DILocation(line: 387, column: 22, scope: !96)
!99 = !DILocation(line: 393, column: 11, scope: !96)
!100 = !DILocation(line: 393, column: 27, scope: !96)
!101 = !DILocation(line: 393, column: 35, scope: !96)
!102 = !DILocation(line: 393, column: 71, scope: !96)
!103 = !DILocation(line: 393, column: 9, scope: !96)
!104 = !DILocation(line: 399, column: 39, scope: !96)
!105 = !DILocation(line: 399, column: 17, scope: !96)
!106 = !DILocation(line: 408, column: 5, scope: !96)
!107 = !DILocation(line: 413, column: 26, scope: !96)
!108 = !DILocation(line: 413, column: 18, scope: !96)
!109 = !DILocation(line: 415, column: 1, scope: !96)
!110 = distinct !DISubprogram(name: "xStreamBufferReset", scope: !1, file: !1, line: 418, type: !8, scopeLine: 419, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!111 = !DILocation(line: 420, column: 45, scope: !110)
!112 = !DILocation(line: 420, column: 28, scope: !110)
!113 = !DILocation(line: 421, column: 16, scope: !110)
!114 = !DILocation(line: 433, column: 36, scope: !110)
!115 = !DILocation(line: 433, column: 52, scope: !110)
!116 = !DILocation(line: 433, column: 34, scope: !110)
!117 = !DILocation(line: 438, column: 5, scope: !110)
!118 = !DILocation(line: 440, column: 13, scope: !110)
!119 = !DILocation(line: 440, column: 29, scope: !110)
!120 = !DILocation(line: 440, column: 51, scope: !110)
!121 = !DILocation(line: 442, column: 17, scope: !110)
!122 = !DILocation(line: 442, column: 33, scope: !110)
!123 = !DILocation(line: 442, column: 52, scope: !110)
!124 = !DILocation(line: 444, column: 47, scope: !110)
!125 = !DILocation(line: 445, column: 47, scope: !110)
!126 = !DILocation(line: 445, column: 63, scope: !110)
!127 = !DILocation(line: 446, column: 47, scope: !110)
!128 = !DILocation(line: 446, column: 63, scope: !110)
!129 = !DILocation(line: 447, column: 47, scope: !110)
!130 = !DILocation(line: 447, column: 63, scope: !110)
!131 = !DILocation(line: 448, column: 47, scope: !110)
!132 = !DILocation(line: 448, column: 63, scope: !110)
!133 = !DILocation(line: 444, column: 17, scope: !110)
!134 = !DILocation(line: 449, column: 25, scope: !110)
!135 = !DILocation(line: 453, column: 64, scope: !110)
!136 = !DILocation(line: 453, column: 25, scope: !110)
!137 = !DILocation(line: 453, column: 41, scope: !110)
!138 = !DILocation(line: 453, column: 62, scope: !110)
!139 = !DILocation(line: 458, column: 13, scope: !110)
!140 = !DILocation(line: 459, column: 9, scope: !110)
!141 = !DILocation(line: 461, column: 5, scope: !110)
!142 = !DILocation(line: 463, column: 12, scope: !110)
!143 = !DILocation(line: 463, column: 5, scope: !110)
!144 = distinct !DISubprogram(name: "xStreamBufferSetTriggerLevel", scope: !1, file: !1, line: 467, type: !8, scopeLine: 469, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!145 = !DILocation(line: 470, column: 45, scope: !144)
!146 = !DILocation(line: 470, column: 28, scope: !144)
!147 = !DILocation(line: 476, column: 9, scope: !144)
!148 = !DILocation(line: 476, column: 23, scope: !144)
!149 = !DILocation(line: 478, column: 23, scope: !144)
!150 = !DILocation(line: 479, column: 5, scope: !144)
!151 = !DILocation(line: 483, column: 9, scope: !144)
!152 = !DILocation(line: 483, column: 25, scope: !144)
!153 = !DILocation(line: 483, column: 41, scope: !144)
!154 = !DILocation(line: 483, column: 23, scope: !144)
!155 = !DILocation(line: 485, column: 46, scope: !144)
!156 = !DILocation(line: 485, column: 9, scope: !144)
!157 = !DILocation(line: 485, column: 25, scope: !144)
!158 = !DILocation(line: 485, column: 44, scope: !144)
!159 = !DILocation(line: 486, column: 17, scope: !144)
!160 = !DILocation(line: 487, column: 5, scope: !144)
!161 = !DILocation(line: 490, column: 17, scope: !144)
!162 = !DILocation(line: 493, column: 12, scope: !144)
!163 = !DILocation(line: 493, column: 5, scope: !144)
!164 = distinct !DISubprogram(name: "xStreamBufferSpacesAvailable", scope: !1, file: !1, line: 497, type: !8, scopeLine: 498, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!165 = !DILocation(line: 499, column: 51, scope: !164)
!166 = !DILocation(line: 499, column: 34, scope: !164)
!167 = !DILocation(line: 508, column: 5, scope: !164)
!168 = !DILocation(line: 510, column: 25, scope: !164)
!169 = !DILocation(line: 510, column: 41, scope: !164)
!170 = !DILocation(line: 510, column: 23, scope: !164)
!171 = !DILocation(line: 511, column: 18, scope: !164)
!172 = !DILocation(line: 511, column: 34, scope: !164)
!173 = !DILocation(line: 511, column: 44, scope: !164)
!174 = !DILocation(line: 511, column: 60, scope: !164)
!175 = !DILocation(line: 511, column: 42, scope: !164)
!176 = !DILocation(line: 511, column: 16, scope: !164)
!177 = !DILocation(line: 512, column: 19, scope: !164)
!178 = !DILocation(line: 512, column: 35, scope: !164)
!179 = !DILocation(line: 512, column: 16, scope: !164)
!180 = !DILocation(line: 513, column: 5, scope: !164)
!181 = !DILocation(line: 513, column: 14, scope: !164)
!182 = !DILocation(line: 513, column: 31, scope: !164)
!183 = !DILocation(line: 513, column: 47, scope: !164)
!184 = !DILocation(line: 513, column: 28, scope: !164)
!185 = distinct !{!185, !167, !186, !187}
!186 = !DILocation(line: 513, column: 53, scope: !164)
!187 = !{!"llvm.loop.mustprogress"}
!188 = !DILocation(line: 515, column: 12, scope: !164)
!189 = !DILocation(line: 517, column: 9, scope: !164)
!190 = !DILocation(line: 517, column: 19, scope: !164)
!191 = !DILocation(line: 517, column: 35, scope: !164)
!192 = !DILocation(line: 517, column: 16, scope: !164)
!193 = !DILocation(line: 519, column: 19, scope: !164)
!194 = !DILocation(line: 519, column: 35, scope: !164)
!195 = !DILocation(line: 519, column: 16, scope: !164)
!196 = !DILocation(line: 520, column: 5, scope: !164)
!197 = !DILocation(line: 526, column: 12, scope: !164)
!198 = !DILocation(line: 526, column: 5, scope: !164)
!199 = distinct !DISubprogram(name: "xStreamBufferBytesAvailable", scope: !1, file: !1, line: 530, type: !8, scopeLine: 531, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!200 = !DILocation(line: 532, column: 51, scope: !199)
!201 = !DILocation(line: 532, column: 34, scope: !199)
!202 = !DILocation(line: 537, column: 33, scope: !199)
!203 = !DILocation(line: 537, column: 15, scope: !199)
!204 = !DILocation(line: 537, column: 13, scope: !199)
!205 = !DILocation(line: 538, column: 12, scope: !199)
!206 = !DILocation(line: 538, column: 5, scope: !199)
!207 = distinct !DISubprogram(name: "prvBytesInBuffer", scope: !1, file: !1, line: 1231, type: !8, scopeLine: 1232, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!208 = !DILocation(line: 1236, column: 14, scope: !207)
!209 = !DILocation(line: 1236, column: 30, scope: !207)
!210 = !DILocation(line: 1236, column: 40, scope: !207)
!211 = !DILocation(line: 1236, column: 56, scope: !207)
!212 = !DILocation(line: 1236, column: 38, scope: !207)
!213 = !DILocation(line: 1236, column: 12, scope: !207)
!214 = !DILocation(line: 1237, column: 15, scope: !207)
!215 = !DILocation(line: 1237, column: 31, scope: !207)
!216 = !DILocation(line: 1237, column: 12, scope: !207)
!217 = !DILocation(line: 1239, column: 9, scope: !207)
!218 = !DILocation(line: 1239, column: 19, scope: !207)
!219 = !DILocation(line: 1239, column: 35, scope: !207)
!220 = !DILocation(line: 1239, column: 16, scope: !207)
!221 = !DILocation(line: 1241, column: 19, scope: !207)
!222 = !DILocation(line: 1241, column: 35, scope: !207)
!223 = !DILocation(line: 1241, column: 16, scope: !207)
!224 = !DILocation(line: 1242, column: 5, scope: !207)
!225 = !DILocation(line: 1248, column: 12, scope: !207)
!226 = !DILocation(line: 1248, column: 5, scope: !207)
!227 = distinct !DISubprogram(name: "xStreamBufferSend", scope: !1, file: !1, line: 542, type: !8, scopeLine: 546, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!228 = !DILocation(line: 547, column: 45, scope: !227)
!229 = !DILocation(line: 547, column: 28, scope: !227)
!230 = !DILocation(line: 548, column: 21, scope: !227)
!231 = !DILocation(line: 549, column: 29, scope: !227)
!232 = !DILocation(line: 549, column: 12, scope: !227)
!233 = !DILocation(line: 551, column: 12, scope: !227)
!234 = !DILocation(line: 558, column: 25, scope: !227)
!235 = !DILocation(line: 558, column: 41, scope: !227)
!236 = !DILocation(line: 558, column: 49, scope: !227)
!237 = !DILocation(line: 558, column: 23, scope: !227)
!238 = !DILocation(line: 564, column: 11, scope: !227)
!239 = !DILocation(line: 564, column: 27, scope: !227)
!240 = !DILocation(line: 564, column: 35, scope: !227)
!241 = !DILocation(line: 564, column: 65, scope: !227)
!242 = !DILocation(line: 564, column: 9, scope: !227)
!243 = !DILocation(line: 566, column: 24, scope: !227)
!244 = !DILocation(line: 573, column: 13, scope: !227)
!245 = !DILocation(line: 573, column: 30, scope: !227)
!246 = !DILocation(line: 573, column: 28, scope: !227)
!247 = !DILocation(line: 577, column: 26, scope: !227)
!248 = !DILocation(line: 578, column: 9, scope: !227)
!249 = !DILocation(line: 583, column: 5, scope: !227)
!250 = !DILocation(line: 589, column: 13, scope: !227)
!251 = !DILocation(line: 589, column: 30, scope: !227)
!252 = !DILocation(line: 589, column: 28, scope: !227)
!253 = !DILocation(line: 591, column: 30, scope: !227)
!254 = !DILocation(line: 591, column: 28, scope: !227)
!255 = !DILocation(line: 592, column: 9, scope: !227)
!256 = !DILocation(line: 599, column: 9, scope: !227)
!257 = !DILocation(line: 599, column: 22, scope: !227)
!258 = !DILocation(line: 601, column: 9, scope: !227)
!259 = !DILocation(line: 603, column: 9, scope: !227)
!260 = !DILocation(line: 607, column: 13, scope: !227)
!261 = !DILocation(line: 609, column: 56, scope: !227)
!262 = !DILocation(line: 609, column: 26, scope: !227)
!263 = !DILocation(line: 609, column: 24, scope: !227)
!264 = !DILocation(line: 611, column: 21, scope: !227)
!265 = !DILocation(line: 611, column: 30, scope: !227)
!266 = !DILocation(line: 611, column: 28, scope: !227)
!267 = !DILocation(line: 614, column: 30, scope: !227)
!268 = !DILocation(line: 618, column: 58, scope: !227)
!269 = !DILocation(line: 618, column: 21, scope: !227)
!270 = !DILocation(line: 618, column: 37, scope: !227)
!271 = !DILocation(line: 618, column: 56, scope: !227)
!272 = !DILocation(line: 619, column: 17, scope: !227)
!273 = !DILocation(line: 622, column: 21, scope: !227)
!274 = !DILocation(line: 623, column: 21, scope: !227)
!275 = !DILocation(line: 626, column: 13, scope: !227)
!276 = !DILocation(line: 629, column: 22, scope: !227)
!277 = !DILocation(line: 630, column: 13, scope: !227)
!278 = !DILocation(line: 630, column: 29, scope: !227)
!279 = !DILocation(line: 630, column: 48, scope: !227)
!280 = !DILocation(line: 631, column: 9, scope: !227)
!281 = !DILocation(line: 631, column: 18, scope: !227)
!282 = !DILocation(line: 631, column: 67, scope: !227)
!283 = distinct !{!283, !259, !284, !187}
!284 = !DILocation(line: 631, column: 78, scope: !227)
!285 = !DILocation(line: 632, column: 5, scope: !227)
!286 = !DILocation(line: 638, column: 9, scope: !227)
!287 = !DILocation(line: 638, column: 16, scope: !227)
!288 = !DILocation(line: 640, column: 48, scope: !227)
!289 = !DILocation(line: 640, column: 18, scope: !227)
!290 = !DILocation(line: 640, column: 16, scope: !227)
!291 = !DILocation(line: 641, column: 5, scope: !227)
!292 = !DILocation(line: 647, column: 40, scope: !227)
!293 = !DILocation(line: 647, column: 56, scope: !227)
!294 = !DILocation(line: 647, column: 66, scope: !227)
!295 = !DILocation(line: 647, column: 84, scope: !227)
!296 = !DILocation(line: 647, column: 92, scope: !227)
!297 = !DILocation(line: 647, column: 15, scope: !227)
!298 = !DILocation(line: 647, column: 13, scope: !227)
!299 = !DILocation(line: 649, column: 9, scope: !227)
!300 = !DILocation(line: 649, column: 17, scope: !227)
!301 = !DILocation(line: 654, column: 31, scope: !227)
!302 = !DILocation(line: 654, column: 13, scope: !227)
!303 = !DILocation(line: 654, column: 51, scope: !227)
!304 = !DILocation(line: 654, column: 67, scope: !227)
!305 = !DILocation(line: 654, column: 48, scope: !227)
!306 = !DILocation(line: 656, column: 13, scope: !227)
!307 = !DILocation(line: 657, column: 9, scope: !227)
!308 = !DILocation(line: 662, column: 5, scope: !227)
!309 = !DILocation(line: 669, column: 12, scope: !227)
!310 = !DILocation(line: 669, column: 5, scope: !227)
!311 = distinct !DISubprogram(name: "prvWriteMessageToBuffer", scope: !1, file: !1, line: 724, type: !8, scopeLine: 729, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!312 = !DILocation(line: 730, column: 24, scope: !311)
!313 = !DILocation(line: 730, column: 40, scope: !311)
!314 = !DILocation(line: 730, column: 12, scope: !311)
!315 = !DILocation(line: 732, column: 11, scope: !311)
!316 = !DILocation(line: 732, column: 27, scope: !311)
!317 = !DILocation(line: 732, column: 35, scope: !311)
!318 = !DILocation(line: 732, column: 65, scope: !311)
!319 = !DILocation(line: 732, column: 9, scope: !311)
!320 = !DILocation(line: 736, column: 13, scope: !311)
!321 = !DILocation(line: 736, column: 23, scope: !311)
!322 = !DILocation(line: 736, column: 20, scope: !311)
!323 = !DILocation(line: 741, column: 48, scope: !311)
!324 = !DILocation(line: 741, column: 140, scope: !311)
!325 = !DILocation(line: 741, column: 25, scope: !311)
!326 = !DILocation(line: 741, column: 23, scope: !311)
!327 = !DILocation(line: 742, column: 9, scope: !311)
!328 = !DILocation(line: 746, column: 30, scope: !311)
!329 = !DILocation(line: 748, column: 5, scope: !311)
!330 = !DILocation(line: 754, column: 28, scope: !311)
!331 = !DILocation(line: 754, column: 26, scope: !311)
!332 = !DILocation(line: 757, column: 9, scope: !311)
!333 = !DILocation(line: 757, column: 26, scope: !311)
!334 = !DILocation(line: 760, column: 56, scope: !311)
!335 = !DILocation(line: 760, column: 92, scope: !311)
!336 = !DILocation(line: 760, column: 102, scope: !311)
!337 = !DILocation(line: 760, column: 120, scope: !311)
!338 = !DILocation(line: 760, column: 33, scope: !311)
!339 = !DILocation(line: 760, column: 9, scope: !311)
!340 = !DILocation(line: 760, column: 25, scope: !311)
!341 = !DILocation(line: 760, column: 31, scope: !311)
!342 = !DILocation(line: 761, column: 5, scope: !311)
!343 = !DILocation(line: 763, column: 12, scope: !311)
!344 = !DILocation(line: 763, column: 5, scope: !311)
!345 = distinct !DISubprogram(name: "xStreamBufferSendFromISR", scope: !1, file: !1, line: 673, type: !8, scopeLine: 677, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!346 = !DILocation(line: 678, column: 45, scope: !345)
!347 = !DILocation(line: 678, column: 28, scope: !345)
!348 = !DILocation(line: 680, column: 29, scope: !345)
!349 = !DILocation(line: 680, column: 12, scope: !345)
!350 = !DILocation(line: 689, column: 11, scope: !345)
!351 = !DILocation(line: 689, column: 27, scope: !345)
!352 = !DILocation(line: 689, column: 35, scope: !345)
!353 = !DILocation(line: 689, column: 65, scope: !345)
!354 = !DILocation(line: 689, column: 9, scope: !345)
!355 = !DILocation(line: 691, column: 24, scope: !345)
!356 = !DILocation(line: 692, column: 5, scope: !345)
!357 = !DILocation(line: 698, column: 44, scope: !345)
!358 = !DILocation(line: 698, column: 14, scope: !345)
!359 = !DILocation(line: 698, column: 12, scope: !345)
!360 = !DILocation(line: 699, column: 40, scope: !345)
!361 = !DILocation(line: 699, column: 56, scope: !345)
!362 = !DILocation(line: 699, column: 66, scope: !345)
!363 = !DILocation(line: 699, column: 84, scope: !345)
!364 = !DILocation(line: 699, column: 92, scope: !345)
!365 = !DILocation(line: 699, column: 15, scope: !345)
!366 = !DILocation(line: 699, column: 13, scope: !345)
!367 = !DILocation(line: 701, column: 9, scope: !345)
!368 = !DILocation(line: 701, column: 17, scope: !345)
!369 = !DILocation(line: 704, column: 31, scope: !345)
!370 = !DILocation(line: 704, column: 13, scope: !345)
!371 = !DILocation(line: 704, column: 51, scope: !345)
!372 = !DILocation(line: 704, column: 67, scope: !345)
!373 = !DILocation(line: 704, column: 48, scope: !345)
!374 = !DILocation(line: 216, column: 9, scope: !375, inlinedAt: !377)
!375 = distinct !DISubprogram(name: "ulPortRaiseBASEPRI", scope: !376, file: !376, line: 212, type: !8, scopeLine: 213, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!376 = !DIFile(filename: "FreeRTOS/Source/portable/GCC/ARM_CM3/portmacro.h", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!377 = distinct !DILocation(line: 706, column: 13, scope: !345)
!378 = !{i64 339876, i64 339923, i64 339965, i64 340011, i64 340048}
!379 = !DILocation(line: 228, column: 16, scope: !375, inlinedAt: !377)
!380 = !DILocation(line: 706, column: 13, scope: !345)
!381 = !DILocation(line: 236, column: 40, scope: !382, inlinedAt: !383)
!382 = distinct !DISubprogram(name: "vPortSetBASEPRI", scope: !376, file: !376, line: 232, type: !8, scopeLine: 233, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!383 = distinct !DILocation(line: 706, column: 13, scope: !345)
!384 = !DILocation(line: 234, column: 9, scope: !382, inlinedAt: !383)
!385 = !{i64 340555}
!386 = !DILocation(line: 707, column: 9, scope: !345)
!387 = !DILocation(line: 712, column: 5, scope: !345)
!388 = !DILocation(line: 720, column: 12, scope: !345)
!389 = !DILocation(line: 720, column: 5, scope: !345)
!390 = distinct !DISubprogram(name: "xStreamBufferReceive", scope: !1, file: !1, line: 767, type: !8, scopeLine: 771, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!391 = !DILocation(line: 772, column: 45, scope: !390)
!392 = !DILocation(line: 772, column: 28, scope: !390)
!393 = !DILocation(line: 773, column: 12, scope: !390)
!394 = !DILocation(line: 783, column: 11, scope: !390)
!395 = !DILocation(line: 783, column: 27, scope: !390)
!396 = !DILocation(line: 783, column: 35, scope: !390)
!397 = !DILocation(line: 783, column: 65, scope: !390)
!398 = !DILocation(line: 783, column: 9, scope: !390)
!399 = !DILocation(line: 785, column: 36, scope: !390)
!400 = !DILocation(line: 786, column: 5, scope: !390)
!401 = !DILocation(line: 789, column: 36, scope: !390)
!402 = !DILocation(line: 792, column: 9, scope: !390)
!403 = !DILocation(line: 792, column: 22, scope: !390)
!404 = !DILocation(line: 796, column: 9, scope: !390)
!405 = !DILocation(line: 798, column: 49, scope: !390)
!406 = !DILocation(line: 798, column: 31, scope: !390)
!407 = !DILocation(line: 798, column: 29, scope: !390)
!408 = !DILocation(line: 805, column: 17, scope: !390)
!409 = !DILocation(line: 805, column: 36, scope: !390)
!410 = !DILocation(line: 805, column: 33, scope: !390)
!411 = !DILocation(line: 808, column: 26, scope: !390)
!412 = !DILocation(line: 812, column: 57, scope: !390)
!413 = !DILocation(line: 812, column: 17, scope: !390)
!414 = !DILocation(line: 812, column: 33, scope: !390)
!415 = !DILocation(line: 812, column: 55, scope: !390)
!416 = !DILocation(line: 813, column: 13, scope: !390)
!417 = !DILocation(line: 819, column: 9, scope: !390)
!418 = !DILocation(line: 821, column: 13, scope: !390)
!419 = !DILocation(line: 821, column: 32, scope: !390)
!420 = !DILocation(line: 821, column: 29, scope: !390)
!421 = !DILocation(line: 825, column: 22, scope: !390)
!422 = !DILocation(line: 826, column: 13, scope: !390)
!423 = !DILocation(line: 826, column: 29, scope: !390)
!424 = !DILocation(line: 826, column: 51, scope: !390)
!425 = !DILocation(line: 829, column: 49, scope: !390)
!426 = !DILocation(line: 829, column: 31, scope: !390)
!427 = !DILocation(line: 829, column: 29, scope: !390)
!428 = !DILocation(line: 830, column: 9, scope: !390)
!429 = !DILocation(line: 835, column: 5, scope: !390)
!430 = !DILocation(line: 838, column: 45, scope: !390)
!431 = !DILocation(line: 838, column: 27, scope: !390)
!432 = !DILocation(line: 838, column: 25, scope: !390)
!433 = !DILocation(line: 846, column: 9, scope: !390)
!434 = !DILocation(line: 846, column: 27, scope: !390)
!435 = !DILocation(line: 846, column: 25, scope: !390)
!436 = !DILocation(line: 848, column: 53, scope: !390)
!437 = !DILocation(line: 848, column: 69, scope: !390)
!438 = !DILocation(line: 848, column: 79, scope: !390)
!439 = !DILocation(line: 848, column: 99, scope: !390)
!440 = !DILocation(line: 848, column: 27, scope: !390)
!441 = !DILocation(line: 848, column: 25, scope: !390)
!442 = !DILocation(line: 851, column: 13, scope: !390)
!443 = !DILocation(line: 851, column: 29, scope: !390)
!444 = !DILocation(line: 854, column: 13, scope: !390)
!445 = !DILocation(line: 855, column: 9, scope: !390)
!446 = !DILocation(line: 860, column: 5, scope: !390)
!447 = !DILocation(line: 867, column: 12, scope: !390)
!448 = !DILocation(line: 867, column: 5, scope: !390)
!449 = distinct !DISubprogram(name: "prvReadMessageFromBuffer", scope: !1, file: !1, line: 968, type: !8, scopeLine: 972, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!450 = !DILocation(line: 975, column: 24, scope: !449)
!451 = !DILocation(line: 975, column: 40, scope: !449)
!452 = !DILocation(line: 975, column: 12, scope: !449)
!453 = !DILocation(line: 977, column: 11, scope: !449)
!454 = !DILocation(line: 977, column: 27, scope: !449)
!455 = !DILocation(line: 977, column: 35, scope: !449)
!456 = !DILocation(line: 977, column: 65, scope: !449)
!457 = !DILocation(line: 977, column: 9, scope: !449)
!458 = !DILocation(line: 981, column: 45, scope: !449)
!459 = !DILocation(line: 981, column: 133, scope: !449)
!460 = !DILocation(line: 981, column: 21, scope: !449)
!461 = !DILocation(line: 981, column: 19, scope: !449)
!462 = !DILocation(line: 982, column: 41, scope: !449)
!463 = !DILocation(line: 982, column: 28, scope: !449)
!464 = !DILocation(line: 986, column: 25, scope: !449)
!465 = !DILocation(line: 990, column: 13, scope: !449)
!466 = !DILocation(line: 990, column: 34, scope: !449)
!467 = !DILocation(line: 990, column: 32, scope: !449)
!468 = !DILocation(line: 993, column: 32, scope: !449)
!469 = !DILocation(line: 994, column: 9, scope: !449)
!470 = !DILocation(line: 999, column: 5, scope: !449)
!471 = !DILocation(line: 1004, column: 30, scope: !449)
!472 = !DILocation(line: 1004, column: 28, scope: !449)
!473 = !DILocation(line: 1008, column: 14, scope: !449)
!474 = !DILocation(line: 1008, column: 12, scope: !449)
!475 = !DILocation(line: 1010, column: 9, scope: !449)
!476 = !DILocation(line: 1010, column: 16, scope: !449)
!477 = !DILocation(line: 1013, column: 57, scope: !449)
!478 = !DILocation(line: 1013, column: 87, scope: !449)
!479 = !DILocation(line: 1013, column: 97, scope: !449)
!480 = !DILocation(line: 1013, column: 105, scope: !449)
!481 = !DILocation(line: 1013, column: 33, scope: !449)
!482 = !DILocation(line: 1013, column: 9, scope: !449)
!483 = !DILocation(line: 1013, column: 25, scope: !449)
!484 = !DILocation(line: 1013, column: 31, scope: !449)
!485 = !DILocation(line: 1014, column: 5, scope: !449)
!486 = !DILocation(line: 1016, column: 12, scope: !449)
!487 = !DILocation(line: 1016, column: 5, scope: !449)
!488 = distinct !DISubprogram(name: "xStreamBufferNextMessageLengthBytes", scope: !1, file: !1, line: 871, type: !8, scopeLine: 872, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!489 = !DILocation(line: 873, column: 45, scope: !488)
!490 = !DILocation(line: 873, column: 28, scope: !488)
!491 = !DILocation(line: 880, column: 11, scope: !488)
!492 = !DILocation(line: 880, column: 27, scope: !488)
!493 = !DILocation(line: 880, column: 35, scope: !488)
!494 = !DILocation(line: 880, column: 65, scope: !488)
!495 = !DILocation(line: 880, column: 9, scope: !488)
!496 = !DILocation(line: 882, column: 45, scope: !488)
!497 = !DILocation(line: 882, column: 27, scope: !488)
!498 = !DILocation(line: 882, column: 25, scope: !488)
!499 = !DILocation(line: 884, column: 13, scope: !488)
!500 = !DILocation(line: 884, column: 29, scope: !488)
!501 = !DILocation(line: 889, column: 46, scope: !488)
!502 = !DILocation(line: 889, column: 123, scope: !488)
!503 = !DILocation(line: 889, column: 139, scope: !488)
!504 = !DILocation(line: 889, column: 22, scope: !488)
!505 = !DILocation(line: 890, column: 34, scope: !488)
!506 = !DILocation(line: 890, column: 21, scope: !488)
!507 = !DILocation(line: 891, column: 9, scope: !488)
!508 = !DILocation(line: 899, column: 21, scope: !488)
!509 = !DILocation(line: 901, column: 5, scope: !488)
!510 = !DILocation(line: 904, column: 17, scope: !488)
!511 = !DILocation(line: 907, column: 12, scope: !488)
!512 = !DILocation(line: 907, column: 5, scope: !488)
!513 = distinct !DISubprogram(name: "prvReadBytesFromBuffer", scope: !1, file: !1, line: 1187, type: !8, scopeLine: 1191, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!514 = !DILocation(line: 1199, column: 20, scope: !513)
!515 = !DILocation(line: 1199, column: 18, scope: !513)
!516 = !DILocation(line: 1205, column: 33, scope: !513)
!517 = !DILocation(line: 1205, column: 62, scope: !513)
!518 = !DILocation(line: 1205, column: 78, scope: !513)
!519 = !DILocation(line: 1205, column: 89, scope: !513)
!520 = !DILocation(line: 1205, column: 100, scope: !513)
!521 = !DILocation(line: 1205, column: 14, scope: !513)
!522 = !DILocation(line: 1209, column: 9, scope: !513)
!523 = !DILocation(line: 1209, column: 18, scope: !513)
!524 = !DILocation(line: 1209, column: 16, scope: !513)
!525 = !DILocation(line: 1212, column: 40, scope: !513)
!526 = !DILocation(line: 1212, column: 49, scope: !513)
!527 = !DILocation(line: 1212, column: 80, scope: !513)
!528 = !DILocation(line: 1212, column: 96, scope: !513)
!529 = !DILocation(line: 1212, column: 109, scope: !513)
!530 = !DILocation(line: 1212, column: 118, scope: !513)
!531 = !DILocation(line: 1212, column: 116, scope: !513)
!532 = !DILocation(line: 1212, column: 18, scope: !513)
!533 = !DILocation(line: 1213, column: 5, scope: !513)
!534 = !DILocation(line: 1220, column: 14, scope: !513)
!535 = !DILocation(line: 1220, column: 11, scope: !513)
!536 = !DILocation(line: 1222, column: 9, scope: !513)
!537 = !DILocation(line: 1222, column: 18, scope: !513)
!538 = !DILocation(line: 1222, column: 34, scope: !513)
!539 = !DILocation(line: 1222, column: 15, scope: !513)
!540 = !DILocation(line: 1224, column: 18, scope: !513)
!541 = !DILocation(line: 1224, column: 34, scope: !513)
!542 = !DILocation(line: 1224, column: 15, scope: !513)
!543 = !DILocation(line: 1225, column: 5, scope: !513)
!544 = !DILocation(line: 1227, column: 12, scope: !513)
!545 = !DILocation(line: 1227, column: 5, scope: !513)
!546 = distinct !DISubprogram(name: "xStreamBufferReceiveFromISR", scope: !1, file: !1, line: 911, type: !8, scopeLine: 915, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!547 = !DILocation(line: 916, column: 45, scope: !546)
!548 = !DILocation(line: 916, column: 28, scope: !546)
!549 = !DILocation(line: 917, column: 12, scope: !546)
!550 = !DILocation(line: 927, column: 11, scope: !546)
!551 = !DILocation(line: 927, column: 27, scope: !546)
!552 = !DILocation(line: 927, column: 35, scope: !546)
!553 = !DILocation(line: 927, column: 65, scope: !546)
!554 = !DILocation(line: 927, column: 9, scope: !546)
!555 = !DILocation(line: 929, column: 36, scope: !546)
!556 = !DILocation(line: 930, column: 5, scope: !546)
!557 = !DILocation(line: 933, column: 36, scope: !546)
!558 = !DILocation(line: 936, column: 41, scope: !546)
!559 = !DILocation(line: 936, column: 23, scope: !546)
!560 = !DILocation(line: 936, column: 21, scope: !546)
!561 = !DILocation(line: 943, column: 9, scope: !546)
!562 = !DILocation(line: 943, column: 27, scope: !546)
!563 = !DILocation(line: 943, column: 25, scope: !546)
!564 = !DILocation(line: 945, column: 53, scope: !546)
!565 = !DILocation(line: 945, column: 69, scope: !546)
!566 = !DILocation(line: 945, column: 79, scope: !546)
!567 = !DILocation(line: 945, column: 99, scope: !546)
!568 = !DILocation(line: 945, column: 27, scope: !546)
!569 = !DILocation(line: 945, column: 25, scope: !546)
!570 = !DILocation(line: 948, column: 13, scope: !546)
!571 = !DILocation(line: 948, column: 29, scope: !546)
!572 = !DILocation(line: 216, column: 9, scope: !375, inlinedAt: !573)
!573 = distinct !DILocation(line: 950, column: 13, scope: !546)
!574 = !DILocation(line: 228, column: 16, scope: !375, inlinedAt: !573)
!575 = !DILocation(line: 950, column: 13, scope: !546)
!576 = !DILocation(line: 236, column: 40, scope: !382, inlinedAt: !577)
!577 = distinct !DILocation(line: 950, column: 13, scope: !546)
!578 = !DILocation(line: 234, column: 9, scope: !382, inlinedAt: !577)
!579 = !DILocation(line: 951, column: 9, scope: !546)
!580 = !DILocation(line: 956, column: 5, scope: !546)
!581 = !DILocation(line: 964, column: 12, scope: !546)
!582 = !DILocation(line: 964, column: 5, scope: !546)
!583 = distinct !DISubprogram(name: "xStreamBufferIsEmpty", scope: !1, file: !1, line: 1020, type: !8, scopeLine: 1021, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!584 = !DILocation(line: 1022, column: 51, scope: !583)
!585 = !DILocation(line: 1022, column: 34, scope: !583)
!586 = !DILocation(line: 1029, column: 13, scope: !583)
!587 = !DILocation(line: 1029, column: 29, scope: !583)
!588 = !DILocation(line: 1029, column: 11, scope: !583)
!589 = !DILocation(line: 1031, column: 9, scope: !583)
!590 = !DILocation(line: 1031, column: 25, scope: !583)
!591 = !DILocation(line: 1031, column: 34, scope: !583)
!592 = !DILocation(line: 1031, column: 31, scope: !583)
!593 = !DILocation(line: 1033, column: 17, scope: !583)
!594 = !DILocation(line: 1034, column: 5, scope: !583)
!595 = !DILocation(line: 1037, column: 17, scope: !583)
!596 = !DILocation(line: 1040, column: 12, scope: !583)
!597 = !DILocation(line: 1040, column: 5, scope: !583)
!598 = distinct !DISubprogram(name: "xStreamBufferIsFull", scope: !1, file: !1, line: 1044, type: !8, scopeLine: 1045, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!599 = !DILocation(line: 1048, column: 51, scope: !598)
!600 = !DILocation(line: 1048, column: 34, scope: !598)
!601 = !DILocation(line: 1056, column: 11, scope: !598)
!602 = !DILocation(line: 1056, column: 27, scope: !598)
!603 = !DILocation(line: 1056, column: 35, scope: !598)
!604 = !DILocation(line: 1056, column: 65, scope: !598)
!605 = !DILocation(line: 1056, column: 9, scope: !598)
!606 = !DILocation(line: 1058, column: 36, scope: !598)
!607 = !DILocation(line: 1059, column: 5, scope: !598)
!608 = !DILocation(line: 1062, column: 36, scope: !598)
!609 = !DILocation(line: 1066, column: 39, scope: !598)
!610 = !DILocation(line: 1066, column: 9, scope: !598)
!611 = !DILocation(line: 1066, column: 58, scope: !598)
!612 = !DILocation(line: 1066, column: 55, scope: !598)
!613 = !DILocation(line: 1068, column: 17, scope: !598)
!614 = !DILocation(line: 1069, column: 5, scope: !598)
!615 = !DILocation(line: 1072, column: 17, scope: !598)
!616 = !DILocation(line: 1075, column: 12, scope: !598)
!617 = !DILocation(line: 1075, column: 5, scope: !598)
!618 = distinct !DISubprogram(name: "xStreamBufferSendCompletedFromISR", scope: !1, file: !1, line: 1079, type: !8, scopeLine: 1081, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!619 = !DILocation(line: 1082, column: 45, scope: !618)
!620 = !DILocation(line: 1082, column: 28, scope: !618)
!621 = !DILocation(line: 216, column: 9, scope: !375, inlinedAt: !622)
!622 = distinct !DILocation(line: 1088, column: 46, scope: !618)
!623 = !DILocation(line: 228, column: 16, scope: !375, inlinedAt: !622)
!624 = !DILocation(line: 1088, column: 28, scope: !618)
!625 = !DILocation(line: 1090, column: 15, scope: !618)
!626 = !DILocation(line: 1090, column: 33, scope: !618)
!627 = !DILocation(line: 1090, column: 55, scope: !618)
!628 = !DILocation(line: 1090, column: 13, scope: !618)
!629 = !DILocation(line: 1092, column: 22, scope: !618)
!630 = !DILocation(line: 1096, column: 15, scope: !618)
!631 = !DILocation(line: 1096, column: 33, scope: !618)
!632 = !DILocation(line: 1096, column: 55, scope: !618)
!633 = !DILocation(line: 1097, column: 21, scope: !618)
!634 = !DILocation(line: 1098, column: 9, scope: !618)
!635 = !DILocation(line: 1101, column: 21, scope: !618)
!636 = !DILocation(line: 1104, column: 5, scope: !618)
!637 = !DILocation(line: 236, column: 40, scope: !382, inlinedAt: !638)
!638 = distinct !DILocation(line: 1104, column: 5, scope: !618)
!639 = !DILocation(line: 234, column: 9, scope: !382, inlinedAt: !638)
!640 = !DILocation(line: 1106, column: 12, scope: !618)
!641 = !DILocation(line: 1106, column: 5, scope: !618)
!642 = distinct !DISubprogram(name: "xStreamBufferReceiveCompletedFromISR", scope: !1, file: !1, line: 1110, type: !8, scopeLine: 1112, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!643 = !DILocation(line: 1113, column: 45, scope: !642)
!644 = !DILocation(line: 1113, column: 28, scope: !642)
!645 = !DILocation(line: 216, column: 9, scope: !375, inlinedAt: !646)
!646 = distinct !DILocation(line: 1119, column: 46, scope: !642)
!647 = !DILocation(line: 228, column: 16, scope: !375, inlinedAt: !646)
!648 = !DILocation(line: 1119, column: 28, scope: !642)
!649 = !DILocation(line: 1121, column: 15, scope: !642)
!650 = !DILocation(line: 1121, column: 33, scope: !642)
!651 = !DILocation(line: 1121, column: 52, scope: !642)
!652 = !DILocation(line: 1121, column: 13, scope: !642)
!653 = !DILocation(line: 1123, column: 22, scope: !642)
!654 = !DILocation(line: 1127, column: 15, scope: !642)
!655 = !DILocation(line: 1127, column: 33, scope: !642)
!656 = !DILocation(line: 1127, column: 52, scope: !642)
!657 = !DILocation(line: 1128, column: 21, scope: !642)
!658 = !DILocation(line: 1129, column: 9, scope: !642)
!659 = !DILocation(line: 1132, column: 21, scope: !642)
!660 = !DILocation(line: 1135, column: 5, scope: !642)
!661 = !DILocation(line: 236, column: 40, scope: !382, inlinedAt: !662)
!662 = distinct !DILocation(line: 1135, column: 5, scope: !642)
!663 = !DILocation(line: 234, column: 9, scope: !382, inlinedAt: !662)
!664 = !DILocation(line: 1137, column: 12, scope: !642)
!665 = !DILocation(line: 1137, column: 5, scope: !642)
!666 = distinct !DISubprogram(name: "uxStreamBufferGetStreamBufferNumber", scope: !1, file: !1, line: 1280, type: !8, scopeLine: 1281, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!667 = !DILocation(line: 1282, column: 16, scope: !666)
!668 = !DILocation(line: 1282, column: 31, scope: !666)
!669 = !DILocation(line: 1282, column: 9, scope: !666)
!670 = distinct !DISubprogram(name: "vStreamBufferSetStreamBufferNumber", scope: !1, file: !1, line: 1290, type: !8, scopeLine: 1292, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!671 = !DILocation(line: 1293, column: 47, scope: !670)
!672 = !DILocation(line: 1293, column: 9, scope: !670)
!673 = !DILocation(line: 1293, column: 24, scope: !670)
!674 = !DILocation(line: 1293, column: 45, scope: !670)
!675 = !DILocation(line: 1294, column: 5, scope: !670)
!676 = distinct !DISubprogram(name: "ucStreamBufferGetStreamBufferType", scope: !1, file: !1, line: 1301, type: !8, scopeLine: 1302, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!677 = !DILocation(line: 1303, column: 17, scope: !676)
!678 = !DILocation(line: 1303, column: 32, scope: !676)
!679 = !DILocation(line: 1303, column: 40, scope: !676)
!680 = !DILocation(line: 1303, column: 15, scope: !676)
!681 = !DILocation(line: 1303, column: 9, scope: !676)
!682 = distinct !DISubprogram(name: "prvWriteBytesToBuffer", scope: !1, file: !1, line: 1141, type: !8, scopeLine: 1145, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!683 = !DILocation(line: 1153, column: 20, scope: !682)
!684 = !DILocation(line: 1153, column: 18, scope: !682)
!685 = !DILocation(line: 1157, column: 38, scope: !682)
!686 = !DILocation(line: 1157, column: 54, scope: !682)
!687 = !DILocation(line: 1157, column: 65, scope: !682)
!688 = !DILocation(line: 1157, column: 95, scope: !682)
!689 = !DILocation(line: 1157, column: 104, scope: !682)
!690 = !DILocation(line: 1157, column: 14, scope: !682)
!691 = !DILocation(line: 1161, column: 9, scope: !682)
!692 = !DILocation(line: 1161, column: 18, scope: !682)
!693 = !DILocation(line: 1161, column: 16, scope: !682)
!694 = !DILocation(line: 1165, column: 37, scope: !682)
!695 = !DILocation(line: 1165, column: 53, scope: !682)
!696 = !DILocation(line: 1165, column: 84, scope: !682)
!697 = !DILocation(line: 1165, column: 93, scope: !682)
!698 = !DILocation(line: 1165, column: 111, scope: !682)
!699 = !DILocation(line: 1165, column: 120, scope: !682)
!700 = !DILocation(line: 1165, column: 118, scope: !682)
!701 = !DILocation(line: 1165, column: 18, scope: !682)
!702 = !DILocation(line: 1166, column: 5, scope: !682)
!703 = !DILocation(line: 1172, column: 14, scope: !682)
!704 = !DILocation(line: 1172, column: 11, scope: !682)
!705 = !DILocation(line: 1174, column: 9, scope: !682)
!706 = !DILocation(line: 1174, column: 18, scope: !682)
!707 = !DILocation(line: 1174, column: 34, scope: !682)
!708 = !DILocation(line: 1174, column: 15, scope: !682)
!709 = !DILocation(line: 1176, column: 18, scope: !682)
!710 = !DILocation(line: 1176, column: 34, scope: !682)
!711 = !DILocation(line: 1176, column: 15, scope: !682)
!712 = !DILocation(line: 1177, column: 5, scope: !682)
!713 = !DILocation(line: 1183, column: 12, scope: !682)
!714 = !DILocation(line: 1183, column: 5, scope: !682)
