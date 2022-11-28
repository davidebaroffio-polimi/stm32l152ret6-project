; ModuleID = 'Core/Src/main.c'
source_filename = "Core/Src/main.c"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-unknown-eabi"

%struct.__UART_HandleTypeDef = type { ptr, %struct.UART_InitTypeDef, ptr, i16, i16, ptr, i16, i16, i32, ptr, ptr, i32, i32, i32, i32 }
%struct.UART_InitTypeDef = type { i32, i32, i32, i32, i32, i32, i32 }
%struct.TIM_HandleTypeDef = type { ptr, %struct.TIM_Base_InitTypeDef, i32, [7 x ptr], i32, i32, [4 x i32], i32 }
%struct.TIM_Base_InitTypeDef = type { i32, i32, i32, i32, i32 }
%struct.RCC_OscInitTypeDef = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, %struct.RCC_PLLInitTypeDef }
%struct.RCC_PLLInitTypeDef = type { i32, i32, i32, i32 }
%struct.RCC_ClkInitTypeDef = type { i32, i32, i32, i32, i32 }
%struct.GPIO_InitTypeDef = type { i32, i32, i32, i32, i32 }
%struct.RCC_TypeDef = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }
%struct.TIM_MasterConfigTypeDef = type { i32, i32 }

@.str = private unnamed_addr constant [5 x i8] c"Led2\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"Led1\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c"des\00", align 1
@.str.3 = private unnamed_addr constant [8 x i8] c"include\00", section "llvm.metadata"
@.str.4 = private unnamed_addr constant [16 x i8] c"Core/Src/main.c\00", section "llvm.metadata"
@.str.5 = private unnamed_addr constant [5 x i8] c"task\00", section "llvm.metadata"
@.str.6 = private unnamed_addr constant [8 x i8] c"exclude\00", section "llvm.metadata"
@huart2 = dso_local global %struct.__UART_HandleTypeDef zeroinitializer, align 4
@htim6 = dso_local global %struct.TIM_HandleTypeDef zeroinitializer, align 4
@llvm.global.annotations = appending global [9 x { ptr, ptr, ptr, i32, ptr }] [{ ptr, ptr, ptr, i32, ptr } { ptr @main, ptr @.str.3, ptr @.str.4, i32 71, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @SystemClock_Config, ptr @.str.3, ptr @.str.4, i32 124, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskCode1, ptr @.str.5, ptr @.str.4, i32 270, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskCode2, ptr @.str.5, ptr @.str.4, i32 295, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vTaskDES, ptr @.str.5, ptr @.str.4, i32 321, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @Error_Handler, ptr @.str.6, ptr @.str.4, i32 356, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @MX_USART2_UART_Init, ptr @.str.3, ptr @.str.4, i32 168, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @MX_GPIO_Init, ptr @.str.3, ptr @.str.4, i32 201, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @MX_TIM6_Init, ptr @.str.3, ptr @.str.4, i32 234, ptr null }], section "llvm.metadata"

; Function Attrs: noinline nounwind
define dso_local i32 @main() #0 !dbg !7 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %6 = call i32 @HAL_Init(), !dbg !10
  call void @SystemClock_Config(), !dbg !11
  call void @MX_GPIO_Init(), !dbg !12
  call void @MX_USART2_UART_Init(), !dbg !13
  call void @MX_TIM6_Init(), !dbg !14
  %7 = call i32 @xTaskCreate(ptr noundef @vTaskCode2, ptr noundef @.str, i16 noundef zeroext 128, ptr noundef null, i32 noundef 2, ptr noundef null), !dbg !15
  store i32 %7, ptr %2, align 4, !dbg !16
  %8 = call i32 @xTaskCreate(ptr noundef @vTaskCode1, ptr noundef @.str.1, i16 noundef zeroext 128, ptr noundef null, i32 noundef 3, ptr noundef null), !dbg !17
  store i32 %8, ptr %3, align 4, !dbg !18
  %9 = call i32 @xTaskCreate(ptr noundef @vTaskDES, ptr noundef @.str.2, i16 noundef zeroext 256, ptr noundef null, i32 noundef 1, ptr noundef null), !dbg !19
  store i32 %9, ptr %4, align 4, !dbg !20
  %10 = load i32, ptr %3, align 4, !dbg !21
  %11 = icmp eq i32 %10, 1, !dbg !22
  br i1 %11, label %12, label %19, !dbg !23

12:                                               ; preds = %0
  %13 = load i32, ptr %2, align 4, !dbg !24
  %14 = icmp eq i32 %13, 1, !dbg !25
  br i1 %14, label %15, label %19, !dbg !26

15:                                               ; preds = %12
  %16 = load i32, ptr %4, align 4, !dbg !27
  %17 = icmp eq i32 %16, 1, !dbg !28
  br i1 %17, label %18, label %19, !dbg !21

18:                                               ; preds = %15
  call void @vTaskStartScheduler(), !dbg !29
  br label %19, !dbg !29

19:                                               ; preds = %18, %15, %12, %0
  br label %20, !dbg !30

20:                                               ; preds = %19, %28
  call void @HAL_GPIO_TogglePin(ptr noundef inttoptr (i32 1073872896 to ptr), i16 noundef zeroext 32), !dbg !31
  store i32 0, ptr %5, align 4, !dbg !32
  br label %21, !dbg !33

21:                                               ; preds = %25, %20
  %22 = load i32, ptr %5, align 4, !dbg !34
  %23 = icmp slt i32 %22, 100000, !dbg !35
  br i1 %23, label %24, label %28, !dbg !36

24:                                               ; preds = %21
  br label %25, !dbg !36

25:                                               ; preds = %24
  %26 = load i32, ptr %5, align 4, !dbg !37
  %27 = add nsw i32 %26, 1, !dbg !37
  store i32 %27, ptr %5, align 4, !dbg !37
  br label %21, !dbg !36, !llvm.loop !38

28:                                               ; preds = %21
  br label %20, !dbg !30, !llvm.loop !41
}

declare dso_local i32 @HAL_Init() #1

; Function Attrs: noinline nounwind
define dso_local void @SystemClock_Config() #0 !dbg !43 {
  %1 = alloca %struct.RCC_OscInitTypeDef, align 4
  %2 = alloca %struct.RCC_ClkInitTypeDef, align 4
  call void @llvm.memset.p0.i32(ptr align 4 %1, i8 0, i32 52, i1 false), !dbg !44
  call void @llvm.memset.p0.i32(ptr align 4 %2, i8 0, i32 20, i1 false), !dbg !45
  %3 = load volatile i32, ptr inttoptr (i32 1073770496 to ptr), align 4, !dbg !46
  %4 = and i32 %3, -6145, !dbg !46
  %5 = or i32 %4, 2048, !dbg !46
  store volatile i32 %5, ptr inttoptr (i32 1073770496 to ptr), align 4, !dbg !46
  %6 = getelementptr inbounds %struct.RCC_OscInitTypeDef, ptr %1, i32 0, i32 0, !dbg !47
  store i32 2, ptr %6, align 4, !dbg !48
  %7 = getelementptr inbounds %struct.RCC_OscInitTypeDef, ptr %1, i32 0, i32 3, !dbg !49
  store i32 1, ptr %7, align 4, !dbg !50
  %8 = getelementptr inbounds %struct.RCC_OscInitTypeDef, ptr %1, i32 0, i32 4, !dbg !51
  store i32 16, ptr %8, align 4, !dbg !52
  %9 = getelementptr inbounds %struct.RCC_OscInitTypeDef, ptr %1, i32 0, i32 9, !dbg !53
  %10 = getelementptr inbounds %struct.RCC_PLLInitTypeDef, ptr %9, i32 0, i32 0, !dbg !54
  store i32 2, ptr %10, align 4, !dbg !55
  %11 = getelementptr inbounds %struct.RCC_OscInitTypeDef, ptr %1, i32 0, i32 9, !dbg !56
  %12 = getelementptr inbounds %struct.RCC_PLLInitTypeDef, ptr %11, i32 0, i32 1, !dbg !57
  store i32 0, ptr %12, align 4, !dbg !58
  %13 = getelementptr inbounds %struct.RCC_OscInitTypeDef, ptr %1, i32 0, i32 9, !dbg !59
  %14 = getelementptr inbounds %struct.RCC_PLLInitTypeDef, ptr %13, i32 0, i32 2, !dbg !60
  store i32 524288, ptr %14, align 4, !dbg !61
  %15 = getelementptr inbounds %struct.RCC_OscInitTypeDef, ptr %1, i32 0, i32 9, !dbg !62
  %16 = getelementptr inbounds %struct.RCC_PLLInitTypeDef, ptr %15, i32 0, i32 3, !dbg !63
  store i32 8388608, ptr %16, align 4, !dbg !64
  %17 = call i32 @HAL_RCC_OscConfig(ptr noundef %1), !dbg !65
  %18 = icmp ne i32 %17, 0, !dbg !66
  br i1 %18, label %19, label %20, !dbg !65

19:                                               ; preds = %0
  call void @Error_Handler(), !dbg !67
  br label %20, !dbg !68

20:                                               ; preds = %19, %0
  %21 = getelementptr inbounds %struct.RCC_ClkInitTypeDef, ptr %2, i32 0, i32 0, !dbg !69
  store i32 15, ptr %21, align 4, !dbg !70
  %22 = getelementptr inbounds %struct.RCC_ClkInitTypeDef, ptr %2, i32 0, i32 1, !dbg !71
  store i32 3, ptr %22, align 4, !dbg !72
  %23 = getelementptr inbounds %struct.RCC_ClkInitTypeDef, ptr %2, i32 0, i32 2, !dbg !73
  store i32 0, ptr %23, align 4, !dbg !74
  %24 = getelementptr inbounds %struct.RCC_ClkInitTypeDef, ptr %2, i32 0, i32 3, !dbg !75
  store i32 0, ptr %24, align 4, !dbg !76
  %25 = getelementptr inbounds %struct.RCC_ClkInitTypeDef, ptr %2, i32 0, i32 4, !dbg !77
  store i32 0, ptr %25, align 4, !dbg !78
  %26 = call i32 @HAL_RCC_ClockConfig(ptr noundef %2, i32 noundef 1), !dbg !79
  %27 = icmp ne i32 %26, 0, !dbg !80
  br i1 %27, label %28, label %29, !dbg !79

28:                                               ; preds = %20
  call void @Error_Handler(), !dbg !81
  br label %29, !dbg !82

29:                                               ; preds = %28, %20
  ret void, !dbg !83
}

; Function Attrs: noinline nounwind
define internal void @MX_GPIO_Init() #0 !dbg !84 {
  %1 = alloca %struct.GPIO_InitTypeDef, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  call void @llvm.memset.p0.i32(ptr align 4 %1, i8 0, i32 20, i1 false), !dbg !85
  br label %6, !dbg !86

6:                                                ; preds = %0
  %7 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !86
  %8 = or i32 %7, 4, !dbg !86
  store volatile i32 %8, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !86
  %9 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !86
  %10 = and i32 %9, 4, !dbg !86
  store volatile i32 %10, ptr %2, align 4, !dbg !86
  %11 = load volatile i32, ptr %2, align 4, !dbg !86
  br label %12, !dbg !86

12:                                               ; preds = %6
  br label %13, !dbg !87

13:                                               ; preds = %12
  %14 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !87
  %15 = or i32 %14, 32, !dbg !87
  store volatile i32 %15, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !87
  %16 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !87
  %17 = and i32 %16, 32, !dbg !87
  store volatile i32 %17, ptr %3, align 4, !dbg !87
  %18 = load volatile i32, ptr %3, align 4, !dbg !87
  br label %19, !dbg !87

19:                                               ; preds = %13
  br label %20, !dbg !88

20:                                               ; preds = %19
  %21 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !88
  %22 = or i32 %21, 1, !dbg !88
  store volatile i32 %22, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !88
  %23 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !88
  %24 = and i32 %23, 1, !dbg !88
  store volatile i32 %24, ptr %4, align 4, !dbg !88
  %25 = load volatile i32, ptr %4, align 4, !dbg !88
  br label %26, !dbg !88

26:                                               ; preds = %20
  br label %27, !dbg !89

27:                                               ; preds = %26
  %28 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !89
  %29 = or i32 %28, 2, !dbg !89
  store volatile i32 %29, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !89
  %30 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !89
  %31 = and i32 %30, 2, !dbg !89
  store volatile i32 %31, ptr %5, align 4, !dbg !89
  %32 = load volatile i32, ptr %5, align 4, !dbg !89
  br label %33, !dbg !89

33:                                               ; preds = %27
  call void @HAL_GPIO_WritePin(ptr noundef inttoptr (i32 1073872896 to ptr), i16 noundef zeroext 32, i32 noundef 0), !dbg !90
  %34 = getelementptr inbounds %struct.GPIO_InitTypeDef, ptr %1, i32 0, i32 0, !dbg !91
  store i32 8192, ptr %34, align 4, !dbg !92
  %35 = getelementptr inbounds %struct.GPIO_InitTypeDef, ptr %1, i32 0, i32 1, !dbg !93
  store i32 1114112, ptr %35, align 4, !dbg !94
  %36 = getelementptr inbounds %struct.GPIO_InitTypeDef, ptr %1, i32 0, i32 2, !dbg !95
  store i32 0, ptr %36, align 4, !dbg !96
  call void @HAL_GPIO_Init(ptr noundef inttoptr (i32 1073874944 to ptr), ptr noundef %1), !dbg !97
  %37 = getelementptr inbounds %struct.GPIO_InitTypeDef, ptr %1, i32 0, i32 0, !dbg !98
  store i32 32, ptr %37, align 4, !dbg !99
  %38 = getelementptr inbounds %struct.GPIO_InitTypeDef, ptr %1, i32 0, i32 1, !dbg !100
  store i32 1, ptr %38, align 4, !dbg !101
  %39 = getelementptr inbounds %struct.GPIO_InitTypeDef, ptr %1, i32 0, i32 2, !dbg !102
  store i32 0, ptr %39, align 4, !dbg !103
  %40 = getelementptr inbounds %struct.GPIO_InitTypeDef, ptr %1, i32 0, i32 3, !dbg !104
  store i32 0, ptr %40, align 4, !dbg !105
  call void @HAL_GPIO_Init(ptr noundef inttoptr (i32 1073872896 to ptr), ptr noundef %1), !dbg !106
  ret void, !dbg !107
}

; Function Attrs: noinline nounwind
define internal void @MX_USART2_UART_Init() #0 !dbg !108 {
  store ptr inttoptr (i32 1073759232 to ptr), ptr @huart2, align 4, !dbg !109
  store i32 115200, ptr getelementptr inbounds (%struct.__UART_HandleTypeDef, ptr @huart2, i32 0, i32 1), align 4, !dbg !110
  store i32 0, ptr getelementptr inbounds (%struct.__UART_HandleTypeDef, ptr @huart2, i32 0, i32 1, i32 1), align 4, !dbg !111
  store i32 0, ptr getelementptr inbounds (%struct.__UART_HandleTypeDef, ptr @huart2, i32 0, i32 1, i32 2), align 4, !dbg !112
  store i32 0, ptr getelementptr inbounds (%struct.__UART_HandleTypeDef, ptr @huart2, i32 0, i32 1, i32 3), align 4, !dbg !113
  store i32 12, ptr getelementptr inbounds (%struct.__UART_HandleTypeDef, ptr @huart2, i32 0, i32 1, i32 4), align 4, !dbg !114
  store i32 0, ptr getelementptr inbounds (%struct.__UART_HandleTypeDef, ptr @huart2, i32 0, i32 1, i32 5), align 4, !dbg !115
  store i32 0, ptr getelementptr inbounds (%struct.__UART_HandleTypeDef, ptr @huart2, i32 0, i32 1, i32 6), align 4, !dbg !116
  %1 = call i32 @HAL_UART_Init(ptr noundef @huart2), !dbg !117
  %2 = icmp ne i32 %1, 0, !dbg !118
  br i1 %2, label %3, label %4, !dbg !117

3:                                                ; preds = %0
  call void @Error_Handler(), !dbg !119
  br label %4, !dbg !120

4:                                                ; preds = %3, %0
  ret void, !dbg !121
}

; Function Attrs: noinline nounwind
define internal void @MX_TIM6_Init() #0 !dbg !122 {
  %1 = alloca %struct.TIM_MasterConfigTypeDef, align 4
  call void @llvm.memset.p0.i32(ptr align 4 %1, i8 0, i32 8, i1 false), !dbg !123
  store ptr inttoptr (i32 1073745920 to ptr), ptr @htim6, align 4, !dbg !124
  store i32 0, ptr getelementptr inbounds (%struct.TIM_HandleTypeDef, ptr @htim6, i32 0, i32 1), align 4, !dbg !125
  store i32 0, ptr getelementptr inbounds (%struct.TIM_HandleTypeDef, ptr @htim6, i32 0, i32 1, i32 1), align 4, !dbg !126
  store i32 65535, ptr getelementptr inbounds (%struct.TIM_HandleTypeDef, ptr @htim6, i32 0, i32 1, i32 2), align 4, !dbg !127
  store i32 0, ptr getelementptr inbounds (%struct.TIM_HandleTypeDef, ptr @htim6, i32 0, i32 1, i32 4), align 4, !dbg !128
  %2 = call i32 @HAL_TIM_Base_Init(ptr noundef @htim6), !dbg !129
  %3 = icmp ne i32 %2, 0, !dbg !130
  br i1 %3, label %4, label %5, !dbg !129

4:                                                ; preds = %0
  call void @Error_Handler(), !dbg !131
  br label %5, !dbg !132

5:                                                ; preds = %4, %0
  %6 = getelementptr inbounds %struct.TIM_MasterConfigTypeDef, ptr %1, i32 0, i32 0, !dbg !133
  store i32 0, ptr %6, align 4, !dbg !134
  %7 = getelementptr inbounds %struct.TIM_MasterConfigTypeDef, ptr %1, i32 0, i32 1, !dbg !135
  store i32 0, ptr %7, align 4, !dbg !136
  %8 = call i32 @HAL_TIMEx_MasterConfigSynchronization(ptr noundef @htim6, ptr noundef %1), !dbg !137
  %9 = icmp ne i32 %8, 0, !dbg !138
  br i1 %9, label %10, label %11, !dbg !137

10:                                               ; preds = %5
  call void @Error_Handler(), !dbg !139
  br label %11, !dbg !140

11:                                               ; preds = %10, %5
  ret void, !dbg !141
}

declare dso_local i32 @xTaskCreate(ptr noundef, ptr noundef, i16 noundef zeroext, ptr noundef, i32 noundef, ptr noundef) #1

; Function Attrs: noinline nounwind
define dso_local void @vTaskCode2(ptr noundef %0) #0 !dbg !142 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  store i32 200, ptr %4, align 4, !dbg !143
  %6 = call i32 @xTaskGetTickCount(), !dbg !144
  store i32 %6, ptr %3, align 4, !dbg !145
  br label %7, !dbg !146

7:                                                ; preds = %12, %1
  %8 = call i32 @xTaskDelayUntil(ptr noundef %3, i32 noundef 200), !dbg !147
  store i32 %8, ptr %5, align 4, !dbg !148
  %9 = load i32, ptr %5, align 4, !dbg !149
  %10 = icmp ne i32 %9, 0, !dbg !149
  br i1 %10, label %11, label %12, !dbg !149

11:                                               ; preds = %7
  call void @HAL_GPIO_WritePin(ptr noundef inttoptr (i32 1073872896 to ptr), i16 noundef zeroext 32, i32 noundef 0), !dbg !150
  br label %12, !dbg !150

12:                                               ; preds = %11, %7
  br label %7, !dbg !146, !llvm.loop !151
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskCode1(ptr noundef %0) #0 !dbg !153 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  store i32 100, ptr %4, align 4, !dbg !154
  %6 = call i32 @xTaskGetTickCount(), !dbg !155
  store i32 %6, ptr %3, align 4, !dbg !156
  br label %7, !dbg !157

7:                                                ; preds = %12, %1
  %8 = call i32 @xTaskDelayUntil(ptr noundef %3, i32 noundef 100), !dbg !158
  store i32 %8, ptr %5, align 4, !dbg !159
  %9 = load i32, ptr %5, align 4, !dbg !160
  %10 = icmp ne i32 %9, 0, !dbg !160
  br i1 %10, label %11, label %12, !dbg !160

11:                                               ; preds = %7
  call void @HAL_GPIO_WritePin(ptr noundef inttoptr (i32 1073872896 to ptr), i16 noundef zeroext 32, i32 noundef 0), !dbg !161
  br label %12, !dbg !161

12:                                               ; preds = %11, %7
  br label %7, !dbg !157, !llvm.loop !162
}

; Function Attrs: noinline nounwind
define dso_local void @vTaskDES(ptr noundef %0) #0 !dbg !164 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  store i32 300, ptr %4, align 4, !dbg !165
  %6 = call i32 @xTaskGetTickCount(), !dbg !166
  store i32 %6, ptr %3, align 4, !dbg !167
  br label %7, !dbg !168

7:                                                ; preds = %12, %1
  %8 = call i32 @xTaskDelayUntil(ptr noundef %3, i32 noundef 300), !dbg !169
  store i32 %8, ptr %5, align 4, !dbg !170
  call void @HAL_GPIO_WritePin(ptr noundef inttoptr (i32 1073872896 to ptr), i16 noundef zeroext 32, i32 noundef 1), !dbg !171
  %9 = load i32, ptr %5, align 4, !dbg !172
  %10 = icmp ne i32 %9, 0, !dbg !172
  br i1 %10, label %11, label %12, !dbg !172

11:                                               ; preds = %7
  call void @testDES(), !dbg !173
  call void @HAL_GPIO_WritePin(ptr noundef inttoptr (i32 1073872896 to ptr), i16 noundef zeroext 32, i32 noundef 0), !dbg !174
  br label %12, !dbg !175

12:                                               ; preds = %11, %7
  br label %7, !dbg !168, !llvm.loop !176
}

declare dso_local void @vTaskStartScheduler() #1

declare dso_local void @HAL_GPIO_TogglePin(ptr noundef, i16 noundef zeroext) #1

; Function Attrs: argmemonly nocallback nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i32(ptr nocapture writeonly, i8, i32, i1 immarg) #2

declare dso_local i32 @HAL_RCC_OscConfig(ptr noundef) #1

; Function Attrs: noinline nounwind
define dso_local void @Error_Handler() #0 !dbg !178 {
  call void asm sideeffect "cpsid i", "~{memory}"() #3, !dbg !179, !srcloc !183
  br label %1, !dbg !184

1:                                                ; preds = %0, %1
  br label %1, !dbg !184, !llvm.loop !185
}

declare dso_local i32 @HAL_RCC_ClockConfig(ptr noundef, i32 noundef) #1

declare dso_local i32 @xTaskGetTickCount() #1

declare dso_local i32 @xTaskDelayUntil(ptr noundef, i32 noundef) #1

declare dso_local void @HAL_GPIO_WritePin(ptr noundef, i16 noundef zeroext, i32 noundef) #1

declare dso_local void @testDES(...) #1

declare dso_local i32 @HAL_UART_Init(ptr noundef) #1

declare dso_local void @HAL_GPIO_Init(ptr noundef, ptr noundef) #1

declare dso_local i32 @HAL_TIM_Base_Init(ptr noundef) #1

declare dso_local i32 @HAL_TIMEx_MasterConfigSynchronization(ptr noundef, ptr noundef) #1

attributes #0 = { noinline nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #2 = { argmemonly nocallback nofree nounwind willreturn writeonly }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "Core/Src/main.c", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 1, !"min_enum_size", i32 4}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{!"clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 71, type: !8, scopeLine: 72, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!8 = !DISubroutineType(types: !9)
!9 = !{}
!10 = !DILocation(line: 80, column: 3, scope: !7)
!11 = !DILocation(line: 87, column: 3, scope: !7)
!12 = !DILocation(line: 94, column: 3, scope: !7)
!13 = !DILocation(line: 95, column: 3, scope: !7)
!14 = !DILocation(line: 96, column: 3, scope: !7)
!15 = !DILocation(line: 99, column: 22, scope: !7)
!16 = !DILocation(line: 99, column: 14, scope: !7)
!17 = !DILocation(line: 100, column: 22, scope: !7)
!18 = !DILocation(line: 100, column: 14, scope: !7)
!19 = !DILocation(line: 102, column: 22, scope: !7)
!20 = !DILocation(line: 102, column: 14, scope: !7)
!21 = !DILocation(line: 104, column: 7, scope: !7)
!22 = !DILocation(line: 104, column: 13, scope: !7)
!23 = !DILocation(line: 104, column: 23, scope: !7)
!24 = !DILocation(line: 104, column: 26, scope: !7)
!25 = !DILocation(line: 104, column: 32, scope: !7)
!26 = !DILocation(line: 104, column: 42, scope: !7)
!27 = !DILocation(line: 104, column: 45, scope: !7)
!28 = !DILocation(line: 104, column: 51, scope: !7)
!29 = !DILocation(line: 105, column: 5, scope: !7)
!30 = !DILocation(line: 110, column: 3, scope: !7)
!31 = !DILocation(line: 113, column: 5, scope: !7)
!32 = !DILocation(line: 114, column: 14, scope: !7)
!33 = !DILocation(line: 114, column: 10, scope: !7)
!34 = !DILocation(line: 114, column: 19, scope: !7)
!35 = !DILocation(line: 114, column: 20, scope: !7)
!36 = !DILocation(line: 114, column: 5, scope: !7)
!37 = !DILocation(line: 114, column: 30, scope: !7)
!38 = distinct !{!38, !36, !39, !40}
!39 = !DILocation(line: 114, column: 33, scope: !7)
!40 = !{!"llvm.loop.mustprogress"}
!41 = distinct !{!41, !30, !42}
!42 = !DILocation(line: 116, column: 3, scope: !7)
!43 = distinct !DISubprogram(name: "SystemClock_Config", scope: !1, file: !1, line: 124, type: !8, scopeLine: 125, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!44 = !DILocation(line: 126, column: 22, scope: !43)
!45 = !DILocation(line: 127, column: 22, scope: !43)
!46 = !DILocation(line: 131, column: 3, scope: !43)
!47 = !DILocation(line: 136, column: 21, scope: !43)
!48 = !DILocation(line: 136, column: 36, scope: !43)
!49 = !DILocation(line: 137, column: 21, scope: !43)
!50 = !DILocation(line: 137, column: 30, scope: !43)
!51 = !DILocation(line: 138, column: 21, scope: !43)
!52 = !DILocation(line: 138, column: 41, scope: !43)
!53 = !DILocation(line: 139, column: 21, scope: !43)
!54 = !DILocation(line: 139, column: 25, scope: !43)
!55 = !DILocation(line: 139, column: 34, scope: !43)
!56 = !DILocation(line: 140, column: 21, scope: !43)
!57 = !DILocation(line: 140, column: 25, scope: !43)
!58 = !DILocation(line: 140, column: 35, scope: !43)
!59 = !DILocation(line: 141, column: 21, scope: !43)
!60 = !DILocation(line: 141, column: 25, scope: !43)
!61 = !DILocation(line: 141, column: 32, scope: !43)
!62 = !DILocation(line: 142, column: 21, scope: !43)
!63 = !DILocation(line: 142, column: 25, scope: !43)
!64 = !DILocation(line: 142, column: 32, scope: !43)
!65 = !DILocation(line: 143, column: 7, scope: !43)
!66 = !DILocation(line: 143, column: 45, scope: !43)
!67 = !DILocation(line: 145, column: 5, scope: !43)
!68 = !DILocation(line: 146, column: 3, scope: !43)
!69 = !DILocation(line: 150, column: 21, scope: !43)
!70 = !DILocation(line: 150, column: 31, scope: !43)
!71 = !DILocation(line: 152, column: 21, scope: !43)
!72 = !DILocation(line: 152, column: 34, scope: !43)
!73 = !DILocation(line: 153, column: 21, scope: !43)
!74 = !DILocation(line: 153, column: 35, scope: !43)
!75 = !DILocation(line: 154, column: 21, scope: !43)
!76 = !DILocation(line: 154, column: 36, scope: !43)
!77 = !DILocation(line: 155, column: 21, scope: !43)
!78 = !DILocation(line: 155, column: 36, scope: !43)
!79 = !DILocation(line: 157, column: 7, scope: !43)
!80 = !DILocation(line: 157, column: 64, scope: !43)
!81 = !DILocation(line: 159, column: 5, scope: !43)
!82 = !DILocation(line: 160, column: 3, scope: !43)
!83 = !DILocation(line: 161, column: 1, scope: !43)
!84 = distinct !DISubprogram(name: "MX_GPIO_Init", scope: !1, file: !1, line: 201, type: !8, scopeLine: 202, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!85 = !DILocation(line: 203, column: 20, scope: !84)
!86 = !DILocation(line: 206, column: 3, scope: !84)
!87 = !DILocation(line: 207, column: 3, scope: !84)
!88 = !DILocation(line: 208, column: 3, scope: !84)
!89 = !DILocation(line: 209, column: 3, scope: !84)
!90 = !DILocation(line: 212, column: 3, scope: !84)
!91 = !DILocation(line: 215, column: 19, scope: !84)
!92 = !DILocation(line: 215, column: 23, scope: !84)
!93 = !DILocation(line: 216, column: 19, scope: !84)
!94 = !DILocation(line: 216, column: 24, scope: !84)
!95 = !DILocation(line: 217, column: 19, scope: !84)
!96 = !DILocation(line: 217, column: 24, scope: !84)
!97 = !DILocation(line: 218, column: 3, scope: !84)
!98 = !DILocation(line: 221, column: 19, scope: !84)
!99 = !DILocation(line: 221, column: 23, scope: !84)
!100 = !DILocation(line: 222, column: 19, scope: !84)
!101 = !DILocation(line: 222, column: 24, scope: !84)
!102 = !DILocation(line: 223, column: 19, scope: !84)
!103 = !DILocation(line: 223, column: 24, scope: !84)
!104 = !DILocation(line: 224, column: 19, scope: !84)
!105 = !DILocation(line: 224, column: 25, scope: !84)
!106 = !DILocation(line: 225, column: 3, scope: !84)
!107 = !DILocation(line: 227, column: 1, scope: !84)
!108 = distinct !DISubprogram(name: "MX_USART2_UART_Init", scope: !1, file: !1, line: 168, type: !8, scopeLine: 169, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!109 = !DILocation(line: 178, column: 19, scope: !108)
!110 = !DILocation(line: 179, column: 24, scope: !108)
!111 = !DILocation(line: 180, column: 26, scope: !108)
!112 = !DILocation(line: 181, column: 24, scope: !108)
!113 = !DILocation(line: 182, column: 22, scope: !108)
!114 = !DILocation(line: 183, column: 20, scope: !108)
!115 = !DILocation(line: 184, column: 25, scope: !108)
!116 = !DILocation(line: 185, column: 28, scope: !108)
!117 = !DILocation(line: 186, column: 7, scope: !108)
!118 = !DILocation(line: 186, column: 30, scope: !108)
!119 = !DILocation(line: 188, column: 5, scope: !108)
!120 = !DILocation(line: 189, column: 3, scope: !108)
!121 = !DILocation(line: 194, column: 1, scope: !108)
!122 = distinct !DISubprogram(name: "MX_TIM6_Init", scope: !1, file: !1, line: 234, type: !8, scopeLine: 235, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!123 = !DILocation(line: 241, column: 27, scope: !122)
!124 = !DILocation(line: 246, column: 18, scope: !122)
!125 = !DILocation(line: 247, column: 24, scope: !122)
!126 = !DILocation(line: 248, column: 26, scope: !122)
!127 = !DILocation(line: 249, column: 21, scope: !122)
!128 = !DILocation(line: 250, column: 32, scope: !122)
!129 = !DILocation(line: 251, column: 7, scope: !122)
!130 = !DILocation(line: 251, column: 33, scope: !122)
!131 = !DILocation(line: 253, column: 5, scope: !122)
!132 = !DILocation(line: 254, column: 3, scope: !122)
!133 = !DILocation(line: 255, column: 17, scope: !122)
!134 = !DILocation(line: 255, column: 37, scope: !122)
!135 = !DILocation(line: 256, column: 17, scope: !122)
!136 = !DILocation(line: 256, column: 33, scope: !122)
!137 = !DILocation(line: 257, column: 7, scope: !122)
!138 = !DILocation(line: 257, column: 69, scope: !122)
!139 = !DILocation(line: 259, column: 5, scope: !122)
!140 = !DILocation(line: 260, column: 3, scope: !122)
!141 = !DILocation(line: 265, column: 1, scope: !122)
!142 = distinct !DISubprogram(name: "vTaskCode2", scope: !1, file: !1, line: 295, type: !8, scopeLine: 296, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!143 = !DILocation(line: 301, column: 22, scope: !142)
!144 = !DILocation(line: 305, column: 21, scope: !142)
!145 = !DILocation(line: 305, column: 19, scope: !142)
!146 = !DILocation(line: 306, column: 5, scope: !142)
!147 = !DILocation(line: 309, column: 21, scope: !142)
!148 = !DILocation(line: 309, column: 19, scope: !142)
!149 = !DILocation(line: 313, column: 11, scope: !142)
!150 = !DILocation(line: 314, column: 9, scope: !142)
!151 = distinct !{!151, !146, !152}
!152 = !DILocation(line: 316, column: 5, scope: !142)
!153 = distinct !DISubprogram(name: "vTaskCode1", scope: !1, file: !1, line: 270, type: !8, scopeLine: 271, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!154 = !DILocation(line: 276, column: 22, scope: !153)
!155 = !DILocation(line: 280, column: 21, scope: !153)
!156 = !DILocation(line: 280, column: 19, scope: !153)
!157 = !DILocation(line: 281, column: 5, scope: !153)
!158 = !DILocation(line: 284, column: 21, scope: !153)
!159 = !DILocation(line: 284, column: 19, scope: !153)
!160 = !DILocation(line: 288, column: 11, scope: !153)
!161 = !DILocation(line: 289, column: 9, scope: !153)
!162 = distinct !{!162, !157, !163}
!163 = !DILocation(line: 290, column: 5, scope: !153)
!164 = distinct !DISubprogram(name: "vTaskDES", scope: !1, file: !1, line: 321, type: !8, scopeLine: 322, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!165 = !DILocation(line: 327, column: 22, scope: !164)
!166 = !DILocation(line: 331, column: 21, scope: !164)
!167 = !DILocation(line: 331, column: 19, scope: !164)
!168 = !DILocation(line: 332, column: 5, scope: !164)
!169 = !DILocation(line: 335, column: 21, scope: !164)
!170 = !DILocation(line: 335, column: 19, scope: !164)
!171 = !DILocation(line: 340, column: 7, scope: !164)
!172 = !DILocation(line: 341, column: 11, scope: !164)
!173 = !DILocation(line: 342, column: 9, scope: !164)
!174 = !DILocation(line: 343, column: 9, scope: !164)
!175 = !DILocation(line: 344, column: 7, scope: !164)
!176 = distinct !{!176, !168, !177}
!177 = !DILocation(line: 345, column: 5, scope: !164)
!178 = distinct !DISubprogram(name: "Error_Handler", scope: !1, file: !1, line: 356, type: !8, scopeLine: 357, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!179 = !DILocation(line: 142, column: 3, scope: !180, inlinedAt: !182)
!180 = distinct !DISubprogram(name: "__disable_irq", scope: !181, file: !181, line: 140, type: !8, scopeLine: 141, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !9)
!181 = !DIFile(filename: "Drivers/CMSIS/Include/cmsis_gcc.h", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!182 = distinct !DILocation(line: 360, column: 3, scope: !178)
!183 = !{i64 1160100}
!184 = !DILocation(line: 361, column: 3, scope: !178)
!185 = distinct !{!185, !184, !186}
!186 = !DILocation(line: 363, column: 3, scope: !178)
