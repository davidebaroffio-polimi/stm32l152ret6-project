; ModuleID = 'Core/Src/system_stm32l1xx.c'
source_filename = "Core/Src/system_stm32l1xx.c"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-unknown-eabi"

%struct.RCC_TypeDef = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }

@SystemCoreClock = dso_local global i32 2097000, align 4
@PLLMulTable = dso_local constant [9 x i8] c"\03\04\06\08\0C\10\18 0", align 1
@AHBPrescTable = dso_local constant [16 x i8] c"\00\00\00\00\00\00\00\00\01\02\03\04\06\07\08\09", align 1
@APBPrescTable = dso_local constant [8 x i8] c"\00\00\00\00\01\02\03\04", align 1

; Function Attrs: noinline nounwind
define dso_local void @SystemInit() #0 !dbg !7 {
  ret void, !dbg !10
}

; Function Attrs: noinline nounwind
define dso_local void @SystemCoreClockUpdate() #0 !dbg !11 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4, !dbg !12
  store i32 0, ptr %2, align 4, !dbg !13
  store i32 0, ptr %3, align 4, !dbg !14
  store i32 0, ptr %4, align 4, !dbg !15
  store i32 0, ptr %5, align 4, !dbg !16
  %6 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 2), align 4, !dbg !17
  %7 = and i32 %6, 12, !dbg !18
  store i32 %7, ptr %1, align 4, !dbg !19
  %8 = load i32, ptr %1, align 4, !dbg !20
  switch i32 %8, label %47 [
    i32 0, label %9
    i32 4, label %17
    i32 8, label %18
    i32 12, label %19
  ], !dbg !21

9:                                                ; preds = %0
  %10 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 1), align 4, !dbg !22
  %11 = and i32 %10, 57344, !dbg !23
  %12 = lshr i32 %11, 13, !dbg !24
  store i32 %12, ptr %5, align 4, !dbg !25
  %13 = load i32, ptr %5, align 4, !dbg !26
  %14 = add i32 %13, 1, !dbg !27
  %15 = shl i32 1, %14, !dbg !28
  %16 = mul nsw i32 32768, %15, !dbg !29
  store i32 %16, ptr @SystemCoreClock, align 4, !dbg !30
  br label %55, !dbg !31

17:                                               ; preds = %0
  store i32 16000000, ptr @SystemCoreClock, align 4, !dbg !32
  br label %55, !dbg !33

18:                                               ; preds = %0
  store i32 8000000, ptr @SystemCoreClock, align 4, !dbg !34
  br label %55, !dbg !35

19:                                               ; preds = %0
  %20 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 2), align 4, !dbg !36
  %21 = and i32 %20, 3932160, !dbg !37
  store i32 %21, ptr %2, align 4, !dbg !38
  %22 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 2), align 4, !dbg !39
  %23 = and i32 %22, 12582912, !dbg !40
  store i32 %23, ptr %3, align 4, !dbg !41
  %24 = load i32, ptr %2, align 4, !dbg !42
  %25 = lshr i32 %24, 18, !dbg !43
  %26 = getelementptr inbounds [9 x i8], ptr @PLLMulTable, i32 0, i32 %25, !dbg !44
  %27 = load i8, ptr %26, align 1, !dbg !44
  %28 = zext i8 %27 to i32, !dbg !44
  store i32 %28, ptr %2, align 4, !dbg !45
  %29 = load i32, ptr %3, align 4, !dbg !46
  %30 = lshr i32 %29, 22, !dbg !47
  %31 = add i32 %30, 1, !dbg !48
  store i32 %31, ptr %3, align 4, !dbg !49
  %32 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 2), align 4, !dbg !50
  %33 = and i32 %32, 65536, !dbg !51
  store i32 %33, ptr %4, align 4, !dbg !52
  %34 = load i32, ptr %4, align 4, !dbg !53
  %35 = icmp eq i32 %34, 0, !dbg !54
  br i1 %35, label %36, label %41, !dbg !53

36:                                               ; preds = %19
  %37 = load i32, ptr %2, align 4, !dbg !55
  %38 = mul i32 16000000, %37, !dbg !56
  %39 = load i32, ptr %3, align 4, !dbg !57
  %40 = udiv i32 %38, %39, !dbg !58
  store i32 %40, ptr @SystemCoreClock, align 4, !dbg !59
  br label %46, !dbg !60

41:                                               ; preds = %19
  %42 = load i32, ptr %2, align 4, !dbg !61
  %43 = mul i32 8000000, %42, !dbg !62
  %44 = load i32, ptr %3, align 4, !dbg !63
  %45 = udiv i32 %43, %44, !dbg !64
  store i32 %45, ptr @SystemCoreClock, align 4, !dbg !65
  br label %46

46:                                               ; preds = %41, %36
  br label %55, !dbg !66

47:                                               ; preds = %0
  %48 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 1), align 4, !dbg !67
  %49 = and i32 %48, 57344, !dbg !68
  %50 = lshr i32 %49, 13, !dbg !69
  store i32 %50, ptr %5, align 4, !dbg !70
  %51 = load i32, ptr %5, align 4, !dbg !71
  %52 = add i32 %51, 1, !dbg !72
  %53 = shl i32 1, %52, !dbg !73
  %54 = mul nsw i32 32768, %53, !dbg !74
  store i32 %54, ptr @SystemCoreClock, align 4, !dbg !75
  br label %55, !dbg !76

55:                                               ; preds = %47, %46, %18, %17, %9
  %56 = load volatile i32, ptr getelementptr inbounds (%struct.RCC_TypeDef, ptr inttoptr (i32 1073887232 to ptr), i32 0, i32 2), align 4, !dbg !77
  %57 = and i32 %56, 240, !dbg !78
  %58 = lshr i32 %57, 4, !dbg !79
  %59 = getelementptr inbounds [16 x i8], ptr @AHBPrescTable, i32 0, i32 %58, !dbg !80
  %60 = load i8, ptr %59, align 1, !dbg !80
  %61 = zext i8 %60 to i32, !dbg !80
  store i32 %61, ptr %1, align 4, !dbg !81
  %62 = load i32, ptr %1, align 4, !dbg !82
  %63 = load i32, ptr @SystemCoreClock, align 4, !dbg !83
  %64 = lshr i32 %63, %62, !dbg !83
  store i32 %64, ptr @SystemCoreClock, align 4, !dbg !83
  ret void, !dbg !84
}

attributes #0 = { noinline nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "Core/Src/system_stm32l1xx.c", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 1, !"min_enum_size", i32 4}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{!"clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)"}
!7 = distinct !DISubprogram(name: "SystemInit", scope: !1, file: !1, line: 160, type: !8, scopeLine: 161, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!8 = !DISubroutineType(types: !9)
!9 = !{}
!10 = !DILocation(line: 170, column: 1, scope: !7)
!11 = distinct !DISubprogram(name: "SystemCoreClockUpdate", scope: !1, file: !1, line: 210, type: !8, scopeLine: 211, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!12 = !DILocation(line: 212, column: 12, scope: !11)
!13 = !DILocation(line: 212, column: 21, scope: !11)
!14 = !DILocation(line: 212, column: 33, scope: !11)
!15 = !DILocation(line: 212, column: 45, scope: !11)
!16 = !DILocation(line: 212, column: 60, scope: !11)
!17 = !DILocation(line: 215, column: 14, scope: !11)
!18 = !DILocation(line: 215, column: 19, scope: !11)
!19 = !DILocation(line: 215, column: 7, scope: !11)
!20 = !DILocation(line: 217, column: 11, scope: !11)
!21 = !DILocation(line: 217, column: 3, scope: !11)
!22 = !DILocation(line: 220, column: 24, scope: !11)
!23 = !DILocation(line: 220, column: 30, scope: !11)
!24 = !DILocation(line: 220, column: 52, scope: !11)
!25 = !DILocation(line: 220, column: 16, scope: !11)
!26 = !DILocation(line: 221, column: 41, scope: !11)
!27 = !DILocation(line: 221, column: 50, scope: !11)
!28 = !DILocation(line: 221, column: 37, scope: !11)
!29 = !DILocation(line: 221, column: 32, scope: !11)
!30 = !DILocation(line: 221, column: 23, scope: !11)
!31 = !DILocation(line: 222, column: 7, scope: !11)
!32 = !DILocation(line: 224, column: 23, scope: !11)
!33 = !DILocation(line: 225, column: 7, scope: !11)
!34 = !DILocation(line: 227, column: 23, scope: !11)
!35 = !DILocation(line: 228, column: 7, scope: !11)
!36 = !DILocation(line: 231, column: 21, scope: !11)
!37 = !DILocation(line: 231, column: 26, scope: !11)
!38 = !DILocation(line: 231, column: 14, scope: !11)
!39 = !DILocation(line: 232, column: 21, scope: !11)
!40 = !DILocation(line: 232, column: 26, scope: !11)
!41 = !DILocation(line: 232, column: 14, scope: !11)
!42 = !DILocation(line: 233, column: 29, scope: !11)
!43 = !DILocation(line: 233, column: 36, scope: !11)
!44 = !DILocation(line: 233, column: 16, scope: !11)
!45 = !DILocation(line: 233, column: 14, scope: !11)
!46 = !DILocation(line: 234, column: 17, scope: !11)
!47 = !DILocation(line: 234, column: 24, scope: !11)
!48 = !DILocation(line: 234, column: 31, scope: !11)
!49 = !DILocation(line: 234, column: 14, scope: !11)
!50 = !DILocation(line: 236, column: 24, scope: !11)
!51 = !DILocation(line: 236, column: 29, scope: !11)
!52 = !DILocation(line: 236, column: 17, scope: !11)
!53 = !DILocation(line: 238, column: 11, scope: !11)
!54 = !DILocation(line: 238, column: 21, scope: !11)
!55 = !DILocation(line: 241, column: 43, scope: !11)
!56 = !DILocation(line: 241, column: 41, scope: !11)
!57 = !DILocation(line: 241, column: 53, scope: !11)
!58 = !DILocation(line: 241, column: 51, scope: !11)
!59 = !DILocation(line: 241, column: 25, scope: !11)
!60 = !DILocation(line: 242, column: 7, scope: !11)
!61 = !DILocation(line: 246, column: 43, scope: !11)
!62 = !DILocation(line: 246, column: 41, scope: !11)
!63 = !DILocation(line: 246, column: 53, scope: !11)
!64 = !DILocation(line: 246, column: 51, scope: !11)
!65 = !DILocation(line: 246, column: 25, scope: !11)
!66 = !DILocation(line: 248, column: 7, scope: !11)
!67 = !DILocation(line: 250, column: 24, scope: !11)
!68 = !DILocation(line: 250, column: 30, scope: !11)
!69 = !DILocation(line: 250, column: 52, scope: !11)
!70 = !DILocation(line: 250, column: 16, scope: !11)
!71 = !DILocation(line: 251, column: 41, scope: !11)
!72 = !DILocation(line: 251, column: 50, scope: !11)
!73 = !DILocation(line: 251, column: 37, scope: !11)
!74 = !DILocation(line: 251, column: 32, scope: !11)
!75 = !DILocation(line: 251, column: 23, scope: !11)
!76 = !DILocation(line: 252, column: 7, scope: !11)
!77 = !DILocation(line: 256, column: 30, scope: !11)
!78 = !DILocation(line: 256, column: 35, scope: !11)
!79 = !DILocation(line: 256, column: 52, scope: !11)
!80 = !DILocation(line: 256, column: 9, scope: !11)
!81 = !DILocation(line: 256, column: 7, scope: !11)
!82 = !DILocation(line: 258, column: 23, scope: !11)
!83 = !DILocation(line: 258, column: 19, scope: !11)
!84 = !DILocation(line: 259, column: 1, scope: !11)
