	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	__ZN4gemm9naive_ijkEPKfS1_Pfmmm ; -- Begin function _ZN4gemm9naive_ijkEPKfS1_Pfmmm
	.p2align	2
__ZN4gemm9naive_ijkEPKfS1_Pfmmm:        ; @_ZN4gemm9naive_ijkEPKfS1_Pfmmm
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
	str	xzr, [sp, #24]
	b	LBB0_1
LBB0_1:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_3 Depth 2
                                        ;       Child Loop BB0_5 Depth 3
	ldr	x8, [sp, #24]
	ldr	x9, [sp, #48]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB0_12
	b	LBB0_2
LBB0_2:                                 ;   in Loop: Header=BB0_1 Depth=1
	str	xzr, [sp, #16]
	b	LBB0_3
LBB0_3:                                 ;   Parent Loop BB0_1 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_5 Depth 3
	ldr	x8, [sp, #16]
	ldr	x9, [sp, #40]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB0_10
	b	LBB0_4
LBB0_4:                                 ;   in Loop: Header=BB0_3 Depth=2
	movi	d0, #0000000000000000
	str	s0, [sp, #12]
	str	xzr, [sp]
	b	LBB0_5
LBB0_5:                                 ;   Parent Loop BB0_1 Depth=1
                                        ;     Parent Loop BB0_3 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	x8, [sp]
	ldr	x9, [sp, #32]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB0_8
	b	LBB0_6
LBB0_6:                                 ;   in Loop: Header=BB0_5 Depth=3
	ldr	x8, [sp, #72]
	ldr	x9, [sp, #24]
	ldr	x10, [sp, #32]
	mul	x9, x9, x10
	ldr	x10, [sp]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	x8, [sp, #64]
	ldr	x9, [sp]
	ldr	x10, [sp, #40]
	mul	x9, x9, x10
	ldr	x10, [sp, #16]
	add	x9, x9, x10
	ldr	s1, [x8, x9, lsl #2]
	ldr	s2, [sp, #12]
	fmadd	s0, s0, s1, s2
	str	s0, [sp, #12]
	b	LBB0_7
LBB0_7:                                 ;   in Loop: Header=BB0_5 Depth=3
	ldr	x8, [sp]
	add	x8, x8, #1
	str	x8, [sp]
	b	LBB0_5
LBB0_8:                                 ;   in Loop: Header=BB0_3 Depth=2
	ldr	s0, [sp, #12]
	ldr	x8, [sp, #56]
	ldr	x9, [sp, #24]
	ldr	x10, [sp, #40]
	mul	x9, x9, x10
	ldr	x10, [sp, #16]
	add	x9, x9, x10
	str	s0, [x8, x9, lsl #2]
	b	LBB0_9
LBB0_9:                                 ;   in Loop: Header=BB0_3 Depth=2
	ldr	x8, [sp, #16]
	add	x8, x8, #1
	str	x8, [sp, #16]
	b	LBB0_3
LBB0_10:                                ;   in Loop: Header=BB0_1 Depth=1
	b	LBB0_11
LBB0_11:                                ;   in Loop: Header=BB0_1 Depth=1
	ldr	x8, [sp, #24]
	add	x8, x8, #1
	str	x8, [sp, #24]
	b	LBB0_1
LBB0_12:
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
