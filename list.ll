; ModuleID = 'FreeRTOS/Source/list.c'
source_filename = "FreeRTOS/Source/list.c"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-unknown-eabi"

%struct.xLIST = type { i32, ptr, %struct.xMINI_LIST_ITEM }
%struct.xMINI_LIST_ITEM = type { i32, ptr, ptr }
%struct.xLIST_ITEM = type { i32, ptr, ptr, ptr, ptr }

@.str = private unnamed_addr constant [8 x i8] c"exclude\00", section "llvm.metadata"
@.str.1 = private unnamed_addr constant [23 x i8] c"FreeRTOS/Source/list.c\00", section "llvm.metadata"
@.str.2 = private unnamed_addr constant [8 x i8] c"include\00", section "llvm.metadata"
@llvm.global.annotations = appending global [5 x { ptr, ptr, ptr, i32, ptr }] [{ ptr, ptr, ptr, i32, ptr } { ptr @vListInitialise, ptr @.str, ptr @.str.1, i32 50, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vListInitialiseItem, ptr @.str.2, ptr @.str.1, i32 75, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vListInsertEnd, ptr @.str.2, ptr @.str.1, i32 87, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @vListInsert, ptr @.str.2, ptr @.str.1, i32 117, ptr null }, { ptr, ptr, ptr, i32, ptr } { ptr @uxListRemove, ptr @.str.2, ptr @.str.1, i32 188, ptr null }], section "llvm.metadata"

; Function Attrs: noinline nounwind
define dso_local void @vListInitialise(ptr noundef %0) #0 !dbg !7 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %3 = load ptr, ptr %2, align 4, !dbg !10
  %4 = getelementptr inbounds %struct.xLIST, ptr %3, i32 0, i32 2, !dbg !11
  %5 = load ptr, ptr %2, align 4, !dbg !12
  %6 = getelementptr inbounds %struct.xLIST, ptr %5, i32 0, i32 1, !dbg !13
  store ptr %4, ptr %6, align 4, !dbg !14
  %7 = load ptr, ptr %2, align 4, !dbg !15
  %8 = getelementptr inbounds %struct.xLIST, ptr %7, i32 0, i32 2, !dbg !16
  %9 = getelementptr inbounds %struct.xMINI_LIST_ITEM, ptr %8, i32 0, i32 0, !dbg !17
  store i32 -1, ptr %9, align 4, !dbg !18
  %10 = load ptr, ptr %2, align 4, !dbg !19
  %11 = getelementptr inbounds %struct.xLIST, ptr %10, i32 0, i32 2, !dbg !20
  %12 = load ptr, ptr %2, align 4, !dbg !21
  %13 = getelementptr inbounds %struct.xLIST, ptr %12, i32 0, i32 2, !dbg !22
  %14 = getelementptr inbounds %struct.xMINI_LIST_ITEM, ptr %13, i32 0, i32 1, !dbg !23
  store ptr %11, ptr %14, align 4, !dbg !24
  %15 = load ptr, ptr %2, align 4, !dbg !25
  %16 = getelementptr inbounds %struct.xLIST, ptr %15, i32 0, i32 2, !dbg !26
  %17 = load ptr, ptr %2, align 4, !dbg !27
  %18 = getelementptr inbounds %struct.xLIST, ptr %17, i32 0, i32 2, !dbg !28
  %19 = getelementptr inbounds %struct.xMINI_LIST_ITEM, ptr %18, i32 0, i32 2, !dbg !29
  store ptr %16, ptr %19, align 4, !dbg !30
  %20 = load ptr, ptr %2, align 4, !dbg !31
  %21 = getelementptr inbounds %struct.xLIST, ptr %20, i32 0, i32 0, !dbg !32
  store volatile i32 0, ptr %21, align 4, !dbg !33
  ret void, !dbg !34
}

; Function Attrs: noinline nounwind
define dso_local void @vListInitialiseItem(ptr noundef %0) #0 !dbg !35 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %3 = load ptr, ptr %2, align 4, !dbg !36
  %4 = getelementptr inbounds %struct.xLIST_ITEM, ptr %3, i32 0, i32 4, !dbg !37
  store ptr null, ptr %4, align 4, !dbg !38
  ret void, !dbg !39
}

; Function Attrs: noinline nounwind
define dso_local void @vListInsertEnd(ptr noundef %0, ptr noundef %1) #0 !dbg !40 {
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store ptr %1, ptr %4, align 4
  %6 = load ptr, ptr %3, align 4, !dbg !41
  %7 = getelementptr inbounds %struct.xLIST, ptr %6, i32 0, i32 1, !dbg !42
  %8 = load ptr, ptr %7, align 4, !dbg !42
  store ptr %8, ptr %5, align 4, !dbg !43
  %9 = load ptr, ptr %5, align 4, !dbg !44
  %10 = load ptr, ptr %4, align 4, !dbg !45
  %11 = getelementptr inbounds %struct.xLIST_ITEM, ptr %10, i32 0, i32 1, !dbg !46
  store ptr %9, ptr %11, align 4, !dbg !47
  %12 = load ptr, ptr %5, align 4, !dbg !48
  %13 = getelementptr inbounds %struct.xLIST_ITEM, ptr %12, i32 0, i32 2, !dbg !49
  %14 = load ptr, ptr %13, align 4, !dbg !49
  %15 = load ptr, ptr %4, align 4, !dbg !50
  %16 = getelementptr inbounds %struct.xLIST_ITEM, ptr %15, i32 0, i32 2, !dbg !51
  store ptr %14, ptr %16, align 4, !dbg !52
  %17 = load ptr, ptr %4, align 4, !dbg !53
  %18 = load ptr, ptr %5, align 4, !dbg !54
  %19 = getelementptr inbounds %struct.xLIST_ITEM, ptr %18, i32 0, i32 2, !dbg !55
  %20 = load ptr, ptr %19, align 4, !dbg !55
  %21 = getelementptr inbounds %struct.xLIST_ITEM, ptr %20, i32 0, i32 1, !dbg !56
  store ptr %17, ptr %21, align 4, !dbg !57
  %22 = load ptr, ptr %4, align 4, !dbg !58
  %23 = load ptr, ptr %5, align 4, !dbg !59
  %24 = getelementptr inbounds %struct.xLIST_ITEM, ptr %23, i32 0, i32 2, !dbg !60
  store ptr %22, ptr %24, align 4, !dbg !61
  %25 = load ptr, ptr %3, align 4, !dbg !62
  %26 = load ptr, ptr %4, align 4, !dbg !63
  %27 = getelementptr inbounds %struct.xLIST_ITEM, ptr %26, i32 0, i32 4, !dbg !64
  store ptr %25, ptr %27, align 4, !dbg !65
  %28 = load ptr, ptr %3, align 4, !dbg !66
  %29 = getelementptr inbounds %struct.xLIST, ptr %28, i32 0, i32 0, !dbg !67
  %30 = load volatile i32, ptr %29, align 4, !dbg !68
  %31 = add i32 %30, 1, !dbg !68
  store volatile i32 %31, ptr %29, align 4, !dbg !68
  ret void, !dbg !69
}

; Function Attrs: noinline nounwind
define dso_local void @vListInsert(ptr noundef %0, ptr noundef %1) #0 !dbg !70 {
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store ptr %1, ptr %4, align 4
  %7 = load ptr, ptr %4, align 4, !dbg !71
  %8 = getelementptr inbounds %struct.xLIST_ITEM, ptr %7, i32 0, i32 0, !dbg !72
  %9 = load i32, ptr %8, align 4, !dbg !72
  store i32 %9, ptr %6, align 4, !dbg !73
  %10 = load i32, ptr %6, align 4, !dbg !74
  %11 = icmp eq i32 %10, -1, !dbg !75
  br i1 %11, label %12, label %17, !dbg !74

12:                                               ; preds = %2
  %13 = load ptr, ptr %3, align 4, !dbg !76
  %14 = getelementptr inbounds %struct.xLIST, ptr %13, i32 0, i32 2, !dbg !77
  %15 = getelementptr inbounds %struct.xMINI_LIST_ITEM, ptr %14, i32 0, i32 2, !dbg !78
  %16 = load ptr, ptr %15, align 4, !dbg !78
  store ptr %16, ptr %5, align 4, !dbg !79
  br label %34, !dbg !80

17:                                               ; preds = %2
  %18 = load ptr, ptr %3, align 4, !dbg !81
  %19 = getelementptr inbounds %struct.xLIST, ptr %18, i32 0, i32 2, !dbg !82
  store ptr %19, ptr %5, align 4, !dbg !83
  br label %20, !dbg !84

20:                                               ; preds = %29, %17
  %21 = load ptr, ptr %5, align 4, !dbg !85
  %22 = getelementptr inbounds %struct.xLIST_ITEM, ptr %21, i32 0, i32 1, !dbg !86
  %23 = load ptr, ptr %22, align 4, !dbg !86
  %24 = getelementptr inbounds %struct.xLIST_ITEM, ptr %23, i32 0, i32 0, !dbg !87
  %25 = load i32, ptr %24, align 4, !dbg !87
  %26 = load i32, ptr %6, align 4, !dbg !88
  %27 = icmp ule i32 %25, %26, !dbg !89
  br i1 %27, label %28, label %33, !dbg !90

28:                                               ; preds = %20
  br label %29, !dbg !91

29:                                               ; preds = %28
  %30 = load ptr, ptr %5, align 4, !dbg !92
  %31 = getelementptr inbounds %struct.xLIST_ITEM, ptr %30, i32 0, i32 1, !dbg !93
  %32 = load ptr, ptr %31, align 4, !dbg !93
  store ptr %32, ptr %5, align 4, !dbg !94
  br label %20, !dbg !90, !llvm.loop !95

33:                                               ; preds = %20
  br label %34

34:                                               ; preds = %33, %12
  %35 = load ptr, ptr %5, align 4, !dbg !97
  %36 = getelementptr inbounds %struct.xLIST_ITEM, ptr %35, i32 0, i32 1, !dbg !98
  %37 = load ptr, ptr %36, align 4, !dbg !98
  %38 = load ptr, ptr %4, align 4, !dbg !99
  %39 = getelementptr inbounds %struct.xLIST_ITEM, ptr %38, i32 0, i32 1, !dbg !100
  store ptr %37, ptr %39, align 4, !dbg !101
  %40 = load ptr, ptr %4, align 4, !dbg !102
  %41 = load ptr, ptr %4, align 4, !dbg !103
  %42 = getelementptr inbounds %struct.xLIST_ITEM, ptr %41, i32 0, i32 1, !dbg !104
  %43 = load ptr, ptr %42, align 4, !dbg !104
  %44 = getelementptr inbounds %struct.xLIST_ITEM, ptr %43, i32 0, i32 2, !dbg !105
  store ptr %40, ptr %44, align 4, !dbg !106
  %45 = load ptr, ptr %5, align 4, !dbg !107
  %46 = load ptr, ptr %4, align 4, !dbg !108
  %47 = getelementptr inbounds %struct.xLIST_ITEM, ptr %46, i32 0, i32 2, !dbg !109
  store ptr %45, ptr %47, align 4, !dbg !110
  %48 = load ptr, ptr %4, align 4, !dbg !111
  %49 = load ptr, ptr %5, align 4, !dbg !112
  %50 = getelementptr inbounds %struct.xLIST_ITEM, ptr %49, i32 0, i32 1, !dbg !113
  store ptr %48, ptr %50, align 4, !dbg !114
  %51 = load ptr, ptr %3, align 4, !dbg !115
  %52 = load ptr, ptr %4, align 4, !dbg !116
  %53 = getelementptr inbounds %struct.xLIST_ITEM, ptr %52, i32 0, i32 4, !dbg !117
  store ptr %51, ptr %53, align 4, !dbg !118
  %54 = load ptr, ptr %3, align 4, !dbg !119
  %55 = getelementptr inbounds %struct.xLIST, ptr %54, i32 0, i32 0, !dbg !120
  %56 = load volatile i32, ptr %55, align 4, !dbg !121
  %57 = add i32 %56, 1, !dbg !121
  store volatile i32 %57, ptr %55, align 4, !dbg !121
  ret void, !dbg !122
}

; Function Attrs: noinline nounwind
define dso_local i32 @uxListRemove(ptr noundef %0) #0 !dbg !123 {
  %2 = alloca ptr, align 4
  %3 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %4 = load ptr, ptr %2, align 4, !dbg !124
  %5 = getelementptr inbounds %struct.xLIST_ITEM, ptr %4, i32 0, i32 4, !dbg !125
  %6 = load ptr, ptr %5, align 4, !dbg !125
  store ptr %6, ptr %3, align 4, !dbg !126
  %7 = load ptr, ptr %2, align 4, !dbg !127
  %8 = getelementptr inbounds %struct.xLIST_ITEM, ptr %7, i32 0, i32 2, !dbg !128
  %9 = load ptr, ptr %8, align 4, !dbg !128
  %10 = load ptr, ptr %2, align 4, !dbg !129
  %11 = getelementptr inbounds %struct.xLIST_ITEM, ptr %10, i32 0, i32 1, !dbg !130
  %12 = load ptr, ptr %11, align 4, !dbg !130
  %13 = getelementptr inbounds %struct.xLIST_ITEM, ptr %12, i32 0, i32 2, !dbg !131
  store ptr %9, ptr %13, align 4, !dbg !132
  %14 = load ptr, ptr %2, align 4, !dbg !133
  %15 = getelementptr inbounds %struct.xLIST_ITEM, ptr %14, i32 0, i32 1, !dbg !134
  %16 = load ptr, ptr %15, align 4, !dbg !134
  %17 = load ptr, ptr %2, align 4, !dbg !135
  %18 = getelementptr inbounds %struct.xLIST_ITEM, ptr %17, i32 0, i32 2, !dbg !136
  %19 = load ptr, ptr %18, align 4, !dbg !136
  %20 = getelementptr inbounds %struct.xLIST_ITEM, ptr %19, i32 0, i32 1, !dbg !137
  store ptr %16, ptr %20, align 4, !dbg !138
  %21 = load ptr, ptr %3, align 4, !dbg !139
  %22 = getelementptr inbounds %struct.xLIST, ptr %21, i32 0, i32 1, !dbg !140
  %23 = load ptr, ptr %22, align 4, !dbg !140
  %24 = load ptr, ptr %2, align 4, !dbg !141
  %25 = icmp eq ptr %23, %24, !dbg !142
  br i1 %25, label %26, label %32, !dbg !139

26:                                               ; preds = %1
  %27 = load ptr, ptr %2, align 4, !dbg !143
  %28 = getelementptr inbounds %struct.xLIST_ITEM, ptr %27, i32 0, i32 2, !dbg !144
  %29 = load ptr, ptr %28, align 4, !dbg !144
  %30 = load ptr, ptr %3, align 4, !dbg !145
  %31 = getelementptr inbounds %struct.xLIST, ptr %30, i32 0, i32 1, !dbg !146
  store ptr %29, ptr %31, align 4, !dbg !147
  br label %33, !dbg !148

32:                                               ; preds = %1
  br label %33

33:                                               ; preds = %32, %26
  %34 = load ptr, ptr %2, align 4, !dbg !149
  %35 = getelementptr inbounds %struct.xLIST_ITEM, ptr %34, i32 0, i32 4, !dbg !150
  store ptr null, ptr %35, align 4, !dbg !151
  %36 = load ptr, ptr %3, align 4, !dbg !152
  %37 = getelementptr inbounds %struct.xLIST, ptr %36, i32 0, i32 0, !dbg !153
  %38 = load volatile i32, ptr %37, align 4, !dbg !154
  %39 = add i32 %38, -1, !dbg !154
  store volatile i32 %39, ptr %37, align 4, !dbg !154
  %40 = load ptr, ptr %3, align 4, !dbg !155
  %41 = getelementptr inbounds %struct.xLIST, ptr %40, i32 0, i32 0, !dbg !156
  %42 = load volatile i32, ptr %41, align 4, !dbg !156
  ret i32 %42, !dbg !157
}

attributes #0 = { noinline nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "FreeRTOS/Source/list.c", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 1, !"min_enum_size", i32 4}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{!"clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)"}
!7 = distinct !DISubprogram(name: "vListInitialise", scope: !1, file: !1, line: 50, type: !8, scopeLine: 51, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!8 = !DISubroutineType(types: !9)
!9 = !{}
!10 = !DILocation(line: 55, column: 43, scope: !7)
!11 = !DILocation(line: 55, column: 51, scope: !7)
!12 = !DILocation(line: 55, column: 5, scope: !7)
!13 = !DILocation(line: 55, column: 13, scope: !7)
!14 = !DILocation(line: 55, column: 21, scope: !7)
!15 = !DILocation(line: 59, column: 5, scope: !7)
!16 = !DILocation(line: 59, column: 13, scope: !7)
!17 = !DILocation(line: 59, column: 22, scope: !7)
!18 = !DILocation(line: 59, column: 33, scope: !7)
!19 = !DILocation(line: 63, column: 51, scope: !7)
!20 = !DILocation(line: 63, column: 59, scope: !7)
!21 = !DILocation(line: 63, column: 5, scope: !7)
!22 = !DILocation(line: 63, column: 13, scope: !7)
!23 = !DILocation(line: 63, column: 22, scope: !7)
!24 = !DILocation(line: 63, column: 29, scope: !7)
!25 = !DILocation(line: 64, column: 55, scope: !7)
!26 = !DILocation(line: 64, column: 63, scope: !7)
!27 = !DILocation(line: 64, column: 5, scope: !7)
!28 = !DILocation(line: 64, column: 13, scope: !7)
!29 = !DILocation(line: 64, column: 22, scope: !7)
!30 = !DILocation(line: 64, column: 33, scope: !7)
!31 = !DILocation(line: 66, column: 5, scope: !7)
!32 = !DILocation(line: 66, column: 13, scope: !7)
!33 = !DILocation(line: 66, column: 29, scope: !7)
!34 = !DILocation(line: 72, column: 1, scope: !7)
!35 = distinct !DISubprogram(name: "vListInitialiseItem", scope: !1, file: !1, line: 75, type: !8, scopeLine: 76, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!36 = !DILocation(line: 78, column: 5, scope: !35)
!37 = !DILocation(line: 78, column: 13, scope: !35)
!38 = !DILocation(line: 78, column: 25, scope: !35)
!39 = !DILocation(line: 84, column: 1, scope: !35)
!40 = distinct !DISubprogram(name: "vListInsertEnd", scope: !1, file: !1, line: 87, type: !8, scopeLine: 89, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!41 = !DILocation(line: 90, column: 34, scope: !40)
!42 = !DILocation(line: 90, column: 42, scope: !40)
!43 = !DILocation(line: 90, column: 24, scope: !40)
!44 = !DILocation(line: 101, column: 29, scope: !40)
!45 = !DILocation(line: 101, column: 5, scope: !40)
!46 = !DILocation(line: 101, column: 20, scope: !40)
!47 = !DILocation(line: 101, column: 27, scope: !40)
!48 = !DILocation(line: 102, column: 33, scope: !40)
!49 = !DILocation(line: 102, column: 42, scope: !40)
!50 = !DILocation(line: 102, column: 5, scope: !40)
!51 = !DILocation(line: 102, column: 20, scope: !40)
!52 = !DILocation(line: 102, column: 31, scope: !40)
!53 = !DILocation(line: 107, column: 35, scope: !40)
!54 = !DILocation(line: 107, column: 5, scope: !40)
!55 = !DILocation(line: 107, column: 14, scope: !40)
!56 = !DILocation(line: 107, column: 26, scope: !40)
!57 = !DILocation(line: 107, column: 33, scope: !40)
!58 = !DILocation(line: 108, column: 27, scope: !40)
!59 = !DILocation(line: 108, column: 5, scope: !40)
!60 = !DILocation(line: 108, column: 14, scope: !40)
!61 = !DILocation(line: 108, column: 25, scope: !40)
!62 = !DILocation(line: 111, column: 34, scope: !40)
!63 = !DILocation(line: 111, column: 5, scope: !40)
!64 = !DILocation(line: 111, column: 20, scope: !40)
!65 = !DILocation(line: 111, column: 32, scope: !40)
!66 = !DILocation(line: 113, column: 7, scope: !40)
!67 = !DILocation(line: 113, column: 15, scope: !40)
!68 = !DILocation(line: 113, column: 32, scope: !40)
!69 = !DILocation(line: 114, column: 1, scope: !40)
!70 = distinct !DISubprogram(name: "vListInsert", scope: !1, file: !1, line: 117, type: !8, scopeLine: 119, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!71 = !DILocation(line: 121, column: 42, scope: !70)
!72 = !DILocation(line: 121, column: 57, scope: !70)
!73 = !DILocation(line: 121, column: 22, scope: !70)
!74 = !DILocation(line: 137, column: 9, scope: !70)
!75 = !DILocation(line: 137, column: 27, scope: !70)
!76 = !DILocation(line: 139, column: 22, scope: !70)
!77 = !DILocation(line: 139, column: 30, scope: !70)
!78 = !DILocation(line: 139, column: 39, scope: !70)
!79 = !DILocation(line: 139, column: 20, scope: !70)
!80 = !DILocation(line: 140, column: 5, scope: !70)
!81 = !DILocation(line: 168, column: 47, scope: !70)
!82 = !DILocation(line: 168, column: 55, scope: !70)
!83 = !DILocation(line: 168, column: 25, scope: !70)
!84 = !DILocation(line: 168, column: 14, scope: !70)
!85 = !DILocation(line: 168, column: 67, scope: !70)
!86 = !DILocation(line: 168, column: 79, scope: !70)
!87 = !DILocation(line: 168, column: 87, scope: !70)
!88 = !DILocation(line: 168, column: 101, scope: !70)
!89 = !DILocation(line: 168, column: 98, scope: !70)
!90 = !DILocation(line: 168, column: 9, scope: !70)
!91 = !DILocation(line: 172, column: 9, scope: !70)
!92 = !DILocation(line: 168, column: 133, scope: !70)
!93 = !DILocation(line: 168, column: 145, scope: !70)
!94 = !DILocation(line: 168, column: 131, scope: !70)
!95 = distinct !{!95, !90, !91, !96}
!96 = !{!"llvm.loop.mustprogress"}
!97 = !DILocation(line: 175, column: 29, scope: !70)
!98 = !DILocation(line: 175, column: 41, scope: !70)
!99 = !DILocation(line: 175, column: 5, scope: !70)
!100 = !DILocation(line: 175, column: 20, scope: !70)
!101 = !DILocation(line: 175, column: 27, scope: !70)
!102 = !DILocation(line: 176, column: 41, scope: !70)
!103 = !DILocation(line: 176, column: 5, scope: !70)
!104 = !DILocation(line: 176, column: 20, scope: !70)
!105 = !DILocation(line: 176, column: 28, scope: !70)
!106 = !DILocation(line: 176, column: 39, scope: !70)
!107 = !DILocation(line: 177, column: 33, scope: !70)
!108 = !DILocation(line: 177, column: 5, scope: !70)
!109 = !DILocation(line: 177, column: 20, scope: !70)
!110 = !DILocation(line: 177, column: 31, scope: !70)
!111 = !DILocation(line: 178, column: 26, scope: !70)
!112 = !DILocation(line: 178, column: 5, scope: !70)
!113 = !DILocation(line: 178, column: 17, scope: !70)
!114 = !DILocation(line: 178, column: 24, scope: !70)
!115 = !DILocation(line: 182, column: 34, scope: !70)
!116 = !DILocation(line: 182, column: 5, scope: !70)
!117 = !DILocation(line: 182, column: 20, scope: !70)
!118 = !DILocation(line: 182, column: 32, scope: !70)
!119 = !DILocation(line: 184, column: 7, scope: !70)
!120 = !DILocation(line: 184, column: 15, scope: !70)
!121 = !DILocation(line: 184, column: 32, scope: !70)
!122 = !DILocation(line: 185, column: 1, scope: !70)
!123 = distinct !DISubprogram(name: "uxListRemove", scope: !1, file: !1, line: 188, type: !8, scopeLine: 189, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!124 = !DILocation(line: 192, column: 29, scope: !123)
!125 = !DILocation(line: 192, column: 45, scope: !123)
!126 = !DILocation(line: 192, column: 20, scope: !123)
!127 = !DILocation(line: 194, column: 42, scope: !123)
!128 = !DILocation(line: 194, column: 58, scope: !123)
!129 = !DILocation(line: 194, column: 5, scope: !123)
!130 = !DILocation(line: 194, column: 21, scope: !123)
!131 = !DILocation(line: 194, column: 29, scope: !123)
!132 = !DILocation(line: 194, column: 40, scope: !123)
!133 = !DILocation(line: 195, column: 42, scope: !123)
!134 = !DILocation(line: 195, column: 58, scope: !123)
!135 = !DILocation(line: 195, column: 5, scope: !123)
!136 = !DILocation(line: 195, column: 21, scope: !123)
!137 = !DILocation(line: 195, column: 33, scope: !123)
!138 = !DILocation(line: 195, column: 40, scope: !123)
!139 = !DILocation(line: 201, column: 9, scope: !123)
!140 = !DILocation(line: 201, column: 17, scope: !123)
!141 = !DILocation(line: 201, column: 28, scope: !123)
!142 = !DILocation(line: 201, column: 25, scope: !123)
!143 = !DILocation(line: 203, column: 27, scope: !123)
!144 = !DILocation(line: 203, column: 43, scope: !123)
!145 = !DILocation(line: 203, column: 9, scope: !123)
!146 = !DILocation(line: 203, column: 17, scope: !123)
!147 = !DILocation(line: 203, column: 25, scope: !123)
!148 = !DILocation(line: 204, column: 5, scope: !123)
!149 = !DILocation(line: 210, column: 5, scope: !123)
!150 = !DILocation(line: 210, column: 21, scope: !123)
!151 = !DILocation(line: 210, column: 33, scope: !123)
!152 = !DILocation(line: 211, column: 7, scope: !123)
!153 = !DILocation(line: 211, column: 15, scope: !123)
!154 = !DILocation(line: 211, column: 32, scope: !123)
!155 = !DILocation(line: 213, column: 12, scope: !123)
!156 = !DILocation(line: 213, column: 20, scope: !123)
!157 = !DILocation(line: 213, column: 5, scope: !123)
