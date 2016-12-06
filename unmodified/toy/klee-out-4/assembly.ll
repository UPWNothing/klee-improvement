; ModuleID = 'toy.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.file_header = type <{ i32, i32, i16, i16, i32 }>
%struct.file_entry = type <{ [16 x i8], i32, %union.anon }>
%union.anon = type <{ float }>

@.str = private unnamed_addr constant [18 x i8] c"Entry: bar = %s, \00", align 1
@.str1 = private unnamed_addr constant [12 x i8] c"fdata = %f\0A\00", align 1
@.str2 = private unnamed_addr constant [14 x i8] c"intdata = %u\0A\00", align 1
@.str3 = private unnamed_addr constant [17 x i8] c"Unknown type %x\0A\00", align 1
@.str4 = private unnamed_addr constant [5 x i8] c"file\00", align 1
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
define void @parse_header(%struct._IO_FILE* %f, %struct.file_header* %hdr) #0 {
  %1 = alloca %struct._IO_FILE*, align 8
  %2 = alloca %struct.file_header*, align 8
  store %struct._IO_FILE* %f, %struct._IO_FILE** %1, align 8
  store %struct.file_header* %hdr, %struct.file_header** %2, align 8
  %3 = load %struct.file_header** %2, align 8, !dbg !215
  %4 = bitcast %struct.file_header* %3 to i8*, !dbg !215
  %5 = load %struct._IO_FILE** %1, align 8, !dbg !215
  %6 = call i64 @fread(i8* %4, i64 16, i64 1, %struct._IO_FILE* %5), !dbg !215
  %7 = icmp ne i64 1, %6, !dbg !215
  br i1 %7, label %8, label %9, !dbg !215

; <label>:8                                       ; preds = %0
  call void @exit(i32 1) #8, !dbg !217
  unreachable, !dbg !217

; <label>:9                                       ; preds = %0
  %10 = load %struct.file_header** %2, align 8, !dbg !218
  %11 = getelementptr inbounds %struct.file_header* %10, i32 0, i32 0, !dbg !218
  %12 = load i32* %11, align 1, !dbg !218
  %13 = icmp ne i32 %12, 1279350337, !dbg !218
  br i1 %13, label %14, label %15, !dbg !218

; <label>:14                                      ; preds = %9
  call void @exit(i32 1) #8, !dbg !220
  unreachable, !dbg !220

; <label>:15                                      ; preds = %9
  ret void, !dbg !221
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i64 @fread(i8*, i64, i64, %struct._IO_FILE*) #2

; Function Attrs: noreturn nounwind
declare void @exit(i32) #3

; Function Attrs: nounwind uwtable
define %struct.file_entry* @parse_record(%struct._IO_FILE* %f) #0 {
  %1 = alloca %struct._IO_FILE*, align 8
  %ret = alloca %struct.file_entry*, align 8
  store %struct._IO_FILE* %f, %struct._IO_FILE** %1, align 8
  %2 = call noalias i8* @malloc(i64 24) #9, !dbg !222
  %3 = bitcast i8* %2 to %struct.file_entry*, !dbg !222
  store %struct.file_entry* %3, %struct.file_entry** %ret, align 8, !dbg !222
  %4 = load %struct.file_entry** %ret, align 8, !dbg !223
  %5 = bitcast %struct.file_entry* %4 to i8*, !dbg !223
  %6 = load %struct._IO_FILE** %1, align 8, !dbg !223
  %7 = call i64 @fread(i8* %5, i64 24, i64 1, %struct._IO_FILE* %6), !dbg !223
  %8 = icmp ne i64 1, %7, !dbg !223
  br i1 %8, label %9, label %10, !dbg !223

; <label>:9                                       ; preds = %0
  call void @exit(i32 1) #8, !dbg !225
  unreachable, !dbg !225

; <label>:10                                      ; preds = %0
  %11 = load %struct.file_entry** %ret, align 8, !dbg !226
  ret %struct.file_entry* %11, !dbg !226
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #4

; Function Attrs: nounwind uwtable
define void @consume_record(%struct.file_entry* %ent) #0 {
  %1 = alloca %struct.file_entry*, align 8
  store %struct.file_entry* %ent, %struct.file_entry** %1, align 8
  %2 = load %struct.file_entry** %1, align 8, !dbg !227
  %3 = getelementptr inbounds %struct.file_entry* %2, i32 0, i32 0, !dbg !227
  %4 = getelementptr inbounds [16 x i8]* %3, i32 0, i32 0, !dbg !227
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str, i32 0, i32 0), i8* %4), !dbg !227
  %6 = load %struct.file_entry** %1, align 8, !dbg !228
  %7 = getelementptr inbounds %struct.file_entry* %6, i32 0, i32 1, !dbg !228
  %8 = load i32* %7, align 1, !dbg !228
  %9 = icmp eq i32 %8, 1, !dbg !228
  %10 = load %struct.file_entry** %1, align 8, !dbg !230
  br i1 %9, label %11, label %17, !dbg !228

; <label>:11                                      ; preds = %0
  %12 = getelementptr inbounds %struct.file_entry* %10, i32 0, i32 2, !dbg !230
  %13 = bitcast %union.anon* %12 to float*, !dbg !230
  %14 = load float* %13, align 1, !dbg !230
  %15 = fpext float %14 to double, !dbg !230
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str1, i32 0, i32 0), double %15), !dbg !230
  br label %31, !dbg !232

; <label>:17                                      ; preds = %0
  %18 = getelementptr inbounds %struct.file_entry* %10, i32 0, i32 1, !dbg !233
  %19 = load i32* %18, align 1, !dbg !233
  %20 = icmp eq i32 %19, 2, !dbg !233
  %21 = load %struct.file_entry** %1, align 8, !dbg !235
  br i1 %20, label %22, label %27, !dbg !233

; <label>:22                                      ; preds = %17
  %23 = getelementptr inbounds %struct.file_entry* %21, i32 0, i32 2, !dbg !235
  %24 = bitcast %union.anon* %23 to i32*, !dbg !235
  %25 = load i32* %24, align 1, !dbg !235
  %26 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str2, i32 0, i32 0), i32 %25), !dbg !235
  br label %31

; <label>:27                                      ; preds = %17
  %28 = getelementptr inbounds %struct.file_entry* %21, i32 0, i32 1, !dbg !237
  %29 = load i32* %28, align 1, !dbg !237
  %30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str3, i32 0, i32 0), i32 %29), !dbg !237
  call void @exit(i32 1) #8, !dbg !239
  unreachable, !dbg !239

; <label>:31                                      ; preds = %22, %11
  %32 = load %struct.file_entry** %1, align 8, !dbg !240
  %33 = bitcast %struct.file_entry* %32 to i8*, !dbg !240
  call void @free(i8* %33) #9, !dbg !240
  ret void, !dbg !241
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
  %i = alloca i32, align 4
  %ent = alloca %struct.file_entry*, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = load %struct._IO_FILE** %f, align 8, !dbg !242
  %5 = bitcast %struct._IO_FILE* %4 to i8*, !dbg !242
  call void @klee_make_symbolic(i8* %5, i64 216, i8* getelementptr inbounds ([5 x i8]* @.str4, i32 0, i32 0)), !dbg !242
  %6 = load %struct._IO_FILE** %f, align 8, !dbg !243
  call void @parse_header(%struct._IO_FILE* %6, %struct.file_header* %head), !dbg !243
  %7 = getelementptr inbounds %struct.file_header* %head, i32 0, i32 4, !dbg !244
  %8 = load i32* %7, align 1, !dbg !244
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str5, i32 0, i32 0), i32 %8), !dbg !244
  store i32 0, i32* %i, align 4, !dbg !245
  br label %10, !dbg !245

; <label>:10                                      ; preds = %16, %0
  %11 = load i32* %i, align 4, !dbg !245
  %12 = getelementptr inbounds %struct.file_header* %head, i32 0, i32 2, !dbg !245
  %13 = load i16* %12, align 1, !dbg !245
  %14 = zext i16 %13 to i32, !dbg !245
  %15 = icmp ult i32 %11, %14, !dbg !245
  br i1 %15, label %16, label %22, !dbg !245

; <label>:16                                      ; preds = %10
  %17 = load %struct._IO_FILE** %f, align 8, !dbg !247
  %18 = call %struct.file_entry* @parse_record(%struct._IO_FILE* %17), !dbg !247
  store %struct.file_entry* %18, %struct.file_entry** %ent, align 8, !dbg !247
  %19 = load %struct.file_entry** %ent, align 8, !dbg !249
  call void @consume_record(%struct.file_entry* %19), !dbg !249
  %20 = load i32* %i, align 4, !dbg !245
  %21 = add i32 %20, 1, !dbg !245
  store i32 %21, i32* %i, align 4, !dbg !245
  br label %10, !dbg !245

; <label>:22                                      ; preds = %10
  ret i32 0, !dbg !250
}

declare void @klee_make_symbolic(i8*, i64, i8*) #2

; Function Attrs: nounwind uwtable
define void @klee_div_zero_check(i64 %z) #5 {
  %1 = icmp eq i64 %z, 0, !dbg !251
  br i1 %1, label %2, label %3, !dbg !251

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([60 x i8]* @.str6, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([15 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str28, i64 0, i64 0)) #10, !dbg !253
  unreachable, !dbg !253

; <label>:3                                       ; preds = %0
  ret void, !dbg !254
}

; Function Attrs: noreturn
declare void @klee_report_error(i8*, i32, i8*, i8*) #6

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

; Function Attrs: nounwind uwtable
define i32 @klee_int(i8* %name) #5 {
  %x = alloca i32, align 4
  %1 = bitcast i32* %x to i8*, !dbg !255
  call void @klee_make_symbolic(i8* %1, i64 4, i8* %name) #11, !dbg !255
  %2 = load i32* %x, align 4, !dbg !256, !tbaa !257
  ret i32 %2, !dbg !256
}

; Function Attrs: nounwind uwtable
define void @klee_overshift_check(i64 %bitWidth, i64 %shift) #5 {
  %1 = icmp ult i64 %shift, %bitWidth, !dbg !261
  br i1 %1, label %3, label %2, !dbg !261

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([8 x i8]* @.str39, i64 0, i64 0), i32 0, i8* getelementptr inbounds ([16 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str25, i64 0, i64 0)) #10, !dbg !263
  unreachable, !dbg !263

; <label>:3                                       ; preds = %0
  ret void, !dbg !265
}

; Function Attrs: nounwind uwtable
define i32 @klee_range(i32 %start, i32 %end, i8* %name) #5 {
  %x = alloca i32, align 4
  %1 = icmp slt i32 %start, %end, !dbg !266
  br i1 %1, label %3, label %2, !dbg !266

; <label>:2                                       ; preds = %0
  call void @klee_report_error(i8* getelementptr inbounds ([51 x i8]* @.str610, i64 0, i64 0), i32 17, i8* getelementptr inbounds ([14 x i8]* @.str1711, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str2812, i64 0, i64 0)) #10, !dbg !268
  unreachable, !dbg !268

; <label>:3                                       ; preds = %0
  %4 = add nsw i32 %start, 1, !dbg !269
  %5 = icmp eq i32 %4, %end, !dbg !269
  br i1 %5, label %21, label %6, !dbg !269

; <label>:6                                       ; preds = %3
  %7 = bitcast i32* %x to i8*, !dbg !271
  call void @klee_make_symbolic(i8* %7, i64 4, i8* %name) #11, !dbg !271
  %8 = icmp eq i32 %start, 0, !dbg !273
  %9 = load i32* %x, align 4, !dbg !275, !tbaa !257
  br i1 %8, label %10, label %13, !dbg !273

; <label>:10                                      ; preds = %6
  %11 = icmp ult i32 %9, %end, !dbg !275
  %12 = zext i1 %11 to i64, !dbg !275
  call void @klee_assume(i64 %12) #11, !dbg !275
  br label %19, !dbg !277

; <label>:13                                      ; preds = %6
  %14 = icmp sge i32 %9, %start, !dbg !278
  %15 = zext i1 %14 to i64, !dbg !278
  call void @klee_assume(i64 %15) #11, !dbg !278
  %16 = load i32* %x, align 4, !dbg !280, !tbaa !257
  %17 = icmp slt i32 %16, %end, !dbg !280
  %18 = zext i1 %17 to i64, !dbg !280
  call void @klee_assume(i64 %18) #11, !dbg !280
  br label %19

; <label>:19                                      ; preds = %13, %10
  %20 = load i32* %x, align 4, !dbg !281, !tbaa !257
  br label %21, !dbg !281

; <label>:21                                      ; preds = %19, %3
  %.0 = phi i32 [ %20, %19 ], [ %start, %3 ]
  ret i32 %.0, !dbg !282
}

declare void @klee_assume(i64) #7

; Function Attrs: nounwind uwtable
define weak i8* @memcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #5 {
  %1 = icmp eq i64 %len, 0, !dbg !283
  br i1 %1, label %._crit_edge, label %.lr.ph.preheader, !dbg !283

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
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !284
  %wide.load = load <16 x i8>* %3, align 1, !dbg !284
  %next.gep.sum279 = or i64 %index, 16, !dbg !284
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum279, !dbg !284
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !284
  %wide.load200 = load <16 x i8>* %5, align 1, !dbg !284
  %6 = bitcast i8* %next.gep103 to <16 x i8>*, !dbg !284
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !284
  %next.gep103.sum296 = or i64 %index, 16, !dbg !284
  %7 = getelementptr i8* %destaddr, i64 %next.gep103.sum296, !dbg !284
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !284
  store <16 x i8> %wide.load200, <16 x i8>* %8, align 1, !dbg !284
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !285

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
  %10 = add i64 %.01, -1, !dbg !283
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !284
  %12 = load i8* %src.03, align 1, !dbg !284, !tbaa !288
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !284
  store i8 %12, i8* %dest.02, align 1, !dbg !284, !tbaa !288
  %14 = icmp eq i64 %10, 0, !dbg !283
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !283, !llvm.loop !289

._crit_edge:                                      ; preds = %.lr.ph, %middle.block, %0
  ret i8* %destaddr, !dbg !290
}

; Function Attrs: nounwind uwtable
define weak i8* @memmove(i8* %dst, i8* %src, i64 %count) #5 {
  %1 = icmp eq i8* %src, %dst, !dbg !291
  br i1 %1, label %.loopexit, label %2, !dbg !291

; <label>:2                                       ; preds = %0
  %3 = icmp ugt i8* %src, %dst, !dbg !293
  br i1 %3, label %.preheader, label %18, !dbg !293

.preheader:                                       ; preds = %2
  %4 = icmp eq i64 %count, 0, !dbg !295
  br i1 %4, label %.loopexit, label %.lr.ph.preheader, !dbg !295

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
  %6 = bitcast i8* %next.gep to <16 x i8>*, !dbg !295
  %wide.load = load <16 x i8>* %6, align 1, !dbg !295
  %next.gep.sum586 = or i64 %index, 16, !dbg !295
  %7 = getelementptr i8* %src, i64 %next.gep.sum586, !dbg !295
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !295
  %wide.load207 = load <16 x i8>* %8, align 1, !dbg !295
  %9 = bitcast i8* %next.gep110 to <16 x i8>*, !dbg !295
  store <16 x i8> %wide.load, <16 x i8>* %9, align 1, !dbg !295
  %next.gep110.sum603 = or i64 %index, 16, !dbg !295
  %10 = getelementptr i8* %dst, i64 %next.gep110.sum603, !dbg !295
  %11 = bitcast i8* %10 to <16 x i8>*, !dbg !295
  store <16 x i8> %wide.load207, <16 x i8>* %11, align 1, !dbg !295
  %index.next = add i64 %index, 32
  %12 = icmp eq i64 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !297

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
  %13 = add i64 %.02, -1, !dbg !295
  %14 = getelementptr inbounds i8* %b.04, i64 1, !dbg !295
  %15 = load i8* %b.04, align 1, !dbg !295, !tbaa !288
  %16 = getelementptr inbounds i8* %a.03, i64 1, !dbg !295
  store i8 %15, i8* %a.03, align 1, !dbg !295, !tbaa !288
  %17 = icmp eq i64 %13, 0, !dbg !295
  br i1 %17, label %.loopexit, label %.lr.ph, !dbg !295, !llvm.loop !298

; <label>:18                                      ; preds = %2
  %19 = add i64 %count, -1, !dbg !299
  %20 = icmp eq i64 %count, 0, !dbg !301
  br i1 %20, label %.loopexit, label %.lr.ph9, !dbg !301

.lr.ph9:                                          ; preds = %18
  %21 = getelementptr inbounds i8* %src, i64 %19, !dbg !302
  %22 = getelementptr inbounds i8* %dst, i64 %19, !dbg !299
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
  %next.gep236.sum = add i64 %.sum440, -15, !dbg !301
  %24 = getelementptr i8* %src, i64 %next.gep236.sum, !dbg !301
  %25 = bitcast i8* %24 to <16 x i8>*, !dbg !301
  %wide.load434 = load <16 x i8>* %25, align 1, !dbg !301
  %reverse = shufflevector <16 x i8> %wide.load434, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !301
  %.sum505 = add i64 %.sum440, -31, !dbg !301
  %26 = getelementptr i8* %src, i64 %.sum505, !dbg !301
  %27 = bitcast i8* %26 to <16 x i8>*, !dbg !301
  %wide.load435 = load <16 x i8>* %27, align 1, !dbg !301
  %reverse436 = shufflevector <16 x i8> %wide.load435, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !301
  %reverse437 = shufflevector <16 x i8> %reverse, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !301
  %next.gep333.sum = add i64 %.sum472, -15, !dbg !301
  %28 = getelementptr i8* %dst, i64 %next.gep333.sum, !dbg !301
  %29 = bitcast i8* %28 to <16 x i8>*, !dbg !301
  store <16 x i8> %reverse437, <16 x i8>* %29, align 1, !dbg !301
  %reverse438 = shufflevector <16 x i8> %reverse436, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !301
  %.sum507 = add i64 %.sum472, -31, !dbg !301
  %30 = getelementptr i8* %dst, i64 %.sum507, !dbg !301
  %31 = bitcast i8* %30 to <16 x i8>*, !dbg !301
  store <16 x i8> %reverse438, <16 x i8>* %31, align 1, !dbg !301
  %index.next234 = add i64 %index212, 32
  %32 = icmp eq i64 %index.next234, %n.vec215
  br i1 %32, label %middle.block210, label %vector.body209, !llvm.loop !303

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
  %33 = add i64 %.16, -1, !dbg !301
  %34 = getelementptr inbounds i8* %b.18, i64 -1, !dbg !301
  %35 = load i8* %b.18, align 1, !dbg !301, !tbaa !288
  %36 = getelementptr inbounds i8* %a.17, i64 -1, !dbg !301
  store i8 %35, i8* %a.17, align 1, !dbg !301, !tbaa !288
  %37 = icmp eq i64 %33, 0, !dbg !301
  br i1 %37, label %.loopexit, label %scalar.ph211, !dbg !301, !llvm.loop !304

.loopexit:                                        ; preds = %scalar.ph211, %middle.block210, %18, %.lr.ph, %middle.block, %.preheader, %0
  ret i8* %dst, !dbg !305
}

; Function Attrs: nounwind uwtable
define weak i8* @mempcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #5 {
  %1 = icmp eq i64 %len, 0, !dbg !306
  br i1 %1, label %15, label %.lr.ph.preheader, !dbg !306

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
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !307
  %wide.load = load <16 x i8>* %3, align 1, !dbg !307
  %next.gep.sum280 = or i64 %index, 16, !dbg !307
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum280, !dbg !307
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !307
  %wide.load201 = load <16 x i8>* %5, align 1, !dbg !307
  %6 = bitcast i8* %next.gep104 to <16 x i8>*, !dbg !307
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !307
  %next.gep104.sum297 = or i64 %index, 16, !dbg !307
  %7 = getelementptr i8* %destaddr, i64 %next.gep104.sum297, !dbg !307
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !307
  store <16 x i8> %wide.load201, <16 x i8>* %8, align 1, !dbg !307
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !308

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
  %10 = add i64 %.01, -1, !dbg !306
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !307
  %12 = load i8* %src.03, align 1, !dbg !307, !tbaa !288
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !307
  store i8 %12, i8* %dest.02, align 1, !dbg !307, !tbaa !288
  %14 = icmp eq i64 %10, 0, !dbg !306
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !306, !llvm.loop !309

._crit_edge:                                      ; preds = %.lr.ph, %middle.block
  %scevgep = getelementptr i8* %destaddr, i64 %len
  br label %15, !dbg !306

; <label>:15                                      ; preds = %._crit_edge, %0
  %dest.0.lcssa = phi i8* [ %scevgep, %._crit_edge ], [ %destaddr, %0 ]
  ret i8* %dest.0.lcssa, !dbg !310
}

; Function Attrs: nounwind uwtable
define weak i8* @memset(i8* %dst, i32 %s, i64 %count) #5 {
  %1 = icmp eq i64 %count, 0, !dbg !311
  br i1 %1, label %._crit_edge, label %.lr.ph, !dbg !311

.lr.ph:                                           ; preds = %0
  %2 = trunc i32 %s to i8, !dbg !312
  br label %3, !dbg !311

; <label>:3                                       ; preds = %3, %.lr.ph
  %a.02 = phi i8* [ %dst, %.lr.ph ], [ %5, %3 ]
  %.01 = phi i64 [ %count, %.lr.ph ], [ %4, %3 ]
  %4 = add i64 %.01, -1, !dbg !311
  %5 = getelementptr inbounds i8* %a.02, i64 1, !dbg !312
  store volatile i8 %2, i8* %a.02, align 1, !dbg !312, !tbaa !288
  %6 = icmp eq i64 %4, 0, !dbg !311
  br i1 %6, label %._crit_edge, label %3, !dbg !311

._crit_edge:                                      ; preds = %3, %0
  ret i8* %dst, !dbg !313
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

!llvm.dbg.cu = !{!0, !108, !118, !130, !141, !153, !169, !183, !197}
!llvm.module.flags = !{!212, !213}
!llvm.ident = !{!214, !214, !214, !214, !214, !214, !214, !214, !214}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 false, metadata !"", i32 0, metadata !2, metadata !7, metadata !8, metadata !7, metadata !7, metadata !""} ; [ 
!1 = metadata !{metadata !"toy.c", metadata !"/home/klee/toy_example_distrib/unmodified/toy"}
!2 = metadata !{metadata !3}
!3 = metadata !{i32 786436, metadata !1, null, metadata !"", i32 9, i64 32, i64 32, i32 0, i32 0, null, metadata !4, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 9, size 32, align 32, offset 0] [def] [from ]
!4 = metadata !{metadata !5, metadata !6}
!5 = metadata !{i32 786472, metadata !"TYPEA", i64 1} ; [ DW_TAG_enumerator ] [TYPEA :: 1]
!6 = metadata !{i32 786472, metadata !"TYPEB", i64 2} ; [ DW_TAG_enumerator ] [TYPEB :: 2]
!7 = metadata !{i32 0}
!8 = metadata !{metadata !9, metadata !83, metadata !101, metadata !104}
!9 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"parse_header", metadata !"parse_header", metadata !"", i32 31, metadata !11, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (%struct._IO_FILE*, %struct.file_header*)* @pars
!10 = metadata !{i32 786473, metadata !1}         ; [ DW_TAG_file_type ] [/home/klee/toy_example_distrib/unmodified/toy/toy.c]
!11 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !12, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!12 = metadata !{null, metadata !13, metadata !71}
!13 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !14} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from FILE]
!14 = metadata !{i32 786454, metadata !1, null, metadata !"FILE", i32 48, i64 0, i64 0, i64 0, i32 0, metadata !15} ; [ DW_TAG_typedef ] [FILE] [line 48, size 0, align 0, offset 0] [from _IO_FILE]
!15 = metadata !{i32 786451, metadata !16, null, metadata !"_IO_FILE", i32 245, i64 1728, i64 64, i32 0, i32 0, null, metadata !17, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [_IO_FILE] [line 245, size 1728, align 64, offset 0] [def] [from ]
!16 = metadata !{metadata !"/usr/include/libio.h", metadata !"/home/klee/toy_example_distrib/unmodified/toy"}
!17 = metadata !{metadata !18, metadata !20, metadata !23, metadata !24, metadata !25, metadata !26, metadata !27, metadata !28, metadata !29, metadata !30, metadata !31, metadata !32, metadata !33, metadata !41, metadata !42, metadata !43, metadata !44,
!18 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_flags", i32 246, i64 32, i64 32, i64 0, i32 0, metadata !19} ; [ DW_TAG_member ] [_flags] [line 246, size 32, align 32, offset 0] [from int]
!19 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!20 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_IO_read_ptr", i32 251, i64 64, i64 64, i64 64, i32 0, metadata !21} ; [ DW_TAG_member ] [_IO_read_ptr] [line 251, size 64, align 64, offset 64] [from ]
!21 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !22} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!22 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!23 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_IO_read_end", i32 252, i64 64, i64 64, i64 128, i32 0, metadata !21} ; [ DW_TAG_member ] [_IO_read_end] [line 252, size 64, align 64, offset 128] [from ]
!24 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_IO_read_base", i32 253, i64 64, i64 64, i64 192, i32 0, metadata !21} ; [ DW_TAG_member ] [_IO_read_base] [line 253, size 64, align 64, offset 192] [from ]
!25 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_IO_write_base", i32 254, i64 64, i64 64, i64 256, i32 0, metadata !21} ; [ DW_TAG_member ] [_IO_write_base] [line 254, size 64, align 64, offset 256] [from ]
!26 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_IO_write_ptr", i32 255, i64 64, i64 64, i64 320, i32 0, metadata !21} ; [ DW_TAG_member ] [_IO_write_ptr] [line 255, size 64, align 64, offset 320] [from ]
!27 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_IO_write_end", i32 256, i64 64, i64 64, i64 384, i32 0, metadata !21} ; [ DW_TAG_member ] [_IO_write_end] [line 256, size 64, align 64, offset 384] [from ]
!28 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_IO_buf_base", i32 257, i64 64, i64 64, i64 448, i32 0, metadata !21} ; [ DW_TAG_member ] [_IO_buf_base] [line 257, size 64, align 64, offset 448] [from ]
!29 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_IO_buf_end", i32 258, i64 64, i64 64, i64 512, i32 0, metadata !21} ; [ DW_TAG_member ] [_IO_buf_end] [line 258, size 64, align 64, offset 512] [from ]
!30 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_IO_save_base", i32 260, i64 64, i64 64, i64 576, i32 0, metadata !21} ; [ DW_TAG_member ] [_IO_save_base] [line 260, size 64, align 64, offset 576] [from ]
!31 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_IO_backup_base", i32 261, i64 64, i64 64, i64 640, i32 0, metadata !21} ; [ DW_TAG_member ] [_IO_backup_base] [line 261, size 64, align 64, offset 640] [from ]
!32 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_IO_save_end", i32 262, i64 64, i64 64, i64 704, i32 0, metadata !21} ; [ DW_TAG_member ] [_IO_save_end] [line 262, size 64, align 64, offset 704] [from ]
!33 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_markers", i32 264, i64 64, i64 64, i64 768, i32 0, metadata !34} ; [ DW_TAG_member ] [_markers] [line 264, size 64, align 64, offset 768] [from ]
!34 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !35} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from _IO_marker]
!35 = metadata !{i32 786451, metadata !16, null, metadata !"_IO_marker", i32 160, i64 192, i64 64, i32 0, i32 0, null, metadata !36, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [_IO_marker] [line 160, size 192, align 64, offset 0] [def] [from ]
!36 = metadata !{metadata !37, metadata !38, metadata !40}
!37 = metadata !{i32 786445, metadata !16, metadata !35, metadata !"_next", i32 161, i64 64, i64 64, i64 0, i32 0, metadata !34} ; [ DW_TAG_member ] [_next] [line 161, size 64, align 64, offset 0] [from ]
!38 = metadata !{i32 786445, metadata !16, metadata !35, metadata !"_sbuf", i32 162, i64 64, i64 64, i64 64, i32 0, metadata !39} ; [ DW_TAG_member ] [_sbuf] [line 162, size 64, align 64, offset 64] [from ]
!39 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !15} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from _IO_FILE]
!40 = metadata !{i32 786445, metadata !16, metadata !35, metadata !"_pos", i32 166, i64 32, i64 32, i64 128, i32 0, metadata !19} ; [ DW_TAG_member ] [_pos] [line 166, size 32, align 32, offset 128] [from int]
!41 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_chain", i32 266, i64 64, i64 64, i64 832, i32 0, metadata !39} ; [ DW_TAG_member ] [_chain] [line 266, size 64, align 64, offset 832] [from ]
!42 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_fileno", i32 268, i64 32, i64 32, i64 896, i32 0, metadata !19} ; [ DW_TAG_member ] [_fileno] [line 268, size 32, align 32, offset 896] [from int]
!43 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_flags2", i32 272, i64 32, i64 32, i64 928, i32 0, metadata !19} ; [ DW_TAG_member ] [_flags2] [line 272, size 32, align 32, offset 928] [from int]
!44 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_old_offset", i32 274, i64 64, i64 64, i64 960, i32 0, metadata !45} ; [ DW_TAG_member ] [_old_offset] [line 274, size 64, align 64, offset 960] [from __off_t]
!45 = metadata !{i32 786454, metadata !16, null, metadata !"__off_t", i32 131, i64 0, i64 0, i64 0, i32 0, metadata !46} ; [ DW_TAG_typedef ] [__off_t] [line 131, size 0, align 0, offset 0] [from long int]
!46 = metadata !{i32 786468, null, null, metadata !"long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!47 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_cur_column", i32 278, i64 16, i64 16, i64 1024, i32 0, metadata !48} ; [ DW_TAG_member ] [_cur_column] [line 278, size 16, align 16, offset 1024] [from unsigned short]
!48 = metadata !{i32 786468, null, null, metadata !"unsigned short", i32 0, i64 16, i64 16, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned short] [line 0, size 16, align 16, offset 0, enc DW_ATE_unsigned]
!49 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_vtable_offset", i32 279, i64 8, i64 8, i64 1040, i32 0, metadata !50} ; [ DW_TAG_member ] [_vtable_offset] [line 279, size 8, align 8, offset 1040] [from signed char]
!50 = metadata !{i32 786468, null, null, metadata !"signed char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [signed char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!51 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_shortbuf", i32 280, i64 8, i64 8, i64 1048, i32 0, metadata !52} ; [ DW_TAG_member ] [_shortbuf] [line 280, size 8, align 8, offset 1048] [from ]
!52 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 8, i64 8, i32 0, i32 0, metadata !22, metadata !53, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 8, align 8, offset 0] [from char]
!53 = metadata !{metadata !54}
!54 = metadata !{i32 786465, i64 0, i64 1}        ; [ DW_TAG_subrange_type ] [0, 0]
!55 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_lock", i32 284, i64 64, i64 64, i64 1088, i32 0, metadata !56} ; [ DW_TAG_member ] [_lock] [line 284, size 64, align 64, offset 1088] [from ]
!56 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!57 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_offset", i32 293, i64 64, i64 64, i64 1152, i32 0, metadata !58} ; [ DW_TAG_member ] [_offset] [line 293, size 64, align 64, offset 1152] [from __off64_t]
!58 = metadata !{i32 786454, metadata !16, null, metadata !"__off64_t", i32 132, i64 0, i64 0, i64 0, i32 0, metadata !46} ; [ DW_TAG_typedef ] [__off64_t] [line 132, size 0, align 0, offset 0] [from long int]
!59 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"__pad1", i32 302, i64 64, i64 64, i64 1216, i32 0, metadata !56} ; [ DW_TAG_member ] [__pad1] [line 302, size 64, align 64, offset 1216] [from ]
!60 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"__pad2", i32 303, i64 64, i64 64, i64 1280, i32 0, metadata !56} ; [ DW_TAG_member ] [__pad2] [line 303, size 64, align 64, offset 1280] [from ]
!61 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"__pad3", i32 304, i64 64, i64 64, i64 1344, i32 0, metadata !56} ; [ DW_TAG_member ] [__pad3] [line 304, size 64, align 64, offset 1344] [from ]
!62 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"__pad4", i32 305, i64 64, i64 64, i64 1408, i32 0, metadata !56} ; [ DW_TAG_member ] [__pad4] [line 305, size 64, align 64, offset 1408] [from ]
!63 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"__pad5", i32 306, i64 64, i64 64, i64 1472, i32 0, metadata !64} ; [ DW_TAG_member ] [__pad5] [line 306, size 64, align 64, offset 1472] [from size_t]
!64 = metadata !{i32 786454, metadata !16, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !65} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!65 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!66 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_mode", i32 308, i64 32, i64 32, i64 1536, i32 0, metadata !19} ; [ DW_TAG_member ] [_mode] [line 308, size 32, align 32, offset 1536] [from int]
!67 = metadata !{i32 786445, metadata !16, metadata !15, metadata !"_unused2", i32 310, i64 160, i64 8, i64 1568, i32 0, metadata !68} ; [ DW_TAG_member ] [_unused2] [line 310, size 160, align 8, offset 1568] [from ]
!68 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 160, i64 8, i32 0, i32 0, metadata !22, metadata !69, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 160, align 8, offset 0] [from char]
!69 = metadata !{metadata !70}
!70 = metadata !{i32 786465, i64 0, i64 20}       ; [ DW_TAG_subrange_type ] [0, 19]
!71 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !72} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from file_header]
!72 = metadata !{i32 786454, metadata !1, null, metadata !"file_header", i32 20, i64 0, i64 0, i64 0, i32 0, metadata !73} ; [ DW_TAG_typedef ] [file_header] [line 20, size 0, align 0, offset 0] [from ]
!73 = metadata !{i32 786451, metadata !1, null, metadata !"", i32 14, i64 128, i64 8, i32 0, i32 0, null, metadata !74, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 14, size 128, align 8, offset 0] [def] [from ]
!74 = metadata !{metadata !75, metadata !78, metadata !79, metadata !81, metadata !82}
!75 = metadata !{i32 786445, metadata !1, metadata !73, metadata !"magic", i32 15, i64 32, i64 32, i64 0, i32 0, metadata !76} ; [ DW_TAG_member ] [magic] [line 15, size 32, align 32, offset 0] [from uint32_t]
!76 = metadata !{i32 786454, metadata !1, null, metadata !"uint32_t", i32 51, i64 0, i64 0, i64 0, i32 0, metadata !77} ; [ DW_TAG_typedef ] [uint32_t] [line 51, size 0, align 0, offset 0] [from unsigned int]
!77 = metadata !{i32 786468, null, null, metadata !"unsigned int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!78 = metadata !{i32 786445, metadata !1, metadata !73, metadata !"reserved", i32 16, i64 32, i64 32, i64 32, i32 0, metadata !76} ; [ DW_TAG_member ] [reserved] [line 16, size 32, align 32, offset 32] [from uint32_t]
!79 = metadata !{i32 786445, metadata !1, metadata !73, metadata !"num_recs", i32 17, i64 16, i64 16, i64 64, i32 0, metadata !80} ; [ DW_TAG_member ] [num_recs] [line 17, size 16, align 16, offset 64] [from uint16_t]
!80 = metadata !{i32 786454, metadata !1, null, metadata !"uint16_t", i32 49, i64 0, i64 0, i64 0, i32 0, metadata !48} ; [ DW_TAG_typedef ] [uint16_t] [line 49, size 0, align 0, offset 0] [from unsigned short]
!81 = metadata !{i32 786445, metadata !1, metadata !73, metadata !"flags", i32 18, i64 16, i64 16, i64 80, i32 0, metadata !80} ; [ DW_TAG_member ] [flags] [line 18, size 16, align 16, offset 80] [from uint16_t]
!82 = metadata !{i32 786445, metadata !1, metadata !73, metadata !"timestamp", i32 19, i64 32, i64 32, i64 96, i32 0, metadata !76} ; [ DW_TAG_member ] [timestamp] [line 19, size 32, align 32, offset 96] [from uint32_t]
!83 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"parse_record", metadata !"parse_record", metadata !"", i32 38, metadata !84, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, %struct.file_entry* (%struct._IO_FILE*)* @parse_reco
!84 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !85, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!85 = metadata !{metadata !86, metadata !13}
!86 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !87} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from file_entry]
!87 = metadata !{i32 786454, metadata !1, null, metadata !"file_entry", i32 29, i64 0, i64 0, i64 0, i32 0, metadata !88} ; [ DW_TAG_typedef ] [file_entry] [line 29, size 0, align 0, offset 0] [from ]
!88 = metadata !{i32 786451, metadata !1, null, metadata !"", i32 22, i64 192, i64 8, i32 0, i32 0, null, metadata !89, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 22, size 192, align 8, offset 0] [def] [from ]
!89 = metadata !{metadata !90, metadata !94, metadata !95}
!90 = metadata !{i32 786445, metadata !1, metadata !88, metadata !"bar", i32 23, i64 128, i64 8, i64 0, i32 0, metadata !91} ; [ DW_TAG_member ] [bar] [line 23, size 128, align 8, offset 0] [from ]
!91 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 128, i64 8, i32 0, i32 0, metadata !22, metadata !92, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 128, align 8, offset 0] [from char]
!92 = metadata !{metadata !93}
!93 = metadata !{i32 786465, i64 0, i64 16}       ; [ DW_TAG_subrange_type ] [0, 15]
!94 = metadata !{i32 786445, metadata !1, metadata !88, metadata !"type", i32 24, i64 32, i64 32, i64 128, i32 0, metadata !76} ; [ DW_TAG_member ] [type] [line 24, size 32, align 32, offset 128] [from uint32_t]
!95 = metadata !{i32 786445, metadata !1, metadata !88, metadata !"data", i32 28, i64 32, i64 8, i64 160, i32 0, metadata !96} ; [ DW_TAG_member ] [data] [line 28, size 32, align 8, offset 160] [from ]
!96 = metadata !{i32 786455, metadata !1, metadata !88, metadata !"", i32 25, i64 32, i64 8, i64 0, i32 0, null, metadata !97, i32 0, null, null, null} ; [ DW_TAG_union_type ] [line 25, size 32, align 8, offset 0] [def] [from ]
!97 = metadata !{metadata !98, metadata !100}
!98 = metadata !{i32 786445, metadata !1, metadata !96, metadata !"fdata", i32 26, i64 32, i64 32, i64 0, i32 0, metadata !99} ; [ DW_TAG_member ] [fdata] [line 26, size 32, align 32, offset 0] [from float]
!99 = metadata !{i32 786468, null, null, metadata !"float", i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!100 = metadata !{i32 786445, metadata !1, metadata !96, metadata !"intdata", i32 27, i64 32, i64 32, i64 0, i32 0, metadata !76} ; [ DW_TAG_member ] [intdata] [line 27, size 32, align 32, offset 0] [from uint32_t]
!101 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"consume_record", metadata !"consume_record", metadata !"", i32 45, metadata !102, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (%struct.file_entry*)* @consume_record, n
!102 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !103, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!103 = metadata !{null, metadata !86}
!104 = metadata !{i32 786478, metadata !1, metadata !10, metadata !"main", metadata !"main", metadata !"", i32 60, metadata !105, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i8**)* @main, null, null, metadata !7, i32 60} ; [ DW_TA
!105 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !106, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!106 = metadata !{metadata !19, metadata !19, metadata !107}
!107 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !21} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!108 = metadata !{i32 786449, metadata !109, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !110, metadata !7, metadata !7, metadata !""} 
!109 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/klee_div_zero_check.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!110 = metadata !{metadata !111}
!111 = metadata !{i32 786478, metadata !109, metadata !112, metadata !"klee_div_zero_check", metadata !"klee_div_zero_check", metadata !"", i32 12, metadata !113, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64)* @klee_div_zero_check, 
!112 = metadata !{i32 786473, metadata !109}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_div_zero_check.c]
!113 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !114, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!114 = metadata !{null, metadata !115}
!115 = metadata !{i32 786468, null, null, metadata !"long long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!116 = metadata !{metadata !117}
!117 = metadata !{i32 786689, metadata !111, metadata !"z", metadata !112, i32 16777228, metadata !115, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 12]
!118 = metadata !{i32 786449, metadata !119, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !120, metadata !7, metadata !7, metadata !""} 
!119 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/klee_int.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!120 = metadata !{metadata !121}
!121 = metadata !{i32 786478, metadata !119, metadata !122, metadata !"klee_int", metadata !"klee_int", metadata !"", i32 13, metadata !123, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @klee_int, null, null, metadata !127, i32 13}
!122 = metadata !{i32 786473, metadata !119}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_int.c]
!123 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !124, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!124 = metadata !{metadata !19, metadata !125}
!125 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !126} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!126 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !22} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!127 = metadata !{metadata !128, metadata !129}
!128 = metadata !{i32 786689, metadata !121, metadata !"name", metadata !122, i32 16777229, metadata !125, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!129 = metadata !{i32 786688, metadata !121, metadata !"x", metadata !122, i32 14, metadata !19, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!130 = metadata !{i32 786449, metadata !131, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !132, metadata !7, metadata !7, metadata !""} 
!131 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/klee_overshift_check.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!132 = metadata !{metadata !133}
!133 = metadata !{i32 786478, metadata !131, metadata !134, metadata !"klee_overshift_check", metadata !"klee_overshift_check", metadata !"", i32 20, metadata !135, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64, i64)* @klee_overshift
!134 = metadata !{i32 786473, metadata !131}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_overshift_check.c]
!135 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !136, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!136 = metadata !{null, metadata !137, metadata !137}
!137 = metadata !{i32 786468, null, null, metadata !"long long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!138 = metadata !{metadata !139, metadata !140}
!139 = metadata !{i32 786689, metadata !133, metadata !"bitWidth", metadata !134, i32 16777236, metadata !137, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bitWidth] [line 20]
!140 = metadata !{i32 786689, metadata !133, metadata !"shift", metadata !134, i32 33554452, metadata !137, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [shift] [line 20]
!141 = metadata !{i32 786449, metadata !142, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !143, metadata !7, metadata !7, metadata !""} 
!142 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/klee_range.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!143 = metadata !{metadata !144}
!144 = metadata !{i32 786478, metadata !142, metadata !145, metadata !"klee_range", metadata !"klee_range", metadata !"", i32 13, metadata !146, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, i8*)* @klee_range, null, null, metada
!145 = metadata !{i32 786473, metadata !142}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_range.c]
!146 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !147, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!147 = metadata !{metadata !19, metadata !19, metadata !19, metadata !125}
!148 = metadata !{metadata !149, metadata !150, metadata !151, metadata !152}
!149 = metadata !{i32 786689, metadata !144, metadata !"start", metadata !145, i32 16777229, metadata !19, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start] [line 13]
!150 = metadata !{i32 786689, metadata !144, metadata !"end", metadata !145, i32 33554445, metadata !19, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [end] [line 13]
!151 = metadata !{i32 786689, metadata !144, metadata !"name", metadata !145, i32 50331661, metadata !125, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!152 = metadata !{i32 786688, metadata !144, metadata !"x", metadata !145, i32 14, metadata !19, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!153 = metadata !{i32 786449, metadata !154, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !155, metadata !7, metadata !7, metadata !""} 
!154 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/memcpy.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!155 = metadata !{metadata !156}
!156 = metadata !{i32 786478, metadata !154, metadata !157, metadata !"memcpy", metadata !"memcpy", metadata !"", i32 12, metadata !158, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memcpy, null, null, metadata !163, i32
!157 = metadata !{i32 786473, metadata !154}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/memcpy.c]
!158 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !159, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!159 = metadata !{metadata !56, metadata !56, metadata !160, metadata !162}
!160 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !161} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!161 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!162 = metadata !{i32 786454, metadata !154, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !65} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!163 = metadata !{metadata !164, metadata !165, metadata !166, metadata !167, metadata !168}
!164 = metadata !{i32 786689, metadata !156, metadata !"destaddr", metadata !157, i32 16777228, metadata !56, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 12]
!165 = metadata !{i32 786689, metadata !156, metadata !"srcaddr", metadata !157, i32 33554444, metadata !160, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 12]
!166 = metadata !{i32 786689, metadata !156, metadata !"len", metadata !157, i32 50331660, metadata !162, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 12]
!167 = metadata !{i32 786688, metadata !156, metadata !"dest", metadata !157, i32 13, metadata !21, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 13]
!168 = metadata !{i32 786688, metadata !156, metadata !"src", metadata !157, i32 14, metadata !125, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 14]
!169 = metadata !{i32 786449, metadata !170, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !171, metadata !7, metadata !7, metadata !""} 
!170 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/memmove.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!171 = metadata !{metadata !172}
!172 = metadata !{i32 786478, metadata !170, metadata !173, metadata !"memmove", metadata !"memmove", metadata !"", i32 12, metadata !174, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memmove, null, null, metadata !177, 
!173 = metadata !{i32 786473, metadata !170}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/memmove.c]
!174 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !175, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!175 = metadata !{metadata !56, metadata !56, metadata !160, metadata !176}
!176 = metadata !{i32 786454, metadata !170, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !65} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!177 = metadata !{metadata !178, metadata !179, metadata !180, metadata !181, metadata !182}
!178 = metadata !{i32 786689, metadata !172, metadata !"dst", metadata !173, i32 16777228, metadata !56, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 12]
!179 = metadata !{i32 786689, metadata !172, metadata !"src", metadata !173, i32 33554444, metadata !160, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [src] [line 12]
!180 = metadata !{i32 786689, metadata !172, metadata !"count", metadata !173, i32 50331660, metadata !176, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 12]
!181 = metadata !{i32 786688, metadata !172, metadata !"a", metadata !173, i32 13, metadata !21, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 13]
!182 = metadata !{i32 786688, metadata !172, metadata !"b", metadata !173, i32 14, metadata !125, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 14]
!183 = metadata !{i32 786449, metadata !184, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !185, metadata !7, metadata !7, metadata !""} 
!184 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/mempcpy.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!185 = metadata !{metadata !186}
!186 = metadata !{i32 786478, metadata !184, metadata !187, metadata !"mempcpy", metadata !"mempcpy", metadata !"", i32 11, metadata !188, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @mempcpy, null, null, metadata !191, 
!187 = metadata !{i32 786473, metadata !184}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/mempcpy.c]
!188 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !189, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!189 = metadata !{metadata !56, metadata !56, metadata !160, metadata !190}
!190 = metadata !{i32 786454, metadata !184, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !65} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!191 = metadata !{metadata !192, metadata !193, metadata !194, metadata !195, metadata !196}
!192 = metadata !{i32 786689, metadata !186, metadata !"destaddr", metadata !187, i32 16777227, metadata !56, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 11]
!193 = metadata !{i32 786689, metadata !186, metadata !"srcaddr", metadata !187, i32 33554443, metadata !160, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 11]
!194 = metadata !{i32 786689, metadata !186, metadata !"len", metadata !187, i32 50331659, metadata !190, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 11]
!195 = metadata !{i32 786688, metadata !186, metadata !"dest", metadata !187, i32 12, metadata !21, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 12]
!196 = metadata !{i32 786688, metadata !186, metadata !"src", metadata !187, i32 13, metadata !125, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 13]
!197 = metadata !{i32 786449, metadata !198, i32 1, metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)", i1 true, metadata !"", i32 0, metadata !7, metadata !7, metadata !199, metadata !7, metadata !7, metadata !""} 
!198 = metadata !{metadata !"/home/klee/klee_src/runtime/Intrinsic/memset.c", metadata !"/home/klee/klee_build/klee/runtime/Intrinsic"}
!199 = metadata !{metadata !200}
!200 = metadata !{i32 786478, metadata !198, metadata !201, metadata !"memset", metadata !"memset", metadata !"", i32 11, metadata !202, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i32, i64)* @memset, null, null, metadata !205, i32
!201 = metadata !{i32 786473, metadata !198}      ; [ DW_TAG_file_type ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/memset.c]
!202 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !203, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!203 = metadata !{metadata !56, metadata !56, metadata !19, metadata !204}
!204 = metadata !{i32 786454, metadata !198, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !65} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!205 = metadata !{metadata !206, metadata !207, metadata !208, metadata !209}
!206 = metadata !{i32 786689, metadata !200, metadata !"dst", metadata !201, i32 16777227, metadata !56, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 11]
!207 = metadata !{i32 786689, metadata !200, metadata !"s", metadata !201, i32 33554443, metadata !19, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 11]
!208 = metadata !{i32 786689, metadata !200, metadata !"count", metadata !201, i32 50331659, metadata !204, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 11]
!209 = metadata !{i32 786688, metadata !200, metadata !"a", metadata !201, i32 12, metadata !210, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 12]
!210 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !211} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!211 = metadata !{i32 786485, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !22} ; [ DW_TAG_volatile_type ] [line 0, size 0, align 0, offset 0] [from char]
!212 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!213 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!214 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!215 = metadata !{i32 32, i32 0, metadata !216, null}
!216 = metadata !{i32 786443, metadata !1, metadata !9, i32 32, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/unmodified/toy/toy.c]
!217 = metadata !{i32 33, i32 0, metadata !216, null}
!218 = metadata !{i32 34, i32 0, metadata !219, null}
!219 = metadata !{i32 786443, metadata !1, metadata !9, i32 34, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/unmodified/toy/toy.c]
!220 = metadata !{i32 35, i32 0, metadata !219, null}
!221 = metadata !{i32 36, i32 0, metadata !9, null}
!222 = metadata !{i32 39, i32 0, metadata !83, null}
!223 = metadata !{i32 40, i32 0, metadata !224, null}
!224 = metadata !{i32 786443, metadata !1, metadata !83, i32 40, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/unmodified/toy/toy.c]
!225 = metadata !{i32 41, i32 0, metadata !224, null}
!226 = metadata !{i32 42, i32 0, metadata !83, null}
!227 = metadata !{i32 46, i32 0, metadata !101, null}
!228 = metadata !{i32 47, i32 0, metadata !229, null}
!229 = metadata !{i32 786443, metadata !1, metadata !101, i32 47, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/unmodified/toy/toy.c]
!230 = metadata !{i32 48, i32 0, metadata !231, null}
!231 = metadata !{i32 786443, metadata !1, metadata !229, i32 47, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/unmodified/toy/toy.c]
!232 = metadata !{i32 49, i32 0, metadata !231, null}
!233 = metadata !{i32 50, i32 0, metadata !234, null}
!234 = metadata !{i32 786443, metadata !1, metadata !229, i32 50, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/unmodified/toy/toy.c]
!235 = metadata !{i32 51, i32 0, metadata !236, null}
!236 = metadata !{i32 786443, metadata !1, metadata !234, i32 50, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/unmodified/toy/toy.c]
!237 = metadata !{i32 54, i32 0, metadata !238, null}
!238 = metadata !{i32 786443, metadata !1, metadata !234, i32 53, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/unmodified/toy/toy.c]
!239 = metadata !{i32 55, i32 0, metadata !238, null}
!240 = metadata !{i32 57, i32 0, metadata !101, null}
!241 = metadata !{i32 58, i32 0, metadata !101, null} ; [ DW_TAG_imported_module ]
!242 = metadata !{i32 63, i32 0, metadata !104, null}
!243 = metadata !{i32 66, i32 0, metadata !104, null}
!244 = metadata !{i32 67, i32 0, metadata !104, null}
!245 = metadata !{i32 70, i32 0, metadata !246, null}
!246 = metadata !{i32 786443, metadata !1, metadata !104, i32 70, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/unmodified/toy/toy.c]
!247 = metadata !{i32 71, i32 0, metadata !248, null}
!248 = metadata !{i32 786443, metadata !1, metadata !246, i32 70, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/home/klee/toy_example_distrib/unmodified/toy/toy.c]
!249 = metadata !{i32 72, i32 0, metadata !248, null}
!250 = metadata !{i32 74, i32 0, metadata !104, null}
!251 = metadata !{i32 13, i32 0, metadata !252, null}
!252 = metadata !{i32 786443, metadata !109, metadata !111, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_div_zero_check.c]
!253 = metadata !{i32 14, i32 0, metadata !252, null}
!254 = metadata !{i32 15, i32 0, metadata !111, null}
!255 = metadata !{i32 15, i32 0, metadata !121, null}
!256 = metadata !{i32 16, i32 0, metadata !121, null}
!257 = metadata !{metadata !258, metadata !258, i64 0}
!258 = metadata !{metadata !"int", metadata !259, i64 0}
!259 = metadata !{metadata !"omnipotent char", metadata !260, i64 0}
!260 = metadata !{metadata !"Simple C/C++ TBAA"}
!261 = metadata !{i32 21, i32 0, metadata !262, null}
!262 = metadata !{i32 786443, metadata !131, metadata !133, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_overshift_check.c]
!263 = metadata !{i32 27, i32 0, metadata !264, null}
!264 = metadata !{i32 786443, metadata !131, metadata !262, i32 21, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_overshift_check.c]
!265 = metadata !{i32 29, i32 0, metadata !133, null}
!266 = metadata !{i32 16, i32 0, metadata !267, null}
!267 = metadata !{i32 786443, metadata !142, metadata !144, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_range.c]
!268 = metadata !{i32 17, i32 0, metadata !267, null}
!269 = metadata !{i32 19, i32 0, metadata !270, null}
!270 = metadata !{i32 786443, metadata !142, metadata !144, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_range.c]
!271 = metadata !{i32 22, i32 0, metadata !272, null}
!272 = metadata !{i32 786443, metadata !142, metadata !270, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_range.c]
!273 = metadata !{i32 25, i32 0, metadata !274, null}
!274 = metadata !{i32 786443, metadata !142, metadata !272, i32 25, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_range.c]
!275 = metadata !{i32 26, i32 0, metadata !276, null}
!276 = metadata !{i32 786443, metadata !142, metadata !274, i32 25, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_range.c]
!277 = metadata !{i32 27, i32 0, metadata !276, null}
!278 = metadata !{i32 28, i32 0, metadata !279, null}
!279 = metadata !{i32 786443, metadata !142, metadata !274, i32 27, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/klee_range.c]
!280 = metadata !{i32 29, i32 0, metadata !279, null}
!281 = metadata !{i32 32, i32 0, metadata !272, null}
!282 = metadata !{i32 34, i32 0, metadata !144, null}
!283 = metadata !{i32 16, i32 0, metadata !156, null}
!284 = metadata !{i32 17, i32 0, metadata !156, null}
!285 = metadata !{metadata !285, metadata !286, metadata !287}
!286 = metadata !{metadata !"llvm.vectorizer.width", i32 1}
!287 = metadata !{metadata !"llvm.vectorizer.unroll", i32 1}
!288 = metadata !{metadata !259, metadata !259, i64 0}
!289 = metadata !{metadata !289, metadata !286, metadata !287}
!290 = metadata !{i32 18, i32 0, metadata !156, null}
!291 = metadata !{i32 16, i32 0, metadata !292, null}
!292 = metadata !{i32 786443, metadata !170, metadata !172, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/memmove.c]
!293 = metadata !{i32 19, i32 0, metadata !294, null}
!294 = metadata !{i32 786443, metadata !170, metadata !172, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/memmove.c]
!295 = metadata !{i32 20, i32 0, metadata !296, null}
!296 = metadata !{i32 786443, metadata !170, metadata !294, i32 19, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/memmove.c]
!297 = metadata !{metadata !297, metadata !286, metadata !287}
!298 = metadata !{metadata !298, metadata !286, metadata !287}
!299 = metadata !{i32 22, i32 0, metadata !300, null}
!300 = metadata !{i32 786443, metadata !170, metadata !294, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/klee/klee_build/klee/runtime/Intrinsic//home/klee/klee_src/runtime/Intrinsic/memmove.c]
!301 = metadata !{i32 24, i32 0, metadata !300, null}
!302 = metadata !{i32 23, i32 0, metadata !300, null}
!303 = metadata !{metadata !303, metadata !286, metadata !287}
!304 = metadata !{metadata !304, metadata !286, metadata !287}
!305 = metadata !{i32 28, i32 0, metadata !172, null}
!306 = metadata !{i32 15, i32 0, metadata !186, null}
!307 = metadata !{i32 16, i32 0, metadata !186, null}
!308 = metadata !{metadata !308, metadata !286, metadata !287}
!309 = metadata !{metadata !309, metadata !286, metadata !287}
!310 = metadata !{i32 17, i32 0, metadata !186, null}
!311 = metadata !{i32 13, i32 0, metadata !200, null}
!312 = metadata !{i32 14, i32 0, metadata !200, null}
!313 = metadata !{i32 15, i32 0, metadata !200, null}
