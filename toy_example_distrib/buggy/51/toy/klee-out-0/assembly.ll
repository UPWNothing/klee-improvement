; ModuleID = 'toy.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.file_header = type <{ i32, i32, i16, i16, i32 }>
%struct.file_entry = type <{ [16 x i8], i32, %union.anon }>
%union.anon = type <{ float }>

@lava_val = internal global [1000000 x i32] zeroinitializer, align 16
@.str = private unnamed_addr constant [18 x i8] c"Entry: bar = %s, \00", align 1
@.str1 = private unnamed_addr constant [12 x i8] c"fdata = %f\0A\00", align 1
@.str2 = private unnamed_addr constant [14 x i8] c"intdata = %u\0A\00", align 1
@.str3 = private unnamed_addr constant [17 x i8] c"Unknown type %x\0A\00", align 1
@.str4 = private unnamed_addr constant [3 x i8] c"rb\00", align 1
@.str5 = private unnamed_addr constant [20 x i8] c"File timestamp: %u\0A\00", align 1
@.str6 = private unnamed_addr constant [60 x i8] c"/home/klee/klee_src/runtime/Intrinsic/klee_div_zero_check.c\00", align 1
@.str17 = private unnamed_addr constant [15 x i8] c"divide by zero\00", align 1
@.str28 = private unnamed_addr constant [8 x i8] c"div.err\00", align 1
@.str39 = private unnamed_addr constant [8 x i8] c"IGNORED\00", align 1
@.str14 = private unnamed_addr constant [16 x i8] c"overshift error\00", align 1
@.str25 = private unnamed_addr constant [14 x i8] c"overshift.err\00", align 1
@.str610 = private unnamed_addr constant [51 x i8] c"/home/klee/klee_src/runtime/Intrinsic/klee_range.c\00", align 1
@.str1711 = private unnamed_addr constant [14 x i8] c"invalid range\00", align 1
@.str2812 = private unnamed_addr constant [5 x i8] c"user\00", align 1

; Function Attrs: nounwind uwtable
define void @lava_set(i32 %bug_num, i32 %val) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 %bug_num, i32* %1, align 4
  store i32 %val, i32* %2, align 4
  %3 = load i32* %2, align 4, !dbg !226
  %4 = load i32* %1, align 4, !dbg !226
  %5 = zext i32 %4 to i64, !dbg !226
  %6 = getelementptr inbounds [1000000 x i32]* @lava_val, i32 0, i64 %5, !dbg !226
  store i32 %3, i32* %6, align 4, !dbg !226
  ret void, !dbg !226
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: nounwind uwtable
define i32 @lava_get(i32 %bug_num) #0 {
  %1 = alloca i32, align 4
  store i32 %bug_num, i32* %1, align 4
  %2 = load i32* %1, align 4, !dbg !227
  %3 = zext i32 %2 to i64, !dbg !227
  %4 = getelementptr inbounds [1000000 x i32]* @lava_val, i32 0, i64 %3, !dbg !227
  %5 = load i32* %4, align 4, !dbg !227
  ret i32 %5, !dbg !227
}

; Function Attrs: nounwind uwtable
define void @parse_header(%struct._IO_FILE* %f, %struct.file_header* %hdr) #0 {
  %1 = alloca %struct._IO_FILE*, align 8
  %2 = alloca %struct.file_header*, align 8
  store %struct._IO_FILE* %f, %struct._IO_FILE** %1, align 8
  store %struct.file_header* %hdr, %struct.file_header** %2, align 8
  %3 = load %struct.file_header** %2, align 8, !dbg !228
  %4 = bitcast %struct.file_header* %3 to i8*, !dbg !228
  %5 = load %struct._IO_FILE** %1, align 8, !dbg !228
  %6 = call i64 @fread(i8* %4, i64 16, i64 1, %struct._IO_FILE* %5), !dbg !228
  %7 = icmp ne i64 1, %6, !dbg !228
  br i1 %7, label %8, label %9, !dbg !228

; <label>:8                                       ; preds = %0
  call void @exit(i32 1) #8, !dbg !230
  unreachable, !dbg !230

; <label>:9                                       ; preds = %0
  %10 = load %struct.file_header** %2, align 8, !dbg !231
  %11 = getelementptr inbounds %struct.file_header* %10, i32 0, i32 0, !dbg !231
  %12 = load i32* %11, align 1, !dbg !231
  %13 = icmp ne i32 %12, 1279350337, !dbg !231
  br i1 %13, label %14, label %15, !dbg !231

; <label>:14                                      ; preds = %9
  call void @exit(i32 1) #8, !dbg !233
  unreachable, !dbg !233

; <label>:15                                      ; preds = %9
  ret void, !dbg !234
}

declare i64 @fread(i8*, i64, i64, %struct._IO_FILE*) #2

; Function Attrs: noreturn nounwind
declare void @exit(i32) #3

; Function Attrs: nounwind uwtable
define %struct.file_entry* @parse_record(%struct._IO_FILE* %f) #0 {
  %1 = alloca %struct._IO_FILE*, align 8
  %ret = alloca %struct.file_entry*, align 8
  store %struct._IO_FILE* %f, %struct._IO_FILE** %1, align 8
  %2 = call noalias i8* @malloc(i64 24) #9, !dbg !235
  %3 = bitcast i8* %2 to %struct.file_entry*, !dbg !235
  store %struct.file_entry* %3, %struct.file_entry** %ret, align 8, !dbg !235
  %4 = load %struct.file_entry** %ret, align 8, !dbg !236
  %5 = bitcast %struct.file_entry* %4 to i8*, !dbg !236
  %6 = load %struct._IO_FILE** %1, align 8, !dbg !236
  %7 = call i64 @fread(i8* %5, i64 24, i64 1, %struct._IO_FILE* %6), !dbg !236
  %8 = icmp ne i64 1, %7, !dbg !236
  br i1 %8, label %9, label %10, !dbg !236

; <label>:9                                       ; preds = %0
  call void @exit(i32 1) #8, !dbg !238
  unreachable, !dbg !238

; <label>:10                                      ; preds = %0
  %11 = load %struct.file_entry** %ret, align 8, !dbg !239
  ret %struct.file_entry* %11, !dbg !239
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #4

; Function Attrs: nounwind uwtable
define void @consume_record(%struct.file_entry* %ent) #0 {
  %1 = alloca %struct.file_entry*, align 8
  store %struct.file_entry* %ent, %struct.file_entry** %1, align 8
  %2 = call i32 @lava_get(i32 101), !dbg !240
  %3 = call i32 @lava_get(i32 101), !dbg !240
  %4 = icmp eq i32 1818326524, %3, !dbg !240
  br i1 %4, label %8, label %5, !dbg !240

; <label>:5                                       ; preds = %0
  %6 = call i32 @lava_get(i32 101), !dbg !240
  %7 = icmp eq i32 -59416212, %6, !dbg !240
  br label %8, !dbg !240

; <label>:8                                       ; preds = %5, %0
  %9 = phi i1 [ true, %0 ], [ %7, %5 ]
  %10 = zext i1 %9 to i32, !dbg !240
  %11 = mul i32 %2, %10, !dbg !240
  %12 = zext i32 %11 to i64, !dbg !240
  %13 = getelementptr inbounds i8* getelementptr inbounds ([18 x i8]* @.str, i32 0, i32 0), i64 %12, !dbg !240
  %14 = load %struct.file_entry** %1, align 8, !dbg !240
  %15 = getelementptr inbounds %struct.file_entry* %14, i32 0, i32 0, !dbg !240
  %16 = getelementptr inbounds [16 x i8]* %15, i32 0, i32 0, !dbg !240
  %17 = call i32 (i8*, ...)* @printf(i8* %13, i8* %16), !dbg !240
  %18 = load %struct.file_entry** %1, align 8, !dbg !241
  %19 = getelementptr inbounds %struct.file_entry* %18, i32 0, i32 1, !dbg !241
  %20 = load i32* %19, align 1, !dbg !241
  %21 = icmp eq i32 %20, 1, !dbg !241
  %22 = load %struct.file_entry** %1, align 8, !dbg !243
  br i1 %21, label %23, label %29, !dbg !241

; <label>:23                                      ; preds = %8
  %24 = getelementptr inbounds %struct.file_entry* %22, i32 0, i32 2, !dbg !243
  %25 = bitcast %union.anon* %24 to float*, !dbg !243
  %26 = load float* %25, align 1, !dbg !243
  %27 = fpext float %26 to double, !dbg !243
  %28 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str1, i32 0, i32 0), double %27), !dbg !243
  br label %43, !dbg !245

; <label>:29                                      ; preds = %8
  %30 = getelementptr inbounds %struct.file_entry* %22, i32 0, i32 1, !dbg !246
  %31 = load i32* %30, align 1, !dbg !246
  %32 = icmp eq i32 %31, 2, !dbg !246
  %33 = load %struct.file_entry** %1, align 8, !dbg !248
  br i1 %32, label %34, label %39, !dbg !246

; <label>:34                                      ; preds = %29
  %35 = getelementptr inbounds %struct.file_entry* %33, i32 0, i32 2, !dbg !248
  %36 = bitcast %union.anon* %35 to i32*, !dbg !248
  %37 = load i32* %36, align 1, !dbg !248
  %38 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str2, i32 0, i32 0), i32 %37), !dbg !248
  br label %43

; <label>:39                                      ; preds = %29
  %40 = getelementptr inbounds %struct.file_entry* %33, i32 0, i32 1, !dbg !250
  %41 = load i32* %40, align 1, !dbg !250
  %42 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str3, i32 0, i32 0), i32 %41), !dbg !250
  call void @exit(i32 1) #8, !dbg !252
  unreachable, !dbg !252

; <label>:43                                      ; preds = %34, %23
  %44 = load %struct.file_entry** %1, align 8, !dbg !253
  %45 = bitcast %struct.file_entry* %44 to i8*, !dbg !253
  call void @free(i8* %45) #9, !dbg !253
  ret void, !dbg !254
}

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind
declare void @free(i8*) #4

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %f = alloca %struct._IO_FILE*, align 8
  %head = alloca %struct.file_header, align 1
  %lava_101 = alloca i32, align 4
  %i = alloca i32, align 4
  %ent = alloca %struct.file_entry*, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = load i8*** %3, align 8, !dbg !255
  %5 = getelementptr inbounds i8** %4, i64 1, !dbg !255
  %6 = load i8** %5, align 8, !dbg !255
  %7 = call %struct._IO_FILE* @fopen(i8* %6, i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0)), !dbg !255
  store %struct._IO_FILE* %7, %struct._IO_FILE** %f, align 8, !dbg !255
  %8 = load %struct._IO_FILE** %f, align 8, !dbg !256
  call void @parse_header(%struct._IO_FILE* %8, %struct.file_header* %head), !dbg !256
  store i32 0, i32* %lava_101, align 4, !dbg !256
  %9 = getelementptr inbounds %struct.file_header* %head, i32 0, i32 4, !dbg !258
  %10 = bitcast i32* %9 to i8*, !dbg !258
  %11 = getelementptr inbounds i8* %10, i64 0, !dbg !258
  %12 = load i8* %11, align 1, !dbg !258
  %13 = zext i8 %12 to i32, !dbg !258
  %int_cast_to_i64 = zext i32 0 to i64
  call void @klee_overshift_check(i64 32, i64 %int_cast_to_i64), !dbg !258
  %14 = shl i32 %13, 0, !dbg !258
  %15 = load i32* %lava_101, align 4, !dbg !258
  %16 = or i32 %15, %14, !dbg !258
  store i32 %16, i32* %lava_101, align 4, !dbg !258
  %17 = getelementptr inbounds %struct.file_header* %head, i32 0, i32 4, !dbg !258
  %18 = bitcast i32* %17 to i8*, !dbg !258
  %19 = getelementptr inbounds i8* %18, i64 1, !dbg !258
  %20 = load i8* %19, align 1, !dbg !258
  %21 = zext i8 %20 to i32, !dbg !258
  %int_cast_to_i641 = zext i32 8 to i64
  call void @klee_overshift_check(i64 32, i64 %int_cast_to_i641), !dbg !258
  %22 = shl i32 %21, 8, !dbg !258
  %23 = load i32* %lava_101, align 4, !dbg !258
  %24 = or i32 %23, %22, !dbg !258
  store i32 %24, i32* %lava_101, align 4, !dbg !258
  %25 = getelementptr inbounds %struct.file_header* %head, i32 0, i32 4, !dbg !258
  %26 = bitcast i32* %25 to i8*, !dbg !258
  %27 = getelementptr inbounds i8* %26, i64 2, !dbg !258
  %28 = load i8* %27, align 1, !dbg !258
  %29 = zext i8 %28 to i32, !dbg !258
  %int_cast_to_i642 = zext i32 16 to i64
  call void @klee_overshift_check(i64 32, i64 %int_cast_to_i642), !dbg !258
  %30 = shl i32 %29, 16, !dbg !258
  %31 = load i32* %lava_101, align 4, !dbg !258
  %32 = or i32 %31, %30, !dbg !258
  store i32 %32, i32* %lava_101, align 4, !dbg !258
  %33 = getelementptr inbounds %struct.file_header* %head, i32 0, i32 4, !dbg !258
  %34 = bitcast i32* %33 to i8*, !dbg !258
  %35 = getelementptr inbounds i8* %34, i64 3, !dbg !258
  %36 = load i8* %35, align 1, !dbg !258
  %37 = zext i8 %36 to i32, !dbg !258
  %int_cast_to_i643 = zext i32 24 to i64
  call void @klee_overshift_check(i64 32, i64 %int_cast_to_i643), !dbg !258
  %38 = shl i32 %37, 24, !dbg !258
  %39 = load i32* %lava_101, align 4, !dbg !258
  %40 = or i32 %39, %38, !dbg !258
  store i32 %40, i32* %lava_101, align 4, !dbg !258
  %41 = load i32* %lava_101, align 4, !dbg !258
  call void @lava_set(i32 101, i32 %41), !dbg !258
  %42 = getelementptr inbounds %struct.file_header* %head, i32 0, i32 4, !dbg !259
  %43 = load i32* %42, align 1, !dbg !259
  %44 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str5, i32 0, i32 0), i32 %43), !dbg !259
  store i32 0, i32* %i, align 4, !dbg !260
  br label %45, !dbg !260

; <label>:45                                      ; preds = %51, %0
  %46 = load i32* %i, align 4, !dbg !260
  %47 = getelementptr inbounds %struct.file_header* %head, i32 0, i32 2, !dbg !260
  %48 = load i16* %47, align 1, !dbg !260
  %49 = zext i16 %48 to i32, !dbg !260
  %50 = icmp ult i32 %46, %49, !dbg !260
  br i1 %50, label %51, label %57, !dbg !260

; <label>:51                                      ; preds = %45
  %52 = load %struct._IO_FILE** %f, align 8, !dbg !262
  %53 = call %struct.file_entry* @parse_record(%struct._IO_FILE* %52), !dbg !262
  store %struct.file_entry* %53, %struct.file_entry** %ent, align 8, !dbg !262
  %54 = load %struct.file_entry** %ent, align 8, !dbg !264
  call void @consume_record(%struct.file_entry* %54), !dbg !264
  %55 = load i32* %i, align 4, !dbg !260
  %56 = add i32 %55, 1, !dbg !260
  store i32 %56, i32* %i, align 4, !dbg !260
  br label %45, !dbg !260

; <label>:57                                      ; preds = %45
  ret i32 0, !dbg !265
}

declare %struct._IO_FILE* @fopen(i8*, i8*) #2

; Function Attrs: nounwind uwtable
define void @klee_div_zero_check(i64 %z) #5 {
  %1 = icmp eq i64 %z, 0, !dbg !266
  br i1 %1, label %2, label %3, !dbg !266

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([60 x i8]* @.str6, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([15 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str28, i64 0, i64 0)) #10, !dbg !268
  unreachable, !dbg !268

; <label>:3                                       ; preds = %0
  ret void, !dbg !269
}

; Function Attrs: noreturn
declare void @klee_report_error(i8*, i32, i8*, i8*) #6

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

; Function Attrs: nounwind uwtable
define i32 @klee_int(i8* %name) #5 {
  %x = alloca i32, align 4
  %1 = bitcast i32* %x to i8*, !dbg !270
  call void @klee_make_symbolic(i8* %1, i64 4, i8* %name) #11, !dbg !270
  %2 = load i32* %x, align 4, !dbg !271, !tbaa !272
  ret i32 %2, !dbg !271
}

declare void @klee_make_symbolic(i8*, i64, i8*) #7

; Function Attrs: nounwind uwtable
define void @klee_overshift_check(i64 %bitWidth, i64 %shift) #5 {
  %1 = icmp ult i64 %shift, %bitWidth, !dbg !276
  br i1 %1, label %3, label %2, !dbg !276

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([8 x i8]* @.str39, i64 0, i64 0), i32 0, i8* getelementptr inbounds ([16 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str25, i64 0, i64 0)) #10, !dbg !278
  unreachable, !dbg !278

; <label>:3                                       ; preds = %0
  ret void, !dbg !280
}

; Function Attrs: nounwind uwtable
define i32 @klee_range(i32 %start, i32 %end, i8* %name) #5 {
  %x = alloca i32, align 4
  %1 = icmp slt i32 %start, %end, !dbg !281
  br i1 %1, label %3, label %2, !dbg !281

; <label>:2                                       ; preds = %0
  call void @klee_report_error(i8* getelementptr inbounds ([51 x i8]* @.str610, i64 0, i64 0), i32 17, i8* getelementptr inbounds ([14 x i8]* @.str1711, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str2812, i64 0, i64 0)) #10, !dbg !283
  unreachable, !dbg !283

; <label>:3                                       ; preds = %0
  %4 = add nsw i32 %start, 1, !dbg !284
  %5 = icmp eq i32 %4, %end, !dbg !284
  br i1 %5, label %21, label %6, !dbg !284

; <label>:6                                       ; preds = %3
  %7 = bitcast i32* %x to i8*, !dbg !286
  call void @klee_make_symbolic(i8* %7, i64 4, i8* %name) #11, !dbg !286
  %8 = icmp eq i32 %start, 0, !dbg !288
  %9 = load i32* %x, align 4, !dbg !290, !tbaa !272
  br i1 %8, label %10, label %13, !dbg !288

; <label>:10                                      ; preds = %6
  %11 = icmp ult i32 %9, %end, !dbg !290
  %12 = zext i1 %11 to i64, !dbg !290
  call void @klee_assume(i64 %12) #11, !dbg !290
  br label %19, !dbg !292

; <label>:13                                      ; preds = %6
  %14 = icmp sge i32 %9, %start, !dbg !293
  %15 = zext i1 %14 to i64, !dbg !293
  call void @klee_assume(i64 %15) #11, !dbg !293
  %16 = load i32* %x, align 4, !dbg !295, !tbaa !272
  %17 = icmp slt i32 %16, %end, !dbg !295
  %18 = zext i1 %17 to i64, !dbg !295
  call void @klee_assume(i64 %18) #11, !dbg !295
  br label %19

; <label>:19                                      ; preds = %13, %10
  %20 = load i32* %x, align 4, !dbg !296, !tbaa !272
  br label %21, !dbg !296

; <label>:21                                      ; preds = %19, %3
  %.0 = phi i32 [ %20, %19 ], [ %start, %3 ]
  ret i32 %.0, !dbg !297
}

declare void @klee_assume(i64) #7

; Function Attrs: nounwind uwtable
define weak i8* @memcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #5 {
  %1 = icmp eq i64 %len, 0, !dbg !298
  br i1 %1, label %._crit_edge, label %.lr.ph.preheader, !dbg !298

.lr.ph.preheader:                                 ; preds = %0
  %n.vec = and i64 %len, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %2 = add i64 %len, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep4 = getelementptr i8* %srcaddr, i64 %2
  %scevgep = getelementptr i8* %destaddr, i64 %2
  %bound1 = icmp uge i8* %scevgep, %srcaddr
  %bound0 = icmp uge i8* %scevgep4, %destaddr
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %srcaddr, i64 %n.vec
  %ptr.ind.end6 = getelementptr i8* %destaddr, i64 %n.vec
  %rev.ind.end = sub i64 %len, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %srcaddr, i64 %index
  %next.gep103 = getelementptr i8* %destaddr, i64 %index
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !299
  %wide.load = load <16 x i8>* %3, align 1, !dbg !299
  %next.gep.sum279 = or i64 %index, 16, !dbg !299
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum279, !dbg !299
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !299
  %wide.load200 = load <16 x i8>* %5, align 1, !dbg !299
  %6 = bitcast i8* %next.gep103 to <16 x i8>*, !dbg !299
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !299
  %next.gep103.sum296 = or i64 %index, 16, !dbg !299
  %7 = getelementptr i8* %destaddr, i64 %next.gep103.sum296, !dbg !299
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !299
  store <16 x i8> %wide.load200, <16 x i8>* %8, align 1, !dbg !299
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !300

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %srcaddr, %.lr.ph.preheader ], [ %srcaddr, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val5 = phi i8* [ %destaddr, %.lr.ph.preheader ], [ %destaddr, %vector.memcheck ], [ %ptr.ind.end6, %vector.body ]
  %resume.val7 = phi i64 [ %len, %.lr.ph.preheader ], [ %len, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %len
  br i1 %cmp.n, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %src.03 = phi i8* [ %11, %.lr.ph ], [ %resume.val, %middle.block ]
  %dest.02 = phi i8* [ %13, %.lr.ph ], [ %resume.val5, %middle.block ]
  %.01 = phi i64 [ %10, %.lr.ph ], [ %resume.val7, %middle.block ]
  %10 = add i64 %.01, -1, !dbg !298
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !299
  %12 = load i8* %src.03, align 1, !dbg !299, !tbaa !303
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !299
  store i8 %12, i8* %dest.02, align 1, !dbg !299, !tbaa !303
  %14 = icmp eq i64 %10, 0, !dbg !298
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !298, !llvm.loop !304

._crit_edge:                                      ; preds = %.lr.ph, %middle.block, %0
  ret i8* %destaddr, !dbg !305
}

; Function Attrs: nounwind uwtable
define weak i8* @memmove(i8* %dst, i8* %src, i64 %count) #5 {
  %1 = icmp eq i8* %src, %dst, !dbg !306
  br i1 %1, label %.loopexit, label %2, !dbg !306

; <label>:2                                       ; preds = %0
  %3 = icmp ugt i8* %src, %dst, !dbg !308
  br i1 %3, label %.preheader, label %18, !dbg !308

.preheader:                                       ; preds = %2
  %4 = icmp eq i64 %count, 0, !dbg !310
  br i1 %4, label %.loopexit, label %.lr.ph.preheader, !dbg !310

.lr.ph.preheader:                                 ; preds = %.preheader
  %n.vec = and i64 %count, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %5 = add i64 %count, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep11 = getelementptr i8* %src, i64 %5
  %scevgep = getelementptr i8* %dst, i64 %5
  %bound1 = icmp uge i8* %scevgep, %src
  %bound0 = icmp uge i8* %scevgep11, %dst
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %src, i64 %n.vec
  %ptr.ind.end13 = getelementptr i8* %dst, i64 %n.vec
  %rev.ind.end = sub i64 %count, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %src, i64 %index
  %next.gep110 = getelementptr i8* %dst, i64 %index
  %6 = bitcast i8* %next.gep to <16 x i8>*, !dbg !310
  %wide.load = load <16 x i8>* %6, align 1, !dbg !310
  %next.gep.sum586 = or i64 %index, 16, !dbg !310
  %7 = getelementptr i8* %src, i64 %next.gep.sum586, !dbg !310
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !310
  %wide.load207 = load <16 x i8>* %8, align 1, !dbg !310
  %9 = bitcast i8* %next.gep110 to <16 x i8>*, !dbg !310
  store <16 x i8> %wide.load, <16 x i8>* %9, align 1, !dbg !310
  %next.gep110.sum603 = or i64 %index, 16, !dbg !310
  %10 = getelementptr i8* %dst, i64 %next.gep110.sum603, !dbg !310
  %11 = bitcast i8* %10 to <16 x i8>*, !dbg !310
  store <16 x i8> %wide.load207, <16 x i8>* %11, align 1, !dbg !310
  %index.next = add i64 %index, 32
  %12 = icmp eq i64 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !312

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %src, %.lr.ph.preheader ], [ %src, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val12 = phi i8* [ %dst, %.lr.ph.preheader ], [ %dst, %vector.memcheck ], [ %ptr.ind.end13, %vector.body ]
  %resume.val14 = phi i64 [ %count, %.lr.ph.preheader ], [ %count, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %count
  br i1 %cmp.n, label %.loopexit, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %b.04 = phi i8* [ %14, %.lr.ph ], [ %resume.val, %middle.block ]
  %a.03 = phi i8* [ %16, %.lr.ph ], [ %resume.val12, %middle.block ]
  %.02 = phi i64 [ %13, %.lr.ph ], [ %resume.val14, %middle.block ]
  %13 = add i64 %.02, -1, !dbg !310
  %14 = getelementptr inbounds i8* %b.04, i64 1, !dbg !310
  %15 = load i8* %b.04, align 1, !dbg !310, !tbaa !303
  %16 = getelementptr inbounds i8* %a.03, i64 1, !dbg !310
  store i8 %15, i8* %a.03, align 1, !dbg !310, !tbaa !303
  %17 = icmp eq i64 %13, 0, !dbg !310
  br i1 %17, label %.loopexit, label %.lr.ph, !dbg !310, !llvm.loop !313

; <label>:18                                      ; preds = %2
  %19 = add i64 %count, -1, !dbg !314
  %20 = icmp eq i64 %count, 0, !dbg !316
  br i1 %20, label %.loopexit, label %.lr.ph9, !dbg !316

.lr.ph9:                                          ; preds = %18
  %21 = getelementptr inbounds i8* %src, i64 %19, !dbg !317
  %22 = getelementptr inbounds i8* %dst, i64 %19, !dbg !314
  %n.vec215 = and i64 %count, -32
  %cmp.zero217 = icmp eq i64 %n.vec215, 0
  %23 = add i64 %count, -1
  br i1 %cmp.zero217, label %middle.block210, label %vector.memcheck224

vector.memcheck224:                               ; preds = %.lr.ph9
  %scevgep219 = getelementptr i8* %src, i64 %23
  %scevgep218 = getelementptr i8* %dst, i64 %23
  %bound1221 = icmp ule i8* %scevgep219, %dst
  %bound0220 = icmp ule i8* %scevgep218, %src
  %memcheck.conflict223 = and i1 %bound0220, %bound1221
  %.sum = sub i64 %19, %n.vec215
  %rev.ptr.ind.end = getelementptr i8* %src, i64 %.sum
  %.sum439 = sub i64 %19, %n.vec215
  %rev.ptr.ind.end229 = getelementptr i8* %dst, i64 %.sum439
  %rev.ind.end231 = sub i64 %count, %n.vec215
  br i1 %memcheck.conflict223, label %middle.block210, label %vector.body209

vector.body209:                                   ; preds = %vector.body209, %vector.memcheck224
  %index212 = phi i64 [ %index.next234, %vector.body209 ], [ 0, %vector.memcheck224 ]
  %.sum440 = sub i64 %19, %index212
  %.sum472 = sub i64 %19, %index212
  %next.gep236.sum = add i64 %.sum440, -15, !dbg !316
  %24 = getelementptr i8* %src, i64 %next.gep236.sum, !dbg !316
  %25 = bitcast i8* %24 to <16 x i8>*, !dbg !316
  %wide.load434 = load <16 x i8>* %25, align 1, !dbg !316
  %reverse = shufflevector <16 x i8> %wide.load434, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !316
  %.sum505 = add i64 %.sum440, -31, !dbg !316
  %26 = getelementptr i8* %src, i64 %.sum505, !dbg !316
  %27 = bitcast i8* %26 to <16 x i8>*, !dbg !316
  %wide.load435 = load <16 x i8>* %27, align 1, !dbg !316
  %reverse436 = shufflevector <16 x i8> %wide.load435, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !316
  %reverse437 = shufflevector <16 x i8> %reverse, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !316
  %next.gep333.sum = add i64 %.sum472, -15, !dbg !316
  %28 = getelementptr i8* %dst, i64 %next.gep333.sum, !dbg !316
  %29 = bitcast i8* %28 to <16 x i8>*, !dbg !316
  store <16 x i8> %reverse437, <16 x i8>* %29, align 1, !dbg !316
  %reverse438 = shufflevector <16 x i8> %reverse436, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !316
  %.sum507 = add i64 %.sum472, -31, !dbg !316
  %30 = getelementptr i8* %dst, i64 %.sum507, !dbg !316
  %31 = bitcast i8* %30 to <16 x i8>*, !dbg !316
  store <16 x i8> %reverse438, <16 x i8>* %31, align 1, !dbg !316
  %index.next234 = add i64 %index212, 32
  %32 = icmp eq i64 %index.next234, %n.vec215
  br i1 %32, label %middle.block210, label %vector.body209, !llvm.loop !318

middle.block210:                                  ; preds = %vector.body209, %vector.memcheck224, %.lr.ph9
  %resume.val225 = phi i8* [ %21, %.lr.ph9 ], [ %21, %vector.memcheck224 ], [ %rev.ptr.ind.end, %vector.body209 ]
  %resume.val227 = phi i8* [ %22, %.lr.ph9 ], [ %22, %vector.memcheck224 ], [ %rev.ptr.ind.end229, %vector.body209 ]
  %resume.val230 = phi i64 [ %count, %.lr.ph9 ], [ %count, %vector.memcheck224 ], [ %rev.ind.end231, %vector.body209 ]
  %new.indc.resume.val232 = phi i64 [ 0, %.lr.ph9 ], [ 0, %vector.memcheck224 ], [ %n.vec215, %vector.body209 ]
  %cmp.n233 = icmp eq i64 %new.indc.resume.val232, %count
  br i1 %cmp.n233, label %.loopexit, label %scalar.ph211

scalar.ph211:                                     ; preds = %scalar.ph211, %middle.block210
  %b.18 = phi i8* [ %34, %scalar.ph211 ], [ %resume.val225, %middle.block210 ]
  %a.17 = phi i8* [ %36, %scalar.ph211 ], [ %resume.val227, %middle.block210 ]
  %.16 = phi i64 [ %33, %scalar.ph211 ], [ %resume.val230, %middle.block210 ]
  %33 = add i64 %.16, -1, !dbg !316
  %34 = getelementptr inbounds i8* %b.18, i64 -1, !dbg !316
  %35 = load i8* %b.18, align 1, !dbg !316, !tbaa !303
  %36 = getelementptr inbounds i8* %a.17, i64 -1, !dbg !316
  store i8 %35, i8* %a.17, align 1, !dbg !316, !tbaa !303
  %37 = icmp eq i64 %33, 0, !dbg !316
  br i1 %37, label %.loopexit, label %scalar.ph211, !dbg !316, !llvm.loop !319

.loopexit:                                        ; preds = %scalar.ph211, %middle.block210, %18, %.lr.ph, %middle.block, %.preheader, %0
  ret i8* %dst, !dbg !320
}

; Function Attrs: nounwind uwtable
define weak i8* @mempcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #5 {
  %1 = icmp eq i64 %len, 0, !dbg !321
  br i1 %1, label %15, label %.lr.ph.preheader, !dbg !321

.lr.ph.preheader:                                 ; preds = %0
  %n.vec = and i64 %len, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %2 = add i64 %len, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep5 = getelementptr i8* %srcaddr, i64 %2
  %scevgep4 = getelementptr i8* %destaddr, i64 %2
  %bound1 = icmp uge i8* %scevgep4, %srcaddr
  %bound0 = icmp uge i8* %scevgep5, %destaddr
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %srcaddr, i64 %n.vec
  %ptr.ind.end7 = getelementptr i8* %destaddr, i64 %n.vec
  %rev.ind.end = sub i64 %len, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %srcaddr, i64 %index
  %next.gep104 = getelementptr i8* %destaddr, i64 %index
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !322
  %wide.load = load <16 x i8>* %3, align 1, !dbg !322
  %next.gep.sum280 = or i64 %index, 16, !dbg !322
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum280, !dbg !322
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !322
  %wide.load201 = load <16 x i8>* %5, align 1, !dbg !322
  %6 = bitcast i8* %next.gep104 to <16 x i8>*, !dbg !322
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !322
  %next.gep104.sum297 = or i64 %index, 16, !dbg !322
  %7 = getelementptr i8* %destaddr, i64 %next.gep104.sum297, !dbg !322
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !322
  store <16 x i8> %wide.load201, <16 x i8>* %8, align 1, !dbg !322
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !323

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %srcaddr, %.lr.ph.preheader ], [ %srcaddr, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val6 = phi i8* [ %destaddr, %.lr.ph.preheader ], [ %destaddr, %vector.memcheck ], [ %ptr.ind.end7, %vector.body ]
  %resume.val8 = phi i64 [ %len, %.lr.ph.preheader ], [ %len, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %len
  br i1 %cmp.n, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %src.03 = phi i8* [ %11, %.lr.ph ], [ %resume.val, %middle.block ]
  %dest.02 = phi i8* [ %13, %.lr.ph ], [ %resume.val6, %middle.block ]
  %.01 = phi i64 [ %10, %.lr.ph ], [ %resume.val8, %middle.block ]
  %10 = add i64 %.01, -1, !dbg !321
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !322
  %12 = load i8* %src.03, align 1, !dbg !322, !tbaa !303
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !322
  store i8 %12, i8* %dest.02, align 1, !dbg !322, !tbaa !303
  %14 = icmp eq i64 %10, 0, !dbg !321
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !321, !llvm.loop !324

._crit_edge:                                      ; preds = %.lr.ph, %middle.block
  %scevgep = getelementptr i8* %destaddr, i64 %len
  br label %15, !dbg !321

; <label>:15                                      ; preds = %._crit_edge, %0
  %dest.0.lcssa = phi i8* [ %scevgep, %._crit_edge ], [ %destaddr, %0 ]
  ret i8* %dest.0.lcssa, !dbg !325
}

; Function Attrs: nounwind uwtable
define weak i8* @memset(i8* %dst, i32 %s, i64 %count) #5 {
  %1 = icmp eq i64 %count, 0, !dbg !326
  br i1 %1, label %._crit_edge, label %.lr.ph, !dbg !326

.lr.ph:                                           ; preds = %0
  %2 = trunc i32 %s to i8, !dbg !327
  br label %3, !dbg !326

; <label>:3                                       ; preds = %3, %.lr.ph
  %a.02 = phi i8* [ %dst, %.lr.ph ], [ %5, %3 ]
  %.01 = phi i64 [ %count, %.lr.ph ], [ %4, %3 ]
  %4 = add i64 %.01, -1, !dbg !326
  %5 = getelementptr inbounds i8* %a.02, i64 1, !dbg !327
  store volatile i8 %2, i8* %a.02, align 1, !dbg !327, !tbaa !303
  %6 = icmp eq i64 %4, 0, !dbg !326
  br i1 %6, label %._crit_edge, label %3, !dbg !326

._crit_edge:                                      ; preds = %3, %0
  ret i8* %dst, !dbg !328
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-floa
attributes #4 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false
attributes #5 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { noreturn nounwind }
attributes #9 = { nounwind }
attributes #10 = { nobuiltin noreturn nounwind }
attributes #11 = { nobuiltin nounwind }

!llvm.dbg.cu = !{!0, !119, !129, !141, !152, !164, !180, !194, !208}
!llvm.module.flags = !{!223, !224}
!llvm.ident = !{!225, !225, !225, !225, !225, !225, !225, !225, !225}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 false, metadata !"", i32 0, metadata !2, metadata !7, metadata !8, metadata !114, metadata !7, metadata !""} ; 
!1 = metadata !{metadata !"toy.c", metadata !"/home/klee/toy_example_distrib/buggy/51/toy"}
!2 = metadata !{metadata !3}
!3 = metadata !{i32 786436, metadata !1, null, metadata !"", i32 16, i64 32, i64 32, i32 0, i32 0, null, metadata !4, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 16, size 32, align 32, offset 0] [def] [from ]
!4 = metadata !{metadata !5, metadata !6}
!5 = metadata !{i32 786472, metadata !"TYPEA", i64 1} ; [ DW_TAG_enumerator ] [TYPEA :: 1]
!6 = metadata !{i32 786472, metadata !"TYPEB", i64 2} ; [ DW_TAG_enumerator ] [TYPEB :: 2]
!7 = metadata !{i32 0}
!8 = metadata !{metadata !9, metadata !14, metadata !17, metadata !89, metadata !107, metadata !110}
!9 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"lava_set", metadata !"lava_set", metadata !"", i32 5, metadata !11, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @lava_set, null, null, metadata !7, i32 5} ; 
!10 = metadata !{i32 786473, metadata !1}         ; [ DW_TAG_file_type ] [/home/klee/toy_example_distrib/buggy/51/toy/toy.c]
!11 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !12, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!12 = metadata !{null, metadata !13, metadata !13}
!13 = metadata !{i32 786468, null, null, metadata !"unsigned int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!14 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"lava_get", metadata !"lava_get", metadata !"", i32 7, metadata !15, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32)* @lava_get, null, null, metadata !7, i32 7} ; [ DW_
!15 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !16, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!16 = metadata !{metadata !13, metadata !13}
!17 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"parse_header", metadata !"parse_header", metadata !"", i32 38, metadata !18, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (%struct._IO_FILE*, %struct.file_header*)* @par
!18 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !19, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!19 = metadata !{null, metadata !20, metadata !78}
!20 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !21} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from FILE]
!21 = metadata !{i32 786454, metadata !1, null, metadata !"FILE", i32 48, i64 0, i64 0, i64 0, i32 0, metadata !22} ; [ DW_TAG_typedef ] [FILE] [line 48, size 0, align 0, offset 0] [from _IO_FILE]
!22 = metadata !{i32 786451, metadata !23, null, metadata !"_IO_FILE", i32 245, i64 1728, i64 64, i32 0, i32 0, null, metadata !24, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [_IO_FILE] [line 245, size 1728, align 64, offset 0] [def] [from ]
!23 = metadata !{metadata !"/usr/include/libio.h", metadata !"/home/klee/toy_example_distrib/buggy/51/toy"}
!24 = metadata !{metadata !25, metadata !27, metadata !30, metadata !31, metadata !32, metadata !33, metadata !34, metadata !35, metadata !36, metadata !37, metadata !38, metadata !39, metadata !40, metadata !48, metadata !49, metadata !50, metadata !51,
!25 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_flags", i32 246, i64 32, i64 32, i64 0, i32 0, metadata !26} ; [ DW_TAG_member ] [_flags] [line 246, size 32, align 32, offset 0] [from int]
!26 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!27 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_read_ptr", i32 251, i64 64, i64 64, i64 64, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_read_ptr] [line 251, size 64, align 64, offset 64] [from ]
!28 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !29} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!29 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!30 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_read_end", i32 252, i64 64, i64 64, i64 128, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_read_end] [line 252, size 64, align 64, offset 128] [from ]
!31 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_read_base", i32 253, i64 64, i64 64, i64 192, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_read_base] [line 253, size 64, align 64, offset 192] [from ]
!32 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_write_base", i32 254, i64 64, i64 64, i64 256, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_write_base] [line 254, size 64, align 64, offset 256] [from ]
!33 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_write_ptr", i32 255, i64 64, i64 64, i64 320, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_write_ptr] [line 255, size 64, align 64, offset 320] [from ]
!34 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_write_end", i32 256, i64 64, i64 64, i64 384, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_write_end] [line 256, size 64, align 64, offset 384] [from ]
!35 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_buf_base", i32 257, i64 64, i64 64, i64 448, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_buf_base] [line 257, size 64, align 64, offset 448] [from ]
!36 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_buf_end", i32 258, i64 64, i64 64, i64 512, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_buf_end] [line 258, size 64, align 64, offset 512] [from ]
!37 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_save_base", i32 260, i64 64, i64 64, i64 576, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_save_base] [line 260, size 64, align 64, offset 576] [from ]
!38 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_backup_base", i32 261, i64 64, i64 64, i64 640, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_backup_base] [line 261, size 64, align 64, offset 640] [from ]
!39 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_IO_save_end", i32 262, i64 64, i64 64, i64 704, i32 0, metadata !28} ; [ DW_TAG_member ] [_IO_save_end] [line 262, size 64, align 64, offset 704] [from ]
!40 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_markers", i32 264, i64 64, i64 64, i64 768, i32 0, metadata !41} ; [ DW_TAG_member ] [_markers] [line 264, size 64, align 64, offset 768] [from ]
!41 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !42} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from _IO_marker]
!42 = metadata !{i32 786451, metadata !23, null, metadata !"_IO_marker", i32 160, i64 192, i64 64, i32 0, i32 0, null, metadata !43, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [_IO_marker] [line 160, size 192, align 64, offset 0] [def] [from ]
!43 = metadata !{metadata !44, metadata !45, metadata !47}
!44 = metadata !{i32 786445, metadata !23, metadata !42, metadata !"_next", i32 161, i64 64, i64 64, i64 0, i32 0, metadata !41} ; [ DW_TAG_member ] [_next] [line 161, size 64, align 64, offset 0] [from ]
!45 = metadata !{i32 786445, metadata !23, metadata !42, metadata !"_sbuf", i32 162, i64 64, i64 64, i64 64, i32 0, metadata !46} ; [ DW_TAG_member ] [_sbuf] [line 162, size 64, align 64, offset 64] [from ]
!46 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !22} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from _IO_FILE]
!47 = metadata !{i32 786445, metadata !23, metadata !42, metadata !"_pos", i32 166, i64 32, i64 32, i64 128, i32 0, metadata !26} ; [ DW_TAG_member ] [_pos] [line 166, size 32, align 32, offset 128] [from int]
!48 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_chain", i32 266, i64 64, i64 64, i64 832, i32 0, metadata !46} ; [ DW_TAG_member ] [_chain] [line 266, size 64, align 64, offset 832] [from ]
!49 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_fileno", i32 268, i64 32, i64 32, i64 896, i32 0, metadata !26} ; [ DW_TAG_member ] [_fileno] [line 268, size 32, align 32, offset 896] [from int]
!50 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_flags2", i32 272, i64 32, i64 32, i64 928, i32 0, metadata !26} ; [ DW_TAG_member ] [_flags2] [line 272, size 32, align 32, offset 928] [from int]
!51 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_old_offset", i32 274, i64 64, i64 64, i64 960, i32 0, metadata !52} ; [ DW_TAG_member ] [_old_offset] [line 274, size 64, align 64, offset 960] [from __off_t]
!52 = metadata !{i32 786454, metadata !23, null, metadata !"__off_t", i32 131, i64 0, i64 0, i64 0, i32 0, metadata !53} ; [ DW_TAG_typedef ] [__off_t] [line 131, size 0, align 0, offset 0] [from long int]
!53 = metadata !{i32 786468, null, null, metadata !"long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!54 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_cur_column", i32 278, i64 16, i64 16, i64 1024, i32 0, metadata !55} ; [ DW_TAG_member ] [_cur_column] [line 278, size 16, align 16, offset 1024] [from unsigned short]
!55 = metadata !{i32 786468, null, null, metadata !"unsigned short", i32 0, i64 16, i64 16, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned short] [line 0, size 16, align 16, offset 0, enc DW_ATE_unsigned]
!56 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_vtable_offset", i32 279, i64 8, i64 8, i64 1040, i32 0, metadata !57} ; [ DW_TAG_member ] [_vtable_offset] [line 279, size 8, align 8, offset 1040] [from signed char]
!57 = metadata !{i32 786468, null, null, metadata !"signed char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [signed char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!58 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_shortbuf", i32 280, i64 8, i64 8, i64 1048, i32 0, metadata !59} ; [ DW_TAG_member ] [_shortbuf] [line 280, size 8, align 8, offset 1048] [from ]
!59 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 8, i64 8, i32 0, i32 0, metadata !29, metadata !60, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 8, align 8, offset 0] [from char]
!60 = metadata !{metadata !61}
!61 = metadata !{i32 786465, i64 0, i64 1}        ; [ DW_TAG_subrange_type ] [0, 0]
!62 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_lock", i32 284, i64 64, i64 64, i64 1088, i32 0, metadata !63} ; [ DW_TAG_member ] [_lock] [line 284, size 64, align 64, offset 1088] [from ]
!63 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!64 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_offset", i32 293, i64 64, i64 64, i64 1152, i32 0, metadata !65} ; [ DW_TAG_member ] [_offset] [line 293, size 64, align 64, offset 1152] [from __off64_t]
!65 = metadata !{i32 786454, metadata !23, null, metadata !"__off64_t", i32 132, i64 0, i64 0, i64 0, i32 0, metadata !53} ; [ DW_TAG_typedef ] [__off64_t] [line 132, size 0, align 0, offset 0] [from long int]
!66 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"__pad1", i32 302, i64 64, i64 64, i64 1216, i32 0, metadata !63} ; [ DW_TAG_member ] [__pad1] [line 302, size 64, align 64, offset 1216] [from ]
!67 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"__pad2", i32 303, i64 64, i64 64, i64 1280, i32 0, metadata !63} ; [ DW_TAG_member ] [__pad2] [line 303, size 64, align 64, offset 1280] [from ]
!68 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"__pad3", i32 304, i64 64, i64 64, i64 1344, i32 0, metadata !63} ; [ DW_TAG_member ] [__pad3] [line 304, size 64, align 64, offset 1344] [from ]
!69 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"__pad4", i32 305, i64 64, i64 64, i64 1408, i32 0, metadata !63} ; [ DW_TAG_member ] [__pad4] [line 305, size 64, align 64, offset 1408] [from ]
!70 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"__pad5", i32 306, i64 64, i64 64, i64 1472, i32 0, metadata !71} ; [ DW_TAG_member ] [__pad5] [line 306, size 64, align 64, offset 1472] [from size_t]
!71 = metadata !{i32 786454, metadata !23, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !72} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!72 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!73 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_mode", i32 308, i64 32, i64 32, i64 1536, i32 0, metadata !26} ; [ DW_TAG_member ] [_mode] [line 308, size 32, align 32, offset 1536] [from int]
!74 = metadata !{i32 786445, metadata !23, metadata !22, metadata !"_unused2", i32 310, i64 160, i64 8, i64 1568, i32 0, metadata !75} ; [ DW_TAG_member ] [_unused2] [line 310, size 160, align 8, offset 1568] [from ]
!75 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 160, i64 8, i32 0, i32 0, metadata !29, metadata !76, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 160, align 8, offset 0] [from char]
!76 = metadata !{metadata !77}
!77 = metadata !{i32 786465, i64 0, i64 20}       ; [ DW_TAG_subrange_type ] [0, 19]
!78 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !79} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from file_header]
!79 = metadata !{i32 786454, metadata !1, null, metadata !"file_header", i32 27, i64 0, i64 0, i64 0, i32 0, metadata !80} ; [ DW_TAG_typedef ] [file_header] [line 27, size 0, align 0, offset 0] [from ]
!80 = metadata !{i32 786451, metadata !1, null, metadata !"", i32 21, i64 128, i64 8, i32 0, i32 0, null, metadata !81, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 21, size 128, align 8, offset 0] [def] [from ]
!81 = metadata !{metadata !82, metadata !84, metadata !85, metadata !87, metadata !88}
!82 = metadata !{i32 786445, metadata !1, metadata !80, metadata !"magic", i32 22, i64 32, i64 32, i64 0, i32 0, metadata !83} ; [ DW_TAG_member ] [magic] [line 22, size 32, align 32, offset 0] [from uint32_t]
!83 = metadata !{i32 786454, metadata !1, null, metadata !"uint32_t", i32 51, i64 0, i64 0, i64 0, i32 0, metadata !13} ; [ DW_TAG_typedef ] [uint32_t] [line 51, size 0, align 0, offset 0] [from unsigned int]
!84 = metadata !{i32 786445, metadata !1, metadata !80, metadata !"reserved", i32 23, i64 32, i64 32, i64 32, i32 0, metadata !83} ; [ DW_TAG_member ] [reserved] [line 23, size 32, align 32, offset 32] [from uint32_t]
!85 = metadata !{i32 786445, metadata !1, metadata !80, metadata !"num_recs", i32 24, i64 16, i64 16, i64 64, i32 0, metadata !86} ; [ DW_TAG_member ] [num_recs] [line 24, size 16, align 16, offset 64] [from uint16_t]
!86 = metadata !{i32 786454, metadata !1, null, metadata !"uint16_t", i32 49, i64 0, i64 0, i64 0, i32 0, metadata !55} ; [ DW_TAG_typedef ] [uint16_t] [line 49, size 0, align 0, offset 0] [from unsigned short]
!87 = metadata !{i32 786445, metadata !1, metadata !80, metadata !"flags", i32 25, i64 16, i64 16, i64 80, i32 0, metadata !86} ; [ DW_TAG_member ] [flags] [line 25, size 16, align 16, offset 80] [from uint16_t]
!88 = metadata !{i32 786445, metadata !1, metadata !80, metadata !"timestamp", i32 26, i64 32, i64 32, i64 96, i32 0, metadata !83} ; [ DW_TAG_member ] [timestamp] [line 26, size 32, align 32, offset 96] [from uint32_t]
!89 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"parse_record", metadata !"parse_record", metadata !"", i32 45, metadata !90, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, %struct.file_entry* (%struct._IO_FILE*)* @parse_reco
!90 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !91, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!91 = metadata !{metadata !92, metadata !20}
!92 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !93} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from file_entry]
!93 = metadata !{i32 786454, metadata !1, null, metadata !"file_entry", i32 36, i64 0, i64 0, i64 0, i32 0, metadata !94} ; [ DW_TAG_typedef ] [file_entry] [line 36, size 0, align 0, offset 0] [from ]
!94 = metadata !{i32 786451, metadata !1, null, metadata !"", i32 29, i64 192, i64 8, i32 0, i32 0, null, metadata !95, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 29, size 192, align 8, offset 0] [def] [from ]
!95 = metadata !{metadata !96, metadata !100, metadata !101}
!96 = metadata !{i32 786445, metadata !1, metadata !94, metadata !"bar", i32 30, i64 128, i64 8, i64 0, i32 0, metadata !97} ; [ DW_TAG_member ] [bar] [line 30, size 128, align 8, offset 0] [from ]
!97 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 128, i64 8, i32 0, i32 0, metadata !29, metadata !98, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 128, align 8, offset 0] [from char]
!98 = metadata !{metadata !99}
!99 = metadata !{i32 786465, i64 0, i64 16}       ; [ DW_TAG_subrange_type ] [0, 15]
!100 = metadata !{i32 786445, metadata !1, metadata !94, metadata !"type", i32 31, i64 32, i64 32, i64 128, i32 0, metadata !83} ; [ DW_TAG_member ] [type] [line 31, size 32, align 32, offset 128] [from uint32_t]
!101 = metadata !{i32 786445, metadata !1, metadata !94, metadata !"data", i32 35, i64 32, i64 8, i64 160, i32 0, metadata !102} ; [ DW_TAG_member ] [data] [line 35, size 32, align 8, offset 160] [from ]
!102 = metadata !{i32 786455, metadata !1, metadata !94, metadata !"", i32 32, i64 32, i64 8, i64 0, i32 0, null, metadata !103, i32 0, null, null, null} ; [ DW_TAG_union_type ] [line 32, size 32, align 8, offset 0] [def] [from ]
!103 = metadata !{metadata !104, metadata !106}
!104 = metadata !{i32 786445, metadata !1, metadata !102, metadata !"fdata", i32 33, i64 32, i64 32, i64 0, i32 0, metadata !105} ; [ DW_TAG_member ] [fdata] [line 33, size 32, align 32, offset 0] [from float]
!105 = metadata !{i32 786468, null, null, metadata !"float", i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!106 = metadata !{i32 786445, metadata !1, metadata !102, metadata !"intdata", i32 34, i64 32, i64 32, i64 0, i32 0, metadata !83} ; [ DW_TAG_member ] [intdata] [line 34, size 32, align 32, offset 0] [from uint32_t]
!107 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"consume_record", metadata !"consume_record", metadata !"", i32 52, metadata !108, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (%struct.file_entry*)* @consume_record, n
!108 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !109, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!109 = metadata !{null, metadata !92}
!110 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"main", metadata !"main", metadata !"", i32 67, metadata !111, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i8**)* @main, null, null, metadata !7, i32 67} ; [ DW_TA
!111 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !112, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!112 = metadata !{metadata !26, metadata !26, metadata !113}
!113 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !28} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!114 = metadata !{metadata !115}
!115 = metadata !{i32 786484, i32 0, null, metadata !"lava_val", metadata !"lava_val", metadata !"", metadata !10, i32 3, metadata !116, i32 1, i32 1, [1000000 x i32]* @lava_val, null} ; [ DW_TAG_variable ] [lava_val] [line 3] [local] [def]
!116 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 32000000, i64 32, i32 0, i32 0, metadata !13, metadata !117, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 32000000, align 32, offset 0] [from unsigned int]
!117 = metadata !{metadata !118}
!118 = metadata !{i32 786465, i64 0, i64 1000000} ; [ DW_TAG_subrange_type ] [0, 999999]
!119 = metadata !{i32 786449, metadata !120, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !121, metadata !7, metadata !7, metadata !""} 
!120 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/klee_div_zero_check.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!121 = metadata !{metadata !122}
!122 = metadata !{i32 786478, metadata !120, metadata !123, metadata !"klee_div_zero_check", metadata !"klee_div_zero_check", metadata !"", i32 12, metadata !124, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64)* @klee_div_zero_check, 
!123 = metadata !{i32 786473, metadata !120}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_div_zero_check.c]
!124 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !125, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!125 = metadata !{null, metadata !126}
!126 = metadata !{i32 786468, null, null, metadata !"long long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!127 = metadata !{metadata !128}
!128 = metadata !{i32 786689, metadata !122, metadata !"z", metadata !123, i32 16777228, metadata !126, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 12]
!129 = metadata !{i32 786449, metadata !130, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !131, metadata !7, metadata !7, metadata !""} 
!130 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/klee_int.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!131 = metadata !{metadata !132}
!132 = metadata !{i32 786478, metadata !130, metadata !133, metadata !"klee_int", metadata !"klee_int", metadata !"", i32 13, metadata !134, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @klee_int, null, null, metadata !138, i32 13}
!133 = metadata !{i32 786473, metadata !130}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_int.c]
!134 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !135, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!135 = metadata !{metadata !26, metadata !136}
!136 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !137} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!137 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !29} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!138 = metadata !{metadata !139, metadata !140}
!139 = metadata !{i32 786689, metadata !132, metadata !"name", metadata !133, i32 16777229, metadata !136, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!140 = metadata !{i32 786688, metadata !132, metadata !"x", metadata !133, i32 14, metadata !26, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!141 = metadata !{i32 786449, metadata !142, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !143, metadata !7, metadata !7, metadata !""} 
!142 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/klee_overshift_check.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!143 = metadata !{metadata !144}
!144 = metadata !{i32 786478, metadata !142, metadata !145, metadata !"klee_overshift_check", metadata !"klee_overshift_check", metadata !"", i32 20, metadata !146, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64, i64)* @klee_overshift
!145 = metadata !{i32 786473, metadata !142}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_overshift_check.c]
!146 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !147, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!147 = metadata !{null, metadata !148, metadata !148}
!148 = metadata !{i32 786468, null, null, metadata !"long long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!149 = metadata !{metadata !150, metadata !151}
!150 = metadata !{i32 786689, metadata !144, metadata !"bitWidth", metadata !145, i32 16777236, metadata !148, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bitWidth] [line 20]
!151 = metadata !{i32 786689, metadata !144, metadata !"shift", metadata !145, i32 33554452, metadata !148, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [shift] [line 20]
!152 = metadata !{i32 786449, metadata !153, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !154, metadata !7, metadata !7, metadata !""} 
!153 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/klee_range.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!154 = metadata !{metadata !155}
!155 = metadata !{i32 786478, metadata !153, metadata !156, metadata !"klee_range", metadata !"klee_range", metadata !"", i32 13, metadata !157, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, i8*)* @klee_range, null, null, metada
!156 = metadata !{i32 786473, metadata !153}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_range.c]
!157 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !158, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!158 = metadata !{metadata !26, metadata !26, metadata !26, metadata !136}
!159 = metadata !{metadata !160, metadata !161, metadata !162, metadata !163}
!160 = metadata !{i32 786689, metadata !155, metadata !"start", metadata !156, i32 16777229, metadata !26, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start] [line 13]
!161 = metadata !{i32 786689, metadata !155, metadata !"end", metadata !156, i32 33554445, metadata !26, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [end] [line 13]
!162 = metadata !{i32 786689, metadata !155, metadata !"name", metadata !156, i32 50331661, metadata !136, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!163 = metadata !{i32 786688, metadata !155, metadata !"x", metadata !156, i32 14, metadata !26, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!164 = metadata !{i32 786449, metadata !165, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !166, metadata !7, metadata !7, metadata !""} 
!165 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/memcpy.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!166 = metadata !{metadata !167}
!167 = metadata !{i32 786478, metadata !165, metadata !168, metadata !"memcpy", metadata !"memcpy", metadata !"", i32 12, metadata !169, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memcpy, null, null, metadata !174, i32
!168 = metadata !{i32 786473, metadata !165}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/memcpy.c]
!169 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !170, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!170 = metadata !{metadata !63, metadata !63, metadata !171, metadata !173}
!171 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !172} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!172 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!173 = metadata !{i32 786454, metadata !165, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !72} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!174 = metadata !{metadata !175, metadata !176, metadata !177, metadata !178, metadata !179}
!175 = metadata !{i32 786689, metadata !167, metadata !"destaddr", metadata !168, i32 16777228, metadata !63, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 12]
!176 = metadata !{i32 786689, metadata !167, metadata !"srcaddr", metadata !168, i32 33554444, metadata !171, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 12]
!177 = metadata !{i32 786689, metadata !167, metadata !"len", metadata !168, i32 50331660, metadata !173, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 12]
!178 = metadata !{i32 786688, metadata !167, metadata !"dest", metadata !168, i32 13, metadata !28, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 13]
!179 = metadata !{i32 786688, metadata !167, metadata !"src", metadata !168, i32 14, metadata !136, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 14]
!180 = metadata !{i32 786449, metadata !181, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !182, metadata !7, metadata !7, metadata !""} 
!181 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/memmove.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!182 = metadata !{metadata !183}
!183 = metadata !{i32 786478, metadata !181, metadata !184, metadata !"memmove", metadata !"memmove", metadata !"", i32 12, metadata !185, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memmove, null, null, metadata !188, 
!184 = metadata !{i32 786473, metadata !181}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/memmove.c]
!185 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !186, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!186 = metadata !{metadata !63, metadata !63, metadata !171, metadata !187}
!187 = metadata !{i32 786454, metadata !181, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !72} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!188 = metadata !{metadata !189, metadata !190, metadata !191, metadata !192, metadata !193}
!189 = metadata !{i32 786689, metadata !183, metadata !"dst", metadata !184, i32 16777228, metadata !63, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 12]
!190 = metadata !{i32 786689, metadata !183, metadata !"src", metadata !184, i32 33554444, metadata !171, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [src] [line 12]
!191 = metadata !{i32 786689, metadata !183, metadata !"count", metadata !184, i32 50331660, metadata !187, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 12]
!192 = metadata !{i32 786688, metadata !183, metadata !"a", metadata !184, i32 13, metadata !28, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 13]
!193 = metadata !{i32 786688, metadata !183, metadata !"b", metadata !184, i32 14, metadata !136, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 14]
!194 = metadata !{i32 786449, metadata !195, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !196, metadata !7, metadata !7, metadata !""} 
!195 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/mempcpy.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!196 = metadata !{metadata !197}
!197 = metadata !{i32 786478, metadata !195, metadata !198, metadata !"mempcpy", metadata !"mempcpy", metadata !"", i32 11, metadata !199, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @mempcpy, null, null, metadata !202, 
!198 = metadata !{i32 786473, metadata !195}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/mempcpy.c]
!199 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !200, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!200 = metadata !{metadata !63, metadata !63, metadata !171, metadata !201}
!201 = metadata !{i32 786454, metadata !195, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !72} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!202 = metadata !{metadata !203, metadata !204, metadata !205, metadata !206, metadata !207}
!203 = metadata !{i32 786689, metadata !197, metadata !"destaddr", metadata !198, i32 16777227, metadata !63, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 11]
!204 = metadata !{i32 786689, metadata !197, metadata !"srcaddr", metadata !198, i32 33554443, metadata !171, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 11]
!205 = metadata !{i32 786689, metadata !197, metadata !"len", metadata !198, i32 50331659, metadata !201, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 11]
!206 = metadata !{i32 786688, metadata !197, metadata !"dest", metadata !198, i32 12, metadata !28, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 12]
!207 = metadata !{i32 786688, metadata !197, metadata !"src", metadata !198, i32 13, metadata !136, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 13]
!208 = metadata !{i32 786449, metadata !209, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !210, metadata !7, metadata !7, metadata !""} 
!209 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/memset.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!210 = metadata !{metadata !211}
!211 = metadata !{i32 786478, metadata !209, metadata !212, metadata !"memset", metadata !"memset", metadata !"", i32 11, metadata !213, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i32, i64)* @memset, null, null, metadata !216, i32
!212 = metadata !{i32 786473, metadata !209}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/memset.c]
!213 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !214, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!214 = metadata !{metadata !63, metadata !63, metadata !26, metadata !215}
!215 = metadata !{i32 786454, metadata !209, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !72} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!216 = metadata !{metadata !217, metadata !218, metadata !219, metadata !220}
!217 = metadata !{i32 786689, metadata !211, metadata !"dst", metadata !212, i32 16777227, metadata !63, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 11]
!218 = metadata !{i32 786689, metadata !211, metadata !"s", metadata !212, i32 33554443, metadata !26, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 11]
!219 = metadata !{i32 786689, metadata !211, metadata !"count", metadata !212, i32 50331659, metadata !215, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 11]
!220 = metadata !{i32 786688, metadata !211, metadata !"a", metadata !212, i32 12, metadata !221, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 12]
!221 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !222} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!222 = metadata !{i32 786485, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !29} ; [ DW_TAG_volatile_type ] [line 0, size 0, align 0, offset 0] [from char]
!223 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!224 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!225 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!226 = metadata !{i32 5, i32 0, metadata !9, null}
!227 = metadata !{i32 7, i32 0, metadata !14, null}
!228 = metadata !{i32 39, i32 0, metadata !229, null}
!229 = metadata !{i32 786443, metadata !1, metadata !17, i32 39, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/51/toy/toy.c]
!230 = metadata !{i32 40, i32 0, metadata !229, null}
!231 = metadata !{i32 41, i32 0, metadata !232, null}
!232 = metadata !{i32 786443, metadata !1, metadata !17, i32 41, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/51/toy/toy.c]
!233 = metadata !{i32 42, i32 0, metadata !232, null}
!234 = metadata !{i32 43, i32 0, metadata !17, null}
!235 = metadata !{i32 46, i32 0, metadata !89, null}
!236 = metadata !{i32 47, i32 0, metadata !237, null}
!237 = metadata !{i32 786443, metadata !1, metadata !89, i32 47, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/51/toy/toy.c]
!238 = metadata !{i32 48, i32 0, metadata !237, null}
!239 = metadata !{i32 49, i32 0, metadata !89, null}
!240 = metadata !{i32 53, i32 0, metadata !107, null}
!241 = metadata !{i32 54, i32 0, metadata !242, null}
!242 = metadata !{i32 786443, metadata !1, metadata !107, i32 54, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/51/toy/toy.c]
!243 = metadata !{i32 55, i32 0, metadata !244, null}
!244 = metadata !{i32 786443, metadata !1, metadata !242, i32 54, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/51/toy/toy.c]
!245 = metadata !{i32 56, i32 0, metadata !244, null}
!246 = metadata !{i32 57, i32 0, metadata !247, null}
!247 = metadata !{i32 786443, metadata !1, metadata !242, i32 57, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/51/toy/toy.c]
!248 = metadata !{i32 58, i32 0, metadata !249, null} ; [ DW_TAG_imported_module ]
!249 = metadata !{i32 786443, metadata !1, metadata !247, i32 57, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/51/toy/toy.c]
!250 = metadata !{i32 61, i32 0, metadata !251, null}
!251 = metadata !{i32 786443, metadata !1, metadata !247, i32 60, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/51/toy/toy.c]
!252 = metadata !{i32 62, i32 0, metadata !251, null}
!253 = metadata !{i32 64, i32 0, metadata !107, null}
!254 = metadata !{i32 65, i32 0, metadata !107, null}
!255 = metadata !{i32 68, i32 0, metadata !110, null}
!256 = metadata !{i32 71, i32 0, metadata !257, null}
!257 = metadata !{i32 786443, metadata !1, metadata !110, i32 71, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/51/toy/toy.c]
!258 = metadata !{i32 72, i32 0, metadata !257, null}
!259 = metadata !{i32 74, i32 0, metadata !110, null}
!260 = metadata !{i32 77, i32 0, metadata !261, null}
!261 = metadata !{i32 786443, metadata !1, metadata !110, i32 77, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/51/toy/toy.c]
!262 = metadata !{i32 78, i32 0, metadata !263, null}
!263 = metadata !{i32 786443, metadata !1, metadata !261, i32 77, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/buggy/51/toy/toy.c]
!264 = metadata !{i32 79, i32 0, metadata !263, null}
!265 = metadata !{i32 81, i32 0, metadata !110, null}
!266 = metadata !{i32 13, i32 0, metadata !267, null}
!267 = metadata !{i32 786443, metadata !120, metadata !122, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_div_zero_check.c]
!268 = metadata !{i32 14, i32 0, metadata !267, null}
!269 = metadata !{i32 15, i32 0, metadata !122, null}
!270 = metadata !{i32 15, i32 0, metadata !132, null}
!271 = metadata !{i32 16, i32 0, metadata !132, null}
!272 = metadata !{metadata !273, metadata !273, i64 0}
!273 = metadata !{metadata !"int", metadata !274, i64 0}
!274 = metadata !{metadata !"omnipotent char", metadata !275, i64 0}
!275 = metadata !{metadata !"Simple C/C++ TBAA"}
!276 = metadata !{i32 21, i32 0, metadata !277, null}
!277 = metadata !{i32 786443, metadata !142, metadata !144, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_overshift_check.c]
!278 = metadata !{i32 27, i32 0, metadata !279, null}
!279 = metadata !{i32 786443, metadata !142, metadata !277, i32 21, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_overshift_check.c]
!280 = metadata !{i32 29, i32 0, metadata !144, null}
!281 = metadata !{i32 16, i32 0, metadata !282, null}
!282 = metadata !{i32 786443, metadata !153, metadata !155, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_range.c]
!283 = metadata !{i32 17, i32 0, metadata !282, null}
!284 = metadata !{i32 19, i32 0, metadata !285, null}
!285 = metadata !{i32 786443, metadata !153, metadata !155, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_range.c]
!286 = metadata !{i32 22, i32 0, metadata !287, null}
!287 = metadata !{i32 786443, metadata !153, metadata !285, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_range.c]
!288 = metadata !{i32 25, i32 0, metadata !289, null}
!289 = metadata !{i32 786443, metadata !153, metadata !287, i32 25, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_range.c]
!290 = metadata !{i32 26, i32 0, metadata !291, null}
!291 = metadata !{i32 786443, metadata !153, metadata !289, i32 25, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_range.c]
!292 = metadata !{i32 27, i32 0, metadata !291, null}
!293 = metadata !{i32 28, i32 0, metadata !294, null}
!294 = metadata !{i32 786443, metadata !153, metadata !289, i32 27, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_range.c]
!295 = metadata !{i32 29, i32 0, metadata !294, null}
!296 = metadata !{i32 32, i32 0, metadata !287, null}
!297 = metadata !{i32 34, i32 0, metadata !155, null}
!298 = metadata !{i32 16, i32 0, metadata !167, null}
!299 = metadata !{i32 17, i32 0, metadata !167, null}
!300 = metadata !{metadata !300, metadata !301, metadata !302}
!301 = metadata !{metadata !"llvm.vectorizer.width", i32 1}
!302 = metadata !{metadata !"llvm.vectorizer.unroll", i32 1}
!303 = metadata !{metadata !274, metadata !274, i64 0}
!304 = metadata !{metadata !304, metadata !301, metadata !302}
!305 = metadata !{i32 18, i32 0, metadata !167, null}
!306 = metadata !{i32 16, i32 0, metadata !307, null}
!307 = metadata !{i32 786443, metadata !181, metadata !183, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/memmove.c]
!308 = metadata !{i32 19, i32 0, metadata !309, null}
!309 = metadata !{i32 786443, metadata !181, metadata !183, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/memmove.c]
!310 = metadata !{i32 20, i32 0, metadata !311, null}
!311 = metadata !{i32 786443, metadata !181, metadata !309, i32 19, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/memmove.c]
!312 = metadata !{metadata !312, metadata !301, metadata !302}
!313 = metadata !{metadata !313, metadata !301, metadata !302}
!314 = metadata !{i32 22, i32 0, metadata !315, null}
!315 = metadata !{i32 786443, metadata !181, metadata !309, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/memmove.c]
!316 = metadata !{i32 24, i32 0, metadata !315, null}
!317 = metadata !{i32 23, i32 0, metadata !315, null}
!318 = metadata !{metadata !318, metadata !301, metadata !302}
!319 = metadata !{metadata !319, metadata !301, metadata !302}
!320 = metadata !{i32 28, i32 0, metadata !183, null}
!321 = metadata !{i32 15, i32 0, metadata !197, null}
!322 = metadata !{i32 16, i32 0, metadata !197, null}
!323 = metadata !{metadata !323, metadata !301, metadata !302}
!324 = metadata !{metadata !324, metadata !301, metadata !302}
!325 = metadata !{i32 17, i32 0, metadata !197, null}
!326 = metadata !{i32 13, i32 0, metadata !211, null}
!327 = metadata !{i32 14, i32 0, metadata !211, null}
!328 = metadata !{i32 15, i32 0, metadata !211, null}
