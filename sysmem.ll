; ModuleID = 'Core/Src/sysmem.c'
source_filename = "Core/Src/sysmem.c"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-unknown-eabi"

@_estack = external dso_local global i8, align 1
@_Min_Stack_Size = external dso_local global i32, align 4
@__sbrk_heap_end = internal global ptr null, align 4
@_end = external dso_local global i8, align 1
@errno = external thread_local global i32, align 4

; Function Attrs: noinline nounwind
define dso_local ptr @_sbrk(i32 noundef %0) #0 !dbg !7 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  store i32 %0, ptr %3, align 4
  store i32 sub (i32 ptrtoint (ptr @_estack to i32), i32 ptrtoint (ptr @_Min_Stack_Size to i32)), ptr %4, align 4, !dbg !10
  %7 = load i32, ptr %4, align 4, !dbg !11
  %8 = inttoptr i32 %7 to ptr, !dbg !12
  store ptr %8, ptr %5, align 4, !dbg !13
  %9 = load ptr, ptr @__sbrk_heap_end, align 4, !dbg !14
  %10 = icmp eq ptr null, %9, !dbg !15
  br i1 %10, label %11, label %12, !dbg !16

11:                                               ; preds = %1
  store ptr @_end, ptr @__sbrk_heap_end, align 4, !dbg !17
  br label %12, !dbg !18

12:                                               ; preds = %11, %1
  %13 = load ptr, ptr @__sbrk_heap_end, align 4, !dbg !19
  %14 = load i32, ptr %3, align 4, !dbg !20
  %15 = getelementptr inbounds i8, ptr %13, i32 %14, !dbg !21
  %16 = load ptr, ptr %5, align 4, !dbg !22
  %17 = icmp ugt ptr %15, %16, !dbg !23
  br i1 %17, label %18, label %19, !dbg !19

18:                                               ; preds = %12
  store i32 12, ptr @errno, align 4, !dbg !24
  store ptr inttoptr (i32 -1 to ptr), ptr %2, align 4, !dbg !25
  br label %25, !dbg !25

19:                                               ; preds = %12
  %20 = load ptr, ptr @__sbrk_heap_end, align 4, !dbg !26
  store ptr %20, ptr %6, align 4, !dbg !27
  %21 = load i32, ptr %3, align 4, !dbg !28
  %22 = load ptr, ptr @__sbrk_heap_end, align 4, !dbg !29
  %23 = getelementptr inbounds i8, ptr %22, i32 %21, !dbg !29
  store ptr %23, ptr @__sbrk_heap_end, align 4, !dbg !29
  %24 = load ptr, ptr %6, align 4, !dbg !30
  store ptr %24, ptr %2, align 4, !dbg !31
  br label %25, !dbg !31

25:                                               ; preds = %19, %18
  %26 = load ptr, ptr %2, align 4, !dbg !32
  ret ptr %26, !dbg !32
}

attributes #0 = { noinline nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "Core/Src/sysmem.c", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 1, !"min_enum_size", i32 4}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{!"clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)"}
!7 = distinct !DISubprogram(name: "_sbrk", scope: !1, file: !1, line: 54, type: !8, scopeLine: 55, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!8 = !DISubroutineType(types: !9)
!9 = !{}
!10 = !DILocation(line: 59, column: 18, scope: !7)
!11 = !DILocation(line: 60, column: 40, scope: !7)
!12 = !DILocation(line: 60, column: 29, scope: !7)
!13 = !DILocation(line: 60, column: 18, scope: !7)
!14 = !DILocation(line: 64, column: 15, scope: !7)
!15 = !DILocation(line: 64, column: 12, scope: !7)
!16 = !DILocation(line: 64, column: 7, scope: !7)
!17 = !DILocation(line: 66, column: 21, scope: !7)
!18 = !DILocation(line: 67, column: 3, scope: !7)
!19 = !DILocation(line: 70, column: 7, scope: !7)
!20 = !DILocation(line: 70, column: 25, scope: !7)
!21 = !DILocation(line: 70, column: 23, scope: !7)
!22 = !DILocation(line: 70, column: 32, scope: !7)
!23 = !DILocation(line: 70, column: 30, scope: !7)
!24 = !DILocation(line: 72, column: 11, scope: !7)
!25 = !DILocation(line: 73, column: 5, scope: !7)
!26 = !DILocation(line: 76, column: 19, scope: !7)
!27 = !DILocation(line: 76, column: 17, scope: !7)
!28 = !DILocation(line: 77, column: 22, scope: !7)
!29 = !DILocation(line: 77, column: 19, scope: !7)
!30 = !DILocation(line: 79, column: 18, scope: !7)
!31 = !DILocation(line: 79, column: 3, scope: !7)
!32 = !DILocation(line: 80, column: 1, scope: !7)
