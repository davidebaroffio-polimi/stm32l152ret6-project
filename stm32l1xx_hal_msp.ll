; ModuleID = 'Core/Src/stm32l1xx_hal_msp.c'
source_filename = "Core/Src/stm32l1xx_hal_msp.c"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-unknown-eabi"

%struct.RCC_TypeDef = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }
%struct.GPIO_InitTypeDef = type { i32, i32, i32, i32, i32 }
%struct.__UART_HandleTypeDef = type { ptr, %struct.UART_InitTypeDef, ptr, i16, i16, ptr, i16, i16, i32, ptr, ptr, i32, i32, i32, i32 }
%struct.UART_InitTypeDef = type { i32, i32, i32, i32, i32, i32, i32 }

@.str = private unnamed_addr constant [8 x i8] c"exclude\00", section "llvm.metadata"
@.str.1 = private unnamed_addr constant [29 x i8] c"Core/Src/stm32l1xx_hal_msp.c\00", section "llvm.metadata"
@.str.2 = private unnamed_addr constant [8 x i8] c"include\00", section "llvm.metadata"
@llvm.global.annotations = appending global [3 x { ptr, ptr, ptr, i32, ptr }] [{ ptr, ptr, ptr, i32, ptr } { ptr @HAL_MspInit, ptr @.str, ptr @.str.1, i32 63, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @HAL_UART_MspInit, ptr @.str.2, ptr @.str.1, i32 89, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @HAL_UART_MspDeInit, ptr @.str.2, ptr @.str.1, i32 125, ptr null }], section "llvm.metadata"

; Function Attrs: noinline nounwind
define dso_local void @HAL_MspInit() #0 !dbg !7 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  br label %4, !dbg !10

4:                                                ; preds = %0
  %5 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 9), align 4, !dbg !10
  %6 = or i32 %5, -2147483648, !dbg !10
  store volatile i32 %6, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 9), align 4, !dbg !10
  %7 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 9), align 4, !dbg !10
  %8 = and i32 %7, -2147483648, !dbg !10
  store volatile i32 %8, ptr %1, align 4, !dbg !10
  %9 = load volatile i32, ptr %1, align 4, !dbg !10
  br label %10, !dbg !10

10:                                               ; preds = %4
  br label %11, !dbg !11

11:                                               ; preds = %10
  %12 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 8), align 4, !dbg !11
  %13 = or i32 %12, 1, !dbg !11
  store volatile i32 %13, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 8), align 4, !dbg !11
  %14 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 8), align 4, !dbg !11
  %15 = and i32 %14, 1, !dbg !11
  store volatile i32 %15, ptr %2, align 4, !dbg !11
  %16 = load volatile i32, ptr %2, align 4, !dbg !11
  br label %17, !dbg !11

17:                                               ; preds = %11
  br label %18, !dbg !12

18:                                               ; preds = %17
  %19 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 9), align 4, !dbg !12
  %20 = or i32 %19, 268435456, !dbg !12
  store volatile i32 %20, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 9), align 4, !dbg !12
  %21 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 9), align 4, !dbg !12
  %22 = and i32 %21, 268435456, !dbg !12
  store volatile i32 %22, ptr %3, align 4, !dbg !12
  %23 = load volatile i32, ptr %3, align 4, !dbg !12
  br label %24, !dbg !12

24:                                               ; preds = %18
  call void @HAL_NVIC_SetPriority(i32 noundef -2, i32 noundef 15, i32 noundef 0), !dbg !13
  ret void, !dbg !14
}

declare dso_local void @HAL_NVIC_SetPriority(i32 noundef, i32 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind
define dso_local void @HAL_UART_MspInit(ptr noundef %0) #0 !dbg !15 {
  %2 = alloca ptr, align 4
  %3 = alloca %struct.GPIO_InitTypeDef, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 4
  call void @llvm.memset.p0.i32(ptr align 4 %3, i8 0, i32 20, i1 false), !dbg !16
  %6 = load ptr, ptr %2, align 4, !dbg !17
  %7 = getelementptr inbounds %struct.__UART_HandleTypeDef, ptr %6, i32 0, i32 0, !dbg !18
  %8 = load ptr, ptr %7, align 4, !dbg !18
  %9 = icmp eq ptr %8, inttoptr (i32 1073759232 to ptr), !dbg !19
  br i1 %9, label %10, label %30, !dbg !17

10:                                               ; preds = %1
  br label %11, !dbg !20

11:                                               ; preds = %10
  %12 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 9), align 4, !dbg !20
  %13 = or i32 %12, 131072, !dbg !20
  store volatile i32 %13, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 9), align 4, !dbg !20
  %14 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 9), align 4, !dbg !20
  %15 = and i32 %14, 131072, !dbg !20
  store volatile i32 %15, ptr %4, align 4, !dbg !20
  %16 = load volatile i32, ptr %4, align 4, !dbg !20
  br label %17, !dbg !20

17:                                               ; preds = %11
  br label %18, !dbg !21

18:                                               ; preds = %17
  %19 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !21
  %20 = or i32 %19, 1, !dbg !21
  store volatile i32 %20, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !21
  %21 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 7), align 4, !dbg !21
  %22 = and i32 %21, 1, !dbg !21
  store volatile i32 %22, ptr %5, align 4, !dbg !21
  %23 = load volatile i32, ptr %5, align 4, !dbg !21
  br label %24, !dbg !21

24:                                               ; preds = %18
  %25 = getelementptr inbounds %struct.GPIO_InitTypeDef, ptr %3, i32 0, i32 0, !dbg !22
  store i32 12, ptr %25, align 4, !dbg !23
  %26 = getelementptr inbounds %struct.GPIO_InitTypeDef, ptr %3, i32 0, i32 1, !dbg !24
  store i32 2, ptr %26, align 4, !dbg !25
  %27 = getelementptr inbounds %struct.GPIO_InitTypeDef, ptr %3, i32 0, i32 2, !dbg !26
  store i32 0, ptr %27, align 4, !dbg !27
  %28 = getelementptr inbounds %struct.GPIO_InitTypeDef, ptr %3, i32 0, i32 3, !dbg !28
  store i32 3, ptr %28, align 4, !dbg !29
  %29 = getelementptr inbounds %struct.GPIO_InitTypeDef, ptr %3, i32 0, i32 4, !dbg !30
  store i32 7, ptr %29, align 4, !dbg !31
  call void @HAL_GPIO_Init(ptr noundef inttoptr (i32 1073872896 to ptr), ptr noundef %3), !dbg !32
  br label %30, !dbg !33

30:                                               ; preds = %24, %1
  ret void, !dbg !34
}

; Function Attrs: argmemonly nocallback nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i32(ptr nocapture writeonly, i8, i32, i1 immarg) #2

declare dso_local void @HAL_GPIO_Init(ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind
define dso_local void @HAL_UART_MspDeInit(ptr noundef %0) #0 !dbg !35 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %3 = load ptr, ptr %2, align 4, !dbg !36
  %4 = getelementptr inbounds %struct.__UART_HandleTypeDef, ptr %3, i32 0, i32 0, !dbg !37
  %5 = load ptr, ptr %4, align 4, !dbg !37
  %6 = icmp eq ptr %5, inttoptr (i32 1073759232 to ptr), !dbg !38
  br i1 %6, label %7, label %10, !dbg !36

7:                                                ; preds = %1
  %8 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 9), align 4, !dbg !39
  %9 = and i32 %8, -131073, !dbg !39
  store volatile i32 %9, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 9), align 4, !dbg !39
  call void @HAL_GPIO_DeInit(ptr noundef inttoptr (i32 1073872896 to ptr), i32 noundef 12), !dbg !40
  br label %10, !dbg !41

10:                                               ; preds = %7, %1
  ret void, !dbg !42
}

declare dso_local void @HAL_GPIO_DeInit(ptr noundef, i32 noundef) #1

attributes #0 = { noinline nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #2 = { argmemonly nocallback nofree nounwind willreturn writeonly }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "Core/Src/stm32l1xx_hal_msp.c", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 1, !"min_enum_size", i32 4}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{!"clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)"}
!7 = distinct !DISubprogram(name: "HAL_MspInit", scope: !1, file: !1, line: 63, type: !8, scopeLine: 64, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!8 = !DISubroutineType(types: !9)
!9 = !{}
!10 = !DILocation(line: 69, column: 3, scope: !7)
!11 = !DILocation(line: 70, column: 3, scope: !7)
!12 = !DILocation(line: 71, column: 3, scope: !7)
!13 = !DILocation(line: 76, column: 3, scope: !7)
!14 = !DILocation(line: 81, column: 1, scope: !7)
!15 = distinct !DISubprogram(name: "HAL_UART_MspInit", scope: !1, file: !1, line: 89, type: !8, scopeLine: 90, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!16 = !DILocation(line: 91, column: 20, scope: !15)
!17 = !DILocation(line: 92, column: 6, scope: !15)
!18 = !DILocation(line: 92, column: 13, scope: !15)
!19 = !DILocation(line: 92, column: 21, scope: !15)
!20 = !DILocation(line: 98, column: 5, scope: !15)
!21 = !DILocation(line: 100, column: 5, scope: !15)
!22 = !DILocation(line: 105, column: 21, scope: !15)
!23 = !DILocation(line: 105, column: 25, scope: !15)
!24 = !DILocation(line: 106, column: 21, scope: !15)
!25 = !DILocation(line: 106, column: 26, scope: !15)
!26 = !DILocation(line: 107, column: 21, scope: !15)
!27 = !DILocation(line: 107, column: 26, scope: !15)
!28 = !DILocation(line: 108, column: 21, scope: !15)
!29 = !DILocation(line: 108, column: 27, scope: !15)
!30 = !DILocation(line: 109, column: 21, scope: !15)
!31 = !DILocation(line: 109, column: 31, scope: !15)
!32 = !DILocation(line: 110, column: 5, scope: !15)
!33 = !DILocation(line: 115, column: 3, scope: !15)
!34 = !DILocation(line: 117, column: 1, scope: !15)
!35 = distinct !DISubprogram(name: "HAL_UART_MspDeInit", scope: !1, file: !1, line: 125, type: !8, scopeLine: 126, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!36 = !DILocation(line: 127, column: 6, scope: !35)
!37 = !DILocation(line: 127, column: 13, scope: !35)
!38 = !DILocation(line: 127, column: 21, scope: !35)
!39 = !DILocation(line: 133, column: 5, scope: !35)
!40 = !DILocation(line: 139, column: 5, scope: !35)
!41 = !DILocation(line: 144, column: 3, scope: !35)
!42 = !DILocation(line: 146, column: 1, scope: !35)
