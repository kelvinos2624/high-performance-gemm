	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	__ZN4gemm6detail16microkernel_implEPKfS2_PfmmmNS_9BlockSizeEmmPFvS2_S2_S3_mmmE ; -- Begin function _ZN4gemm6detail16microkernel_implEPKfS2_PfmmmNS_9BlockSizeEmmPFvS2_S2_S3_mmmE
	.p2align	2
__ZN4gemm6detail16microkernel_implEPKfS2_PfmmmNS_9BlockSizeEmmPFvS2_S2_S3_mmmE: ; @_ZN4gemm6detail16microkernel_implEPKfS2_PfmmmNS_9BlockSizeEmmPFvS2_S2_S3_mmmE
Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception0
; %bb.0:
	sub	sp, sp, #336
	.cfi_def_cfa_offset 336
	stp	x28, x27, [sp, #240]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #256]            ; 16-byte Folded Spill
	stp	x24, x23, [sp, #272]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #288]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #304]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #320]            ; 16-byte Folded Spill
	add	x29, sp, #320
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	str	x0, [sp, #56]                   ; 8-byte Folded Spill
	ldr	x8, [x29, #24]
	stur	x8, [x29, #-112]                ; 8-byte Folded Spill
	cbz	x8, LBB0_69
; %bb.1:
	mov	x19, x6
	ldr	x8, [x6]
	cbz	x8, LBB0_69
; %bb.2:
	ldr	x8, [x19, #8]
	cbz	x8, LBB0_69
; %bb.3:
	ldr	x8, [x19, #16]
	cbz	x8, LBB0_69
; %bb.4:
	mov	x21, x3
	cbz	x3, LBB0_68
; %bb.5:
	cbz	x4, LBB0_68
; %bb.6:
	mov	x24, x2
	mov	x22, x1
	mul	x8, x4, x21
	stp	x5, x7, [x29, #-128]            ; 16-byte Folded Spill
	stur	x4, [x29, #-96]                 ; 8-byte Folded Spill
	cbz	x8, LBB0_8
; %bb.7:
	lsl	x1, x8, #2
	mov	x0, x24
	bl	_bzero
	ldur	x4, [x29, #-96]                 ; 8-byte Folded Reload
	ldp	x5, x7, [x29, #-128]            ; 16-byte Folded Reload
LBB0_8:
	cbz	x5, LBB0_68
; %bb.9:
	mov	x10, #0
	lsl	x20, x4, #2
	ldr	x3, [x29, #16]
	lsl	x6, x5, #2
	ldr	x8, [sp, #56]                   ; 8-byte Folded Reload
	add	x8, x8, #32
	str	x8, [sp, #32]                   ; 8-byte Folded Spill
	add	x8, x22, #32
	str	x8, [sp, #72]                   ; 8-byte Folded Spill
	lsl	x23, x4, #6
	str	x19, [sp, #16]                  ; 8-byte Folded Spill
	str	x22, [sp, #120]                 ; 8-byte Folded Spill
	stp	x6, x3, [x29, #-144]            ; 16-byte Folded Spill
	str	x21, [sp]                       ; 8-byte Folded Spill
	b	LBB0_11
LBB0_10:                                ;   in Loop: Header=BB0_11 Depth=1
	mov	x10, x11
	ldr	x21, [sp]                       ; 8-byte Folded Reload
	cmp	x11, x21
	b.hs	LBB0_68
LBB0_11:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_14 Depth 2
                                        ;       Child Loop BB0_55 Depth 3
                                        ;         Child Loop BB0_57 Depth 4
                                        ;           Child Loop BB0_61 Depth 5
                                        ;           Child Loop BB0_59 Depth 5
                                        ;           Child Loop BB0_66 Depth 5
                                        ;       Child Loop BB0_17 Depth 3
                                        ;         Child Loop BB0_19 Depth 4
                                        ;           Child Loop BB0_23 Depth 5
                                        ;             Child Loop BB0_44 Depth 6
                                        ;               Child Loop BB0_45 Depth 7
                                        ;                 Child Loop BB0_46 Depth 8
                                        ;             Child Loop BB0_36 Depth 6
                                        ;               Child Loop BB0_38 Depth 7
                                        ;                 Child Loop BB0_39 Depth 8
                                        ;                 Child Loop BB0_42 Depth 8
                                        ;             Child Loop BB0_28 Depth 6
                                        ;               Child Loop BB0_29 Depth 7
                                        ;                 Child Loop BB0_30 Depth 8
                                        ;           Child Loop BB0_51 Depth 5
	ldr	x8, [x19]
	sub	x9, x21, x10
	cmp	x9, x8
	csel	x8, x9, x8, lo
	add	x11, x8, x10
	cmp	x11, x10
	b.ls	LBB0_10
; %bb.12:                               ;   in Loop: Header=BB0_11 Depth=1
	mov	x12, #0
	str	x10, [sp, #24]                  ; 8-byte Folded Spill
	str	x11, [sp, #88]                  ; 8-byte Folded Spill
	b	LBB0_14
LBB0_13:                                ;   in Loop: Header=BB0_14 Depth=2
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	mov	x12, x8
	cmp	x8, x5
	ldr	x22, [sp, #120]                 ; 8-byte Folded Reload
	b.hs	LBB0_10
LBB0_14:                                ;   Parent Loop BB0_11 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_55 Depth 3
                                        ;         Child Loop BB0_57 Depth 4
                                        ;           Child Loop BB0_61 Depth 5
                                        ;           Child Loop BB0_59 Depth 5
                                        ;           Child Loop BB0_66 Depth 5
                                        ;       Child Loop BB0_17 Depth 3
                                        ;         Child Loop BB0_19 Depth 4
                                        ;           Child Loop BB0_23 Depth 5
                                        ;             Child Loop BB0_44 Depth 6
                                        ;               Child Loop BB0_45 Depth 7
                                        ;                 Child Loop BB0_46 Depth 8
                                        ;             Child Loop BB0_36 Depth 6
                                        ;               Child Loop BB0_38 Depth 7
                                        ;                 Child Loop BB0_39 Depth 8
                                        ;                 Child Loop BB0_42 Depth 8
                                        ;             Child Loop BB0_28 Depth 6
                                        ;               Child Loop BB0_29 Depth 7
                                        ;                 Child Loop BB0_30 Depth 8
                                        ;           Child Loop BB0_51 Depth 5
	ldr	x8, [x19, #16]
	sub	x9, x5, x12
	cmp	x9, x8
	csel	x27, x9, x8, lo
	mul	x8, x12, x4
	add	x8, x22, x8, lsl #2
	stur	x8, [x29, #-104]                ; 8-byte Folded Spill
	ldr	x8, [sp, #56]                   ; 8-byte Folded Reload
	add	x8, x8, x12, lsl #2
	str	x8, [sp, #96]                   ; 8-byte Folded Spill
	add	x8, x27, x12
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	cmp	x12, x8
	b.hs	LBB0_53
; %bb.15:                               ;   in Loop: Header=BB0_14 Depth=2
	mov	x13, #0
	and	x28, x27, #0xfffffffffffffff0
	add	x8, x12, x28
	stp	x8, x12, [sp, #40]              ; 16-byte Folded Spill
	mul	x9, x4, x12
	str	x9, [sp, #136]                  ; 8-byte Folded Spill
	sub	x21, x27, x28
	mul	x8, x4, x8
	add	x8, x22, x8, lsl #2
	str	x8, [sp, #80]                   ; 8-byte Folded Spill
	b	LBB0_17
LBB0_16:                                ;   in Loop: Header=BB0_17 Depth=3
	mov	x13, x30
	cmp	x30, x4
	ldp	x19, x10, [sp, #16]             ; 16-byte Folded Reload
	b.hs	LBB0_13
LBB0_17:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB0_19 Depth 4
                                        ;           Child Loop BB0_23 Depth 5
                                        ;             Child Loop BB0_44 Depth 6
                                        ;               Child Loop BB0_45 Depth 7
                                        ;                 Child Loop BB0_46 Depth 8
                                        ;             Child Loop BB0_36 Depth 6
                                        ;               Child Loop BB0_38 Depth 7
                                        ;                 Child Loop BB0_39 Depth 8
                                        ;                 Child Loop BB0_42 Depth 8
                                        ;             Child Loop BB0_28 Depth 6
                                        ;               Child Loop BB0_29 Depth 7
                                        ;                 Child Loop BB0_30 Depth 8
                                        ;           Child Loop BB0_51 Depth 5
	ldr	x8, [x19, #8]
	sub	x9, x4, x13
	cmp	x9, x8
	csel	x8, x9, x8, lo
	add	x30, x8, x13
	cmp	x30, x13
	mov	x19, x10
	str	x13, [sp, #64]                  ; 8-byte Folded Spill
	str	x30, [sp, #144]                 ; 8-byte Folded Spill
	b.hi	LBB0_19
	b	LBB0_16
LBB0_18:                                ;   in Loop: Header=BB0_19 Depth=4
	add	x19, x26, x19
	ldr	x11, [sp, #88]                  ; 8-byte Folded Reload
	cmp	x11, x19
	ldr	x13, [sp, #64]                  ; 8-byte Folded Reload
	b.ls	LBB0_16
LBB0_19:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_17 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB0_23 Depth 5
                                        ;             Child Loop BB0_44 Depth 6
                                        ;               Child Loop BB0_45 Depth 7
                                        ;                 Child Loop BB0_46 Depth 8
                                        ;             Child Loop BB0_36 Depth 6
                                        ;               Child Loop BB0_38 Depth 7
                                        ;                 Child Loop BB0_39 Depth 8
                                        ;                 Child Loop BB0_42 Depth 8
                                        ;             Child Loop BB0_28 Depth 6
                                        ;               Child Loop BB0_29 Depth 7
                                        ;                 Child Loop BB0_30 Depth 8
                                        ;           Child Loop BB0_51 Depth 5
	sub	x12, x11, x19
	cmp	x12, x7
	csel	x26, x12, x7, lo
	mul	x8, x19, x5
	ldr	x9, [sp, #96]                   ; 8-byte Folded Reload
	add	x10, x9, x8, lsl #2
	mul	x8, x19, x4
	add	x8, x24, x8, lsl #2
	stp	x8, x10, [sp, #152]             ; 16-byte Folded Spill
	cbz	x26, LBB0_49
; %bb.20:                               ;   in Loop: Header=BB0_19 Depth=4
	mul	x8, x5, x19
	ldp	x9, x10, [sp, #48]              ; 16-byte Folded Reload
	add	x9, x9, x8
	lsl	x9, x9, #2
	add	x11, x10, x9
	str	x11, [sp, #128]                 ; 8-byte Folded Spill
	ldr	x11, [sp, #32]                  ; 8-byte Folded Reload
	add	x9, x11, x9
	str	x9, [sp, #112]                  ; 8-byte Folded Spill
	ldr	x9, [sp, #40]                   ; 8-byte Folded Reload
	add	x8, x9, x8
	add	x8, x10, x8, lsl #2
	str	x8, [sp, #104]                  ; 8-byte Folded Spill
	mov	x22, x13
	stur	x12, [x29, #-152]               ; 8-byte Folded Spill
	b	LBB0_23
LBB0_21:                                ;   in Loop: Header=BB0_23 Depth=5
	lsl	x8, x22, #2
	ldp	x9, x4, [x29, #-104]            ; 16-byte Folded Reload
	add	x1, x9, x8
	ldp	x9, x0, [sp, #152]              ; 16-byte Folded Reload
	add	x2, x9, x8
	mov	x3, x5
	mov	x5, x27
	ldur	x8, [x29, #-112]                ; 8-byte Folded Reload
	blr	x8
	ldr	x30, [sp, #144]                 ; 8-byte Folded Reload
	ldp	x6, x3, [x29, #-144]            ; 16-byte Folded Reload
	ldur	x4, [x29, #-96]                 ; 8-byte Folded Reload
	ldp	x5, x7, [x29, #-128]            ; 16-byte Folded Reload
LBB0_22:                                ;   in Loop: Header=BB0_23 Depth=5
	add	x22, x25, x22
	cmp	x30, x22
	ldur	x12, [x29, #-152]               ; 8-byte Folded Reload
	b.ls	LBB0_18
LBB0_23:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_17 Depth=3
                                        ;         Parent Loop BB0_19 Depth=4
                                        ; =>        This Loop Header: Depth=5
                                        ;             Child Loop BB0_44 Depth 6
                                        ;               Child Loop BB0_45 Depth 7
                                        ;                 Child Loop BB0_46 Depth 8
                                        ;             Child Loop BB0_36 Depth 6
                                        ;               Child Loop BB0_38 Depth 7
                                        ;                 Child Loop BB0_39 Depth 8
                                        ;                 Child Loop BB0_42 Depth 8
                                        ;             Child Loop BB0_28 Depth 6
                                        ;               Child Loop BB0_29 Depth 7
                                        ;                 Child Loop BB0_30 Depth 8
	sub	x8, x30, x22
	cmp	x8, x3
	csel	x25, x8, x3, lo
	cmp	x12, x7
	b.lo	LBB0_25
; %bb.24:                               ;   in Loop: Header=BB0_23 Depth=5
	cmp	x8, x3
	b.hs	LBB0_21
LBB0_25:                                ;   in Loop: Header=BB0_23 Depth=5
	cbz	x25, LBB0_22
; %bb.26:                               ;   in Loop: Header=BB0_23 Depth=5
	cmp	x27, #15
	b.hi	LBB0_33
; %bb.27:                               ;   in Loop: Header=BB0_23 Depth=5
	mov	x8, #0
	ldr	x9, [sp, #136]                  ; 8-byte Folded Reload
	add	x9, x9, x22
	ldr	x10, [sp, #120]                 ; 8-byte Folded Reload
	add	x9, x10, x9, lsl #2
	ldr	x10, [sp, #128]                 ; 8-byte Folded Reload
LBB0_28:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_17 Depth=3
                                        ;         Parent Loop BB0_19 Depth=4
                                        ;           Parent Loop BB0_23 Depth=5
                                        ; =>          This Loop Header: Depth=6
                                        ;               Child Loop BB0_29 Depth 7
                                        ;                 Child Loop BB0_30 Depth 8
	mov	x11, #0
	add	x12, x8, x19
	mul	x12, x12, x4
	mov	x13, x9
LBB0_29:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_17 Depth=3
                                        ;         Parent Loop BB0_19 Depth=4
                                        ;           Parent Loop BB0_23 Depth=5
                                        ;             Parent Loop BB0_28 Depth=6
                                        ; =>            This Loop Header: Depth=7
                                        ;                 Child Loop BB0_30 Depth 8
	add	x14, x11, x22
	add	x14, x14, x12
	ldr	s0, [x24, x14, lsl #2]
	mov	x15, x10
	mov	x16, x13
	mov	x17, x27
LBB0_30:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_17 Depth=3
                                        ;         Parent Loop BB0_19 Depth=4
                                        ;           Parent Loop BB0_23 Depth=5
                                        ;             Parent Loop BB0_28 Depth=6
                                        ;               Parent Loop BB0_29 Depth=7
                                        ; =>              This Inner Loop Header: Depth=8
	ldr	s1, [x15], #4
	ldr	s2, [x16]
	fmadd	s0, s1, s2, s0
	add	x16, x16, x20
	subs	x17, x17, #1
	b.ne	LBB0_30
; %bb.31:                               ;   in Loop: Header=BB0_29 Depth=7
	str	s0, [x24, x14, lsl #2]
	add	x11, x11, #1
	add	x13, x13, #4
	cmp	x11, x25
	b.ne	LBB0_29
; %bb.32:                               ;   in Loop: Header=BB0_28 Depth=6
	add	x8, x8, #1
	add	x10, x10, x6
	cmp	x8, x26
	b.ne	LBB0_28
	b	LBB0_22
LBB0_33:                                ;   in Loop: Header=BB0_23 Depth=5
	cmp	x4, #1
	b.ne	LBB0_43
; %bb.34:                               ;   in Loop: Header=BB0_23 Depth=5
	mov	x8, #0
	ldr	x9, [sp, #136]                  ; 8-byte Folded Reload
	add	x9, x9, x22
	ldr	x10, [sp, #72]                  ; 8-byte Folded Reload
	add	x9, x10, x9, lsl #2
	ldr	x10, [sp, #80]                  ; 8-byte Folded Reload
	add	x10, x10, x22, lsl #2
	ldp	x11, x12, [sp, #104]            ; 16-byte Folded Reload
	b	LBB0_36
LBB0_35:                                ;   in Loop: Header=BB0_36 Depth=6
	add	x8, x8, #1
	add	x12, x12, x6
	add	x11, x11, x6
	cmp	x8, x26
	b.eq	LBB0_22
LBB0_36:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_17 Depth=3
                                        ;         Parent Loop BB0_19 Depth=4
                                        ;           Parent Loop BB0_23 Depth=5
                                        ; =>          This Loop Header: Depth=6
                                        ;               Child Loop BB0_38 Depth 7
                                        ;                 Child Loop BB0_39 Depth 8
                                        ;                 Child Loop BB0_42 Depth 8
	mov	x13, #0
	add	x14, x8, x19
	mul	x14, x14, x4
	mov	x15, x10
	mov	x16, x9
	b	LBB0_38
LBB0_37:                                ;   in Loop: Header=BB0_38 Depth=7
	str	s0, [x24, x17, lsl #2]
	add	x13, x13, #1
	add	x16, x16, #4
	add	x15, x15, #4
	cmp	x13, x25
	b.eq	LBB0_35
LBB0_38:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_17 Depth=3
                                        ;         Parent Loop BB0_19 Depth=4
                                        ;           Parent Loop BB0_23 Depth=5
                                        ;             Parent Loop BB0_36 Depth=6
                                        ; =>            This Loop Header: Depth=7
                                        ;                 Child Loop BB0_39 Depth 8
                                        ;                 Child Loop BB0_42 Depth 8
	add	x17, x13, x22
	add	x17, x17, x14
	ldr	s0, [x24, x17, lsl #2]
	mov	x0, x16
	mov	x1, x12
	mov	x2, x28
LBB0_39:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_17 Depth=3
                                        ;         Parent Loop BB0_19 Depth=4
                                        ;           Parent Loop BB0_23 Depth=5
                                        ;             Parent Loop BB0_36 Depth=6
                                        ;               Parent Loop BB0_38 Depth=7
                                        ; =>              This Inner Loop Header: Depth=8
	ldp	q1, q2, [x1, #-32]
	ldp	q3, q4, [x1], #64
	ldp	q5, q6, [x0, #-32]
	ldp	q7, q16, [x0]
	fmul.4s	v1, v1, v5
	mov	s5, v1[3]
	mov	s17, v1[2]
	mov	s18, v1[1]
	fmul.4s	v2, v2, v6
	mov	s6, v2[3]
	mov	s19, v2[2]
	mov	s20, v2[1]
	fmul.4s	v3, v3, v7
	mov	s7, v3[3]
	mov	s21, v3[2]
	mov	s22, v3[1]
	fmul.4s	v4, v4, v16
	mov	s16, v4[3]
	mov	s23, v4[2]
	mov	s24, v4[1]
	fadd	s0, s0, s1
	fadd	s0, s0, s18
	fadd	s0, s0, s17
	fadd	s0, s0, s5
	fadd	s0, s0, s2
	fadd	s0, s0, s20
	fadd	s0, s0, s19
	fadd	s0, s0, s6
	fadd	s0, s0, s3
	fadd	s0, s0, s22
	fadd	s0, s0, s21
	fadd	s0, s0, s7
	fadd	s0, s0, s4
	fadd	s0, s0, s24
	fadd	s0, s0, s23
	fadd	s0, s0, s16
	add	x0, x0, x23
	subs	x2, x2, #16
	b.ne	LBB0_39
; %bb.40:                               ;   in Loop: Header=BB0_38 Depth=7
	cmp	x27, x28
	b.eq	LBB0_37
; %bb.41:                               ;   in Loop: Header=BB0_38 Depth=7
	mov	x0, x11
	mov	x1, x15
	mov	x2, x21
LBB0_42:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_17 Depth=3
                                        ;         Parent Loop BB0_19 Depth=4
                                        ;           Parent Loop BB0_23 Depth=5
                                        ;             Parent Loop BB0_36 Depth=6
                                        ;               Parent Loop BB0_38 Depth=7
                                        ; =>              This Inner Loop Header: Depth=8
	ldr	s1, [x0], #4
	ldr	s2, [x1]
	fmadd	s0, s1, s2, s0
	add	x1, x1, x20
	subs	x2, x2, #1
	b.ne	LBB0_42
	b	LBB0_37
LBB0_43:                                ;   in Loop: Header=BB0_23 Depth=5
	mov	x8, #0
	ldr	x9, [sp, #136]                  ; 8-byte Folded Reload
	add	x9, x9, x22
	ldr	x10, [sp, #120]                 ; 8-byte Folded Reload
	add	x9, x10, x9, lsl #2
	ldr	x10, [sp, #128]                 ; 8-byte Folded Reload
LBB0_44:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_17 Depth=3
                                        ;         Parent Loop BB0_19 Depth=4
                                        ;           Parent Loop BB0_23 Depth=5
                                        ; =>          This Loop Header: Depth=6
                                        ;               Child Loop BB0_45 Depth 7
                                        ;                 Child Loop BB0_46 Depth 8
	mov	x11, #0
	add	x12, x8, x19
	mul	x12, x12, x4
	mov	x13, x9
LBB0_45:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_17 Depth=3
                                        ;         Parent Loop BB0_19 Depth=4
                                        ;           Parent Loop BB0_23 Depth=5
                                        ;             Parent Loop BB0_44 Depth=6
                                        ; =>            This Loop Header: Depth=7
                                        ;                 Child Loop BB0_46 Depth 8
	add	x14, x11, x22
	add	x14, x14, x12
	ldr	s0, [x24, x14, lsl #2]
	mov	x15, x10
	mov	x16, x13
	mov	x17, x27
LBB0_46:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_17 Depth=3
                                        ;         Parent Loop BB0_19 Depth=4
                                        ;           Parent Loop BB0_23 Depth=5
                                        ;             Parent Loop BB0_44 Depth=6
                                        ;               Parent Loop BB0_45 Depth=7
                                        ; =>              This Inner Loop Header: Depth=8
	ldr	s1, [x15], #4
	ldr	s2, [x16]
	fmadd	s0, s1, s2, s0
	add	x16, x16, x20
	subs	x17, x17, #1
	b.ne	LBB0_46
; %bb.47:                               ;   in Loop: Header=BB0_45 Depth=7
	str	s0, [x24, x14, lsl #2]
	add	x11, x11, #1
	add	x13, x13, #4
	cmp	x11, x25
	b.ne	LBB0_45
; %bb.48:                               ;   in Loop: Header=BB0_44 Depth=6
	add	x8, x8, #1
	add	x10, x10, x6
	cmp	x8, x26
	b.ne	LBB0_44
	b	LBB0_22
LBB0_49:                                ;   in Loop: Header=BB0_19 Depth=4
	mov	x22, x13
	cmp	x12, x7
	b.hs	LBB0_51
	b	LBB0_18
LBB0_50:                                ;   in Loop: Header=BB0_51 Depth=5
	add	x22, x25, x22
	cmp	x30, x22
	b.ls	LBB0_18
LBB0_51:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_17 Depth=3
                                        ;         Parent Loop BB0_19 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	sub	x8, x30, x22
	cmp	x8, x3
	csel	x25, x8, x3, lo
	b.lo	LBB0_50
; %bb.52:                               ;   in Loop: Header=BB0_51 Depth=5
	lsl	x8, x22, #2
	ldp	x9, x4, [x29, #-104]            ; 16-byte Folded Reload
	add	x1, x9, x8
	ldp	x9, x0, [sp, #152]              ; 16-byte Folded Reload
	add	x2, x9, x8
	mov	x3, x5
	mov	x5, x27
	ldur	x8, [x29, #-112]                ; 8-byte Folded Reload
	blr	x8
	ldr	x30, [sp, #144]                 ; 8-byte Folded Reload
	ldp	x6, x3, [x29, #-144]            ; 16-byte Folded Reload
	ldur	x4, [x29, #-96]                 ; 8-byte Folded Reload
	ldp	x5, x7, [x29, #-128]            ; 16-byte Folded Reload
	b	LBB0_50
LBB0_53:                                ;   in Loop: Header=BB0_14 Depth=2
	mov	x12, #0
	b	LBB0_55
LBB0_54:                                ;   in Loop: Header=BB0_55 Depth=3
	mov	x12, x21
	cmp	x21, x4
	ldp	x19, x10, [sp, #16]             ; 16-byte Folded Reload
	b.hs	LBB0_13
LBB0_55:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB0_57 Depth 4
                                        ;           Child Loop BB0_61 Depth 5
                                        ;           Child Loop BB0_59 Depth 5
                                        ;           Child Loop BB0_66 Depth 5
	ldr	x8, [x19, #8]
	sub	x9, x4, x12
	cmp	x9, x8
	csel	x8, x9, x8, lo
	add	x21, x8, x12
	str	x12, [sp, #160]                 ; 8-byte Folded Spill
	cmp	x21, x12
	mov	x22, x10
	b.hi	LBB0_57
	b	LBB0_54
LBB0_56:                                ;   in Loop: Header=BB0_57 Depth=4
	ldur	x8, [x29, #-152]                ; 8-byte Folded Reload
	add	x22, x8, x22
	ldr	x11, [sp, #88]                  ; 8-byte Folded Reload
	cmp	x11, x22
	b.ls	LBB0_54
LBB0_57:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_55 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB0_61 Depth 5
                                        ;           Child Loop BB0_59 Depth 5
                                        ;           Child Loop BB0_66 Depth 5
	sub	x8, x11, x22
	cmp	x8, x7
	csel	x11, x8, x7, lo
	mul	x9, x22, x5
	ldr	x10, [sp, #96]                  ; 8-byte Folded Reload
	add	x28, x10, x9, lsl #2
	mul	x9, x22, x4
	add	x26, x24, x9, lsl #2
	stur	x11, [x29, #-152]               ; 8-byte Folded Spill
	cbz	x11, LBB0_63
; %bb.58:                               ;   in Loop: Header=BB0_57 Depth=4
	ldr	x9, [sp, #160]                  ; 8-byte Folded Reload
	mov	x19, x9
	cmp	x8, x7
	b.hs	LBB0_61
LBB0_59:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_55 Depth=3
                                        ;         Parent Loop BB0_57 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	sub	x8, x21, x9
	cmp	x8, x3
	csel	x8, x8, x3, lo
	add	x9, x8, x9
	cmp	x21, x9
	b.hi	LBB0_59
	b	LBB0_56
LBB0_60:                                ;   in Loop: Header=BB0_61 Depth=5
	add	x19, x25, x19
	cmp	x21, x19
	b.ls	LBB0_56
LBB0_61:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_55 Depth=3
                                        ;         Parent Loop BB0_57 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	sub	x8, x21, x19
	cmp	x8, x3
	csel	x25, x8, x3, lo
	b.lo	LBB0_60
; %bb.62:                               ;   in Loop: Header=BB0_61 Depth=5
	lsl	x8, x19, #2
	ldp	x9, x4, [x29, #-104]            ; 16-byte Folded Reload
	add	x1, x9, x8
	add	x2, x26, x8
	mov	x0, x28
	mov	x3, x5
	mov	x5, x27
	ldur	x8, [x29, #-112]                ; 8-byte Folded Reload
	blr	x8
	ldp	x6, x3, [x29, #-144]            ; 16-byte Folded Reload
	ldur	x4, [x29, #-96]                 ; 8-byte Folded Reload
	ldp	x5, x7, [x29, #-128]            ; 16-byte Folded Reload
	b	LBB0_60
LBB0_63:                                ;   in Loop: Header=BB0_57 Depth=4
	cmp	x8, x7
	b.lo	LBB0_56
; %bb.64:                               ;   in Loop: Header=BB0_57 Depth=4
	ldr	x19, [sp, #160]                 ; 8-byte Folded Reload
	b	LBB0_66
LBB0_65:                                ;   in Loop: Header=BB0_66 Depth=5
	add	x19, x25, x19
	cmp	x21, x19
	b.ls	LBB0_56
LBB0_66:                                ;   Parent Loop BB0_11 Depth=1
                                        ;     Parent Loop BB0_14 Depth=2
                                        ;       Parent Loop BB0_55 Depth=3
                                        ;         Parent Loop BB0_57 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	sub	x8, x21, x19
	cmp	x8, x3
	csel	x25, x8, x3, lo
	b.lo	LBB0_65
; %bb.67:                               ;   in Loop: Header=BB0_66 Depth=5
	lsl	x8, x19, #2
	ldp	x9, x4, [x29, #-104]            ; 16-byte Folded Reload
	add	x1, x9, x8
	add	x2, x26, x8
	mov	x0, x28
	mov	x3, x5
	mov	x5, x27
	ldur	x8, [x29, #-112]                ; 8-byte Folded Reload
	blr	x8
	ldp	x6, x3, [x29, #-144]            ; 16-byte Folded Reload
	ldur	x4, [x29, #-96]                 ; 8-byte Folded Reload
	ldp	x5, x7, [x29, #-128]            ; 16-byte Folded Reload
	b	LBB0_65
LBB0_68:
	ldp	x29, x30, [sp, #320]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #304]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #288]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #272]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #256]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #240]            ; 16-byte Folded Reload
	add	sp, sp, #336
	ret
LBB0_69:
	mov	w0, #16
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp0:
Lloh0:
	adrp	x1, l_.str@PAGE
Lloh1:
	add	x1, x1, l_.str@PAGEOFF
	bl	__ZNSt16invalid_argumentC1B6v15006EPKc
Ltmp1:
; %bb.70:
Lloh2:
	adrp	x1, __ZTISt16invalid_argument@GOTPAGE
Lloh3:
	ldr	x1, [x1, __ZTISt16invalid_argument@GOTPAGEOFF]
Lloh4:
	adrp	x2, __ZNSt16invalid_argumentD1Ev@GOTPAGE
Lloh5:
	ldr	x2, [x2, __ZNSt16invalid_argumentD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
LBB0_71:
Ltmp2:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh0, Lloh1
	.loh AdrpLdrGot	Lloh4, Lloh5
	.loh AdrpLdrGot	Lloh2, Lloh3
Lfunc_end0:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table0:
Lexception0:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end0-Lcst_begin0
Lcst_begin0:
	.uleb128 Lfunc_begin0-Lfunc_begin0      ; >> Call Site 1 <<
	.uleb128 Ltmp0-Lfunc_begin0             ;   Call between Lfunc_begin0 and Ltmp0
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp0-Lfunc_begin0             ; >> Call Site 2 <<
	.uleb128 Ltmp1-Ltmp0                    ;   Call between Ltmp0 and Ltmp1
	.uleb128 Ltmp2-Lfunc_begin0             ;     jumps to Ltmp2
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp1-Lfunc_begin0             ; >> Call Site 3 <<
	.uleb128 Lfunc_end0-Ltmp1               ;   Call between Ltmp1 and Lfunc_end0
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end0:
	.p2align	2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt16invalid_argumentC1B6v15006EPKc ; -- Begin function _ZNSt16invalid_argumentC1B6v15006EPKc
	.globl	__ZNSt16invalid_argumentC1B6v15006EPKc
	.weak_def_can_be_hidden	__ZNSt16invalid_argumentC1B6v15006EPKc
	.p2align	2
__ZNSt16invalid_argumentC1B6v15006EPKc: ; @_ZNSt16invalid_argumentC1B6v15006EPKc
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	__ZNSt11logic_errorC2EPKc
Lloh6:
	adrp	x8, __ZTVSt16invalid_argument@GOTPAGE
Lloh7:
	ldr	x8, [x8, __ZTVSt16invalid_argument@GOTPAGEOFF]
	add	x8, x8, #16
	str	x8, [x0]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh6, Lloh7
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"Unsupported microtile or zero block dimension"

.subsections_via_symbols
