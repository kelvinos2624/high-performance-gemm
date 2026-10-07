	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	__ZN4gemm9naive_ijkEPKfS1_Pfmmm ; -- Begin function _ZN4gemm9naive_ijkEPKfS1_Pfmmm
	.p2align	2
__ZN4gemm9naive_ijkEPKfS1_Pfmmm:        ; @_ZN4gemm9naive_ijkEPKfS1_Pfmmm
	.cfi_startproc
; %bb.0:
	stp	x22, x21, [sp, #-32]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	cbz	x3, LBB0_15
; %bb.1:
	mov	x8, #0
	mov	x9, #0
	cmp	x5, #15
	ccmp	x4, #1, #0, hi
	cset	w10, eq
	lsl	x11, x4, #6
	and	x12, x5, #0xfffffffffffffff0
	add	x13, x1, #32
	add	x14, x0, #32
	lsl	x15, x5, #2
	lsl	x16, x4, #2
	b	LBB0_3
LBB0_2:                                 ;   in Loop: Header=BB0_3 Depth=1
	add	x9, x9, #1
	add	x14, x14, x15
	add	x8, x8, x5
	cmp	x9, x3
	b.eq	LBB0_15
LBB0_3:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_7 Depth 2
                                        ;       Child Loop BB0_10 Depth 3
                                        ;       Child Loop BB0_14 Depth 3
	cbz	x4, LBB0_2
; %bb.4:                                ;   in Loop: Header=BB0_3 Depth=1
	mov	x17, #0
	mul	x6, x9, x4
	mov	x7, x13
	b	LBB0_7
LBB0_5:                                 ;   in Loop: Header=BB0_7 Depth=2
	movi	d0, #0000000000000000
LBB0_6:                                 ;   in Loop: Header=BB0_7 Depth=2
	add	x19, x17, x6
	str	s0, [x2, x19, lsl #2]
	add	x17, x17, #1
	add	x7, x7, #4
	cmp	x17, x4
	b.eq	LBB0_2
LBB0_7:                                 ;   Parent Loop BB0_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_10 Depth 3
                                        ;       Child Loop BB0_14 Depth 3
	cbz	x5, LBB0_5
; %bb.8:                                ;   in Loop: Header=BB0_7 Depth=2
	cbz	w10, LBB0_12
; %bb.9:                                ;   in Loop: Header=BB0_7 Depth=2
	movi	d0, #0000000000000000
	mov	x19, x14
	mov	x20, x7
	mov	x21, x12
LBB0_10:                                ;   Parent Loop BB0_3 Depth=1
                                        ;     Parent Loop BB0_7 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldp	q1, q2, [x19, #-32]
	ldp	q3, q4, [x19], #64
	ldp	q5, q6, [x20, #-32]
	ldp	q7, q16, [x20]
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
	add	x20, x20, x11
	subs	x21, x21, #16
	b.ne	LBB0_10
; %bb.11:                               ;   in Loop: Header=BB0_7 Depth=2
	mov	x21, x12
	cmp	x12, x5
	b.eq	LBB0_6
	b	LBB0_13
LBB0_12:                                ;   in Loop: Header=BB0_7 Depth=2
	mov	x21, #0
	movi	d0, #0000000000000000
LBB0_13:                                ;   in Loop: Header=BB0_7 Depth=2
	sub	x19, x5, x21
	madd	x20, x4, x21, x17
	add	x20, x1, x20, lsl #2
	add	x21, x8, x21
	add	x21, x0, x21, lsl #2
LBB0_14:                                ;   Parent Loop BB0_3 Depth=1
                                        ;     Parent Loop BB0_7 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x21], #4
	ldr	s2, [x20]
	fmadd	s0, s1, s2, s0
	add	x20, x20, x16
	subs	x19, x19, #1
	b.ne	LBB0_14
	b	LBB0_6
LBB0_15:
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
