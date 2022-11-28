; ModuleID = 'Core/Src/syscalls.c'
source_filename = "Core/Src/syscalls.c"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7m-none-unknown-eabi"

%struct.stat = type { i16, i16, i32, i16, i16, i16, i16, i32, %struct.timespec, %struct.timespec, %struct.timespec, i32, i32, [2 x i32] }
%struct.timespec = type { i64, i32 }

@__env = dso_local global [1 x ptr] zeroinitializer, align 4
@environ = dso_local global ptr @__env, align 4
@errno = external thread_local global i32, align 4

; Function Attrs: noinline nounwind
define dso_local void @initialise_monitor_handles() #0 !dbg !7 {
  ret void, !dbg !10
}

; Function Attrs: noinline nounwind
define dso_local i32 @_getpid() #0 !dbg !11 {
  ret i32 1, !dbg !12
}

; Function Attrs: noinline nounwind
define dso_local i32 @_kill(i32 noundef %0, i32 noundef %1) #0 !dbg !13 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 22, ptr @errno, align 4, !dbg !14
  ret i32 -1, !dbg !15
}

; Function Attrs: noinline noreturn nounwind
define dso_local void @_exit(i32 noundef %0) #1 !dbg !16 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4, !dbg !17
  %4 = call i32 @_kill(i32 noundef %3, i32 noundef -1), !dbg !18
  br label %5, !dbg !19

5:                                                ; preds = %1, %5
  br label %5, !dbg !19, !llvm.loop !20
}

; Function Attrs: noinline nounwind
define weak dso_local i32 @_read(i32 noundef %0, ptr noundef %1, i32 noundef %2) #0 !dbg !22 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4, !dbg !23
  br label %8, !dbg !24

8:                                                ; preds = %17, %3
  %9 = load i32, ptr %7, align 4, !dbg !25
  %10 = load i32, ptr %6, align 4, !dbg !26
  %11 = icmp slt i32 %9, %10, !dbg !27
  br i1 %11, label %12, label %20, !dbg !28

12:                                               ; preds = %8
  %13 = call i32 @__io_getchar(), !dbg !29
  %14 = trunc i32 %13 to i8, !dbg !29
  %15 = load ptr, ptr %5, align 4, !dbg !30
  %16 = getelementptr inbounds i8, ptr %15, i32 1, !dbg !30
  store ptr %16, ptr %5, align 4, !dbg !30
  store i8 %14, ptr %15, align 1, !dbg !31
  br label %17, !dbg !32

17:                                               ; preds = %12
  %18 = load i32, ptr %7, align 4, !dbg !33
  %19 = add nsw i32 %18, 1, !dbg !33
  store i32 %19, ptr %7, align 4, !dbg !33
  br label %8, !dbg !28, !llvm.loop !34

20:                                               ; preds = %8
  %21 = load i32, ptr %6, align 4, !dbg !36
  ret i32 %21, !dbg !37
}

declare extern_weak dso_local i32 @__io_getchar() #2

; Function Attrs: noinline nounwind
define weak dso_local i32 @_write(i32 noundef %0, ptr noundef %1, i32 noundef %2) #0 !dbg !38 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4, !dbg !39
  br label %8, !dbg !40

8:                                                ; preds = %18, %3
  %9 = load i32, ptr %7, align 4, !dbg !41
  %10 = load i32, ptr %6, align 4, !dbg !42
  %11 = icmp slt i32 %9, %10, !dbg !43
  br i1 %11, label %12, label %21, !dbg !44

12:                                               ; preds = %8
  %13 = load ptr, ptr %5, align 4, !dbg !45
  %14 = getelementptr inbounds i8, ptr %13, i32 1, !dbg !45
  store ptr %14, ptr %5, align 4, !dbg !45
  %15 = load i8, ptr %13, align 1, !dbg !46
  %16 = zext i8 %15 to i32, !dbg !46
  %17 = call i32 @__io_putchar(i32 noundef %16), !dbg !47
  br label %18, !dbg !48

18:                                               ; preds = %12
  %19 = load i32, ptr %7, align 4, !dbg !49
  %20 = add nsw i32 %19, 1, !dbg !49
  store i32 %20, ptr %7, align 4, !dbg !49
  br label %8, !dbg !44, !llvm.loop !50

21:                                               ; preds = %8
  %22 = load i32, ptr %6, align 4, !dbg !51
  ret i32 %22, !dbg !52
}

declare extern_weak dso_local i32 @__io_putchar(i32 noundef) #2

; Function Attrs: noinline nounwind
define dso_local i32 @_close(i32 noundef %0) #0 !dbg !53 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  ret i32 -1, !dbg !54
}

; Function Attrs: noinline nounwind
define dso_local i32 @_fstat(i32 noundef %0, ptr noundef %1) #0 !dbg !55 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 4
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 4
  %5 = load ptr, ptr %4, align 4, !dbg !56
  %6 = getelementptr inbounds %struct.stat, ptr %5, i32 0, i32 2, !dbg !57
  store i32 8192, ptr %6, align 4, !dbg !58
  ret i32 0, !dbg !59
}

; Function Attrs: noinline nounwind
define dso_local i32 @_isatty(i32 noundef %0) #0 !dbg !60 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  ret i32 1, !dbg !61
}

; Function Attrs: noinline nounwind
define dso_local i32 @_lseek(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 !dbg !62 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  ret i32 0, !dbg !63
}

; Function Attrs: noinline nounwind
define dso_local i32 @_open(ptr noundef %0, i32 noundef %1, ...) #0 !dbg !64 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  ret i32 -1, !dbg !65
}

; Function Attrs: noinline nounwind
define dso_local i32 @_wait(ptr noundef %0) #0 !dbg !66 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  store i32 10, ptr @errno, align 4, !dbg !67
  ret i32 -1, !dbg !68
}

; Function Attrs: noinline nounwind
define dso_local i32 @_unlink(ptr noundef %0) #0 !dbg !69 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  store i32 2, ptr @errno, align 4, !dbg !70
  ret i32 -1, !dbg !71
}

; Function Attrs: noinline nounwind
define dso_local i32 @_times(ptr noundef %0) #0 !dbg !72 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  ret i32 -1, !dbg !73
}

; Function Attrs: noinline nounwind
define dso_local i32 @_stat(ptr noundef %0, ptr noundef %1) #0 !dbg !74 {
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store ptr %1, ptr %4, align 4
  %5 = load ptr, ptr %4, align 4, !dbg !75
  %6 = getelementptr inbounds %struct.stat, ptr %5, i32 0, i32 2, !dbg !76
  store i32 8192, ptr %6, align 4, !dbg !77
  ret i32 0, !dbg !78
}

; Function Attrs: noinline nounwind
define dso_local i32 @_link(ptr noundef %0, ptr noundef %1) #0 !dbg !79 {
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store ptr %1, ptr %4, align 4
  store i32 31, ptr @errno, align 4, !dbg !80
  ret i32 -1, !dbg !81
}

; Function Attrs: noinline nounwind
define dso_local i32 @_fork() #0 !dbg !82 {
  store i32 11, ptr @errno, align 4, !dbg !83
  ret i32 -1, !dbg !84
}

; Function Attrs: noinline nounwind
define dso_local i32 @_execve(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 !dbg !85 {
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  store ptr %0, ptr %4, align 4
  store ptr %1, ptr %5, align 4
  store ptr %2, ptr %6, align 4
  store i32 12, ptr @errno, align 4, !dbg !86
  ret i32 -1, !dbg !87
}

attributes #0 = { noinline nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #1 = { noinline noreturn nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m3" "target-features"="+armv7-m,+hwdiv,+soft-float,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-dsp,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-neon,-pacbti,-ras,-sb,-sha2,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "use-soft-float"="true" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "Core/Src/syscalls.c", directory: "/home/buoffio/Documents/tesi/FreeRTOSv202112.00/FreeRTOS/stm32l152ret6-project")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 1, !"min_enum_size", i32 4}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{!"clang version 15.0.2 (https://github.com/llvm/llvm-project.git 4bd3f3759259548e159aeba5c76efb9a0864e6fa)"}
!7 = distinct !DISubprogram(name: "initialise_monitor_handles", scope: !1, file: !1, line: 44, type: !8, scopeLine: 45, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!8 = !DISubroutineType(types: !9)
!9 = !{}
!10 = !DILocation(line: 46, column: 1, scope: !7)
!11 = distinct !DISubprogram(name: "_getpid", scope: !1, file: !1, line: 48, type: !8, scopeLine: 49, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!12 = !DILocation(line: 50, column: 2, scope: !11)
!13 = distinct !DISubprogram(name: "_kill", scope: !1, file: !1, line: 53, type: !8, scopeLine: 54, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!14 = !DILocation(line: 55, column: 8, scope: !13)
!15 = !DILocation(line: 56, column: 2, scope: !13)
!16 = distinct !DISubprogram(name: "_exit", scope: !1, file: !1, line: 59, type: !8, scopeLine: 60, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!17 = !DILocation(line: 61, column: 8, scope: !16)
!18 = !DILocation(line: 61, column: 2, scope: !16)
!19 = !DILocation(line: 62, column: 2, scope: !16)
!20 = distinct !{!20, !19, !21}
!21 = !DILocation(line: 62, column: 13, scope: !16)
!22 = distinct !DISubprogram(name: "_read", scope: !1, file: !1, line: 65, type: !8, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!23 = !DILocation(line: 69, column: 15, scope: !22)
!24 = !DILocation(line: 69, column: 7, scope: !22)
!25 = !DILocation(line: 69, column: 20, scope: !22)
!26 = !DILocation(line: 69, column: 30, scope: !22)
!27 = !DILocation(line: 69, column: 28, scope: !22)
!28 = !DILocation(line: 69, column: 2, scope: !22)
!29 = !DILocation(line: 71, column: 12, scope: !22)
!30 = !DILocation(line: 71, column: 7, scope: !22)
!31 = !DILocation(line: 71, column: 10, scope: !22)
!32 = !DILocation(line: 72, column: 2, scope: !22)
!33 = !DILocation(line: 69, column: 42, scope: !22)
!34 = distinct !{!34, !28, !32, !35}
!35 = !{!"llvm.loop.mustprogress"}
!36 = !DILocation(line: 74, column: 8, scope: !22)
!37 = !DILocation(line: 74, column: 1, scope: !22)
!38 = distinct !DISubprogram(name: "_write", scope: !1, file: !1, line: 77, type: !8, scopeLine: 78, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!39 = !DILocation(line: 81, column: 15, scope: !38)
!40 = !DILocation(line: 81, column: 7, scope: !38)
!41 = !DILocation(line: 81, column: 20, scope: !38)
!42 = !DILocation(line: 81, column: 30, scope: !38)
!43 = !DILocation(line: 81, column: 28, scope: !38)
!44 = !DILocation(line: 81, column: 2, scope: !38)
!45 = !DILocation(line: 83, column: 20, scope: !38)
!46 = !DILocation(line: 83, column: 16, scope: !38)
!47 = !DILocation(line: 83, column: 3, scope: !38)
!48 = !DILocation(line: 84, column: 2, scope: !38)
!49 = !DILocation(line: 81, column: 42, scope: !38)
!50 = distinct !{!50, !44, !48, !35}
!51 = !DILocation(line: 85, column: 9, scope: !38)
!52 = !DILocation(line: 85, column: 2, scope: !38)
!53 = distinct !DISubprogram(name: "_close", scope: !1, file: !1, line: 88, type: !8, scopeLine: 89, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!54 = !DILocation(line: 90, column: 2, scope: !53)
!55 = distinct !DISubprogram(name: "_fstat", scope: !1, file: !1, line: 94, type: !8, scopeLine: 95, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!56 = !DILocation(line: 96, column: 2, scope: !55)
!57 = !DILocation(line: 96, column: 6, scope: !55)
!58 = !DILocation(line: 96, column: 14, scope: !55)
!59 = !DILocation(line: 97, column: 2, scope: !55)
!60 = distinct !DISubprogram(name: "_isatty", scope: !1, file: !1, line: 100, type: !8, scopeLine: 101, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!61 = !DILocation(line: 102, column: 2, scope: !60)
!62 = distinct !DISubprogram(name: "_lseek", scope: !1, file: !1, line: 105, type: !8, scopeLine: 106, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!63 = !DILocation(line: 107, column: 2, scope: !62)
!64 = distinct !DISubprogram(name: "_open", scope: !1, file: !1, line: 110, type: !8, scopeLine: 111, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!65 = !DILocation(line: 113, column: 2, scope: !64)
!66 = distinct !DISubprogram(name: "_wait", scope: !1, file: !1, line: 116, type: !8, scopeLine: 117, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!67 = !DILocation(line: 118, column: 8, scope: !66)
!68 = !DILocation(line: 119, column: 2, scope: !66)
!69 = distinct !DISubprogram(name: "_unlink", scope: !1, file: !1, line: 122, type: !8, scopeLine: 123, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!70 = !DILocation(line: 124, column: 8, scope: !69)
!71 = !DILocation(line: 125, column: 2, scope: !69)
!72 = distinct !DISubprogram(name: "_times", scope: !1, file: !1, line: 128, type: !8, scopeLine: 129, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!73 = !DILocation(line: 130, column: 2, scope: !72)
!74 = distinct !DISubprogram(name: "_stat", scope: !1, file: !1, line: 133, type: !8, scopeLine: 134, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!75 = !DILocation(line: 135, column: 2, scope: !74)
!76 = !DILocation(line: 135, column: 6, scope: !74)
!77 = !DILocation(line: 135, column: 14, scope: !74)
!78 = !DILocation(line: 136, column: 2, scope: !74)
!79 = distinct !DISubprogram(name: "_link", scope: !1, file: !1, line: 139, type: !8, scopeLine: 140, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!80 = !DILocation(line: 141, column: 8, scope: !79)
!81 = !DILocation(line: 142, column: 2, scope: !79)
!82 = distinct !DISubprogram(name: "_fork", scope: !1, file: !1, line: 145, type: !8, scopeLine: 146, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!83 = !DILocation(line: 147, column: 8, scope: !82)
!84 = !DILocation(line: 148, column: 2, scope: !82)
!85 = distinct !DISubprogram(name: "_execve", scope: !1, file: !1, line: 151, type: !8, scopeLine: 152, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !9)
!86 = !DILocation(line: 153, column: 8, scope: !85)
!87 = !DILocation(line: 154, column: 2, scope: !85)
