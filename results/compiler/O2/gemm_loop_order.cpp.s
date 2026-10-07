	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	__ZN4gemm3ikjEPKfS1_Pfmmm       ; -- Begin function _ZN4gemm3ikjEPKfS1_Pfmmm
	.p2align	2
__ZN4gemm3ikjEPKfS1_Pfmmm:              ; @_ZN4gemm3ikjEPKfS1_Pfmmm
	.cfi_startproc
; %bb.0:
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	cbz	x3, LBB0_17
; %bb.1:
	mov	x20, x4
	cbz	x4, LBB0_17
; %bb.2:
	mov	x19, x5
	mov	x21, x3
	mov	x22, x2
	mov	x23, x1
	mov	x24, x0
	mul	x8, x20, x3
	cbz	x8, LBB0_4
; %bb.3:
	lsl	x1, x8, #2
	mov	x0, x22
	bl	_bzero
LBB0_4:
	mov	x8, #0
	mov	x9, #0
	and	x10, x20, #0xfffffffffffffff0
	add	x11, x22, #32
	lsl	x12, x20, #2
	add	x13, x23, #32
	b	LBB0_6
LBB0_5:                                 ;   in Loop: Header=BB0_6 Depth=1
	add	x9, x9, #1
	add	x11, x11, x12
	add	x8, x8, x20
	cmp	x9, x21
	b.eq	LBB0_17
LBB0_6:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_9 Depth 2
                                        ;       Child Loop BB0_12 Depth 3
                                        ;       Child Loop BB0_16 Depth 3
	cbz	x19, LBB0_5
; %bb.7:                                ;   in Loop: Header=BB0_6 Depth=1
	mov	x14, #0
	mov	x15, #0
	mul	x17, x9, x20
	add	x16, x22, x17, lsl #2
	add	x17, x17, x20
	add	x17, x22, x17, lsl #2
	mul	x0, x9, x19
	mov	x1, x13
	b	LBB0_9
LBB0_8:                                 ;   in Loop: Header=BB0_9 Depth=2
	add	x15, x15, #1
	add	x1, x1, x12
	add	x14, x14, x20
	cmp	x15, x19
	b.eq	LBB0_5
LBB0_9:                                 ;   Parent Loop BB0_6 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_12 Depth 3
                                        ;       Child Loop BB0_16 Depth 3
	add	x2, x15, x0
	ldr	s0, [x24, x2, lsl #2]
	cmp	x20, #16
	b.lo	LBB0_14
; %bb.10:                               ;   in Loop: Header=BB0_9 Depth=2
	mul	x2, x15, x20
	add	x3, x2, x20
	add	x3, x23, x3, lsl #2
	add	x2, x23, x2, lsl #2
	cmp	x16, x3
	ccmp	x2, x17, #2, lo
	b.lo	LBB0_14
; %bb.11:                               ;   in Loop: Header=BB0_9 Depth=2
	dup.4s	v1, v0[0]
	mov	x2, x1
	mov	x3, x11
	mov	x4, x10
LBB0_12:                                ;   Parent Loop BB0_6 Depth=1
                                        ;     Parent Loop BB0_9 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldp	q2, q3, [x2, #-32]
	ldp	q4, q5, [x2], #64
	ldp	q6, q7, [x3, #-32]
	ldp	q16, q17, [x3]
	fmla.4s	v6, v2, v1
	fmla.4s	v7, v3, v1
	fmla.4s	v16, v4, v1
	fmla.4s	v17, v5, v1
	stp	q6, q7, [x3, #-32]
	stp	q16, q17, [x3], #64
	subs	x4, x4, #16
	b.ne	LBB0_12
; %bb.13:                               ;   in Loop: Header=BB0_9 Depth=2
	mov	x4, x10
	cmp	x10, x20
	b.eq	LBB0_8
	b	LBB0_15
LBB0_14:                                ;   in Loop: Header=BB0_9 Depth=2
	mov	x4, #0
LBB0_15:                                ;   in Loop: Header=BB0_9 Depth=2
	sub	x2, x20, x4
	add	x3, x8, x4
	add	x3, x22, x3, lsl #2
	add	x4, x4, x14
	add	x4, x23, x4, lsl #2
LBB0_16:                                ;   Parent Loop BB0_6 Depth=1
                                        ;     Parent Loop BB0_9 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x4], #4
	ldr	s2, [x3]
	fmadd	s1, s0, s1, s2
	str	s1, [x3], #4
	subs	x2, x2, #1
	b.ne	LBB0_16
	b	LBB0_8
LBB0_17:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm3jikEPKfS1_Pfmmm       ; -- Begin function _ZN4gemm3jikEPKfS1_Pfmmm
	.p2align	2
__ZN4gemm3jikEPKfS1_Pfmmm:              ; @_ZN4gemm3jikEPKfS1_Pfmmm
	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	cbz	x3, LBB1_15
; %bb.1:
	cbz	x4, LBB1_15
; %bb.2:
	mov	x8, #0
	cmp	x5, #15
	ccmp	x4, #1, #0, hi
	cset	w9, eq
	lsl	x10, x4, #6
	and	x11, x5, #0xfffffffffffffff0
	add	x12, x1, #32
	add	x13, x0, #32
	lsl	x14, x5, #2
	lsl	x15, x4, #2
	b	LBB1_4
LBB1_3:                                 ;   in Loop: Header=BB1_4 Depth=1
	add	x8, x8, #1
	add	x12, x12, #4
	cmp	x8, x4
	b.eq	LBB1_15
LBB1_4:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_7 Depth 2
                                        ;       Child Loop BB1_10 Depth 3
                                        ;       Child Loop BB1_14 Depth 3
	mov	x16, #0
	mov	x17, #0
	mov	x6, x13
	b	LBB1_7
LBB1_5:                                 ;   in Loop: Header=BB1_7 Depth=2
	movi	d0, #0000000000000000
LBB1_6:                                 ;   in Loop: Header=BB1_7 Depth=2
	madd	x7, x17, x4, x8
	str	s0, [x2, x7, lsl #2]
	add	x17, x17, #1
	add	x6, x6, x14
	add	x16, x16, x5
	cmp	x17, x3
	b.eq	LBB1_3
LBB1_7:                                 ;   Parent Loop BB1_4 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB1_10 Depth 3
                                        ;       Child Loop BB1_14 Depth 3
	cbz	x5, LBB1_5
; %bb.8:                                ;   in Loop: Header=BB1_7 Depth=2
	cbz	w9, LBB1_12
; %bb.9:                                ;   in Loop: Header=BB1_7 Depth=2
	movi	d0, #0000000000000000
	mov	x7, x6
	mov	x19, x12
	mov	x20, x11
LBB1_10:                                ;   Parent Loop BB1_4 Depth=1
                                        ;     Parent Loop BB1_7 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldp	q1, q2, [x7, #-32]
	ldp	q3, q4, [x7], #64
	ldp	q5, q6, [x19, #-32]
	ldp	q7, q16, [x19]
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
	add	x19, x19, x10
	subs	x20, x20, #16
	b.ne	LBB1_10
; %bb.11:                               ;   in Loop: Header=BB1_7 Depth=2
	mov	x20, x11
	cmp	x11, x5
	b.eq	LBB1_6
	b	LBB1_13
LBB1_12:                                ;   in Loop: Header=BB1_7 Depth=2
	mov	x20, #0
	movi	d0, #0000000000000000
LBB1_13:                                ;   in Loop: Header=BB1_7 Depth=2
	sub	x7, x5, x20
	madd	x19, x4, x20, x8
	add	x19, x1, x19, lsl #2
	add	x20, x20, x16
	add	x20, x0, x20, lsl #2
LBB1_14:                                ;   Parent Loop BB1_4 Depth=1
                                        ;     Parent Loop BB1_7 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x20], #4
	ldr	s2, [x19]
	fmadd	s0, s1, s2, s0
	add	x19, x19, x15
	subs	x7, x7, #1
	b.ne	LBB1_14
	b	LBB1_6
LBB1_15:
	ldp	x20, x19, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm3jkiEPKfS1_Pfmmm       ; -- Begin function _ZN4gemm3jkiEPKfS1_Pfmmm
	.p2align	2
__ZN4gemm3jkiEPKfS1_Pfmmm:              ; @_ZN4gemm3jkiEPKfS1_Pfmmm
	.cfi_startproc
; %bb.0:
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	cbz	x3, LBB2_18
; %bb.1:
	mov	x20, x4
	cbz	x4, LBB2_18
; %bb.2:
	mov	x19, x5
	mov	x21, x3
	mov	x22, x2
	mov	x23, x1
	mov	x24, x0
	mul	x8, x20, x3
	cbz	x8, LBB2_4
; %bb.3:
	lsl	x1, x8, #2
	mov	x0, x22
	bl	_bzero
LBB2_4:
	mov	x8, #0
	cmp	x20, #1
	ccmp	x19, #1, #0, eq
	cset	w9, ne
	lsl	x10, x20, #6
	lsl	x11, x19, #6
	and	x12, x21, #0xfffffffffffffff0
	add	x13, x22, #32
	add	x14, x24, #32
	lsl	x15, x20, #2
	lsl	x16, x19, #2
	b	LBB2_6
LBB2_5:                                 ;   in Loop: Header=BB2_6 Depth=1
	add	x8, x8, #1
	add	x13, x13, #4
	cmp	x8, x20
	b.eq	LBB2_18
LBB2_6:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_9 Depth 2
                                        ;       Child Loop BB2_16 Depth 3
                                        ;       Child Loop BB2_14 Depth 3
	cbz	x19, LBB2_5
; %bb.7:                                ;   in Loop: Header=BB2_6 Depth=1
	mov	x17, #0
	add	x0, x22, x8, lsl #2
	add	x1, x8, x21
	add	x1, x22, x1, lsl #2
	mov	x2, x14
	b	LBB2_9
LBB2_8:                                 ;   in Loop: Header=BB2_9 Depth=2
	add	x17, x17, #1
	add	x2, x2, #4
	cmp	x17, x19
	b.eq	LBB2_5
LBB2_9:                                 ;   Parent Loop BB2_6 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_16 Depth 3
                                        ;       Child Loop BB2_14 Depth 3
	cmp	x21, #16
	cset	w3, lo
	madd	x4, x17, x20, x8
	ldr	s0, [x23, x4, lsl #2]
	orr	w3, w3, w9
	tbnz	w3, #0, LBB2_12
; %bb.10:                               ;   in Loop: Header=BB2_9 Depth=2
	add	x3, x17, x21
	add	x3, x24, x3, lsl #2
	cmp	x0, x3
	b.hs	LBB2_15
; %bb.11:                               ;   in Loop: Header=BB2_9 Depth=2
	add	x3, x24, x17, lsl #2
	cmp	x3, x1
	b.hs	LBB2_15
LBB2_12:                                ;   in Loop: Header=BB2_9 Depth=2
	mov	x5, #0
LBB2_13:                                ;   in Loop: Header=BB2_9 Depth=2
	sub	x3, x21, x5
	madd	x4, x20, x5, x8
	add	x4, x22, x4, lsl #2
	madd	x5, x19, x5, x17
	add	x5, x24, x5, lsl #2
LBB2_14:                                ;   Parent Loop BB2_6 Depth=1
                                        ;     Parent Loop BB2_9 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x5]
	ldr	s2, [x4]
	fmadd	s1, s1, s0, s2
	str	s1, [x4]
	add	x4, x4, x15
	add	x5, x5, x16
	subs	x3, x3, #1
	b.ne	LBB2_14
	b	LBB2_8
LBB2_15:                                ;   in Loop: Header=BB2_9 Depth=2
	dup.4s	v1, v0[0]
	mov	x3, x2
	mov	x4, x13
	mov	x5, x12
LBB2_16:                                ;   Parent Loop BB2_6 Depth=1
                                        ;     Parent Loop BB2_9 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldp	q2, q3, [x3, #-32]
	ldp	q4, q5, [x3]
	ldp	q6, q7, [x4, #-32]
	ldp	q16, q17, [x4]
	fmla.4s	v6, v1, v2
	fmla.4s	v7, v1, v3
	fmla.4s	v16, v1, v4
	fmla.4s	v17, v1, v5
	stp	q6, q7, [x4, #-32]
	stp	q16, q17, [x4]
	add	x4, x4, x10
	add	x3, x3, x11
	subs	x5, x5, #16
	b.ne	LBB2_16
; %bb.17:                               ;   in Loop: Header=BB2_9 Depth=2
	mov	x5, x12
	cmp	x12, x21
	b.eq	LBB2_8
	b	LBB2_13
LBB2_18:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm3kijEPKfS1_Pfmmm       ; -- Begin function _ZN4gemm3kijEPKfS1_Pfmmm
	.p2align	2
__ZN4gemm3kijEPKfS1_Pfmmm:              ; @_ZN4gemm3kijEPKfS1_Pfmmm
	.cfi_startproc
; %bb.0:
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	cbz	x3, LBB3_17
; %bb.1:
	mov	x20, x4
	cbz	x4, LBB3_17
; %bb.2:
	mov	x19, x5
	mov	x21, x3
	mov	x22, x2
	mov	x23, x1
	mov	x24, x0
	mul	x8, x20, x3
	cbz	x8, LBB3_4
; %bb.3:
	lsl	x1, x8, #2
	mov	x0, x22
	bl	_bzero
LBB3_4:
	cbz	x19, LBB3_17
; %bb.5:
	mov	x8, #0
	mov	x9, #0
	and	x10, x20, #0xfffffffffffffff0
	add	x11, x22, #32
	lsl	x12, x20, #2
	add	x13, x23, #32
	b	LBB3_7
LBB3_6:                                 ;   in Loop: Header=BB3_7 Depth=1
	add	x9, x9, #1
	add	x13, x13, x12
	add	x8, x8, x20
	cmp	x9, x19
	b.eq	LBB3_17
LBB3_7:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_9 Depth 2
                                        ;       Child Loop BB3_12 Depth 3
                                        ;       Child Loop BB3_16 Depth 3
	mov	x14, #0
	mov	x15, #0
	mul	x17, x9, x20
	add	x16, x23, x17, lsl #2
	add	x17, x17, x20
	add	x17, x23, x17, lsl #2
	mov	x0, x11
	b	LBB3_9
LBB3_8:                                 ;   in Loop: Header=BB3_9 Depth=2
	add	x15, x15, #1
	add	x0, x0, x12
	add	x14, x14, x20
	cmp	x15, x21
	b.eq	LBB3_6
LBB3_9:                                 ;   Parent Loop BB3_7 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB3_12 Depth 3
                                        ;       Child Loop BB3_16 Depth 3
	madd	x1, x15, x19, x9
	ldr	s0, [x24, x1, lsl #2]
	cmp	x20, #16
	b.lo	LBB3_14
; %bb.10:                               ;   in Loop: Header=BB3_9 Depth=2
	mul	x1, x15, x20
	add	x2, x1, x20
	add	x2, x22, x2, lsl #2
	add	x1, x22, x1, lsl #2
	cmp	x1, x17
	ccmp	x16, x2, #2, lo
	b.lo	LBB3_14
; %bb.11:                               ;   in Loop: Header=BB3_9 Depth=2
	dup.4s	v1, v0[0]
	mov	x1, x13
	mov	x2, x0
	mov	x3, x10
LBB3_12:                                ;   Parent Loop BB3_7 Depth=1
                                        ;     Parent Loop BB3_9 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldp	q2, q3, [x1, #-32]
	ldp	q4, q5, [x1], #64
	ldp	q6, q7, [x2, #-32]
	ldp	q16, q17, [x2]
	fmla.4s	v6, v2, v1
	fmla.4s	v7, v3, v1
	fmla.4s	v16, v4, v1
	fmla.4s	v17, v5, v1
	stp	q6, q7, [x2, #-32]
	stp	q16, q17, [x2], #64
	subs	x3, x3, #16
	b.ne	LBB3_12
; %bb.13:                               ;   in Loop: Header=BB3_9 Depth=2
	mov	x3, x10
	cmp	x10, x20
	b.eq	LBB3_8
	b	LBB3_15
LBB3_14:                                ;   in Loop: Header=BB3_9 Depth=2
	mov	x3, #0
LBB3_15:                                ;   in Loop: Header=BB3_9 Depth=2
	sub	x1, x20, x3
	add	x2, x3, x14
	add	x2, x22, x2, lsl #2
	add	x3, x8, x3
	add	x3, x23, x3, lsl #2
LBB3_16:                                ;   Parent Loop BB3_7 Depth=1
                                        ;     Parent Loop BB3_9 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x3], #4
	ldr	s2, [x2]
	fmadd	s1, s0, s1, s2
	str	s1, [x2], #4
	subs	x1, x1, #1
	b.ne	LBB3_16
	b	LBB3_8
LBB3_17:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm3kjiEPKfS1_Pfmmm       ; -- Begin function _ZN4gemm3kjiEPKfS1_Pfmmm
	.p2align	2
__ZN4gemm3kjiEPKfS1_Pfmmm:              ; @_ZN4gemm3kjiEPKfS1_Pfmmm
	.cfi_startproc
; %bb.0:
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	cbz	x3, LBB4_18
; %bb.1:
	mov	x20, x4
	cbz	x4, LBB4_18
; %bb.2:
	mov	x19, x5
	mov	x21, x3
	mov	x22, x2
	mov	x23, x1
	mov	x24, x0
	mul	x8, x20, x3
	cbz	x8, LBB4_4
; %bb.3:
	lsl	x1, x8, #2
	mov	x0, x22
	bl	_bzero
LBB4_4:
	cbz	x19, LBB4_18
; %bb.5:
	mov	x8, #0
	cmp	x20, #1
	ccmp	x19, #1, #0, eq
	cset	w9, ne
	lsl	x10, x20, #6
	lsl	x11, x19, #6
	and	x12, x21, #0xfffffffffffffff0
	add	x13, x22, #32
	add	x14, x24, #32
	lsl	x15, x20, #2
	lsl	x16, x19, #2
	b	LBB4_7
LBB4_6:                                 ;   in Loop: Header=BB4_7 Depth=1
	add	x8, x8, #1
	add	x14, x14, #4
	cmp	x8, x19
	b.eq	LBB4_18
LBB4_7:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_9 Depth 2
                                        ;       Child Loop BB4_16 Depth 3
                                        ;       Child Loop BB4_14 Depth 3
	mov	x17, #0
	add	x0, x24, x8, lsl #2
	add	x1, x8, x21
	add	x1, x24, x1, lsl #2
	mul	x2, x8, x20
	mov	x3, x13
	b	LBB4_9
LBB4_8:                                 ;   in Loop: Header=BB4_9 Depth=2
	add	x17, x17, #1
	add	x3, x3, #4
	cmp	x17, x20
	b.eq	LBB4_6
LBB4_9:                                 ;   Parent Loop BB4_7 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB4_16 Depth 3
                                        ;       Child Loop BB4_14 Depth 3
	cmp	x21, #16
	cset	w4, lo
	add	x5, x17, x2
	ldr	s0, [x23, x5, lsl #2]
	orr	w4, w4, w9
	tbnz	w4, #0, LBB4_12
; %bb.10:                               ;   in Loop: Header=BB4_9 Depth=2
	add	x4, x22, x17, lsl #2
	cmp	x4, x1
	b.hs	LBB4_15
; %bb.11:                               ;   in Loop: Header=BB4_9 Depth=2
	add	x4, x17, x21
	add	x4, x22, x4, lsl #2
	cmp	x0, x4
	b.hs	LBB4_15
LBB4_12:                                ;   in Loop: Header=BB4_9 Depth=2
	mov	x6, #0
LBB4_13:                                ;   in Loop: Header=BB4_9 Depth=2
	sub	x4, x21, x6
	madd	x5, x20, x6, x17
	add	x5, x22, x5, lsl #2
	madd	x6, x19, x6, x8
	add	x6, x24, x6, lsl #2
LBB4_14:                                ;   Parent Loop BB4_7 Depth=1
                                        ;     Parent Loop BB4_9 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x6]
	ldr	s2, [x5]
	fmadd	s1, s1, s0, s2
	str	s1, [x5]
	add	x5, x5, x15
	add	x6, x6, x16
	subs	x4, x4, #1
	b.ne	LBB4_14
	b	LBB4_8
LBB4_15:                                ;   in Loop: Header=BB4_9 Depth=2
	dup.4s	v1, v0[0]
	mov	x4, x14
	mov	x5, x3
	mov	x6, x12
LBB4_16:                                ;   Parent Loop BB4_7 Depth=1
                                        ;     Parent Loop BB4_9 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldp	q2, q3, [x4, #-32]
	ldp	q4, q5, [x4]
	ldp	q6, q7, [x5, #-32]
	ldp	q16, q17, [x5]
	fmla.4s	v6, v1, v2
	fmla.4s	v7, v1, v3
	fmla.4s	v16, v1, v4
	fmla.4s	v17, v1, v5
	stp	q6, q7, [x5, #-32]
	stp	q16, q17, [x5]
	add	x5, x5, x10
	add	x4, x4, x11
	subs	x6, x6, #16
	b.ne	LBB4_16
; %bb.17:                               ;   in Loop: Header=BB4_9 Depth=2
	mov	x6, x12
	cmp	x12, x21
	b.eq	LBB4_8
	b	LBB4_13
LBB4_18:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
