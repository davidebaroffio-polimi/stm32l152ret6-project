; ModuleID = 'FreeRTOS/Source/event_groups.c'
source_filename = "FreeRTOS/Source/event_groups.c"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-unknown-eabi"

%struct.EventGroupDef_t = type { i32, %struct.xLIST, i32, i8 }
%struct.xLIST = type { i32, ptr, %struct.xMINI_LIST_ITEM }
%struct.xMINI_LIST_ITEM = type { i32, ptr, ptr }
%struct.xLIST_ITEM = type { i32, ptr, ptr, ptr, ptr }

; Function Attrs: noinline nounwind
define dso_local ptr @xEventGroupCreateStatic(ptr noundef %0) #0 !dbg !7 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %4 = load ptr, ptr %2, align 4, !dbg !10
  store ptr %4, ptr %3, align 4, !dbg !11
  %5 = load ptr, ptr %3, align 4, !dbg !12
  %6 = icmp ne ptr %5, null, !dbg !13
  br i1 %6, label %7, label %14, !dbg !12

7:                                                ; preds = %1
  %8 = load ptr, ptr %3, align 4, !dbg !14
  %9 = getelementptr inbounds %struct.EventGroupDef_t, ptr %8, i32 0, i32 0, !dbg !15
  store i32 0, ptr %9, align 4, !dbg !16
  %10 = load ptr, ptr %3, align 4, !dbg !17
  %11 = getelementptr inbounds %struct.EventGroupDef_t, ptr %10, i32 0, i32 1, !dbg !18
  call void @vListInitialise(ptr noundef %11), !dbg !19
  %12 = load ptr, ptr %3, align 4, !dbg !20
  %13 = getelementptr inbounds %struct.EventGroupDef_t, ptr %12, i32 0, i32 3, !dbg !21
  store i8 1, ptr %13, align 4, !dbg !22
  br label %15, !dbg !23

14:                                               ; preds = %1
  br label %15

15:                                               ; preds = %14, %7
  %16 = load ptr, ptr %3, align 4, !dbg !24
  ret ptr %16, !dbg !25
}

declare dso_local void @vListInitialise(ptr noundef) #1

; Function Attrs: noinline nounwind
define dso_local ptr @xEventGroupCreate() #0 !dbg !26 {
  %1 = alloca ptr, align 4
  %2 = call ptr @pvPortMalloc(i32 noundef 32), !dbg !27
  store ptr %2, ptr %1, align 4, !dbg !28
  %3 = load ptr, ptr %1, align 4, !dbg !29
  %4 = icmp ne ptr %3, null, !dbg !30
  br i1 %4, label %5, label %12, !dbg !29

5:                                                ; preds = %0
  %6 = load ptr, ptr %1, align 4, !dbg !31
  %7 = getelementptr inbounds %struct.EventGroupDef_t, ptr %6, i32 0, i32 0, !dbg !32
  store i32 0, ptr %7, align 4, !dbg !33
  %8 = load ptr, ptr %1, align 4, !dbg !34
  %9 = getelementptr inbounds %struct.EventGroupDef_t, ptr %8, i32 0, i32 1, !dbg !35
  call void @vListInitialise(ptr noundef %9), !dbg !36
  %10 = load ptr, ptr %1, align 4, !dbg !37
  %11 = getelementptr inbounds %struct.EventGroupDef_t, ptr %10, i32 0, i32 3, !dbg !38
  store i8 0, ptr %11, align 4, !dbg !39
  br label %13, !dbg !40

12:                                               ; preds = %0
  br label %13

13:                                               ; preds = %12, %5
  %14 = load ptr, ptr %1, align 4, !dbg !41
  ret ptr %14, !dbg !42
}

declare dso_local ptr @pvPortMalloc(i32 noundef) #1

; Function Attrs: noinline nounwind
define dso_local i32 @xEventGroupSync(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 !dbg !43 {
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store ptr %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %14 = load ptr, ptr %5, align 4, !dbg !44
  store ptr %14, ptr %11, align 4, !dbg !45
  store i32 0, ptr %13, align 4, !dbg !46
  call void @vTaskSuspendAll(), !dbg !47
  %15 = load ptr, ptr %11, align 4, !dbg !48
  %16 = getelementptr inbounds %struct.EventGroupDef_t, ptr %15, i32 0, i32 0, !dbg !49
  %17 = load i32, ptr %16, align 4, !dbg !49
  store i32 %17, ptr %9, align 4, !dbg !50
  %18 = load ptr, ptr %5, align 4, !dbg !51
  %19 = load i32, ptr %6, align 4, !dbg !52
  %20 = call i32 @xEventGroupSetBits(ptr noundef %18, i32 noundef %19), !dbg !53
  %21 = load i32, ptr %9, align 4, !dbg !54
  %22 = load i32, ptr %6, align 4, !dbg !55
  %23 = or i32 %21, %22, !dbg !56
  %24 = load i32, ptr %7, align 4, !dbg !57
  %25 = and i32 %23, %24, !dbg !58
  %26 = load i32, ptr %7, align 4, !dbg !59
  %27 = icmp eq i32 %25, %26, !dbg !60
  br i1 %27, label %28, label %38, !dbg !61

28:                                               ; preds = %4
  %29 = load i32, ptr %9, align 4, !dbg !62
  %30 = load i32, ptr %6, align 4, !dbg !63
  %31 = or i32 %29, %30, !dbg !64
  store i32 %31, ptr %10, align 4, !dbg !65
  %32 = load i32, ptr %7, align 4, !dbg !66
  %33 = xor i32 %32, -1, !dbg !67
  %34 = load ptr, ptr %11, align 4, !dbg !68
  %35 = getelementptr inbounds %struct.EventGroupDef_t, ptr %34, i32 0, i32 0, !dbg !69
  %36 = load i32, ptr %35, align 4, !dbg !70
  %37 = and i32 %36, %33, !dbg !70
  store i32 %37, ptr %35, align 4, !dbg !70
  store i32 0, ptr %8, align 4, !dbg !71
  br label %53, !dbg !72

38:                                               ; preds = %4
  %39 = load i32, ptr %8, align 4, !dbg !73
  %40 = icmp ne i32 %39, 0, !dbg !74
  br i1 %40, label %41, label %48, !dbg !73

41:                                               ; preds = %38
  %42 = load ptr, ptr %11, align 4, !dbg !75
  %43 = getelementptr inbounds %struct.EventGroupDef_t, ptr %42, i32 0, i32 1, !dbg !76
  %44 = load i32, ptr %7, align 4, !dbg !77
  %45 = or i32 %44, 16777216, !dbg !78
  %46 = or i32 %45, 67108864, !dbg !79
  %47 = load i32, ptr %8, align 4, !dbg !80
  call void @vTaskPlaceOnUnorderedEventList(ptr noundef %43, i32 noundef %46, i32 noundef %47), !dbg !81
  store i32 0, ptr %10, align 4, !dbg !82
  br label %52, !dbg !83

48:                                               ; preds = %38
  %49 = load ptr, ptr %11, align 4, !dbg !84
  %50 = getelementptr inbounds %struct.EventGroupDef_t, ptr %49, i32 0, i32 0, !dbg !85
  %51 = load i32, ptr %50, align 4, !dbg !85
  store i32 %51, ptr %10, align 4, !dbg !86
  store i32 1, ptr %13, align 4, !dbg !87
  br label %52

52:                                               ; preds = %48, %41
  br label %53

53:                                               ; preds = %52, %28
  %54 = call i32 @xTaskResumeAll(), !dbg !88
  store i32 %54, ptr %12, align 4, !dbg !89
  %55 = load i32, ptr %8, align 4, !dbg !90
  %56 = icmp ne i32 %55, 0, !dbg !91
  br i1 %56, label %57, label %89, !dbg !90

57:                                               ; preds = %53
  %58 = load i32, ptr %12, align 4, !dbg !92
  %59 = icmp eq i32 %58, 0, !dbg !93
  br i1 %59, label %60, label %61, !dbg !92

60:                                               ; preds = %57
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !94
  call void asm sideeffect "dsb", "~{memory}"() #2, !dbg !94, !srcloc !95
  call void asm sideeffect "isb", ""() #2, !dbg !94, !srcloc !96
  br label %62, !dbg !97

61:                                               ; preds = %57
  br label %62

62:                                               ; preds = %61, %60
  %63 = call i32 @uxTaskResetEventItemValue(), !dbg !98
  store i32 %63, ptr %10, align 4, !dbg !99
  %64 = load i32, ptr %10, align 4, !dbg !100
  %65 = and i32 %64, 33554432, !dbg !101
  %66 = icmp eq i32 %65, 0, !dbg !102
  br i1 %66, label %67, label %85, !dbg !103

67:                                               ; preds = %62
  call void @vPortEnterCritical(), !dbg !104
  %68 = load ptr, ptr %11, align 4, !dbg !105
  %69 = getelementptr inbounds %struct.EventGroupDef_t, ptr %68, i32 0, i32 0, !dbg !106
  %70 = load i32, ptr %69, align 4, !dbg !106
  store i32 %70, ptr %10, align 4, !dbg !107
  %71 = load i32, ptr %10, align 4, !dbg !108
  %72 = load i32, ptr %7, align 4, !dbg !109
  %73 = and i32 %71, %72, !dbg !110
  %74 = load i32, ptr %7, align 4, !dbg !111
  %75 = icmp eq i32 %73, %74, !dbg !112
  br i1 %75, label %76, label %83, !dbg !113

76:                                               ; preds = %67
  %77 = load i32, ptr %7, align 4, !dbg !114
  %78 = xor i32 %77, -1, !dbg !115
  %79 = load ptr, ptr %11, align 4, !dbg !116
  %80 = getelementptr inbounds %struct.EventGroupDef_t, ptr %79, i32 0, i32 0, !dbg !117
  %81 = load i32, ptr %80, align 4, !dbg !118
  %82 = and i32 %81, %78, !dbg !118
  store i32 %82, ptr %80, align 4, !dbg !118
  br label %84, !dbg !119

83:                                               ; preds = %67
  br label %84

84:                                               ; preds = %83, %76
  call void @vPortExitCritical(), !dbg !120
  store i32 1, ptr %13, align 4, !dbg !121
  br label %86, !dbg !122

85:                                               ; preds = %62
  br label %86

86:                                               ; preds = %85, %84
  %87 = load i32, ptr %10, align 4, !dbg !123
  %88 = and i32 %87, 16777215, !dbg !123
  store i32 %88, ptr %10, align 4, !dbg !123
  br label %89, !dbg !124

89:                                               ; preds = %86, %53
  %90 = load i32, ptr %13, align 4, !dbg !125
  %91 = load i32, ptr %13, align 4, !dbg !126
  %92 = load i32, ptr %10, align 4, !dbg !127
  ret i32 %92, !dbg !128
}

declare dso_local void @vTaskSuspendAll() #1

; Function Attrs: noinline nounwind
define dso_local i32 @xEventGroupSetBits(ptr noundef %0, i32 noundef %1) #0 !dbg !129 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca ptr, align 4
  %8 = alloca ptr, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca ptr, align 4
  %13 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %9, align 4, !dbg !130
  %14 = load ptr, ptr %3, align 4, !dbg !131
  store ptr %14, ptr %12, align 4, !dbg !132
  store i32 0, ptr %13, align 4, !dbg !133
  %15 = load ptr, ptr %12, align 4, !dbg !134
  %16 = getelementptr inbounds %struct.EventGroupDef_t, ptr %15, i32 0, i32 1, !dbg !135
  store ptr %16, ptr %8, align 4, !dbg !136
  %17 = load ptr, ptr %8, align 4, !dbg !137
  %18 = getelementptr inbounds %struct.xLIST, ptr %17, i32 0, i32 2, !dbg !137
  store ptr %18, ptr %7, align 4, !dbg !138
  call void @vTaskSuspendAll(), !dbg !139
  %19 = load ptr, ptr %8, align 4, !dbg !140
  %20 = getelementptr inbounds %struct.xLIST, ptr %19, i32 0, i32 2, !dbg !140
  %21 = getelementptr inbounds %struct.xMINI_LIST_ITEM, ptr %20, i32 0, i32 1, !dbg !140
  %22 = load ptr, ptr %21, align 4, !dbg !140
  store ptr %22, ptr %5, align 4, !dbg !141
  %23 = load i32, ptr %4, align 4, !dbg !142
  %24 = load ptr, ptr %12, align 4, !dbg !143
  %25 = getelementptr inbounds %struct.EventGroupDef_t, ptr %24, i32 0, i32 0, !dbg !144
  %26 = load i32, ptr %25, align 4, !dbg !145
  %27 = or i32 %26, %23, !dbg !145
  store i32 %27, ptr %25, align 4, !dbg !145
  br label %28, !dbg !146

28:                                               ; preds = %85, %2
  %29 = load ptr, ptr %5, align 4, !dbg !147
  %30 = load ptr, ptr %7, align 4, !dbg !148
  %31 = icmp ne ptr %29, %30, !dbg !149
  br i1 %31, label %32, label %87, !dbg !146

32:                                               ; preds = %28
  %33 = load ptr, ptr %5, align 4, !dbg !150
  %34 = getelementptr inbounds %struct.xLIST_ITEM, ptr %33, i32 0, i32 1, !dbg !150
  %35 = load ptr, ptr %34, align 4, !dbg !150
  store ptr %35, ptr %6, align 4, !dbg !151
  %36 = load ptr, ptr %5, align 4, !dbg !152
  %37 = getelementptr inbounds %struct.xLIST_ITEM, ptr %36, i32 0, i32 0, !dbg !152
  %38 = load i32, ptr %37, align 4, !dbg !152
  store i32 %38, ptr %10, align 4, !dbg !153
  store i32 0, ptr %13, align 4, !dbg !154
  %39 = load i32, ptr %10, align 4, !dbg !155
  %40 = and i32 %39, -16777216, !dbg !156
  store i32 %40, ptr %11, align 4, !dbg !157
  %41 = load i32, ptr %10, align 4, !dbg !158
  %42 = and i32 %41, 16777215, !dbg !158
  store i32 %42, ptr %10, align 4, !dbg !158
  %43 = load i32, ptr %11, align 4, !dbg !159
  %44 = and i32 %43, 67108864, !dbg !160
  %45 = icmp eq i32 %44, 0, !dbg !161
  br i1 %45, label %46, label %56, !dbg !162

46:                                               ; preds = %32
  %47 = load i32, ptr %10, align 4, !dbg !163
  %48 = load ptr, ptr %12, align 4, !dbg !164
  %49 = getelementptr inbounds %struct.EventGroupDef_t, ptr %48, i32 0, i32 0, !dbg !165
  %50 = load i32, ptr %49, align 4, !dbg !165
  %51 = and i32 %47, %50, !dbg !166
  %52 = icmp ne i32 %51, 0, !dbg !167
  br i1 %52, label %53, label %54, !dbg !168

53:                                               ; preds = %46
  store i32 1, ptr %13, align 4, !dbg !169
  br label %55, !dbg !170

54:                                               ; preds = %46
  br label %55

55:                                               ; preds = %54, %53
  br label %67, !dbg !171

56:                                               ; preds = %32
  %57 = load i32, ptr %10, align 4, !dbg !172
  %58 = load ptr, ptr %12, align 4, !dbg !173
  %59 = getelementptr inbounds %struct.EventGroupDef_t, ptr %58, i32 0, i32 0, !dbg !174
  %60 = load i32, ptr %59, align 4, !dbg !174
  %61 = and i32 %57, %60, !dbg !175
  %62 = load i32, ptr %10, align 4, !dbg !176
  %63 = icmp eq i32 %61, %62, !dbg !177
  br i1 %63, label %64, label %65, !dbg !178

64:                                               ; preds = %56
  store i32 1, ptr %13, align 4, !dbg !179
  br label %66, !dbg !180

65:                                               ; preds = %56
  br label %66

66:                                               ; preds = %65, %64
  br label %67

67:                                               ; preds = %66, %55
  %68 = load i32, ptr %13, align 4, !dbg !181
  %69 = icmp ne i32 %68, 0, !dbg !182
  br i1 %69, label %70, label %85, !dbg !181

70:                                               ; preds = %67
  %71 = load i32, ptr %11, align 4, !dbg !183
  %72 = and i32 %71, 16777216, !dbg !184
  %73 = icmp ne i32 %72, 0, !dbg !185
  br i1 %73, label %74, label %78, !dbg !186

74:                                               ; preds = %70
  %75 = load i32, ptr %10, align 4, !dbg !187
  %76 = load i32, ptr %9, align 4, !dbg !188
  %77 = or i32 %76, %75, !dbg !188
  store i32 %77, ptr %9, align 4, !dbg !188
  br label %79, !dbg !189

78:                                               ; preds = %70
  br label %79

79:                                               ; preds = %78, %74
  %80 = load ptr, ptr %5, align 4, !dbg !190
  %81 = load ptr, ptr %12, align 4, !dbg !191
  %82 = getelementptr inbounds %struct.EventGroupDef_t, ptr %81, i32 0, i32 0, !dbg !192
  %83 = load i32, ptr %82, align 4, !dbg !192
  %84 = or i32 %83, 33554432, !dbg !193
  call void @vTaskRemoveFromUnorderedEventList(ptr noundef %80, i32 noundef %84), !dbg !194
  br label %85, !dbg !195

85:                                               ; preds = %79, %67
  %86 = load ptr, ptr %6, align 4, !dbg !196
  store ptr %86, ptr %5, align 4, !dbg !197
  br label %28, !dbg !146, !llvm.loop !198

87:                                               ; preds = %28
  %88 = load i32, ptr %9, align 4, !dbg !201
  %89 = xor i32 %88, -1, !dbg !202
  %90 = load ptr, ptr %12, align 4, !dbg !203
  %91 = getelementptr inbounds %struct.EventGroupDef_t, ptr %90, i32 0, i32 0, !dbg !204
  %92 = load i32, ptr %91, align 4, !dbg !205
  %93 = and i32 %92, %89, !dbg !205
  store i32 %93, ptr %91, align 4, !dbg !205
  %94 = call i32 @xTaskResumeAll(), !dbg !206
  %95 = load ptr, ptr %12, align 4, !dbg !207
  %96 = getelementptr inbounds %struct.EventGroupDef_t, ptr %95, i32 0, i32 0, !dbg !208
  %97 = load i32, ptr %96, align 4, !dbg !208
  ret i32 %97, !dbg !209
}

declare dso_local void @vTaskPlaceOnUnorderedEventList(ptr noundef, i32 noundef, i32 noundef) #1

declare dso_local i32 @xTaskResumeAll() #1

declare dso_local i32 @uxTaskResetEventItemValue() #1

declare dso_local void @vPortEnterCritical() #1

declare dso_local void @vPortExitCritical() #1

; Function Attrs: noinline nounwind
define dso_local i32 @xEventGroupWaitBits(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4) #0 !dbg !210 {
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  store ptr %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  %18 = load ptr, ptr %6, align 4, !dbg !211
  store ptr %18, ptr %11, align 4, !dbg !212
  store i32 0, ptr %13, align 4, !dbg !213
  store i32 0, ptr %16, align 4, !dbg !214
  call void @vTaskSuspendAll(), !dbg !215
  %19 = load ptr, ptr %11, align 4, !dbg !216
  %20 = getelementptr inbounds %struct.EventGroupDef_t, ptr %19, i32 0, i32 0, !dbg !217
  %21 = load i32, ptr %20, align 4, !dbg !217
  store i32 %21, ptr %17, align 4, !dbg !218
  %22 = load i32, ptr %17, align 4, !dbg !219
  %23 = load i32, ptr %7, align 4, !dbg !220
  %24 = load i32, ptr %9, align 4, !dbg !221
  %25 = call i32 @prvTestWaitCondition(i32 noundef %22, i32 noundef %23, i32 noundef %24), !dbg !222
  store i32 %25, ptr %14, align 4, !dbg !223
  %26 = load i32, ptr %14, align 4, !dbg !224
  %27 = icmp ne i32 %26, 0, !dbg !225
  br i1 %27, label %28, label %41, !dbg !224

28:                                               ; preds = %5
  %29 = load i32, ptr %17, align 4, !dbg !226
  store i32 %29, ptr %12, align 4, !dbg !227
  store i32 0, ptr %10, align 4, !dbg !228
  %30 = load i32, ptr %8, align 4, !dbg !229
  %31 = icmp ne i32 %30, 0, !dbg !230
  br i1 %31, label %32, label %39, !dbg !229

32:                                               ; preds = %28
  %33 = load i32, ptr %7, align 4, !dbg !231
  %34 = xor i32 %33, -1, !dbg !232
  %35 = load ptr, ptr %11, align 4, !dbg !233
  %36 = getelementptr inbounds %struct.EventGroupDef_t, ptr %35, i32 0, i32 0, !dbg !234
  %37 = load i32, ptr %36, align 4, !dbg !235
  %38 = and i32 %37, %34, !dbg !235
  store i32 %38, ptr %36, align 4, !dbg !235
  br label %40, !dbg !236

39:                                               ; preds = %28
  br label %40

40:                                               ; preds = %39, %32
  br label %68, !dbg !237

41:                                               ; preds = %5
  %42 = load i32, ptr %10, align 4, !dbg !238
  %43 = icmp eq i32 %42, 0, !dbg !239
  br i1 %43, label %44, label %46, !dbg !238

44:                                               ; preds = %41
  %45 = load i32, ptr %17, align 4, !dbg !240
  store i32 %45, ptr %12, align 4, !dbg !241
  store i32 1, ptr %16, align 4, !dbg !242
  br label %67, !dbg !243

46:                                               ; preds = %41
  %47 = load i32, ptr %8, align 4, !dbg !244
  %48 = icmp ne i32 %47, 0, !dbg !245
  br i1 %48, label %49, label %52, !dbg !244

49:                                               ; preds = %46
  %50 = load i32, ptr %13, align 4, !dbg !246
  %51 = or i32 %50, 16777216, !dbg !246
  store i32 %51, ptr %13, align 4, !dbg !246
  br label %53, !dbg !247

52:                                               ; preds = %46
  br label %53

53:                                               ; preds = %52, %49
  %54 = load i32, ptr %9, align 4, !dbg !248
  %55 = icmp ne i32 %54, 0, !dbg !249
  br i1 %55, label %56, label %59, !dbg !248

56:                                               ; preds = %53
  %57 = load i32, ptr %13, align 4, !dbg !250
  %58 = or i32 %57, 67108864, !dbg !250
  store i32 %58, ptr %13, align 4, !dbg !250
  br label %60, !dbg !251

59:                                               ; preds = %53
  br label %60

60:                                               ; preds = %59, %56
  %61 = load ptr, ptr %11, align 4, !dbg !252
  %62 = getelementptr inbounds %struct.EventGroupDef_t, ptr %61, i32 0, i32 1, !dbg !253
  %63 = load i32, ptr %7, align 4, !dbg !254
  %64 = load i32, ptr %13, align 4, !dbg !255
  %65 = or i32 %63, %64, !dbg !256
  %66 = load i32, ptr %10, align 4, !dbg !257
  call void @vTaskPlaceOnUnorderedEventList(ptr noundef %62, i32 noundef %65, i32 noundef %66), !dbg !258
  store i32 0, ptr %12, align 4, !dbg !259
  br label %67

67:                                               ; preds = %60, %44
  br label %68

68:                                               ; preds = %67, %40
  %69 = call i32 @xTaskResumeAll(), !dbg !260
  store i32 %69, ptr %15, align 4, !dbg !261
  %70 = load i32, ptr %10, align 4, !dbg !262
  %71 = icmp ne i32 %70, 0, !dbg !263
  br i1 %71, label %72, label %109, !dbg !262

72:                                               ; preds = %68
  %73 = load i32, ptr %15, align 4, !dbg !264
  %74 = icmp eq i32 %73, 0, !dbg !265
  br i1 %74, label %75, label %76, !dbg !264

75:                                               ; preds = %72
  store volatile i32 268435456, ptr inttoptr (i32 -536810236 to ptr), align 4, !dbg !266
  call void asm sideeffect "dsb", "~{memory}"() #2, !dbg !266, !srcloc !267
  call void asm sideeffect "isb", ""() #2, !dbg !266, !srcloc !268
  br label %77, !dbg !269

76:                                               ; preds = %72
  br label %77

77:                                               ; preds = %76, %75
  %78 = call i32 @uxTaskResetEventItemValue(), !dbg !270
  store i32 %78, ptr %12, align 4, !dbg !271
  %79 = load i32, ptr %12, align 4, !dbg !272
  %80 = and i32 %79, 33554432, !dbg !273
  %81 = icmp eq i32 %80, 0, !dbg !274
  br i1 %81, label %82, label %105, !dbg !275

82:                                               ; preds = %77
  call void @vPortEnterCritical(), !dbg !276
  %83 = load ptr, ptr %11, align 4, !dbg !277
  %84 = getelementptr inbounds %struct.EventGroupDef_t, ptr %83, i32 0, i32 0, !dbg !278
  %85 = load i32, ptr %84, align 4, !dbg !278
  store i32 %85, ptr %12, align 4, !dbg !279
  %86 = load i32, ptr %12, align 4, !dbg !280
  %87 = load i32, ptr %7, align 4, !dbg !281
  %88 = load i32, ptr %9, align 4, !dbg !282
  %89 = call i32 @prvTestWaitCondition(i32 noundef %86, i32 noundef %87, i32 noundef %88), !dbg !283
  %90 = icmp ne i32 %89, 0, !dbg !284
  br i1 %90, label %91, label %103, !dbg !283

91:                                               ; preds = %82
  %92 = load i32, ptr %8, align 4, !dbg !285
  %93 = icmp ne i32 %92, 0, !dbg !286
  br i1 %93, label %94, label %101, !dbg !285

94:                                               ; preds = %91
  %95 = load i32, ptr %7, align 4, !dbg !287
  %96 = xor i32 %95, -1, !dbg !288
  %97 = load ptr, ptr %11, align 4, !dbg !289
  %98 = getelementptr inbounds %struct.EventGroupDef_t, ptr %97, i32 0, i32 0, !dbg !290
  %99 = load i32, ptr %98, align 4, !dbg !291
  %100 = and i32 %99, %96, !dbg !291
  store i32 %100, ptr %98, align 4, !dbg !291
  br label %102, !dbg !292

101:                                              ; preds = %91
  br label %102

102:                                              ; preds = %101, %94
  br label %104, !dbg !293

103:                                              ; preds = %82
  br label %104

104:                                              ; preds = %103, %102
  store i32 1, ptr %16, align 4, !dbg !294
  call void @vPortExitCritical(), !dbg !295
  br label %106, !dbg !296

105:                                              ; preds = %77
  br label %106

106:                                              ; preds = %105, %104
  %107 = load i32, ptr %12, align 4, !dbg !297
  %108 = and i32 %107, 16777215, !dbg !297
  store i32 %108, ptr %12, align 4, !dbg !297
  br label %109, !dbg !298

109:                                              ; preds = %106, %68
  %110 = load i32, ptr %16, align 4, !dbg !299
  %111 = load i32, ptr %16, align 4, !dbg !300
  %112 = load i32, ptr %12, align 4, !dbg !301
  ret i32 %112, !dbg !302
}

; Function Attrs: noinline nounwind
define internal i32 @prvTestWaitCondition(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 !dbg !303 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4, !dbg !304
  %8 = load i32, ptr %6, align 4, !dbg !305
  %9 = icmp eq i32 %8, 0, !dbg !306
  br i1 %9, label %10, label %18, !dbg !305

10:                                               ; preds = %3
  %11 = load i32, ptr %4, align 4, !dbg !307
  %12 = load i32, ptr %5, align 4, !dbg !308
  %13 = and i32 %11, %12, !dbg !309
  %14 = icmp ne i32 %13, 0, !dbg !310
  br i1 %14, label %15, label %16, !dbg !311

15:                                               ; preds = %10
  store i32 1, ptr %7, align 4, !dbg !312
  br label %17, !dbg !313

16:                                               ; preds = %10
  br label %17

17:                                               ; preds = %16, %15
  br label %27, !dbg !314

18:                                               ; preds = %3
  %19 = load i32, ptr %4, align 4, !dbg !315
  %20 = load i32, ptr %5, align 4, !dbg !316
  %21 = and i32 %19, %20, !dbg !317
  %22 = load i32, ptr %5, align 4, !dbg !318
  %23 = icmp eq i32 %21, %22, !dbg !319
  br i1 %23, label %24, label %25, !dbg !320

24:                                               ; preds = %18
  store i32 1, ptr %7, align 4, !dbg !321
  br label %26, !dbg !322

25:                                               ; preds = %18
  br label %26

26:                                               ; preds = %25, %24
  br label %27

27:                                               ; preds = %26, %17
  %28 = load i32, ptr %7, align 4, !dbg !323
  ret i32 %28, !dbg !324
}

; Function Attrs: noinline nounwind
define dso_local i32 @xEventGroupClearBits(ptr noundef %0, i32 noundef %1) #0 !dbg !325 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = load ptr, ptr %3, align 4, !dbg !326
  store ptr %7, ptr %5, align 4, !dbg !327
  call void @vPortEnterCritical(), !dbg !328
  %8 = load ptr, ptr %5, align 4, !dbg !329
  %9 = getelementptr inbounds %struct.EventGroupDef_t, ptr %8, i32 0, i32 0, !dbg !330
  %10 = load i32, ptr %9, align 4, !dbg !330
  store i32 %10, ptr %6, align 4, !dbg !331
  %11 = load i32, ptr %4, align 4, !dbg !332
  %12 = xor i32 %11, -1, !dbg !333
  %13 = load ptr, ptr %5, align 4, !dbg !334
  %14 = getelementptr inbounds %struct.EventGroupDef_t, ptr %13, i32 0, i32 0, !dbg !335
  %15 = load i32, ptr %14, align 4, !dbg !336
  %16 = and i32 %15, %12, !dbg !336
  store i32 %16, ptr %14, align 4, !dbg !336
  call void @vPortExitCritical(), !dbg !337
  %17 = load i32, ptr %6, align 4, !dbg !338
  ret i32 %17, !dbg !339
}

; Function Attrs: noinline nounwind
define dso_local i32 @xEventGroupClearBitsFromISR(ptr noundef %0, i32 noundef %1) #0 !dbg !340 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %6 = load ptr, ptr %3, align 4, !dbg !341
  %7 = load i32, ptr %4, align 4, !dbg !342
  %8 = call i32 @xTimerPendFunctionCallFromISR(ptr noundef @vEventGroupClearBitsCallback, ptr noundef %6, i32 noundef %7, ptr noundef null), !dbg !343
  store i32 %8, ptr %5, align 4, !dbg !344
  %9 = load i32, ptr %5, align 4, !dbg !345
  ret i32 %9, !dbg !346
}

declare dso_local i32 @xTimerPendFunctionCallFromISR(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #1

; Function Attrs: noinline nounwind
define dso_local void @vEventGroupClearBitsCallback(ptr noundef %0, i32 noundef %1) #0 !dbg !347 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 4, !dbg !348
  %6 = load i32, ptr %4, align 4, !dbg !349
  %7 = call i32 @xEventGroupClearBits(ptr noundef %5, i32 noundef %6), !dbg !350
  ret void, !dbg !351
}

; Function Attrs: noinline nounwind
define dso_local i32 @xEventGroupGetBitsFromISR(ptr noundef %0) #0 !dbg !352 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %5, align 4
  %9 = load ptr, ptr %5, align 4, !dbg !353
  store ptr %9, ptr %7, align 4, !dbg !354
  %10 = call { i32, i32 } asm sideeffect "\09mrs $0, basepri\09\09\09\09\09\09\09\09\09\09\09\0A\09mov $1, $2\09\09\09\09\09\09\09\09\09\09\09\09\0A\09msr basepri, $1\09\09\09\09\09\09\09\09\09\09\09\0A\09isb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A\09dsb\09\09\09\09\09\09\09\09\09\09\09\09\09\09\0A", "=r,=r,i,~{memory}"(i32 80) #2, !dbg !355, !srcloc !359
  %11 = extractvalue { i32, i32 } %10, 0, !dbg !355
  %12 = extractvalue { i32, i32 } %10, 1, !dbg !355
  store i32 %11, ptr %3, align 4, !dbg !355
  store i32 %12, ptr %4, align 4, !dbg !355
  %13 = load i32, ptr %3, align 4, !dbg !360
  store i32 %13, ptr %6, align 4, !dbg !361
  %14 = load ptr, ptr %7, align 4, !dbg !362
  %15 = getelementptr inbounds %struct.EventGroupDef_t, ptr %14, i32 0, i32 0, !dbg !363
  %16 = load i32, ptr %15, align 4, !dbg !363
  store i32 %16, ptr %8, align 4, !dbg !364
  %17 = load i32, ptr %6, align 4, !dbg !365
  store i32 %17, ptr %2, align 4
  %18 = load i32, ptr %2, align 4, !dbg !366
  call void asm sideeffect "\09msr basepri, $0\09", "r,~{memory}"(i32 %18) #2, !dbg !369, !srcloc !370
  %19 = load i32, ptr %8, align 4, !dbg !371
  ret i32 %19, !dbg !372
}

declare dso_local void @vTaskRemoveFromUnorderedEventList(ptr noundef, i32 noundef) #1

; Function Attrs: noinline nounwind
define dso_local void @vEventGroupDelete(ptr noundef %0) #0 !dbg !373 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !374
  store ptr %5, ptr %3, align 4, !dbg !375
  %6 = load ptr, ptr %3, align 4, !dbg !376
  %7 = getelementptr inbounds %struct.EventGroupDef_t, ptr %6, i32 0, i32 1, !dbg !377
  store ptr %7, ptr %4, align 4, !dbg !378
  call void @vTaskSuspendAll(), !dbg !379
  br label %8, !dbg !380

8:                                                ; preds = %13, %1
  %9 = load ptr, ptr %4, align 4, !dbg !381
  %10 = getelementptr inbounds %struct.xLIST, ptr %9, i32 0, i32 0, !dbg !381
  %11 = load volatile i32, ptr %10, align 4, !dbg !381
  %12 = icmp ugt i32 %11, 0, !dbg !382
  br i1 %12, label %13, label %18, !dbg !380

13:                                               ; preds = %8
  %14 = load ptr, ptr %4, align 4, !dbg !383
  %15 = getelementptr inbounds %struct.xLIST, ptr %14, i32 0, i32 2, !dbg !384
  %16 = getelementptr inbounds %struct.xMINI_LIST_ITEM, ptr %15, i32 0, i32 1, !dbg !385
  %17 = load ptr, ptr %16, align 4, !dbg !385
  call void @vTaskRemoveFromUnorderedEventList(ptr noundef %17, i32 noundef 33554432), !dbg !386
  br label %8, !dbg !380, !llvm.loop !387

18:                                               ; preds = %8
  %19 = load ptr, ptr %3, align 4, !dbg !389
  %20 = getelementptr inbounds %struct.EventGroupDef_t, ptr %19, i32 0, i32 3, !dbg !390
  %21 = load i8, ptr %20, align 4, !dbg !390
  %22 = zext i8 %21 to i32, !dbg !389
  %23 = icmp eq i32 %22, 0, !dbg !391
  br i1 %23, label %24, label %26, !dbg !389

24:                                               ; preds = %18
  %25 = load ptr, ptr %3, align 4, !dbg !392
  call void @vPortFree(ptr noundef %25), !dbg !393
  br label %27, !dbg !394

26:                                               ; preds = %18
  br label %27

27:                                               ; preds = %26, %24
  %28 = call i32 @xTaskResumeAll(), !dbg !395
  ret void, !dbg !396
}

declare dso_local void @vPortFree(ptr noundef) #1

; Function Attrs: noinline nounwind
define dso_local void @vEventGroupSetBitsCallback(ptr noundef %0, i32 noundef %1) #0 !dbg !397 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 4, !dbg !398
  %6 = load i32, ptr %4, align 4, !dbg !399
  %7 = call i32 @xEventGroupSetBits(ptr noundef %5, i32 noundef %6), !dbg !400
  ret void, !dbg !401
}

; Function Attrs: noinline nounwind
define dso_local i32 @xEventGroupSetBitsFromISR(ptr noundef %0, i32 noundef %1, ptr noundef %2) #0 !dbg !402 {
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store ptr %2, ptr %6, align 4
  %8 = load ptr, ptr %4, align 4, !dbg !403
  %9 = load i32, ptr %5, align 4, !dbg !404
  %10 = load ptr, ptr %6, align 4, !dbg !405
  %11 = call i32 @xTimerPendFunctionCallFromISR(ptr noundef @vEventGroupSetBitsCallback, ptr noundef %8, i32 noundef %9, ptr noundef %10), !dbg !406
  store i32 %11, ptr %7, align 4, !dbg !407
  %12 = load i32, ptr %7, align 4, !dbg !408
  ret i32 %12, !dbg !409
}

; Function Attrs: noinline nounwind
define dso_local i32 @uxEventGroupGetNumber(ptr noundef %0) #0 !dbg !410 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %5 = load ptr, ptr %2, align 4, !dbg !411
  store ptr %5, ptr %4, align 4, !dbg !412
  %6 = load ptr, ptr %2, align 4, !dbg !413
  %7 = icmp eq ptr %6, null, !dbg !414
  br i1 %7, label %8, label %9, !dbg !413

8:                                                ; preds = %1
  store i32 0, ptr %3, align 4, !dbg !415
  br label %13, !dbg !416

9:                                                ; preds = %1
  %10 = load ptr, ptr %4, align 4, !dbg !417
  %11 = getelementptr inbounds %struct.EventGroupDef_t, ptr %10, i32 0, i32 2, !dbg !418
  %12 = load i32, ptr %11, align 4, !dbg !418
  store i32 %12, ptr %3, align 4, !dbg !419
  br label %13

13:                                               ; preds = %9, %8
  %14 = load i32, ptr %3, align 4, !dbg !420
  ret i32 %14, !dbg !421
}

; Function Attrs: noinline nounwind
define dso_local void @vEventGroupSetNumber(ptr noundef %0, i32 noundef %1) #0 !dbg !422 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %4, align 4, !dbg !423
  %6 = load ptr, ptr %3, align 4, !dbg !424
  %7 = getelementptr inbounds %struct.EventGroupDef_t, ptr %6, i32 0, i32 2, !dbg !425
  store i32 %5, ptr %7, align 4, !dbg !426
  ret void, !dbg !427
}

attributes #0 = { noinline nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #2 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "FreeRTOS/Source/event_groups.c", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 1, !"min_enum_size", i32 4}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{!"clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)"}
!7 = distinct !DISubprogram(name: "xEventGroupCreateStatic", scope: !1, file: !1, line: 96, type: !8, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!8 = !DISubroutineType(types: !9)
!9 = !{}
!10 = !DILocation(line: 114, column: 42, scope: !7)
!11 = !DILocation(line: 114, column: 21, scope: !7)
!12 = !DILocation(line: 116, column: 13, scope: !7)
!13 = !DILocation(line: 116, column: 25, scope: !7)
!14 = !DILocation(line: 118, column: 13, scope: !7)
!15 = !DILocation(line: 118, column: 26, scope: !7)
!16 = !DILocation(line: 118, column: 38, scope: !7)
!17 = !DILocation(line: 119, column: 33, scope: !7)
!18 = !DILocation(line: 119, column: 46, scope: !7)
!19 = !DILocation(line: 119, column: 13, scope: !7)
!20 = !DILocation(line: 126, column: 21, scope: !7)
!21 = !DILocation(line: 126, column: 34, scope: !7)
!22 = !DILocation(line: 126, column: 56, scope: !7)
!23 = !DILocation(line: 131, column: 9, scope: !7)
!24 = !DILocation(line: 140, column: 16, scope: !7)
!25 = !DILocation(line: 140, column: 9, scope: !7)
!26 = distinct !DISubprogram(name: "xEventGroupCreate", scope: !1, file: !1, line: 148, type: !8, scopeLine: 149, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!27 = !DILocation(line: 165, column: 42, scope: !26)
!28 = !DILocation(line: 165, column: 21, scope: !26)
!29 = !DILocation(line: 167, column: 13, scope: !26)
!30 = !DILocation(line: 167, column: 25, scope: !26)
!31 = !DILocation(line: 169, column: 13, scope: !26)
!32 = !DILocation(line: 169, column: 26, scope: !26)
!33 = !DILocation(line: 169, column: 38, scope: !26)
!34 = !DILocation(line: 170, column: 33, scope: !26)
!35 = !DILocation(line: 170, column: 46, scope: !26)
!36 = !DILocation(line: 170, column: 13, scope: !26)
!37 = !DILocation(line: 177, column: 21, scope: !26)
!38 = !DILocation(line: 177, column: 34, scope: !26)
!39 = !DILocation(line: 177, column: 56, scope: !26)
!40 = !DILocation(line: 182, column: 9, scope: !26)
!41 = !DILocation(line: 188, column: 16, scope: !26)
!42 = !DILocation(line: 188, column: 9, scope: !26)
!43 = distinct !DISubprogram(name: "xEventGroupSync", scope: !1, file: !1, line: 194, type: !8, scopeLine: 198, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!44 = !DILocation(line: 200, column: 34, scope: !43)
!45 = !DILocation(line: 200, column: 20, scope: !43)
!46 = !DILocation(line: 202, column: 16, scope: !43)
!47 = !DILocation(line: 212, column: 5, scope: !43)
!48 = !DILocation(line: 214, column: 30, scope: !43)
!49 = !DILocation(line: 214, column: 43, scope: !43)
!50 = !DILocation(line: 214, column: 28, scope: !43)
!51 = !DILocation(line: 216, column: 38, scope: !43)
!52 = !DILocation(line: 216, column: 51, scope: !43)
!53 = !DILocation(line: 216, column: 18, scope: !43)
!54 = !DILocation(line: 218, column: 17, scope: !43)
!55 = !DILocation(line: 218, column: 38, scope: !43)
!56 = !DILocation(line: 218, column: 36, scope: !43)
!57 = !DILocation(line: 218, column: 54, scope: !43)
!58 = !DILocation(line: 218, column: 52, scope: !43)
!59 = !DILocation(line: 218, column: 75, scope: !43)
!60 = !DILocation(line: 218, column: 72, scope: !43)
!61 = !DILocation(line: 218, column: 13, scope: !43)
!62 = !DILocation(line: 221, column: 26, scope: !43)
!63 = !DILocation(line: 221, column: 47, scope: !43)
!64 = !DILocation(line: 221, column: 45, scope: !43)
!65 = !DILocation(line: 221, column: 22, scope: !43)
!66 = !DILocation(line: 225, column: 42, scope: !43)
!67 = !DILocation(line: 225, column: 41, scope: !43)
!68 = !DILocation(line: 225, column: 13, scope: !43)
!69 = !DILocation(line: 225, column: 26, scope: !43)
!70 = !DILocation(line: 225, column: 38, scope: !43)
!71 = !DILocation(line: 227, column: 26, scope: !43)
!72 = !DILocation(line: 228, column: 9, scope: !43)
!73 = !DILocation(line: 231, column: 17, scope: !43)
!74 = !DILocation(line: 231, column: 30, scope: !43)
!75 = !DILocation(line: 238, column: 52, scope: !43)
!76 = !DILocation(line: 238, column: 65, scope: !43)
!77 = !DILocation(line: 238, column: 91, scope: !43)
!78 = !DILocation(line: 238, column: 107, scope: !43)
!79 = !DILocation(line: 238, column: 139, scope: !43)
!80 = !DILocation(line: 238, column: 167, scope: !43)
!81 = !DILocation(line: 238, column: 17, scope: !43)
!82 = !DILocation(line: 244, column: 26, scope: !43)
!83 = !DILocation(line: 245, column: 13, scope: !43)
!84 = !DILocation(line: 250, column: 28, scope: !43)
!85 = !DILocation(line: 250, column: 41, scope: !43)
!86 = !DILocation(line: 250, column: 26, scope: !43)
!87 = !DILocation(line: 251, column: 34, scope: !43)
!88 = !DILocation(line: 255, column: 23, scope: !43)
!89 = !DILocation(line: 255, column: 21, scope: !43)
!90 = !DILocation(line: 257, column: 9, scope: !43)
!91 = !DILocation(line: 257, column: 22, scope: !43)
!92 = !DILocation(line: 259, column: 13, scope: !43)
!93 = !DILocation(line: 259, column: 29, scope: !43)
!94 = !DILocation(line: 261, column: 13, scope: !43)
!95 = !{i64 2148075420}
!96 = !{i64 2148075490}
!97 = !DILocation(line: 262, column: 9, scope: !43)
!98 = !DILocation(line: 272, column: 20, scope: !43)
!99 = !DILocation(line: 272, column: 18, scope: !43)
!100 = !DILocation(line: 274, column: 15, scope: !43)
!101 = !DILocation(line: 274, column: 24, scope: !43)
!102 = !DILocation(line: 274, column: 58, scope: !43)
!103 = !DILocation(line: 274, column: 13, scope: !43)
!104 = !DILocation(line: 277, column: 13, scope: !43)
!105 = !DILocation(line: 279, column: 28, scope: !43)
!106 = !DILocation(line: 279, column: 41, scope: !43)
!107 = !DILocation(line: 279, column: 26, scope: !43)
!108 = !DILocation(line: 285, column: 23, scope: !43)
!109 = !DILocation(line: 285, column: 34, scope: !43)
!110 = !DILocation(line: 285, column: 32, scope: !43)
!111 = !DILocation(line: 285, column: 55, scope: !43)
!112 = !DILocation(line: 285, column: 52, scope: !43)
!113 = !DILocation(line: 285, column: 21, scope: !43)
!114 = !DILocation(line: 287, column: 50, scope: !43)
!115 = !DILocation(line: 287, column: 49, scope: !43)
!116 = !DILocation(line: 287, column: 21, scope: !43)
!117 = !DILocation(line: 287, column: 34, scope: !43)
!118 = !DILocation(line: 287, column: 46, scope: !43)
!119 = !DILocation(line: 288, column: 17, scope: !43)
!120 = !DILocation(line: 294, column: 13, scope: !43)
!121 = !DILocation(line: 296, column: 30, scope: !43)
!122 = !DILocation(line: 297, column: 9, scope: !43)
!123 = !DILocation(line: 305, column: 18, scope: !43)
!124 = !DILocation(line: 306, column: 5, scope: !43)
!125 = !DILocation(line: 308, column: 5, scope: !43)
!126 = !DILocation(line: 311, column: 14, scope: !43)
!127 = !DILocation(line: 313, column: 12, scope: !43)
!128 = !DILocation(line: 313, column: 5, scope: !43)
!129 = distinct !DISubprogram(name: "xEventGroupSetBits", scope: !1, file: !1, line: 533, type: !8, scopeLine: 535, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!130 = !DILocation(line: 539, column: 17, scope: !129)
!131 = !DILocation(line: 540, column: 34, scope: !129)
!132 = !DILocation(line: 540, column: 20, scope: !129)
!133 = !DILocation(line: 541, column: 16, scope: !129)
!134 = !DILocation(line: 548, column: 17, scope: !129)
!135 = !DILocation(line: 548, column: 30, scope: !129)
!136 = !DILocation(line: 548, column: 12, scope: !129)
!137 = !DILocation(line: 549, column: 17, scope: !129)
!138 = !DILocation(line: 549, column: 15, scope: !129)
!139 = !DILocation(line: 550, column: 5, scope: !129)
!140 = !DILocation(line: 554, column: 22, scope: !129)
!141 = !DILocation(line: 554, column: 20, scope: !129)
!142 = !DILocation(line: 557, column: 37, scope: !129)
!143 = !DILocation(line: 557, column: 9, scope: !129)
!144 = !DILocation(line: 557, column: 22, scope: !129)
!145 = !DILocation(line: 557, column: 34, scope: !129)
!146 = !DILocation(line: 560, column: 9, scope: !129)
!147 = !DILocation(line: 560, column: 16, scope: !129)
!148 = !DILocation(line: 560, column: 30, scope: !129)
!149 = !DILocation(line: 560, column: 27, scope: !129)
!150 = !DILocation(line: 562, column: 22, scope: !129)
!151 = !DILocation(line: 562, column: 20, scope: !129)
!152 = !DILocation(line: 563, column: 31, scope: !129)
!153 = !DILocation(line: 563, column: 29, scope: !129)
!154 = !DILocation(line: 564, column: 25, scope: !129)
!155 = !DILocation(line: 567, column: 29, scope: !129)
!156 = !DILocation(line: 567, column: 45, scope: !129)
!157 = !DILocation(line: 567, column: 27, scope: !129)
!158 = !DILocation(line: 568, column: 29, scope: !129)
!159 = !DILocation(line: 570, column: 19, scope: !129)
!160 = !DILocation(line: 570, column: 33, scope: !129)
!161 = !DILocation(line: 570, column: 60, scope: !129)
!162 = !DILocation(line: 570, column: 17, scope: !129)
!163 = !DILocation(line: 573, column: 23, scope: !129)
!164 = !DILocation(line: 573, column: 41, scope: !129)
!165 = !DILocation(line: 573, column: 54, scope: !129)
!166 = !DILocation(line: 573, column: 39, scope: !129)
!167 = !DILocation(line: 573, column: 68, scope: !129)
!168 = !DILocation(line: 573, column: 21, scope: !129)
!169 = !DILocation(line: 575, column: 33, scope: !129)
!170 = !DILocation(line: 576, column: 17, scope: !129)
!171 = !DILocation(line: 581, column: 13, scope: !129)
!172 = !DILocation(line: 582, column: 24, scope: !129)
!173 = !DILocation(line: 582, column: 42, scope: !129)
!174 = !DILocation(line: 582, column: 55, scope: !129)
!175 = !DILocation(line: 582, column: 40, scope: !129)
!176 = !DILocation(line: 582, column: 72, scope: !129)
!177 = !DILocation(line: 582, column: 69, scope: !129)
!178 = !DILocation(line: 582, column: 22, scope: !129)
!179 = !DILocation(line: 585, column: 29, scope: !129)
!180 = !DILocation(line: 586, column: 13, scope: !129)
!181 = !DILocation(line: 592, column: 17, scope: !129)
!182 = !DILocation(line: 592, column: 29, scope: !129)
!183 = !DILocation(line: 595, column: 23, scope: !129)
!184 = !DILocation(line: 595, column: 37, scope: !129)
!185 = !DILocation(line: 595, column: 71, scope: !129)
!186 = !DILocation(line: 595, column: 21, scope: !129)
!187 = !DILocation(line: 597, column: 38, scope: !129)
!188 = !DILocation(line: 597, column: 35, scope: !129)
!189 = !DILocation(line: 598, column: 17, scope: !129)
!190 = !DILocation(line: 609, column: 52, scope: !129)
!191 = !DILocation(line: 609, column: 64, scope: !129)
!192 = !DILocation(line: 609, column: 77, scope: !129)
!193 = !DILocation(line: 609, column: 89, scope: !129)
!194 = !DILocation(line: 609, column: 17, scope: !129)
!195 = !DILocation(line: 610, column: 13, scope: !129)
!196 = !DILocation(line: 615, column: 26, scope: !129)
!197 = !DILocation(line: 615, column: 24, scope: !129)
!198 = distinct !{!198, !146, !199, !200}
!199 = !DILocation(line: 616, column: 9, scope: !129)
!200 = !{!"llvm.loop.mustprogress"}
!201 = !DILocation(line: 620, column: 38, scope: !129)
!202 = !DILocation(line: 620, column: 37, scope: !129)
!203 = !DILocation(line: 620, column: 9, scope: !129)
!204 = !DILocation(line: 620, column: 22, scope: !129)
!205 = !DILocation(line: 620, column: 34, scope: !129)
!206 = !DILocation(line: 622, column: 14, scope: !129)
!207 = !DILocation(line: 624, column: 12, scope: !129)
!208 = !DILocation(line: 624, column: 25, scope: !129)
!209 = !DILocation(line: 624, column: 5, scope: !129)
!210 = distinct !DISubprogram(name: "xEventGroupWaitBits", scope: !1, file: !1, line: 317, type: !8, scopeLine: 322, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!211 = !DILocation(line: 323, column: 34, scope: !210)
!212 = !DILocation(line: 323, column: 20, scope: !210)
!213 = !DILocation(line: 324, column: 27, scope: !210)
!214 = !DILocation(line: 326, column: 16, scope: !210)
!215 = !DILocation(line: 339, column: 5, scope: !210)
!216 = !DILocation(line: 341, column: 48, scope: !210)
!217 = !DILocation(line: 341, column: 61, scope: !210)
!218 = !DILocation(line: 341, column: 27, scope: !210)
!219 = !DILocation(line: 344, column: 51, scope: !210)
!220 = !DILocation(line: 344, column: 71, scope: !210)
!221 = !DILocation(line: 344, column: 88, scope: !210)
!222 = !DILocation(line: 344, column: 29, scope: !210)
!223 = !DILocation(line: 344, column: 27, scope: !210)
!224 = !DILocation(line: 346, column: 13, scope: !210)
!225 = !DILocation(line: 346, column: 31, scope: !210)
!226 = !DILocation(line: 350, column: 24, scope: !210)
!227 = !DILocation(line: 350, column: 22, scope: !210)
!228 = !DILocation(line: 351, column: 26, scope: !210)
!229 = !DILocation(line: 354, column: 17, scope: !210)
!230 = !DILocation(line: 354, column: 30, scope: !210)
!231 = !DILocation(line: 356, column: 46, scope: !210)
!232 = !DILocation(line: 356, column: 45, scope: !210)
!233 = !DILocation(line: 356, column: 17, scope: !210)
!234 = !DILocation(line: 356, column: 30, scope: !210)
!235 = !DILocation(line: 356, column: 42, scope: !210)
!236 = !DILocation(line: 357, column: 13, scope: !210)
!237 = !DILocation(line: 362, column: 9, scope: !210)
!238 = !DILocation(line: 363, column: 18, scope: !210)
!239 = !DILocation(line: 363, column: 31, scope: !210)
!240 = !DILocation(line: 367, column: 24, scope: !210)
!241 = !DILocation(line: 367, column: 22, scope: !210)
!242 = !DILocation(line: 368, column: 30, scope: !210)
!243 = !DILocation(line: 369, column: 9, scope: !210)
!244 = !DILocation(line: 376, column: 17, scope: !210)
!245 = !DILocation(line: 376, column: 30, scope: !210)
!246 = !DILocation(line: 378, column: 31, scope: !210)
!247 = !DILocation(line: 379, column: 13, scope: !210)
!248 = !DILocation(line: 385, column: 17, scope: !210)
!249 = !DILocation(line: 385, column: 33, scope: !210)
!250 = !DILocation(line: 387, column: 31, scope: !210)
!251 = !DILocation(line: 388, column: 13, scope: !210)
!252 = !DILocation(line: 397, column: 48, scope: !210)
!253 = !DILocation(line: 397, column: 61, scope: !210)
!254 = !DILocation(line: 397, column: 87, scope: !210)
!255 = !DILocation(line: 397, column: 105, scope: !210)
!256 = !DILocation(line: 397, column: 103, scope: !210)
!257 = !DILocation(line: 397, column: 122, scope: !210)
!258 = !DILocation(line: 397, column: 13, scope: !210)
!259 = !DILocation(line: 402, column: 22, scope: !210)
!260 = !DILocation(line: 407, column: 23, scope: !210)
!261 = !DILocation(line: 407, column: 21, scope: !210)
!262 = !DILocation(line: 409, column: 9, scope: !210)
!263 = !DILocation(line: 409, column: 22, scope: !210)
!264 = !DILocation(line: 411, column: 13, scope: !210)
!265 = !DILocation(line: 411, column: 29, scope: !210)
!266 = !DILocation(line: 413, column: 13, scope: !210)
!267 = !{i64 2148076373}
!268 = !{i64 2148076443}
!269 = !DILocation(line: 414, column: 9, scope: !210)
!270 = !DILocation(line: 424, column: 20, scope: !210)
!271 = !DILocation(line: 424, column: 18, scope: !210)
!272 = !DILocation(line: 426, column: 15, scope: !210)
!273 = !DILocation(line: 426, column: 24, scope: !210)
!274 = !DILocation(line: 426, column: 58, scope: !210)
!275 = !DILocation(line: 426, column: 13, scope: !210)
!276 = !DILocation(line: 428, column: 13, scope: !210)
!277 = !DILocation(line: 431, column: 28, scope: !210)
!278 = !DILocation(line: 431, column: 41, scope: !210)
!279 = !DILocation(line: 431, column: 26, scope: !210)
!280 = !DILocation(line: 435, column: 43, scope: !210)
!281 = !DILocation(line: 435, column: 53, scope: !210)
!282 = !DILocation(line: 435, column: 70, scope: !210)
!283 = !DILocation(line: 435, column: 21, scope: !210)
!284 = !DILocation(line: 435, column: 88, scope: !210)
!285 = !DILocation(line: 437, column: 25, scope: !210)
!286 = !DILocation(line: 437, column: 38, scope: !210)
!287 = !DILocation(line: 439, column: 54, scope: !210)
!288 = !DILocation(line: 439, column: 53, scope: !210)
!289 = !DILocation(line: 439, column: 25, scope: !210)
!290 = !DILocation(line: 439, column: 38, scope: !210)
!291 = !DILocation(line: 439, column: 50, scope: !210)
!292 = !DILocation(line: 440, column: 21, scope: !210)
!293 = !DILocation(line: 445, column: 17, scope: !210)
!294 = !DILocation(line: 451, column: 34, scope: !210)
!295 = !DILocation(line: 453, column: 13, scope: !210)
!296 = !DILocation(line: 454, column: 9, scope: !210)
!297 = !DILocation(line: 461, column: 18, scope: !210)
!298 = !DILocation(line: 462, column: 5, scope: !210)
!299 = !DILocation(line: 464, column: 5, scope: !210)
!300 = !DILocation(line: 467, column: 14, scope: !210)
!301 = !DILocation(line: 469, column: 12, scope: !210)
!302 = !DILocation(line: 469, column: 5, scope: !210)
!303 = distinct !DISubprogram(name: "prvTestWaitCondition", scope: !1, file: !1, line: 692, type: !8, scopeLine: 695, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!304 = !DILocation(line: 696, column: 16, scope: !303)
!305 = !DILocation(line: 698, column: 9, scope: !303)
!306 = !DILocation(line: 698, column: 25, scope: !303)
!307 = !DILocation(line: 702, column: 15, scope: !303)
!308 = !DILocation(line: 702, column: 36, scope: !303)
!309 = !DILocation(line: 702, column: 34, scope: !303)
!310 = !DILocation(line: 702, column: 54, scope: !303)
!311 = !DILocation(line: 702, column: 13, scope: !303)
!312 = !DILocation(line: 704, column: 31, scope: !303)
!313 = !DILocation(line: 705, column: 9, scope: !303)
!314 = !DILocation(line: 710, column: 5, scope: !303)
!315 = !DILocation(line: 715, column: 15, scope: !303)
!316 = !DILocation(line: 715, column: 36, scope: !303)
!317 = !DILocation(line: 715, column: 34, scope: !303)
!318 = !DILocation(line: 715, column: 57, scope: !303)
!319 = !DILocation(line: 715, column: 54, scope: !303)
!320 = !DILocation(line: 715, column: 13, scope: !303)
!321 = !DILocation(line: 717, column: 31, scope: !303)
!322 = !DILocation(line: 718, column: 9, scope: !303)
!323 = !DILocation(line: 725, column: 12, scope: !303)
!324 = !DILocation(line: 725, column: 5, scope: !303)
!325 = distinct !DISubprogram(name: "xEventGroupClearBits", scope: !1, file: !1, line: 473, type: !8, scopeLine: 475, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!326 = !DILocation(line: 476, column: 34, scope: !325)
!327 = !DILocation(line: 476, column: 20, scope: !325)
!328 = !DILocation(line: 484, column: 5, scope: !325)
!329 = !DILocation(line: 490, column: 20, scope: !325)
!330 = !DILocation(line: 490, column: 33, scope: !325)
!331 = !DILocation(line: 490, column: 18, scope: !325)
!332 = !DILocation(line: 493, column: 38, scope: !325)
!333 = !DILocation(line: 493, column: 37, scope: !325)
!334 = !DILocation(line: 493, column: 9, scope: !325)
!335 = !DILocation(line: 493, column: 22, scope: !325)
!336 = !DILocation(line: 493, column: 34, scope: !325)
!337 = !DILocation(line: 495, column: 5, scope: !325)
!338 = !DILocation(line: 497, column: 12, scope: !325)
!339 = !DILocation(line: 497, column: 5, scope: !325)
!340 = distinct !DISubprogram(name: "xEventGroupClearBitsFromISR", scope: !1, file: !1, line: 503, type: !8, scopeLine: 505, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!341 = !DILocation(line: 509, column: 91, scope: !340)
!342 = !DILocation(line: 509, column: 117, scope: !340)
!343 = !DILocation(line: 509, column: 19, scope: !340)
!344 = !DILocation(line: 509, column: 17, scope: !340)
!345 = !DILocation(line: 511, column: 16, scope: !340)
!346 = !DILocation(line: 511, column: 9, scope: !340)
!347 = distinct !DISubprogram(name: "vEventGroupClearBitsCallback", scope: !1, file: !1, line: 685, type: !8, scopeLine: 687, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!348 = !DILocation(line: 688, column: 36, scope: !347)
!349 = !DILocation(line: 688, column: 66, scope: !347)
!350 = !DILocation(line: 688, column: 14, scope: !347)
!351 = !DILocation(line: 689, column: 1, scope: !347)
!352 = distinct !DISubprogram(name: "xEventGroupGetBitsFromISR", scope: !1, file: !1, line: 517, type: !8, scopeLine: 518, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!353 = !DILocation(line: 520, column: 46, scope: !352)
!354 = !DILocation(line: 520, column: 32, scope: !352)
!355 = !DILocation(line: 216, column: 9, scope: !356, inlinedAt: !358)
!356 = distinct !DISubprogram(name: "ulPortRaiseBASEPRI", scope: !357, file: !357, line: 212, type: !8, scopeLine: 213, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!357 = !DIFile(filename: "FreeRTOS/Source/portable/GCC/ARM_CM3/portmacro.h", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!358 = distinct !DILocation(line: 523, column: 30, scope: !352)
!359 = !{i64 320363, i64 320410, i64 320452, i64 320498, i64 320535}
!360 = !DILocation(line: 228, column: 16, scope: !356, inlinedAt: !358)
!361 = !DILocation(line: 523, column: 28, scope: !352)
!362 = !DILocation(line: 525, column: 20, scope: !352)
!363 = !DILocation(line: 525, column: 33, scope: !352)
!364 = !DILocation(line: 525, column: 18, scope: !352)
!365 = !DILocation(line: 527, column: 5, scope: !352)
!366 = !DILocation(line: 236, column: 40, scope: !367, inlinedAt: !368)
!367 = distinct !DISubprogram(name: "vPortSetBASEPRI", scope: !357, file: !357, line: 232, type: !8, scopeLine: 233, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!368 = distinct !DILocation(line: 527, column: 5, scope: !352)
!369 = !DILocation(line: 234, column: 9, scope: !367, inlinedAt: !368)
!370 = !{i64 321042}
!371 = !DILocation(line: 529, column: 12, scope: !352)
!372 = !DILocation(line: 529, column: 5, scope: !352)
!373 = distinct !DISubprogram(name: "vEventGroupDelete", scope: !1, file: !1, line: 628, type: !8, scopeLine: 629, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!374 = !DILocation(line: 630, column: 34, scope: !373)
!375 = !DILocation(line: 630, column: 20, scope: !373)
!376 = !DILocation(line: 635, column: 32, scope: !373)
!377 = !DILocation(line: 635, column: 45, scope: !373)
!378 = !DILocation(line: 635, column: 27, scope: !373)
!379 = !DILocation(line: 637, column: 5, scope: !373)
!380 = !DILocation(line: 641, column: 9, scope: !373)
!381 = !DILocation(line: 641, column: 16, scope: !373)
!382 = !DILocation(line: 641, column: 65, scope: !373)
!383 = !DILocation(line: 646, column: 48, scope: !373)
!384 = !DILocation(line: 646, column: 71, scope: !373)
!385 = !DILocation(line: 646, column: 80, scope: !373)
!386 = !DILocation(line: 646, column: 13, scope: !373)
!387 = distinct !{!387, !380, !388, !200}
!388 = !DILocation(line: 647, column: 9, scope: !373)
!389 = !DILocation(line: 659, column: 21, scope: !373)
!390 = !DILocation(line: 659, column: 34, scope: !373)
!391 = !DILocation(line: 659, column: 56, scope: !373)
!392 = !DILocation(line: 661, column: 32, scope: !373)
!393 = !DILocation(line: 661, column: 21, scope: !373)
!394 = !DILocation(line: 662, column: 17, scope: !373)
!395 = !DILocation(line: 670, column: 14, scope: !373)
!396 = !DILocation(line: 671, column: 1, scope: !373)
!397 = distinct !DISubprogram(name: "vEventGroupSetBitsCallback", scope: !1, file: !1, line: 676, type: !8, scopeLine: 678, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!398 = !DILocation(line: 679, column: 34, scope: !397)
!399 = !DILocation(line: 679, column: 64, scope: !397)
!400 = !DILocation(line: 679, column: 14, scope: !397)
!401 = !DILocation(line: 680, column: 1, scope: !397)
!402 = distinct !DISubprogram(name: "xEventGroupSetBitsFromISR", scope: !1, file: !1, line: 731, type: !8, scopeLine: 734, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!403 = !DILocation(line: 738, column: 89, scope: !402)
!404 = !DILocation(line: 738, column: 115, scope: !402)
!405 = !DILocation(line: 738, column: 128, scope: !402)
!406 = !DILocation(line: 738, column: 19, scope: !402)
!407 = !DILocation(line: 738, column: 17, scope: !402)
!408 = !DILocation(line: 740, column: 16, scope: !402)
!409 = !DILocation(line: 740, column: 9, scope: !402)
!410 = distinct !DISubprogram(name: "uxEventGroupGetNumber", scope: !1, file: !1, line: 748, type: !8, scopeLine: 749, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!411 = !DILocation(line: 751, column: 63, scope: !410)
!412 = !DILocation(line: 751, column: 30, scope: !410)
!413 = !DILocation(line: 753, column: 13, scope: !410)
!414 = !DILocation(line: 753, column: 25, scope: !410)
!415 = !DILocation(line: 755, column: 21, scope: !410)
!416 = !DILocation(line: 756, column: 9, scope: !410)
!417 = !DILocation(line: 759, column: 23, scope: !410)
!418 = !DILocation(line: 759, column: 36, scope: !410)
!419 = !DILocation(line: 759, column: 21, scope: !410)
!420 = !DILocation(line: 762, column: 16, scope: !410)
!421 = !DILocation(line: 762, column: 9, scope: !410)
!422 = distinct !DISubprogram(name: "vEventGroupSetNumber", scope: !1, file: !1, line: 770, type: !8, scopeLine: 772, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!423 = !DILocation(line: 773, column: 66, scope: !422)
!424 = !DILocation(line: 773, column: 30, scope: !422)
!425 = !DILocation(line: 773, column: 45, scope: !422)
!426 = !DILocation(line: 773, column: 64, scope: !422)
!427 = !DILocation(line: 774, column: 5, scope: !422)
