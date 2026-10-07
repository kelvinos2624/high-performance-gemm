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
	cbz	x3, LBB0_12
; %bb.1:
	mov	x20, x4
	cbz	x4, LBB0_12
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
	cbz	x19, LBB0_12
; %bb.5:
	cmp	x20, #16
	b.hs	LBB0_13
; %bb.6:
	mov	x8, #0
	lsl	x9, x20, #2
LBB0_7:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_8 Depth 2
                                        ;       Child Loop BB0_9 Depth 3
	mov	x10, #0
	mul	x11, x8, x19
	mov	x12, x23
LBB0_8:                                 ;   Parent Loop BB0_7 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_9 Depth 3
	add	x13, x10, x11
	ldr	s0, [x24, x13, lsl #2]
	mov	x13, x12
	mov	x14, x22
	mov	x15, x20
LBB0_9:                                 ;   Parent Loop BB0_7 Depth=1
                                        ;     Parent Loop BB0_8 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x13], #4
	ldr	s2, [x14]
	fmadd	s1, s0, s1, s2
	str	s1, [x14], #4
	subs	x15, x15, #1
	b.ne	LBB0_9
; %bb.10:                               ;   in Loop: Header=BB0_8 Depth=2
	add	x10, x10, #1
	add	x12, x12, x9
	cmp	x10, x19
	b.ne	LBB0_8
; %bb.11:                               ;   in Loop: Header=BB0_7 Depth=1
	add	x8, x8, #1
	add	x22, x22, x9
	cmp	x8, x21
	b.ne	LBB0_7
LBB0_12:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB0_13:
	mov	x8, #0
	mov	x9, #0
	and	x10, x20, #0xfffffffffffffff0
	add	x11, x22, #32
	lsl	x12, x20, #2
	add	x13, x23, #32
	b	LBB0_15
LBB0_14:                                ;   in Loop: Header=BB0_15 Depth=1
	add	x9, x9, #1
	add	x11, x11, x12
	add	x8, x8, x20
	cmp	x9, x21
	b.eq	LBB0_12
LBB0_15:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_17 Depth 2
                                        ;       Child Loop BB0_19 Depth 3
                                        ;       Child Loop BB0_23 Depth 3
	mov	x14, #0
	mov	x15, #0
	mul	x17, x9, x20
	add	x16, x22, x17, lsl #2
	add	x17, x17, x20
	add	x17, x22, x17, lsl #2
	mul	x0, x9, x19
	mov	x1, x13
	b	LBB0_17
LBB0_16:                                ;   in Loop: Header=BB0_17 Depth=2
	add	x15, x15, #1
	add	x1, x1, x12
	add	x14, x14, x20
	cmp	x15, x19
	b.eq	LBB0_14
LBB0_17:                                ;   Parent Loop BB0_15 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_19 Depth 3
                                        ;       Child Loop BB0_23 Depth 3
	add	x2, x15, x0
	ldr	s0, [x24, x2, lsl #2]
	mul	x2, x15, x20
	add	x3, x2, x20
	add	x3, x23, x3, lsl #2
	add	x2, x23, x2, lsl #2
	cmp	x16, x3
	ccmp	x2, x17, #2, lo
	b.lo	LBB0_21
; %bb.18:                               ;   in Loop: Header=BB0_17 Depth=2
	dup.4s	v1, v0[0]
	mov	x2, x1
	mov	x3, x11
	mov	x4, x10
LBB0_19:                                ;   Parent Loop BB0_15 Depth=1
                                        ;     Parent Loop BB0_17 Depth=2
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
	b.ne	LBB0_19
; %bb.20:                               ;   in Loop: Header=BB0_17 Depth=2
	mov	x4, x10
	cmp	x10, x20
	b.eq	LBB0_16
	b	LBB0_22
LBB0_21:                                ;   in Loop: Header=BB0_17 Depth=2
	mov	x4, #0
LBB0_22:                                ;   in Loop: Header=BB0_17 Depth=2
	sub	x2, x20, x4
	add	x3, x8, x4
	add	x3, x22, x3, lsl #2
	add	x4, x4, x14
	add	x4, x23, x4, lsl #2
LBB0_23:                                ;   Parent Loop BB0_15 Depth=1
                                        ;     Parent Loop BB0_17 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x4], #4
	ldr	s2, [x3]
	fmadd	s1, s0, s1, s2
	str	s1, [x3], #4
	subs	x2, x2, #1
	b.ne	LBB0_23
	b	LBB0_16
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm3jikEPKfS1_Pfmmm       ; -- Begin function _ZN4gemm3jikEPKfS1_Pfmmm
	.p2align	2
__ZN4gemm3jikEPKfS1_Pfmmm:              ; @_ZN4gemm3jikEPKfS1_Pfmmm
	.cfi_startproc
; %bb.0:
	cbz	x3, LBB1_41
; %bb.1:
	cbz	x4, LBB1_41
; %bb.2:
	cbz	x5, LBB1_10
; %bb.3:
	cmp	x5, #15
	b.hi	LBB1_15
; %bb.4:
	mov	x8, #0
	lsl	x9, x4, #2
	lsl	x10, x5, #2
LBB1_5:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_6 Depth 2
                                        ;       Child Loop BB1_7 Depth 3
	mov	x11, #0
	mov	x12, x0
LBB1_6:                                 ;   Parent Loop BB1_5 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB1_7 Depth 3
	movi	d0, #0000000000000000
	mov	x13, x12
	mov	x14, x1
	mov	x15, x5
LBB1_7:                                 ;   Parent Loop BB1_5 Depth=1
                                        ;     Parent Loop BB1_6 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x13], #4
	ldr	s2, [x14]
	fmadd	s0, s1, s2, s0
	add	x14, x14, x9
	subs	x15, x15, #1
	b.ne	LBB1_7
; %bb.8:                                ;   in Loop: Header=BB1_6 Depth=2
	madd	x13, x11, x4, x8
	str	s0, [x2, x13, lsl #2]
	add	x11, x11, #1
	add	x12, x12, x10
	cmp	x11, x3
	b.ne	LBB1_6
; %bb.9:                                ;   in Loop: Header=BB1_5 Depth=1
	add	x8, x8, #1
	add	x1, x1, #4
	cmp	x8, x4
	b.ne	LBB1_5
	b	LBB1_41
LBB1_10:
	cmp	x3, #15
	b.hi	LBB1_23
; %bb.11:
	mov	x8, #0
	lsl	x9, x4, #2
LBB1_12:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_13 Depth 2
	mov	x10, x2
	mov	x11, x3
LBB1_13:                                ;   Parent Loop BB1_12 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	str	wzr, [x10]
	add	x10, x10, x9
	subs	x11, x11, #1
	b.ne	LBB1_13
; %bb.14:                               ;   in Loop: Header=BB1_12 Depth=1
	add	x8, x8, #1
	add	x2, x2, #4
	cmp	x8, x4
	b.ne	LBB1_12
	b	LBB1_41
LBB1_15:
	cmp	x4, #1
	b.ne	LBB1_27
; %bb.16:
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
	b	LBB1_18
LBB1_17:                                ;   in Loop: Header=BB1_18 Depth=1
	mul	x0, x8, x4
	str	s0, [x2, x0, lsl #2]
	add	x8, x8, #1
	add	x10, x10, x11
	add	x17, x17, x11
	cmp	x8, x3
	b.eq	LBB1_41
LBB1_18:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_19 Depth 2
                                        ;     Child Loop BB1_22 Depth 2
	movi	d0, #0000000000000000
	mov	x0, x12
	mov	x1, x10
	mov	x6, x9
LBB1_19:                                ;   Parent Loop BB1_18 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
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
	add	x0, x0, x13
	subs	x6, x6, #16
	b.ne	LBB1_19
; %bb.20:                               ;   in Loop: Header=BB1_18 Depth=1
	cmp	x9, x5
	b.eq	LBB1_17
; %bb.21:                               ;   in Loop: Header=BB1_18 Depth=1
	mov	x0, x17
	mov	x1, x15
	mov	x6, x14
LBB1_22:                                ;   Parent Loop BB1_18 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	s1, [x0], #4
	ldr	s2, [x1]
	fmadd	s0, s1, s2, s0
	add	x1, x1, x16
	subs	x6, x6, #1
	b.ne	LBB1_22
	b	LBB1_17
LBB1_23:
	cmp	x4, #1
	b.ne	LBB1_33
; %bb.24:
	and	x8, x3, #0xfffffffffffffff0
	cmp	x8, x3
	b.ne	LBB1_37
; %bb.25:
	add	x9, x2, #32
	lsl	x10, x4, #6
	movi.2d	v0, #0000000000000000
LBB1_26:                                ; =>This Inner Loop Header: Depth=1
	stp	q0, q0, [x9, #-32]
	stp	q0, q0, [x9]
	add	x9, x9, x10
	subs	x8, x8, #16
	b.ne	LBB1_26
	b	LBB1_41
LBB1_27:
	mov	x8, #0
	lsl	x9, x4, #2
	lsl	x10, x5, #2
LBB1_28:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_29 Depth 2
                                        ;       Child Loop BB1_30 Depth 3
	mov	x11, #0
	mov	x12, x0
LBB1_29:                                ;   Parent Loop BB1_28 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB1_30 Depth 3
	movi	d0, #0000000000000000
	mov	x13, x12
	mov	x14, x1
	mov	x15, x5
LBB1_30:                                ;   Parent Loop BB1_28 Depth=1
                                        ;     Parent Loop BB1_29 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x13], #4
	ldr	s2, [x14]
	fmadd	s0, s1, s2, s0
	add	x14, x14, x9
	subs	x15, x15, #1
	b.ne	LBB1_30
; %bb.31:                               ;   in Loop: Header=BB1_29 Depth=2
	madd	x13, x11, x4, x8
	str	s0, [x2, x13, lsl #2]
	add	x11, x11, #1
	add	x12, x12, x10
	cmp	x11, x3
	b.ne	LBB1_29
; %bb.32:                               ;   in Loop: Header=BB1_28 Depth=1
	add	x8, x8, #1
	add	x1, x1, #4
	cmp	x8, x4
	b.ne	LBB1_28
	b	LBB1_41
LBB1_33:
	mov	x8, #0
	lsl	x9, x4, #2
LBB1_34:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_35 Depth 2
	mov	x10, x2
	mov	x11, x3
LBB1_35:                                ;   Parent Loop BB1_34 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	str	wzr, [x10]
	add	x10, x10, x9
	subs	x11, x11, #1
	b.ne	LBB1_35
; %bb.36:                               ;   in Loop: Header=BB1_34 Depth=1
	add	x8, x8, #1
	add	x2, x2, #4
	cmp	x8, x4
	b.ne	LBB1_34
	b	LBB1_41
LBB1_37:
	add	x9, x2, #32
	lsl	x10, x4, #6
	movi.2d	v0, #0000000000000000
	mov	x11, x8
LBB1_38:                                ; =>This Inner Loop Header: Depth=1
	stp	q0, q0, [x9, #-32]
	stp	q0, q0, [x9]
	add	x9, x9, x10
	subs	x11, x11, #16
	b.ne	LBB1_38
; %bb.39:
	sub	x8, x3, x8
	lsr	x9, x3, #4
	mul	x9, x4, x9
	add	x9, x2, x9, lsl #6
	lsl	x10, x4, #2
LBB1_40:                                ; =>This Inner Loop Header: Depth=1
	str	wzr, [x9]
	add	x9, x9, x10
	subs	x8, x8, #1
	b.ne	LBB1_40
LBB1_41:
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
	cbz	x3, LBB2_28
; %bb.1:
	mov	x20, x4
	cbz	x4, LBB2_28
; %bb.2:
	mov	x19, x5
	mov	x23, x3
	mov	x22, x2
	mov	x24, x1
	mov	x21, x0
	mul	x8, x20, x3
	cbz	x8, LBB2_4
; %bb.3:
	lsl	x1, x8, #2
	mov	x0, x22
	bl	_bzero
LBB2_4:
	cbz	x19, LBB2_28
; %bb.5:
	cmp	x23, #15
	b.hi	LBB2_12
; %bb.6:
	mov	x8, #0
	lsl	x9, x20, #2
	lsl	x10, x19, #2
LBB2_7:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_8 Depth 2
                                        ;       Child Loop BB2_9 Depth 3
	mov	x11, #0
	mov	x12, x21
LBB2_8:                                 ;   Parent Loop BB2_7 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_9 Depth 3
	madd	x13, x11, x20, x8
	ldr	s0, [x24, x13, lsl #2]
	mov	x13, x12
	mov	x14, x22
	mov	x15, x23
LBB2_9:                                 ;   Parent Loop BB2_7 Depth=1
                                        ;     Parent Loop BB2_8 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x13]
	ldr	s2, [x14]
	fmadd	s1, s1, s0, s2
	str	s1, [x14]
	add	x14, x14, x9
	add	x13, x13, x10
	subs	x15, x15, #1
	b.ne	LBB2_9
; %bb.10:                               ;   in Loop: Header=BB2_8 Depth=2
	add	x11, x11, #1
	add	x12, x12, #4
	cmp	x11, x19
	b.ne	LBB2_8
; %bb.11:                               ;   in Loop: Header=BB2_7 Depth=1
	add	x8, x8, #1
	add	x22, x22, #4
	cmp	x8, x20
	b.ne	LBB2_7
	b	LBB2_28
LBB2_12:
	cmp	x20, #1
	b.ne	LBB2_17
; %bb.13:
	cmp	x19, #1
	b.ne	LBB2_17
; %bb.14:
	lsl	x8, x23, #2
	ldr	s0, [x24]
	add	x9, x21, x8
	cmp	x9, x22
	b.ls	LBB2_23
; %bb.15:
	add	x8, x22, x8
	cmp	x8, x21
	b.ls	LBB2_23
; %bb.16:
	mov	x8, #0
	b	LBB2_26
LBB2_17:
	mov	x8, #0
	lsl	x9, x20, #2
	lsl	x10, x19, #2
LBB2_18:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_19 Depth 2
                                        ;       Child Loop BB2_20 Depth 3
	mov	x11, #0
	mov	x12, x21
LBB2_19:                                ;   Parent Loop BB2_18 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_20 Depth 3
	madd	x13, x11, x20, x8
	ldr	s0, [x24, x13, lsl #2]
	mov	x13, x12
	mov	x14, x22
	mov	x15, x23
LBB2_20:                                ;   Parent Loop BB2_18 Depth=1
                                        ;     Parent Loop BB2_19 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x13]
	ldr	s2, [x14]
	fmadd	s1, s1, s0, s2
	str	s1, [x14]
	add	x14, x14, x9
	add	x13, x13, x10
	subs	x15, x15, #1
	b.ne	LBB2_20
; %bb.21:                               ;   in Loop: Header=BB2_19 Depth=2
	add	x11, x11, #1
	add	x12, x12, #4
	cmp	x11, x19
	b.ne	LBB2_19
; %bb.22:                               ;   in Loop: Header=BB2_18 Depth=1
	add	x8, x8, #1
	add	x22, x22, #4
	cmp	x8, x20
	b.ne	LBB2_18
	b	LBB2_28
LBB2_23:
	and	x8, x23, #0xfffffffffffffff0
	add	x9, x22, #32
	dup.4s	v1, v0[0]
	lsl	x10, x20, #6
	add	x11, x21, #32
	lsl	x12, x19, #6
	mov	x13, x8
LBB2_24:                                ; =>This Inner Loop Header: Depth=1
	ldp	q2, q3, [x11, #-32]
	ldp	q4, q5, [x11]
	ldp	q6, q7, [x9, #-32]
	ldp	q16, q17, [x9]
	fmla.4s	v6, v1, v2
	fmla.4s	v7, v1, v3
	fmla.4s	v16, v1, v4
	fmla.4s	v17, v1, v5
	stp	q6, q7, [x9, #-32]
	stp	q16, q17, [x9]
	add	x9, x9, x10
	add	x11, x11, x12
	subs	x13, x13, #16
	b.ne	LBB2_24
; %bb.25:
	cmp	x8, x23
	b.eq	LBB2_28
LBB2_26:
	sub	x9, x23, x8
	mul	x10, x8, x20
	add	x10, x22, x10, lsl #2
	lsl	x11, x20, #2
	mul	x8, x8, x19
	add	x8, x21, x8, lsl #2
	lsl	x12, x19, #2
LBB2_27:                                ; =>This Inner Loop Header: Depth=1
	ldr	s1, [x8]
	ldr	s2, [x10]
	fmadd	s1, s1, s0, s2
	str	s1, [x10]
	add	x10, x10, x11
	add	x8, x8, x12
	subs	x9, x9, #1
	b.ne	LBB2_27
LBB2_28:
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
	cbz	x3, LBB3_12
; %bb.1:
	mov	x20, x4
	cbz	x4, LBB3_12
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
	cbz	x19, LBB3_12
; %bb.5:
	cmp	x20, #16
	b.hs	LBB3_13
; %bb.6:
	mov	x8, #0
	lsl	x9, x20, #2
LBB3_7:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_8 Depth 2
                                        ;       Child Loop BB3_9 Depth 3
	mov	x10, #0
	mov	x11, x22
LBB3_8:                                 ;   Parent Loop BB3_7 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB3_9 Depth 3
	madd	x12, x10, x19, x8
	ldr	s0, [x24, x12, lsl #2]
	mov	x12, x23
	mov	x13, x11
	mov	x14, x20
LBB3_9:                                 ;   Parent Loop BB3_7 Depth=1
                                        ;     Parent Loop BB3_8 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x12], #4
	ldr	s2, [x13]
	fmadd	s1, s0, s1, s2
	str	s1, [x13], #4
	subs	x14, x14, #1
	b.ne	LBB3_9
; %bb.10:                               ;   in Loop: Header=BB3_8 Depth=2
	add	x10, x10, #1
	add	x11, x11, x9
	cmp	x10, x21
	b.ne	LBB3_8
; %bb.11:                               ;   in Loop: Header=BB3_7 Depth=1
	add	x8, x8, #1
	add	x23, x23, x9
	cmp	x8, x19
	b.ne	LBB3_7
LBB3_12:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB3_13:
	mov	x8, #0
	mov	x9, #0
	and	x10, x20, #0xfffffffffffffff0
	add	x11, x22, #32
	lsl	x12, x20, #2
	add	x13, x23, #32
	b	LBB3_15
LBB3_14:                                ;   in Loop: Header=BB3_15 Depth=1
	add	x9, x9, #1
	add	x13, x13, x12
	add	x8, x8, x20
	cmp	x9, x19
	b.eq	LBB3_12
LBB3_15:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_17 Depth 2
                                        ;       Child Loop BB3_19 Depth 3
                                        ;       Child Loop BB3_23 Depth 3
	mov	x14, #0
	mov	x15, #0
	mul	x17, x9, x20
	add	x16, x23, x17, lsl #2
	add	x17, x17, x20
	add	x17, x23, x17, lsl #2
	mov	x0, x11
	b	LBB3_17
LBB3_16:                                ;   in Loop: Header=BB3_17 Depth=2
	add	x15, x15, #1
	add	x0, x0, x12
	add	x14, x14, x20
	cmp	x15, x21
	b.eq	LBB3_14
LBB3_17:                                ;   Parent Loop BB3_15 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB3_19 Depth 3
                                        ;       Child Loop BB3_23 Depth 3
	madd	x1, x15, x19, x9
	ldr	s0, [x24, x1, lsl #2]
	mul	x1, x15, x20
	add	x2, x1, x20
	add	x2, x22, x2, lsl #2
	add	x1, x22, x1, lsl #2
	cmp	x1, x17
	ccmp	x16, x2, #2, lo
	b.lo	LBB3_21
; %bb.18:                               ;   in Loop: Header=BB3_17 Depth=2
	dup.4s	v1, v0[0]
	mov	x1, x13
	mov	x2, x0
	mov	x3, x10
LBB3_19:                                ;   Parent Loop BB3_15 Depth=1
                                        ;     Parent Loop BB3_17 Depth=2
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
	b.ne	LBB3_19
; %bb.20:                               ;   in Loop: Header=BB3_17 Depth=2
	mov	x3, x10
	cmp	x10, x20
	b.eq	LBB3_16
	b	LBB3_22
LBB3_21:                                ;   in Loop: Header=BB3_17 Depth=2
	mov	x3, #0
LBB3_22:                                ;   in Loop: Header=BB3_17 Depth=2
	sub	x1, x20, x3
	add	x2, x3, x14
	add	x2, x22, x2, lsl #2
	add	x3, x8, x3
	add	x3, x23, x3, lsl #2
LBB3_23:                                ;   Parent Loop BB3_15 Depth=1
                                        ;     Parent Loop BB3_17 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x3], #4
	ldr	s2, [x2]
	fmadd	s1, s0, s1, s2
	str	s1, [x2], #4
	subs	x1, x1, #1
	b.ne	LBB3_23
	b	LBB3_16
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
	cbz	x3, LBB4_28
; %bb.1:
	mov	x20, x4
	cbz	x4, LBB4_28
; %bb.2:
	mov	x19, x5
	mov	x23, x3
	mov	x22, x2
	mov	x24, x1
	mov	x21, x0
	mul	x8, x20, x3
	cbz	x8, LBB4_4
; %bb.3:
	lsl	x1, x8, #2
	mov	x0, x22
	bl	_bzero
LBB4_4:
	cbz	x19, LBB4_28
; %bb.5:
	cmp	x23, #15
	b.hi	LBB4_12
; %bb.6:
	mov	x8, #0
	lsl	x9, x20, #2
	lsl	x10, x19, #2
LBB4_7:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_8 Depth 2
                                        ;       Child Loop BB4_9 Depth 3
	mov	x11, #0
	mul	x12, x8, x20
	mov	x13, x22
LBB4_8:                                 ;   Parent Loop BB4_7 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB4_9 Depth 3
	add	x14, x11, x12
	ldr	s0, [x24, x14, lsl #2]
	mov	x14, x21
	mov	x15, x13
	mov	x16, x23
LBB4_9:                                 ;   Parent Loop BB4_7 Depth=1
                                        ;     Parent Loop BB4_8 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x14]
	ldr	s2, [x15]
	fmadd	s1, s1, s0, s2
	str	s1, [x15]
	add	x15, x15, x9
	add	x14, x14, x10
	subs	x16, x16, #1
	b.ne	LBB4_9
; %bb.10:                               ;   in Loop: Header=BB4_8 Depth=2
	add	x11, x11, #1
	add	x13, x13, #4
	cmp	x11, x20
	b.ne	LBB4_8
; %bb.11:                               ;   in Loop: Header=BB4_7 Depth=1
	add	x8, x8, #1
	add	x21, x21, #4
	cmp	x8, x19
	b.ne	LBB4_7
	b	LBB4_28
LBB4_12:
	cmp	x20, #1
	b.ne	LBB4_17
; %bb.13:
	cmp	x19, #1
	b.ne	LBB4_17
; %bb.14:
	lsl	x8, x23, #2
	ldr	s0, [x24]
	add	x9, x21, x8
	cmp	x9, x22
	b.ls	LBB4_23
; %bb.15:
	add	x8, x22, x8
	cmp	x8, x21
	b.ls	LBB4_23
; %bb.16:
	mov	x8, #0
	b	LBB4_26
LBB4_17:
	mov	x8, #0
	lsl	x9, x20, #2
	lsl	x10, x19, #2
LBB4_18:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_19 Depth 2
                                        ;       Child Loop BB4_20 Depth 3
	mov	x11, #0
	mul	x12, x8, x20
	mov	x13, x22
LBB4_19:                                ;   Parent Loop BB4_18 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB4_20 Depth 3
	add	x14, x11, x12
	ldr	s0, [x24, x14, lsl #2]
	mov	x14, x21
	mov	x15, x13
	mov	x16, x23
LBB4_20:                                ;   Parent Loop BB4_18 Depth=1
                                        ;     Parent Loop BB4_19 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x14]
	ldr	s2, [x15]
	fmadd	s1, s1, s0, s2
	str	s1, [x15]
	add	x15, x15, x9
	add	x14, x14, x10
	subs	x16, x16, #1
	b.ne	LBB4_20
; %bb.21:                               ;   in Loop: Header=BB4_19 Depth=2
	add	x11, x11, #1
	add	x13, x13, #4
	cmp	x11, x20
	b.ne	LBB4_19
; %bb.22:                               ;   in Loop: Header=BB4_18 Depth=1
	add	x8, x8, #1
	add	x21, x21, #4
	cmp	x8, x19
	b.ne	LBB4_18
	b	LBB4_28
LBB4_23:
	and	x8, x23, #0xfffffffffffffff0
	add	x9, x22, #32
	dup.4s	v1, v0[0]
	lsl	x10, x20, #6
	add	x11, x21, #32
	lsl	x12, x19, #6
	mov	x13, x8
LBB4_24:                                ; =>This Inner Loop Header: Depth=1
	ldp	q2, q3, [x11, #-32]
	ldp	q4, q5, [x11]
	ldp	q6, q7, [x9, #-32]
	ldp	q16, q17, [x9]
	fmla.4s	v6, v1, v2
	fmla.4s	v7, v1, v3
	fmla.4s	v16, v1, v4
	fmla.4s	v17, v1, v5
	stp	q6, q7, [x9, #-32]
	stp	q16, q17, [x9]
	add	x9, x9, x10
	add	x11, x11, x12
	subs	x13, x13, #16
	b.ne	LBB4_24
; %bb.25:
	cmp	x8, x23
	b.eq	LBB4_28
LBB4_26:
	sub	x9, x23, x8
	mul	x10, x8, x20
	add	x10, x22, x10, lsl #2
	lsl	x11, x20, #2
	mul	x8, x8, x19
	add	x8, x21, x8, lsl #2
	lsl	x12, x19, #2
LBB4_27:                                ; =>This Inner Loop Header: Depth=1
	ldr	s1, [x8]
	ldr	s2, [x10]
	fmadd	s1, s1, s0, s2
	str	s1, [x10]
	add	x10, x10, x11
	add	x8, x8, x12
	subs	x9, x9, #1
	b.ne	LBB4_27
LBB4_28:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
