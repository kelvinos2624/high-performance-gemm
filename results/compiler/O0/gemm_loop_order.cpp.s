	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	__ZN4gemm3ikjEPKfS1_Pfmmm       ; -- Begin function _ZN4gemm3ikjEPKfS1_Pfmmm
	.p2align	2
__ZN4gemm3ikjEPKfS1_Pfmmm:              ; @_ZN4gemm3ikjEPKfS1_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	stur	x2, [x29, #-24]
	stur	x3, [x29, #-32]
	str	x4, [sp, #40]
	str	x5, [sp, #32]
	ldur	x8, [x29, #-32]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB0_2
	b	LBB0_1
LBB0_1:
	ldr	x8, [sp, #40]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB0_3
	b	LBB0_2
LBB0_2:
	b	LBB0_15
LBB0_3:
	ldur	x0, [x29, #-24]
	ldur	x1, [x29, #-32]
	ldr	x2, [sp, #40]
	bl	__ZN4gemm12_GLOBAL__N_111zero_outputEPfmm
	str	xzr, [sp, #24]
	b	LBB0_4
LBB0_4:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_6 Depth 2
                                        ;       Child Loop BB0_8 Depth 3
	ldr	x8, [sp, #24]
	ldur	x9, [x29, #-32]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB0_15
	b	LBB0_5
LBB0_5:                                 ;   in Loop: Header=BB0_4 Depth=1
	str	xzr, [sp, #16]
	b	LBB0_6
LBB0_6:                                 ;   Parent Loop BB0_4 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_8 Depth 3
	ldr	x8, [sp, #16]
	ldr	x9, [sp, #32]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB0_13
	b	LBB0_7
LBB0_7:                                 ;   in Loop: Header=BB0_6 Depth=2
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #24]
	ldr	x10, [sp, #32]
	mul	x9, x9, x10
	ldr	x10, [sp, #16]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	str	s0, [sp, #12]
	str	xzr, [sp]
	b	LBB0_8
LBB0_8:                                 ;   Parent Loop BB0_4 Depth=1
                                        ;     Parent Loop BB0_6 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	x8, [sp]
	ldr	x9, [sp, #40]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB0_11
	b	LBB0_9
LBB0_9:                                 ;   in Loop: Header=BB0_8 Depth=3
	ldr	s0, [sp, #12]
	ldur	x8, [x29, #-16]
	ldr	x9, [sp, #16]
	ldr	x10, [sp, #40]
	mul	x9, x9, x10
	ldr	x10, [sp]
	add	x9, x9, x10
	ldr	s1, [x8, x9, lsl #2]
	ldur	x8, [x29, #-24]
	ldr	x9, [sp, #24]
	ldr	x10, [sp, #40]
	mul	x9, x9, x10
	ldr	x10, [sp]
	add	x9, x9, x10
	add	x8, x8, x9, lsl #2
	ldr	s2, [x8]
	fmadd	s0, s0, s1, s2
	str	s0, [x8]
	b	LBB0_10
LBB0_10:                                ;   in Loop: Header=BB0_8 Depth=3
	ldr	x8, [sp]
	add	x8, x8, #1
	str	x8, [sp]
	b	LBB0_8
LBB0_11:                                ;   in Loop: Header=BB0_6 Depth=2
	b	LBB0_12
LBB0_12:                                ;   in Loop: Header=BB0_6 Depth=2
	ldr	x8, [sp, #16]
	add	x8, x8, #1
	str	x8, [sp, #16]
	b	LBB0_6
LBB0_13:                                ;   in Loop: Header=BB0_4 Depth=1
	b	LBB0_14
LBB0_14:                                ;   in Loop: Header=BB0_4 Depth=1
	ldr	x8, [sp, #24]
	add	x8, x8, #1
	str	x8, [sp, #24]
	b	LBB0_4
LBB0_15:
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN4gemm12_GLOBAL__N_111zero_outputEPfmm
__ZN4gemm12_GLOBAL__N_111zero_outputEPfmm: ; @_ZN4gemm12_GLOBAL__N_111zero_outputEPfmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	str	x0, [sp, #24]
	str	x1, [sp, #16]
	str	x2, [sp, #8]
	str	xzr, [sp]
	b	LBB1_1
LBB1_1:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp]
	ldr	x9, [sp, #16]
	ldr	x10, [sp, #8]
	mul	x9, x9, x10
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB1_4
	b	LBB1_2
LBB1_2:                                 ;   in Loop: Header=BB1_1 Depth=1
	ldr	x8, [sp, #24]
	ldr	x9, [sp]
	movi	d0, #0000000000000000
	str	s0, [x8, x9, lsl #2]
	b	LBB1_3
LBB1_3:                                 ;   in Loop: Header=BB1_1 Depth=1
	ldr	x8, [sp]
	add	x8, x8, #1
	str	x8, [sp]
	b	LBB1_1
LBB1_4:
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm3jikEPKfS1_Pfmmm       ; -- Begin function _ZN4gemm3jikEPKfS1_Pfmmm
	.p2align	2
__ZN4gemm3jikEPKfS1_Pfmmm:              ; @_ZN4gemm3jikEPKfS1_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	.cfi_def_cfa_offset 80
	str	x0, [sp, #72]
	str	x1, [sp, #64]
	str	x2, [sp, #56]
	str	x3, [sp, #48]
	str	x4, [sp, #40]
	str	x5, [sp, #32]
	ldr	x8, [sp, #48]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB2_2
	b	LBB2_1
LBB2_1:
	ldr	x8, [sp, #40]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB2_3
	b	LBB2_2
LBB2_2:
	b	LBB2_15
LBB2_3:
	str	xzr, [sp, #24]
	b	LBB2_4
LBB2_4:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_6 Depth 2
                                        ;       Child Loop BB2_8 Depth 3
	ldr	x8, [sp, #24]
	ldr	x9, [sp, #40]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB2_15
	b	LBB2_5
LBB2_5:                                 ;   in Loop: Header=BB2_4 Depth=1
	str	xzr, [sp, #16]
	b	LBB2_6
LBB2_6:                                 ;   Parent Loop BB2_4 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_8 Depth 3
	ldr	x8, [sp, #16]
	ldr	x9, [sp, #48]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB2_13
	b	LBB2_7
LBB2_7:                                 ;   in Loop: Header=BB2_6 Depth=2
	movi	d0, #0000000000000000
	str	s0, [sp, #12]
	str	xzr, [sp]
	b	LBB2_8
LBB2_8:                                 ;   Parent Loop BB2_4 Depth=1
                                        ;     Parent Loop BB2_6 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	x8, [sp]
	ldr	x9, [sp, #32]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB2_11
	b	LBB2_9
LBB2_9:                                 ;   in Loop: Header=BB2_8 Depth=3
	ldr	x8, [sp, #72]
	ldr	x9, [sp, #16]
	ldr	x10, [sp, #32]
	mul	x9, x9, x10
	ldr	x10, [sp]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	x8, [sp, #64]
	ldr	x9, [sp]
	ldr	x10, [sp, #40]
	mul	x9, x9, x10
	ldr	x10, [sp, #24]
	add	x9, x9, x10
	ldr	s1, [x8, x9, lsl #2]
	ldr	s2, [sp, #12]
	fmadd	s0, s0, s1, s2
	str	s0, [sp, #12]
	b	LBB2_10
LBB2_10:                                ;   in Loop: Header=BB2_8 Depth=3
	ldr	x8, [sp]
	add	x8, x8, #1
	str	x8, [sp]
	b	LBB2_8
LBB2_11:                                ;   in Loop: Header=BB2_6 Depth=2
	ldr	s0, [sp, #12]
	ldr	x8, [sp, #56]
	ldr	x9, [sp, #16]
	ldr	x10, [sp, #40]
	mul	x9, x9, x10
	ldr	x10, [sp, #24]
	add	x9, x9, x10
	str	s0, [x8, x9, lsl #2]
	b	LBB2_12
LBB2_12:                                ;   in Loop: Header=BB2_6 Depth=2
	ldr	x8, [sp, #16]
	add	x8, x8, #1
	str	x8, [sp, #16]
	b	LBB2_6
LBB2_13:                                ;   in Loop: Header=BB2_4 Depth=1
	b	LBB2_14
LBB2_14:                                ;   in Loop: Header=BB2_4 Depth=1
	ldr	x8, [sp, #24]
	add	x8, x8, #1
	str	x8, [sp, #24]
	b	LBB2_4
LBB2_15:
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm3jkiEPKfS1_Pfmmm       ; -- Begin function _ZN4gemm3jkiEPKfS1_Pfmmm
	.p2align	2
__ZN4gemm3jkiEPKfS1_Pfmmm:              ; @_ZN4gemm3jkiEPKfS1_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	stur	x2, [x29, #-24]
	stur	x3, [x29, #-32]
	str	x4, [sp, #40]
	str	x5, [sp, #32]
	ldur	x8, [x29, #-32]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB3_2
	b	LBB3_1
LBB3_1:
	ldr	x8, [sp, #40]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB3_3
	b	LBB3_2
LBB3_2:
	b	LBB3_15
LBB3_3:
	ldur	x0, [x29, #-24]
	ldur	x1, [x29, #-32]
	ldr	x2, [sp, #40]
	bl	__ZN4gemm12_GLOBAL__N_111zero_outputEPfmm
	str	xzr, [sp, #24]
	b	LBB3_4
LBB3_4:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_6 Depth 2
                                        ;       Child Loop BB3_8 Depth 3
	ldr	x8, [sp, #24]
	ldr	x9, [sp, #40]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB3_15
	b	LBB3_5
LBB3_5:                                 ;   in Loop: Header=BB3_4 Depth=1
	str	xzr, [sp, #16]
	b	LBB3_6
LBB3_6:                                 ;   Parent Loop BB3_4 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB3_8 Depth 3
	ldr	x8, [sp, #16]
	ldr	x9, [sp, #32]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB3_13
	b	LBB3_7
LBB3_7:                                 ;   in Loop: Header=BB3_6 Depth=2
	ldur	x8, [x29, #-16]
	ldr	x9, [sp, #16]
	ldr	x10, [sp, #40]
	mul	x9, x9, x10
	ldr	x10, [sp, #24]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	str	s0, [sp, #12]
	str	xzr, [sp]
	b	LBB3_8
LBB3_8:                                 ;   Parent Loop BB3_4 Depth=1
                                        ;     Parent Loop BB3_6 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	x8, [sp]
	ldur	x9, [x29, #-32]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB3_11
	b	LBB3_9
LBB3_9:                                 ;   in Loop: Header=BB3_8 Depth=3
	ldur	x8, [x29, #-8]
	ldr	x9, [sp]
	ldr	x10, [sp, #32]
	mul	x9, x9, x10
	ldr	x10, [sp, #16]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	s1, [sp, #12]
	ldur	x8, [x29, #-24]
	ldr	x9, [sp]
	ldr	x10, [sp, #40]
	mul	x9, x9, x10
	ldr	x10, [sp, #24]
	add	x9, x9, x10
	add	x8, x8, x9, lsl #2
	ldr	s2, [x8]
	fmadd	s0, s0, s1, s2
	str	s0, [x8]
	b	LBB3_10
LBB3_10:                                ;   in Loop: Header=BB3_8 Depth=3
	ldr	x8, [sp]
	add	x8, x8, #1
	str	x8, [sp]
	b	LBB3_8
LBB3_11:                                ;   in Loop: Header=BB3_6 Depth=2
	b	LBB3_12
LBB3_12:                                ;   in Loop: Header=BB3_6 Depth=2
	ldr	x8, [sp, #16]
	add	x8, x8, #1
	str	x8, [sp, #16]
	b	LBB3_6
LBB3_13:                                ;   in Loop: Header=BB3_4 Depth=1
	b	LBB3_14
LBB3_14:                                ;   in Loop: Header=BB3_4 Depth=1
	ldr	x8, [sp, #24]
	add	x8, x8, #1
	str	x8, [sp, #24]
	b	LBB3_4
LBB3_15:
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm3kijEPKfS1_Pfmmm       ; -- Begin function _ZN4gemm3kijEPKfS1_Pfmmm
	.p2align	2
__ZN4gemm3kijEPKfS1_Pfmmm:              ; @_ZN4gemm3kijEPKfS1_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	stur	x2, [x29, #-24]
	stur	x3, [x29, #-32]
	str	x4, [sp, #40]
	str	x5, [sp, #32]
	ldur	x8, [x29, #-32]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB4_2
	b	LBB4_1
LBB4_1:
	ldr	x8, [sp, #40]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB4_3
	b	LBB4_2
LBB4_2:
	b	LBB4_15
LBB4_3:
	ldur	x0, [x29, #-24]
	ldur	x1, [x29, #-32]
	ldr	x2, [sp, #40]
	bl	__ZN4gemm12_GLOBAL__N_111zero_outputEPfmm
	str	xzr, [sp, #24]
	b	LBB4_4
LBB4_4:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_6 Depth 2
                                        ;       Child Loop BB4_8 Depth 3
	ldr	x8, [sp, #24]
	ldr	x9, [sp, #32]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB4_15
	b	LBB4_5
LBB4_5:                                 ;   in Loop: Header=BB4_4 Depth=1
	str	xzr, [sp, #16]
	b	LBB4_6
LBB4_6:                                 ;   Parent Loop BB4_4 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB4_8 Depth 3
	ldr	x8, [sp, #16]
	ldur	x9, [x29, #-32]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB4_13
	b	LBB4_7
LBB4_7:                                 ;   in Loop: Header=BB4_6 Depth=2
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #16]
	ldr	x10, [sp, #32]
	mul	x9, x9, x10
	ldr	x10, [sp, #24]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	str	s0, [sp, #12]
	str	xzr, [sp]
	b	LBB4_8
LBB4_8:                                 ;   Parent Loop BB4_4 Depth=1
                                        ;     Parent Loop BB4_6 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	x8, [sp]
	ldr	x9, [sp, #40]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB4_11
	b	LBB4_9
LBB4_9:                                 ;   in Loop: Header=BB4_8 Depth=3
	ldr	s0, [sp, #12]
	ldur	x8, [x29, #-16]
	ldr	x9, [sp, #24]
	ldr	x10, [sp, #40]
	mul	x9, x9, x10
	ldr	x10, [sp]
	add	x9, x9, x10
	ldr	s1, [x8, x9, lsl #2]
	ldur	x8, [x29, #-24]
	ldr	x9, [sp, #16]
	ldr	x10, [sp, #40]
	mul	x9, x9, x10
	ldr	x10, [sp]
	add	x9, x9, x10
	add	x8, x8, x9, lsl #2
	ldr	s2, [x8]
	fmadd	s0, s0, s1, s2
	str	s0, [x8]
	b	LBB4_10
LBB4_10:                                ;   in Loop: Header=BB4_8 Depth=3
	ldr	x8, [sp]
	add	x8, x8, #1
	str	x8, [sp]
	b	LBB4_8
LBB4_11:                                ;   in Loop: Header=BB4_6 Depth=2
	b	LBB4_12
LBB4_12:                                ;   in Loop: Header=BB4_6 Depth=2
	ldr	x8, [sp, #16]
	add	x8, x8, #1
	str	x8, [sp, #16]
	b	LBB4_6
LBB4_13:                                ;   in Loop: Header=BB4_4 Depth=1
	b	LBB4_14
LBB4_14:                                ;   in Loop: Header=BB4_4 Depth=1
	ldr	x8, [sp, #24]
	add	x8, x8, #1
	str	x8, [sp, #24]
	b	LBB4_4
LBB4_15:
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm3kjiEPKfS1_Pfmmm       ; -- Begin function _ZN4gemm3kjiEPKfS1_Pfmmm
	.p2align	2
__ZN4gemm3kjiEPKfS1_Pfmmm:              ; @_ZN4gemm3kjiEPKfS1_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	stur	x2, [x29, #-24]
	stur	x3, [x29, #-32]
	str	x4, [sp, #40]
	str	x5, [sp, #32]
	ldur	x8, [x29, #-32]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB5_2
	b	LBB5_1
LBB5_1:
	ldr	x8, [sp, #40]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB5_3
	b	LBB5_2
LBB5_2:
	b	LBB5_15
LBB5_3:
	ldur	x0, [x29, #-24]
	ldur	x1, [x29, #-32]
	ldr	x2, [sp, #40]
	bl	__ZN4gemm12_GLOBAL__N_111zero_outputEPfmm
	str	xzr, [sp, #24]
	b	LBB5_4
LBB5_4:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB5_6 Depth 2
                                        ;       Child Loop BB5_8 Depth 3
	ldr	x8, [sp, #24]
	ldr	x9, [sp, #32]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB5_15
	b	LBB5_5
LBB5_5:                                 ;   in Loop: Header=BB5_4 Depth=1
	str	xzr, [sp, #16]
	b	LBB5_6
LBB5_6:                                 ;   Parent Loop BB5_4 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB5_8 Depth 3
	ldr	x8, [sp, #16]
	ldr	x9, [sp, #40]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB5_13
	b	LBB5_7
LBB5_7:                                 ;   in Loop: Header=BB5_6 Depth=2
	ldur	x8, [x29, #-16]
	ldr	x9, [sp, #24]
	ldr	x10, [sp, #40]
	mul	x9, x9, x10
	ldr	x10, [sp, #16]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	str	s0, [sp, #12]
	str	xzr, [sp]
	b	LBB5_8
LBB5_8:                                 ;   Parent Loop BB5_4 Depth=1
                                        ;     Parent Loop BB5_6 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	x8, [sp]
	ldur	x9, [x29, #-32]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB5_11
	b	LBB5_9
LBB5_9:                                 ;   in Loop: Header=BB5_8 Depth=3
	ldur	x8, [x29, #-8]
	ldr	x9, [sp]
	ldr	x10, [sp, #32]
	mul	x9, x9, x10
	ldr	x10, [sp, #24]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	s1, [sp, #12]
	ldur	x8, [x29, #-24]
	ldr	x9, [sp]
	ldr	x10, [sp, #40]
	mul	x9, x9, x10
	ldr	x10, [sp, #16]
	add	x9, x9, x10
	add	x8, x8, x9, lsl #2
	ldr	s2, [x8]
	fmadd	s0, s0, s1, s2
	str	s0, [x8]
	b	LBB5_10
LBB5_10:                                ;   in Loop: Header=BB5_8 Depth=3
	ldr	x8, [sp]
	add	x8, x8, #1
	str	x8, [sp]
	b	LBB5_8
LBB5_11:                                ;   in Loop: Header=BB5_6 Depth=2
	b	LBB5_12
LBB5_12:                                ;   in Loop: Header=BB5_6 Depth=2
	ldr	x8, [sp, #16]
	add	x8, x8, #1
	str	x8, [sp, #16]
	b	LBB5_6
LBB5_13:                                ;   in Loop: Header=BB5_4 Depth=1
	b	LBB5_14
LBB5_14:                                ;   in Loop: Header=BB5_4 Depth=1
	ldr	x8, [sp, #24]
	add	x8, x8, #1
	str	x8, [sp, #24]
	b	LBB5_4
LBB5_15:
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
