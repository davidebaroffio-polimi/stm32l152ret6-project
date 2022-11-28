; ModuleID = 'Core/Src/stm32l1xx_it.c'
source_filename = "Core/Src/stm32l1xx_it.c"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-unknown-eabi"

; Function Attrs: noinline nounwind
define dso_local void @NMI_Handler() #0 !dbg !7 {
  br label %1, !dbg !10

1:                                                ; preds = %0, %1
  br label %1, !dbg !10, !llvm.loop !11
}

; Function Attrs: noinline nounwind
define dso_local void @HardFault_Handler() #0 !dbg !13 {
  br label %1, !dbg !14

1:                                                ; preds = %0, %1
  br label %1, !dbg !14, !llvm.loop !15
}

; Function Attrs: noinline nounwind
define dso_local void @MemManage_Handler() #0 !dbg !17 {
  br label %1, !dbg !18

1:                                                ; preds = %0, %1
  br label %1, !dbg !18, !llvm.loop !19
}

; Function Attrs: noinline nounwind
define dso_local void @BusFault_Handler() #0 !dbg !21 {
  br label %1, !dbg !22

1:                                                ; preds = %0, %1
  br label %1, !dbg !22, !llvm.loop !23
}

; Function Attrs: noinline nounwind
define dso_local void @UsageFault_Handler() #0 !dbg !25 {
  br label %1, !dbg !26

1:                                                ; preds = %0, %1
  br label %1, !dbg !26, !llvm.loop !27
}

; Function Attrs: noinline nounwind
define weak dso_local void @SVC_Handler() #0 !dbg !29 {
  ret void, !dbg !30
}

; Function Attrs: noinline nounwind
define dso_local void @DebugMon_Handler() #0 !dbg !31 {
  ret void, !dbg !32
}

; Function Attrs: noinline nounwind
define weak dso_local void @PendSV_Handler() #0 !dbg !33 {
  ret void, !dbg !34
}

; Function Attrs: noinline nounwind
define weak dso_local void @SysTick_Handler() #0 !dbg !35 {
  call void @HAL_IncTick(), !dbg !36
  ret void, !dbg !37
}

declare dso_local void @HAL_IncTick() #1

attributes #0 = { noinline nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "Core/Src/stm32l1xx_it.c", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 1, !"min_enum_size", i32 4}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{!"clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)"}
!7 = distinct !DISubprogram(name: "NMI_Handler", scope: !1, file: !1, line: 69, type: !8, scopeLine: 70, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!8 = !DISubroutineType(types: !9)
!9 = !{}
!10 = !DILocation(line: 75, column: 3, scope: !7)
!11 = distinct !{!11, !10, !12}
!12 = !DILocation(line: 77, column: 3, scope: !7)
!13 = distinct !DISubprogram(name: "HardFault_Handler", scope: !1, file: !1, line: 84, type: !8, scopeLine: 85, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!14 = !DILocation(line: 89, column: 3, scope: !13)
!15 = distinct !{!15, !14, !16}
!16 = !DILocation(line: 93, column: 3, scope: !13)
!17 = distinct !DISubprogram(name: "MemManage_Handler", scope: !1, file: !1, line: 99, type: !8, scopeLine: 100, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!18 = !DILocation(line: 104, column: 3, scope: !17)
!19 = distinct !{!19, !18, !20}
!20 = !DILocation(line: 108, column: 3, scope: !17)
!21 = distinct !DISubprogram(name: "BusFault_Handler", scope: !1, file: !1, line: 114, type: !8, scopeLine: 115, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!22 = !DILocation(line: 119, column: 3, scope: !21)
!23 = distinct !{!23, !22, !24}
!24 = !DILocation(line: 123, column: 3, scope: !21)
!25 = distinct !DISubprogram(name: "UsageFault_Handler", scope: !1, file: !1, line: 129, type: !8, scopeLine: 130, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!26 = !DILocation(line: 134, column: 3, scope: !25)
!27 = distinct !{!27, !26, !28}
!28 = !DILocation(line: 138, column: 3, scope: !25)
!29 = distinct !DISubprogram(name: "SVC_Handler", scope: !1, file: !1, line: 144, type: !8, scopeLine: 145, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!30 = !DILocation(line: 152, column: 1, scope: !29)
!31 = distinct !DISubprogram(name: "DebugMon_Handler", scope: !1, file: !1, line: 157, type: !8, scopeLine: 158, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!32 = !DILocation(line: 165, column: 1, scope: !31)
!33 = distinct !DISubprogram(name: "PendSV_Handler", scope: !1, file: !1, line: 170, type: !8, scopeLine: 171, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!34 = !DILocation(line: 178, column: 1, scope: !33)
!35 = distinct !DISubprogram(name: "SysTick_Handler", scope: !1, file: !1, line: 183, type: !8, scopeLine: 184, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!36 = !DILocation(line: 188, column: 3, scope: !35)
!37 = !DILocation(line: 192, column: 1, scope: !35)
