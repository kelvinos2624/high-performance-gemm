	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	__ZN4gemm9naive_ijkEPKfS1_Pfmmm ; -- Begin function _ZN4gemm9naive_ijkEPKfS1_Pfmmm
	.p2align	2
__ZN4gemm9naive_ijkEPKfS1_Pfmmm:        ; @_ZN4gemm9naive_ijkEPKfS1_Pfmmm
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	cbz	x3, LBB0_10
; %bb.1:
	cbz	x4, LBB0_10
; %bb.2:
	cbz	x5, LBB0_11
; %bb.3:
	cmp	x5, #15
	b.hi	LBB0_12
; %bb.4:
	mov	x8, #0
	lsl	x9, x4, #2
	lsl	x10, x5, #2
LBB0_5:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_6 Depth 2
                                        ;       Child Loop BB0_7 Depth 3
	mov	x11, #0
	mul	x12, x8, x4
	mov	x13, x1
LBB0_6:                                 ;   Parent Loop BB0_5 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_7 Depth 3
	movi	d0, #0000000000000000
	mov	x14, x0
	mov	x15, x13
	mov	x16, x5
LBB0_7:                                 ;   Parent Loop BB0_5 Depth=1
                                        ;     Parent Loop BB0_6 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x14], #4
	ldr	s2, [x15]
	fmadd	s0, s1, s2, s0
	add	x15, x15, x9
	subs	x16, x16, #1
	b.ne	LBB0_7
; %bb.8:                                ;   in Loop: Header=BB0_6 Depth=2
	add	x14, x11, x12
	str	s0, [x2, x14, lsl #2]
	add	x11, x11, #1
	add	x13, x13, #4
	cmp	x11, x4
	b.ne	LBB0_6
; %bb.9:                                ;   in Loop: Header=BB0_5 Depth=1
	add	x8, x8, #1
	add	x0, x0, x10
	cmp	x8, x3
	b.ne	LBB0_5
LBB0_10:
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB0_11:
	mul	x8, x4, x3
	lsl	x1, x8, #2
	mov	x0, x2
	bl	_bzero
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB0_12:
	cmp	x4, #1
	b.ne	LBB0_20
; %bb.13:
	mov	x8, #0
	and	x9, x5, #0xfffffffffffffff0
	add	x10, x0, #32
	lsl	x11, x5, #2
	add	x12, x1, #32
	lsl	x13, x4, #6
	sub	x14, x5, x9
	lsr	x15, x5, #4
	mul	x15, x4, x15
	add	x15, x1, x15, lsl #6
	lsl	x16, x4, #2
	add	x17, x0, x9, lsl #2
	b	LBB0_15
LBB0_14:                                ;   in Loop: Header=BB0_15 Depth=1
	str	s0, [x2, x0, lsl #2]
	add	x8, x8, #1
	add	x10, x10, x11
	add	x17, x17, x11
	cmp	x8, x3
	b.eq	LBB0_10
LBB0_15:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_16 Depth 2
                                        ;     Child Loop BB0_19 Depth 2
	mul	x0, x8, x4
	movi	d0, #0000000000000000
	mov	x1, x12
	mov	x6, x10
	mov	x7, x9
LBB0_16:                                ;   Parent Loop BB0_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldp	q1, q2, [x6, #-32]
	ldp	q3, q4, [x6], #64
	ldp	q5, q6, [x1, #-32]
	ldp	q7, q16, [x1]
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
	add	x1, x1, x13
	subs	x7, x7, #16
	b.ne	LBB0_16
; %bb.17:                               ;   in Loop: Header=BB0_15 Depth=1
	cmp	x9, x5
	b.eq	LBB0_14
; %bb.18:                               ;   in Loop: Header=BB0_15 Depth=1
	mov	x1, x17
	mov	x6, x15
	mov	x7, x14
LBB0_19:                                ;   Parent Loop BB0_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	s1, [x1], #4
	ldr	s2, [x6]
	fmadd	s0, s1, s2, s0
	add	x6, x6, x16
	subs	x7, x7, #1
	b.ne	LBB0_19
	b	LBB0_14
LBB0_20:
	mov	x8, #0
	lsl	x9, x4, #2
	lsl	x10, x5, #2
LBB0_21:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_22 Depth 2
                                        ;       Child Loop BB0_23 Depth 3
	mov	x11, #0
	mul	x12, x8, x4
	mov	x13, x1
LBB0_22:                                ;   Parent Loop BB0_21 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_23 Depth 3
	movi	d0, #0000000000000000
	mov	x14, x0
	mov	x15, x13
	mov	x16, x5
LBB0_23:                                ;   Parent Loop BB0_21 Depth=1
                                        ;     Parent Loop BB0_22 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x14], #4
	ldr	s2, [x15]
	fmadd	s0, s1, s2, s0
	add	x15, x15, x9
	subs	x16, x16, #1
	b.ne	LBB0_23
; %bb.24:                               ;   in Loop: Header=BB0_22 Depth=2
	add	x14, x11, x12
	str	s0, [x2, x14, lsl #2]
	add	x11, x11, #1
	add	x13, x13, #4
	cmp	x11, x4
	b.ne	LBB0_22
; %bb.25:                               ;   in Loop: Header=BB0_21 Depth=1
	add	x8, x8, #1
	add	x0, x0, x10
	cmp	x8, x3
	b.ne	LBB0_21
	b	LBB0_10
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
