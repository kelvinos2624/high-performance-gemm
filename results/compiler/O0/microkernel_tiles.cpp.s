	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	__ZN4gemm6detail8tile_2x4EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail8tile_2x4EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail8tile_2x4EPKfS2_Pfmmm:  ; @_ZN4gemm6detail8tile_2x4EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	str	x2, [sp, #24]
	str	x3, [sp, #16]
	str	x4, [sp, #8]
	str	x5, [sp]
	ldur	x0, [x29, #-8]
	ldur	x1, [x29, #-16]
	ldr	x2, [sp, #24]
	ldr	x3, [sp, #16]
	ldr	x4, [sp, #8]
	ldr	x5, [sp]
	bl	__ZN4gemm6detail12_GLOBAL__N_14tileILm2ELm4EEEvPKfS4_Pfmmm
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN4gemm6detail12_GLOBAL__N_14tileILm2ELm4EEEvPKfS4_Pfmmm
__ZN4gemm6detail12_GLOBAL__N_14tileILm2ELm4EEEvPKfS4_Pfmmm: ; @_ZN4gemm6detail12_GLOBAL__N_14tileILm2ELm4EEEvPKfS4_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #192
	.cfi_def_cfa_offset 192
	stp	x29, x30, [sp, #176]            ; 16-byte Folded Spill
	add	x29, sp, #176
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-8]
	stur	x0, [x29, #-64]
	stur	x1, [x29, #-72]
	stur	x2, [x29, #-80]
	str	x3, [sp, #88]
	str	x4, [sp, #80]
	str	x5, [sp, #72]
	str	xzr, [sp, #64]
	b	LBB1_1
LBB1_1:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_3 Depth 2
	ldr	x8, [sp, #64]
	subs	x8, x8, #2
	cset	w8, hs
	tbnz	w8, #0, LBB1_8
	b	LBB1_2
LBB1_2:                                 ;   in Loop: Header=BB1_1 Depth=1
	str	xzr, [sp, #56]
	b	LBB1_3
LBB1_3:                                 ;   Parent Loop BB1_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #56]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB1_6
	b	LBB1_4
LBB1_4:                                 ;   in Loop: Header=BB1_3 Depth=2
	ldur	x8, [x29, #-80]
	ldr	x9, [sp, #64]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp, #56]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	x9, [sp, #64]
	sub	x8, x29, #40
	add	x8, x8, x9, lsl #4
	ldr	x9, [sp, #56]
	str	s0, [x8, x9, lsl #2]
	b	LBB1_5
LBB1_5:                                 ;   in Loop: Header=BB1_3 Depth=2
	ldr	x8, [sp, #56]
	add	x8, x8, #1
	str	x8, [sp, #56]
	b	LBB1_3
LBB1_6:                                 ;   in Loop: Header=BB1_1 Depth=1
	b	LBB1_7
LBB1_7:                                 ;   in Loop: Header=BB1_1 Depth=1
	ldr	x8, [sp, #64]
	add	x8, x8, #1
	str	x8, [sp, #64]
	b	LBB1_1
LBB1_8:
	str	xzr, [sp, #48]
	b	LBB1_9
LBB1_9:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_11 Depth 2
                                        ;     Child Loop BB1_15 Depth 2
                                        ;       Child Loop BB1_17 Depth 3
	ldr	x8, [sp, #48]
	ldr	x9, [sp, #72]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB1_24
	b	LBB1_10
LBB1_10:                                ;   in Loop: Header=BB1_9 Depth=1
	str	xzr, [sp, #40]
	b	LBB1_11
LBB1_11:                                ;   Parent Loop BB1_9 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #40]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB1_14
	b	LBB1_12
LBB1_12:                                ;   in Loop: Header=BB1_11 Depth=2
	ldur	x8, [x29, #-72]
	ldr	x9, [sp, #48]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp, #40]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	x9, [sp, #40]
	sub	x8, x29, #56
	str	s0, [x8, x9, lsl #2]
	b	LBB1_13
LBB1_13:                                ;   in Loop: Header=BB1_11 Depth=2
	ldr	x8, [sp, #40]
	add	x8, x8, #1
	str	x8, [sp, #40]
	b	LBB1_11
LBB1_14:                                ;   in Loop: Header=BB1_9 Depth=1
	str	xzr, [sp, #32]
	b	LBB1_15
LBB1_15:                                ;   Parent Loop BB1_9 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB1_17 Depth 3
	ldr	x8, [sp, #32]
	subs	x8, x8, #2
	cset	w8, hs
	tbnz	w8, #0, LBB1_22
	b	LBB1_16
LBB1_16:                                ;   in Loop: Header=BB1_15 Depth=2
	ldur	x8, [x29, #-64]
	ldr	x9, [sp, #32]
	ldr	x10, [sp, #88]
	mul	x9, x9, x10
	ldr	x10, [sp, #48]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	str	s0, [sp, #28]
	str	xzr, [sp, #16]
	b	LBB1_17
LBB1_17:                                ;   Parent Loop BB1_9 Depth=1
                                        ;     Parent Loop BB1_15 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	x8, [sp, #16]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB1_20
	b	LBB1_18
LBB1_18:                                ;   in Loop: Header=BB1_17 Depth=3
	ldr	s0, [sp, #28]
	ldr	x9, [sp, #16]
	sub	x8, x29, #56
	ldr	s1, [x8, x9, lsl #2]
	ldr	x9, [sp, #32]
	sub	x8, x29, #40
	add	x8, x8, x9, lsl #4
	ldr	x9, [sp, #16]
	add	x8, x8, x9, lsl #2
	ldr	s2, [x8]
	fmadd	s0, s0, s1, s2
	str	s0, [x8]
	b	LBB1_19
LBB1_19:                                ;   in Loop: Header=BB1_17 Depth=3
	ldr	x8, [sp, #16]
	add	x8, x8, #1
	str	x8, [sp, #16]
	b	LBB1_17
LBB1_20:                                ;   in Loop: Header=BB1_15 Depth=2
	b	LBB1_21
LBB1_21:                                ;   in Loop: Header=BB1_15 Depth=2
	ldr	x8, [sp, #32]
	add	x8, x8, #1
	str	x8, [sp, #32]
	b	LBB1_15
LBB1_22:                                ;   in Loop: Header=BB1_9 Depth=1
	b	LBB1_23
LBB1_23:                                ;   in Loop: Header=BB1_9 Depth=1
	ldr	x8, [sp, #48]
	add	x8, x8, #1
	str	x8, [sp, #48]
	b	LBB1_9
LBB1_24:
	str	xzr, [sp, #8]
	b	LBB1_25
LBB1_25:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_27 Depth 2
	ldr	x8, [sp, #8]
	subs	x8, x8, #2
	cset	w8, hs
	tbnz	w8, #0, LBB1_32
	b	LBB1_26
LBB1_26:                                ;   in Loop: Header=BB1_25 Depth=1
	str	xzr, [sp]
	b	LBB1_27
LBB1_27:                                ;   Parent Loop BB1_25 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB1_30
	b	LBB1_28
LBB1_28:                                ;   in Loop: Header=BB1_27 Depth=2
	ldr	x9, [sp, #8]
	sub	x8, x29, #40
	add	x8, x8, x9, lsl #4
	ldr	x9, [sp]
	ldr	s0, [x8, x9, lsl #2]
	ldur	x8, [x29, #-80]
	ldr	x9, [sp, #8]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp]
	add	x9, x9, x10
	str	s0, [x8, x9, lsl #2]
	b	LBB1_29
LBB1_29:                                ;   in Loop: Header=BB1_27 Depth=2
	ldr	x8, [sp]
	add	x8, x8, #1
	str	x8, [sp]
	b	LBB1_27
LBB1_30:                                ;   in Loop: Header=BB1_25 Depth=1
	b	LBB1_31
LBB1_31:                                ;   in Loop: Header=BB1_25 Depth=1
	ldr	x8, [sp, #8]
	add	x8, x8, #1
	str	x8, [sp, #8]
	b	LBB1_25
LBB1_32:
	ldur	x9, [x29, #-8]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB1_34
	b	LBB1_33
LBB1_33:
	bl	___stack_chk_fail
LBB1_34:
	ldp	x29, x30, [sp, #176]            ; 16-byte Folded Reload
	add	sp, sp, #192
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm6detail8tile_4x4EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail8tile_4x4EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail8tile_4x4EPKfS2_Pfmmm:  ; @_ZN4gemm6detail8tile_4x4EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	str	x2, [sp, #24]
	str	x3, [sp, #16]
	str	x4, [sp, #8]
	str	x5, [sp]
	ldur	x0, [x29, #-8]
	ldur	x1, [x29, #-16]
	ldr	x2, [sp, #24]
	ldr	x3, [sp, #16]
	ldr	x4, [sp, #8]
	ldr	x5, [sp]
	bl	__ZN4gemm6detail12_GLOBAL__N_14tileILm4ELm4EEEvPKfS4_Pfmmm
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN4gemm6detail12_GLOBAL__N_14tileILm4ELm4EEEvPKfS4_Pfmmm
__ZN4gemm6detail12_GLOBAL__N_14tileILm4ELm4EEEvPKfS4_Pfmmm: ; @_ZN4gemm6detail12_GLOBAL__N_14tileILm4ELm4EEEvPKfS4_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #224
	.cfi_def_cfa_offset 224
	stp	x29, x30, [sp, #208]            ; 16-byte Folded Spill
	add	x29, sp, #208
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-8]
	stur	x0, [x29, #-96]
	str	x1, [sp, #104]
	str	x2, [sp, #96]
	str	x3, [sp, #88]
	str	x4, [sp, #80]
	str	x5, [sp, #72]
	str	xzr, [sp, #64]
	b	LBB3_1
LBB3_1:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_3 Depth 2
	ldr	x8, [sp, #64]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB3_8
	b	LBB3_2
LBB3_2:                                 ;   in Loop: Header=BB3_1 Depth=1
	str	xzr, [sp, #56]
	b	LBB3_3
LBB3_3:                                 ;   Parent Loop BB3_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #56]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB3_6
	b	LBB3_4
LBB3_4:                                 ;   in Loop: Header=BB3_3 Depth=2
	ldr	x8, [sp, #96]
	ldr	x9, [sp, #64]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp, #56]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	x9, [sp, #64]
	sub	x8, x29, #72
	add	x8, x8, x9, lsl #4
	ldr	x9, [sp, #56]
	str	s0, [x8, x9, lsl #2]
	b	LBB3_5
LBB3_5:                                 ;   in Loop: Header=BB3_3 Depth=2
	ldr	x8, [sp, #56]
	add	x8, x8, #1
	str	x8, [sp, #56]
	b	LBB3_3
LBB3_6:                                 ;   in Loop: Header=BB3_1 Depth=1
	b	LBB3_7
LBB3_7:                                 ;   in Loop: Header=BB3_1 Depth=1
	ldr	x8, [sp, #64]
	add	x8, x8, #1
	str	x8, [sp, #64]
	b	LBB3_1
LBB3_8:
	str	xzr, [sp, #48]
	b	LBB3_9
LBB3_9:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_11 Depth 2
                                        ;     Child Loop BB3_15 Depth 2
                                        ;       Child Loop BB3_17 Depth 3
	ldr	x8, [sp, #48]
	ldr	x9, [sp, #72]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB3_24
	b	LBB3_10
LBB3_10:                                ;   in Loop: Header=BB3_9 Depth=1
	str	xzr, [sp, #40]
	b	LBB3_11
LBB3_11:                                ;   Parent Loop BB3_9 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #40]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB3_14
	b	LBB3_12
LBB3_12:                                ;   in Loop: Header=BB3_11 Depth=2
	ldr	x8, [sp, #104]
	ldr	x9, [sp, #48]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp, #40]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	x9, [sp, #40]
	sub	x8, x29, #88
	str	s0, [x8, x9, lsl #2]
	b	LBB3_13
LBB3_13:                                ;   in Loop: Header=BB3_11 Depth=2
	ldr	x8, [sp, #40]
	add	x8, x8, #1
	str	x8, [sp, #40]
	b	LBB3_11
LBB3_14:                                ;   in Loop: Header=BB3_9 Depth=1
	str	xzr, [sp, #32]
	b	LBB3_15
LBB3_15:                                ;   Parent Loop BB3_9 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB3_17 Depth 3
	ldr	x8, [sp, #32]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB3_22
	b	LBB3_16
LBB3_16:                                ;   in Loop: Header=BB3_15 Depth=2
	ldur	x8, [x29, #-96]
	ldr	x9, [sp, #32]
	ldr	x10, [sp, #88]
	mul	x9, x9, x10
	ldr	x10, [sp, #48]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	str	s0, [sp, #28]
	str	xzr, [sp, #16]
	b	LBB3_17
LBB3_17:                                ;   Parent Loop BB3_9 Depth=1
                                        ;     Parent Loop BB3_15 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	x8, [sp, #16]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB3_20
	b	LBB3_18
LBB3_18:                                ;   in Loop: Header=BB3_17 Depth=3
	ldr	s0, [sp, #28]
	ldr	x9, [sp, #16]
	sub	x8, x29, #88
	ldr	s1, [x8, x9, lsl #2]
	ldr	x9, [sp, #32]
	sub	x8, x29, #72
	add	x8, x8, x9, lsl #4
	ldr	x9, [sp, #16]
	add	x8, x8, x9, lsl #2
	ldr	s2, [x8]
	fmadd	s0, s0, s1, s2
	str	s0, [x8]
	b	LBB3_19
LBB3_19:                                ;   in Loop: Header=BB3_17 Depth=3
	ldr	x8, [sp, #16]
	add	x8, x8, #1
	str	x8, [sp, #16]
	b	LBB3_17
LBB3_20:                                ;   in Loop: Header=BB3_15 Depth=2
	b	LBB3_21
LBB3_21:                                ;   in Loop: Header=BB3_15 Depth=2
	ldr	x8, [sp, #32]
	add	x8, x8, #1
	str	x8, [sp, #32]
	b	LBB3_15
LBB3_22:                                ;   in Loop: Header=BB3_9 Depth=1
	b	LBB3_23
LBB3_23:                                ;   in Loop: Header=BB3_9 Depth=1
	ldr	x8, [sp, #48]
	add	x8, x8, #1
	str	x8, [sp, #48]
	b	LBB3_9
LBB3_24:
	str	xzr, [sp, #8]
	b	LBB3_25
LBB3_25:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_27 Depth 2
	ldr	x8, [sp, #8]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB3_32
	b	LBB3_26
LBB3_26:                                ;   in Loop: Header=BB3_25 Depth=1
	str	xzr, [sp]
	b	LBB3_27
LBB3_27:                                ;   Parent Loop BB3_25 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB3_30
	b	LBB3_28
LBB3_28:                                ;   in Loop: Header=BB3_27 Depth=2
	ldr	x9, [sp, #8]
	sub	x8, x29, #72
	add	x8, x8, x9, lsl #4
	ldr	x9, [sp]
	ldr	s0, [x8, x9, lsl #2]
	ldr	x8, [sp, #96]
	ldr	x9, [sp, #8]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp]
	add	x9, x9, x10
	str	s0, [x8, x9, lsl #2]
	b	LBB3_29
LBB3_29:                                ;   in Loop: Header=BB3_27 Depth=2
	ldr	x8, [sp]
	add	x8, x8, #1
	str	x8, [sp]
	b	LBB3_27
LBB3_30:                                ;   in Loop: Header=BB3_25 Depth=1
	b	LBB3_31
LBB3_31:                                ;   in Loop: Header=BB3_25 Depth=1
	ldr	x8, [sp, #8]
	add	x8, x8, #1
	str	x8, [sp, #8]
	b	LBB3_25
LBB3_32:
	ldur	x9, [x29, #-8]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB3_34
	b	LBB3_33
LBB3_33:
	bl	___stack_chk_fail
LBB3_34:
	ldp	x29, x30, [sp, #208]            ; 16-byte Folded Reload
	add	sp, sp, #224
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm6detail8tile_4x8EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail8tile_4x8EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail8tile_4x8EPKfS2_Pfmmm:  ; @_ZN4gemm6detail8tile_4x8EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	str	x2, [sp, #24]
	str	x3, [sp, #16]
	str	x4, [sp, #8]
	str	x5, [sp]
	ldur	x0, [x29, #-8]
	ldur	x1, [x29, #-16]
	ldr	x2, [sp, #24]
	ldr	x3, [sp, #16]
	ldr	x4, [sp, #8]
	ldr	x5, [sp]
	bl	__ZN4gemm6detail12_GLOBAL__N_14tileILm4ELm8EEEvPKfS4_Pfmmm
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN4gemm6detail12_GLOBAL__N_14tileILm4ELm8EEEvPKfS4_Pfmmm
__ZN4gemm6detail12_GLOBAL__N_14tileILm4ELm8EEEvPKfS4_Pfmmm: ; @_ZN4gemm6detail12_GLOBAL__N_14tileILm4ELm8EEEvPKfS4_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #320
	.cfi_def_cfa_offset 320
	stp	x28, x27, [sp, #288]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #304]            ; 16-byte Folded Spill
	add	x29, sp, #304
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	str	x0, [sp, #112]
	str	x1, [sp, #104]
	str	x2, [sp, #96]
	str	x3, [sp, #88]
	str	x4, [sp, #80]
	str	x5, [sp, #72]
	str	xzr, [sp, #64]
	b	LBB5_1
LBB5_1:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB5_3 Depth 2
	ldr	x8, [sp, #64]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB5_8
	b	LBB5_2
LBB5_2:                                 ;   in Loop: Header=BB5_1 Depth=1
	str	xzr, [sp, #56]
	b	LBB5_3
LBB5_3:                                 ;   Parent Loop BB5_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #56]
	subs	x8, x8, #8
	cset	w8, hs
	tbnz	w8, #0, LBB5_6
	b	LBB5_4
LBB5_4:                                 ;   in Loop: Header=BB5_3 Depth=2
	ldr	x8, [sp, #96]
	ldr	x9, [sp, #64]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp, #56]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	x9, [sp, #64]
	add	x8, sp, #152
	add	x8, x8, x9, lsl #5
	ldr	x9, [sp, #56]
	str	s0, [x8, x9, lsl #2]
	b	LBB5_5
LBB5_5:                                 ;   in Loop: Header=BB5_3 Depth=2
	ldr	x8, [sp, #56]
	add	x8, x8, #1
	str	x8, [sp, #56]
	b	LBB5_3
LBB5_6:                                 ;   in Loop: Header=BB5_1 Depth=1
	b	LBB5_7
LBB5_7:                                 ;   in Loop: Header=BB5_1 Depth=1
	ldr	x8, [sp, #64]
	add	x8, x8, #1
	str	x8, [sp, #64]
	b	LBB5_1
LBB5_8:
	str	xzr, [sp, #48]
	b	LBB5_9
LBB5_9:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB5_11 Depth 2
                                        ;     Child Loop BB5_15 Depth 2
                                        ;       Child Loop BB5_17 Depth 3
	ldr	x8, [sp, #48]
	ldr	x9, [sp, #72]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB5_24
	b	LBB5_10
LBB5_10:                                ;   in Loop: Header=BB5_9 Depth=1
	str	xzr, [sp, #40]
	b	LBB5_11
LBB5_11:                                ;   Parent Loop BB5_9 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #40]
	subs	x8, x8, #8
	cset	w8, hs
	tbnz	w8, #0, LBB5_14
	b	LBB5_12
LBB5_12:                                ;   in Loop: Header=BB5_11 Depth=2
	ldr	x8, [sp, #104]
	ldr	x9, [sp, #48]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp, #40]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	x9, [sp, #40]
	add	x8, sp, #120
	str	s0, [x8, x9, lsl #2]
	b	LBB5_13
LBB5_13:                                ;   in Loop: Header=BB5_11 Depth=2
	ldr	x8, [sp, #40]
	add	x8, x8, #1
	str	x8, [sp, #40]
	b	LBB5_11
LBB5_14:                                ;   in Loop: Header=BB5_9 Depth=1
	str	xzr, [sp, #32]
	b	LBB5_15
LBB5_15:                                ;   Parent Loop BB5_9 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB5_17 Depth 3
	ldr	x8, [sp, #32]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB5_22
	b	LBB5_16
LBB5_16:                                ;   in Loop: Header=BB5_15 Depth=2
	ldr	x8, [sp, #112]
	ldr	x9, [sp, #32]
	ldr	x10, [sp, #88]
	mul	x9, x9, x10
	ldr	x10, [sp, #48]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	str	s0, [sp, #28]
	str	xzr, [sp, #16]
	b	LBB5_17
LBB5_17:                                ;   Parent Loop BB5_9 Depth=1
                                        ;     Parent Loop BB5_15 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	x8, [sp, #16]
	subs	x8, x8, #8
	cset	w8, hs
	tbnz	w8, #0, LBB5_20
	b	LBB5_18
LBB5_18:                                ;   in Loop: Header=BB5_17 Depth=3
	ldr	s0, [sp, #28]
	ldr	x9, [sp, #16]
	add	x8, sp, #120
	ldr	s1, [x8, x9, lsl #2]
	ldr	x9, [sp, #32]
	add	x8, sp, #152
	add	x8, x8, x9, lsl #5
	ldr	x9, [sp, #16]
	add	x8, x8, x9, lsl #2
	ldr	s2, [x8]
	fmadd	s0, s0, s1, s2
	str	s0, [x8]
	b	LBB5_19
LBB5_19:                                ;   in Loop: Header=BB5_17 Depth=3
	ldr	x8, [sp, #16]
	add	x8, x8, #1
	str	x8, [sp, #16]
	b	LBB5_17
LBB5_20:                                ;   in Loop: Header=BB5_15 Depth=2
	b	LBB5_21
LBB5_21:                                ;   in Loop: Header=BB5_15 Depth=2
	ldr	x8, [sp, #32]
	add	x8, x8, #1
	str	x8, [sp, #32]
	b	LBB5_15
LBB5_22:                                ;   in Loop: Header=BB5_9 Depth=1
	b	LBB5_23
LBB5_23:                                ;   in Loop: Header=BB5_9 Depth=1
	ldr	x8, [sp, #48]
	add	x8, x8, #1
	str	x8, [sp, #48]
	b	LBB5_9
LBB5_24:
	str	xzr, [sp, #8]
	b	LBB5_25
LBB5_25:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB5_27 Depth 2
	ldr	x8, [sp, #8]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB5_32
	b	LBB5_26
LBB5_26:                                ;   in Loop: Header=BB5_25 Depth=1
	str	xzr, [sp]
	b	LBB5_27
LBB5_27:                                ;   Parent Loop BB5_25 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp]
	subs	x8, x8, #8
	cset	w8, hs
	tbnz	w8, #0, LBB5_30
	b	LBB5_28
LBB5_28:                                ;   in Loop: Header=BB5_27 Depth=2
	ldr	x9, [sp, #8]
	add	x8, sp, #152
	add	x8, x8, x9, lsl #5
	ldr	x9, [sp]
	ldr	s0, [x8, x9, lsl #2]
	ldr	x8, [sp, #96]
	ldr	x9, [sp, #8]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp]
	add	x9, x9, x10
	str	s0, [x8, x9, lsl #2]
	b	LBB5_29
LBB5_29:                                ;   in Loop: Header=BB5_27 Depth=2
	ldr	x8, [sp]
	add	x8, x8, #1
	str	x8, [sp]
	b	LBB5_27
LBB5_30:                                ;   in Loop: Header=BB5_25 Depth=1
	b	LBB5_31
LBB5_31:                                ;   in Loop: Header=BB5_25 Depth=1
	ldr	x8, [sp, #8]
	add	x8, x8, #1
	str	x8, [sp, #8]
	b	LBB5_25
LBB5_32:
	ldur	x9, [x29, #-24]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB5_34
	b	LBB5_33
LBB5_33:
	bl	___stack_chk_fail
LBB5_34:
	ldp	x29, x30, [sp, #304]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #288]            ; 16-byte Folded Reload
	add	sp, sp, #320
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm6detail8tile_8x4EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail8tile_8x4EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail8tile_8x4EPKfS2_Pfmmm:  ; @_ZN4gemm6detail8tile_8x4EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	str	x2, [sp, #24]
	str	x3, [sp, #16]
	str	x4, [sp, #8]
	str	x5, [sp]
	ldur	x0, [x29, #-8]
	ldur	x1, [x29, #-16]
	ldr	x2, [sp, #24]
	ldr	x3, [sp, #16]
	ldr	x4, [sp, #8]
	ldr	x5, [sp]
	bl	__ZN4gemm6detail12_GLOBAL__N_14tileILm8ELm4EEEvPKfS4_Pfmmm
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN4gemm6detail12_GLOBAL__N_14tileILm8ELm4EEEvPKfS4_Pfmmm
__ZN4gemm6detail12_GLOBAL__N_14tileILm8ELm4EEEvPKfS4_Pfmmm: ; @_ZN4gemm6detail12_GLOBAL__N_14tileILm8ELm4EEEvPKfS4_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #304
	.cfi_def_cfa_offset 304
	stp	x28, x27, [sp, #272]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #288]            ; 16-byte Folded Spill
	add	x29, sp, #288
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	str	x0, [sp, #112]
	str	x1, [sp, #104]
	str	x2, [sp, #96]
	str	x3, [sp, #88]
	str	x4, [sp, #80]
	str	x5, [sp, #72]
	str	xzr, [sp, #64]
	b	LBB7_1
LBB7_1:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB7_3 Depth 2
	ldr	x8, [sp, #64]
	subs	x8, x8, #8
	cset	w8, hs
	tbnz	w8, #0, LBB7_8
	b	LBB7_2
LBB7_2:                                 ;   in Loop: Header=BB7_1 Depth=1
	str	xzr, [sp, #56]
	b	LBB7_3
LBB7_3:                                 ;   Parent Loop BB7_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #56]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB7_6
	b	LBB7_4
LBB7_4:                                 ;   in Loop: Header=BB7_3 Depth=2
	ldr	x8, [sp, #96]
	ldr	x9, [sp, #64]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp, #56]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	x9, [sp, #64]
	add	x8, sp, #136
	add	x8, x8, x9, lsl #4
	ldr	x9, [sp, #56]
	str	s0, [x8, x9, lsl #2]
	b	LBB7_5
LBB7_5:                                 ;   in Loop: Header=BB7_3 Depth=2
	ldr	x8, [sp, #56]
	add	x8, x8, #1
	str	x8, [sp, #56]
	b	LBB7_3
LBB7_6:                                 ;   in Loop: Header=BB7_1 Depth=1
	b	LBB7_7
LBB7_7:                                 ;   in Loop: Header=BB7_1 Depth=1
	ldr	x8, [sp, #64]
	add	x8, x8, #1
	str	x8, [sp, #64]
	b	LBB7_1
LBB7_8:
	str	xzr, [sp, #48]
	b	LBB7_9
LBB7_9:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB7_11 Depth 2
                                        ;     Child Loop BB7_15 Depth 2
                                        ;       Child Loop BB7_17 Depth 3
	ldr	x8, [sp, #48]
	ldr	x9, [sp, #72]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB7_24
	b	LBB7_10
LBB7_10:                                ;   in Loop: Header=BB7_9 Depth=1
	str	xzr, [sp, #40]
	b	LBB7_11
LBB7_11:                                ;   Parent Loop BB7_9 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #40]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB7_14
	b	LBB7_12
LBB7_12:                                ;   in Loop: Header=BB7_11 Depth=2
	ldr	x8, [sp, #104]
	ldr	x9, [sp, #48]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp, #40]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	x9, [sp, #40]
	add	x8, sp, #120
	str	s0, [x8, x9, lsl #2]
	b	LBB7_13
LBB7_13:                                ;   in Loop: Header=BB7_11 Depth=2
	ldr	x8, [sp, #40]
	add	x8, x8, #1
	str	x8, [sp, #40]
	b	LBB7_11
LBB7_14:                                ;   in Loop: Header=BB7_9 Depth=1
	str	xzr, [sp, #32]
	b	LBB7_15
LBB7_15:                                ;   Parent Loop BB7_9 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB7_17 Depth 3
	ldr	x8, [sp, #32]
	subs	x8, x8, #8
	cset	w8, hs
	tbnz	w8, #0, LBB7_22
	b	LBB7_16
LBB7_16:                                ;   in Loop: Header=BB7_15 Depth=2
	ldr	x8, [sp, #112]
	ldr	x9, [sp, #32]
	ldr	x10, [sp, #88]
	mul	x9, x9, x10
	ldr	x10, [sp, #48]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	str	s0, [sp, #28]
	str	xzr, [sp, #16]
	b	LBB7_17
LBB7_17:                                ;   Parent Loop BB7_9 Depth=1
                                        ;     Parent Loop BB7_15 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	x8, [sp, #16]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB7_20
	b	LBB7_18
LBB7_18:                                ;   in Loop: Header=BB7_17 Depth=3
	ldr	s0, [sp, #28]
	ldr	x9, [sp, #16]
	add	x8, sp, #120
	ldr	s1, [x8, x9, lsl #2]
	ldr	x9, [sp, #32]
	add	x8, sp, #136
	add	x8, x8, x9, lsl #4
	ldr	x9, [sp, #16]
	add	x8, x8, x9, lsl #2
	ldr	s2, [x8]
	fmadd	s0, s0, s1, s2
	str	s0, [x8]
	b	LBB7_19
LBB7_19:                                ;   in Loop: Header=BB7_17 Depth=3
	ldr	x8, [sp, #16]
	add	x8, x8, #1
	str	x8, [sp, #16]
	b	LBB7_17
LBB7_20:                                ;   in Loop: Header=BB7_15 Depth=2
	b	LBB7_21
LBB7_21:                                ;   in Loop: Header=BB7_15 Depth=2
	ldr	x8, [sp, #32]
	add	x8, x8, #1
	str	x8, [sp, #32]
	b	LBB7_15
LBB7_22:                                ;   in Loop: Header=BB7_9 Depth=1
	b	LBB7_23
LBB7_23:                                ;   in Loop: Header=BB7_9 Depth=1
	ldr	x8, [sp, #48]
	add	x8, x8, #1
	str	x8, [sp, #48]
	b	LBB7_9
LBB7_24:
	str	xzr, [sp, #8]
	b	LBB7_25
LBB7_25:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB7_27 Depth 2
	ldr	x8, [sp, #8]
	subs	x8, x8, #8
	cset	w8, hs
	tbnz	w8, #0, LBB7_32
	b	LBB7_26
LBB7_26:                                ;   in Loop: Header=BB7_25 Depth=1
	str	xzr, [sp]
	b	LBB7_27
LBB7_27:                                ;   Parent Loop BB7_25 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp]
	subs	x8, x8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB7_30
	b	LBB7_28
LBB7_28:                                ;   in Loop: Header=BB7_27 Depth=2
	ldr	x9, [sp, #8]
	add	x8, sp, #136
	add	x8, x8, x9, lsl #4
	ldr	x9, [sp]
	ldr	s0, [x8, x9, lsl #2]
	ldr	x8, [sp, #96]
	ldr	x9, [sp, #8]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp]
	add	x9, x9, x10
	str	s0, [x8, x9, lsl #2]
	b	LBB7_29
LBB7_29:                                ;   in Loop: Header=BB7_27 Depth=2
	ldr	x8, [sp]
	add	x8, x8, #1
	str	x8, [sp]
	b	LBB7_27
LBB7_30:                                ;   in Loop: Header=BB7_25 Depth=1
	b	LBB7_31
LBB7_31:                                ;   in Loop: Header=BB7_25 Depth=1
	ldr	x8, [sp, #8]
	add	x8, x8, #1
	str	x8, [sp, #8]
	b	LBB7_25
LBB7_32:
	ldur	x9, [x29, #-24]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB7_34
	b	LBB7_33
LBB7_33:
	bl	___stack_chk_fail
LBB7_34:
	ldp	x29, x30, [sp, #288]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #272]            ; 16-byte Folded Reload
	add	sp, sp, #304
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm6detail8tile_8x8EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail8tile_8x8EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail8tile_8x8EPKfS2_Pfmmm:  ; @_ZN4gemm6detail8tile_8x8EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	str	x2, [sp, #24]
	str	x3, [sp, #16]
	str	x4, [sp, #8]
	str	x5, [sp]
	ldur	x0, [x29, #-8]
	ldur	x1, [x29, #-16]
	ldr	x2, [sp, #24]
	ldr	x3, [sp, #16]
	ldr	x4, [sp, #8]
	ldr	x5, [sp]
	bl	__ZN4gemm6detail12_GLOBAL__N_14tileILm8ELm8EEEvPKfS4_Pfmmm
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN4gemm6detail12_GLOBAL__N_14tileILm8ELm8EEEvPKfS4_Pfmmm
__ZN4gemm6detail12_GLOBAL__N_14tileILm8ELm8EEEvPKfS4_Pfmmm: ; @_ZN4gemm6detail12_GLOBAL__N_14tileILm8ELm8EEEvPKfS4_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #448
	.cfi_def_cfa_offset 448
	stp	x28, x27, [sp, #416]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #432]            ; 16-byte Folded Spill
	add	x29, sp, #432
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	str	x0, [sp, #112]
	str	x1, [sp, #104]
	str	x2, [sp, #96]
	str	x3, [sp, #88]
	str	x4, [sp, #80]
	str	x5, [sp, #72]
	str	xzr, [sp, #64]
	b	LBB9_1
LBB9_1:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB9_3 Depth 2
	ldr	x8, [sp, #64]
	subs	x8, x8, #8
	cset	w8, hs
	tbnz	w8, #0, LBB9_8
	b	LBB9_2
LBB9_2:                                 ;   in Loop: Header=BB9_1 Depth=1
	str	xzr, [sp, #56]
	b	LBB9_3
LBB9_3:                                 ;   Parent Loop BB9_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #56]
	subs	x8, x8, #8
	cset	w8, hs
	tbnz	w8, #0, LBB9_6
	b	LBB9_4
LBB9_4:                                 ;   in Loop: Header=BB9_3 Depth=2
	ldr	x8, [sp, #96]
	ldr	x9, [sp, #64]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp, #56]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	x9, [sp, #64]
	add	x8, sp, #152
	add	x8, x8, x9, lsl #5
	ldr	x9, [sp, #56]
	str	s0, [x8, x9, lsl #2]
	b	LBB9_5
LBB9_5:                                 ;   in Loop: Header=BB9_3 Depth=2
	ldr	x8, [sp, #56]
	add	x8, x8, #1
	str	x8, [sp, #56]
	b	LBB9_3
LBB9_6:                                 ;   in Loop: Header=BB9_1 Depth=1
	b	LBB9_7
LBB9_7:                                 ;   in Loop: Header=BB9_1 Depth=1
	ldr	x8, [sp, #64]
	add	x8, x8, #1
	str	x8, [sp, #64]
	b	LBB9_1
LBB9_8:
	str	xzr, [sp, #48]
	b	LBB9_9
LBB9_9:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB9_11 Depth 2
                                        ;     Child Loop BB9_15 Depth 2
                                        ;       Child Loop BB9_17 Depth 3
	ldr	x8, [sp, #48]
	ldr	x9, [sp, #72]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB9_24
	b	LBB9_10
LBB9_10:                                ;   in Loop: Header=BB9_9 Depth=1
	str	xzr, [sp, #40]
	b	LBB9_11
LBB9_11:                                ;   Parent Loop BB9_9 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #40]
	subs	x8, x8, #8
	cset	w8, hs
	tbnz	w8, #0, LBB9_14
	b	LBB9_12
LBB9_12:                                ;   in Loop: Header=BB9_11 Depth=2
	ldr	x8, [sp, #104]
	ldr	x9, [sp, #48]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp, #40]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	x9, [sp, #40]
	add	x8, sp, #120
	str	s0, [x8, x9, lsl #2]
	b	LBB9_13
LBB9_13:                                ;   in Loop: Header=BB9_11 Depth=2
	ldr	x8, [sp, #40]
	add	x8, x8, #1
	str	x8, [sp, #40]
	b	LBB9_11
LBB9_14:                                ;   in Loop: Header=BB9_9 Depth=1
	str	xzr, [sp, #32]
	b	LBB9_15
LBB9_15:                                ;   Parent Loop BB9_9 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB9_17 Depth 3
	ldr	x8, [sp, #32]
	subs	x8, x8, #8
	cset	w8, hs
	tbnz	w8, #0, LBB9_22
	b	LBB9_16
LBB9_16:                                ;   in Loop: Header=BB9_15 Depth=2
	ldr	x8, [sp, #112]
	ldr	x9, [sp, #32]
	ldr	x10, [sp, #88]
	mul	x9, x9, x10
	ldr	x10, [sp, #48]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	str	s0, [sp, #28]
	str	xzr, [sp, #16]
	b	LBB9_17
LBB9_17:                                ;   Parent Loop BB9_9 Depth=1
                                        ;     Parent Loop BB9_15 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	x8, [sp, #16]
	subs	x8, x8, #8
	cset	w8, hs
	tbnz	w8, #0, LBB9_20
	b	LBB9_18
LBB9_18:                                ;   in Loop: Header=BB9_17 Depth=3
	ldr	s0, [sp, #28]
	ldr	x9, [sp, #16]
	add	x8, sp, #120
	ldr	s1, [x8, x9, lsl #2]
	ldr	x9, [sp, #32]
	add	x8, sp, #152
	add	x8, x8, x9, lsl #5
	ldr	x9, [sp, #16]
	add	x8, x8, x9, lsl #2
	ldr	s2, [x8]
	fmadd	s0, s0, s1, s2
	str	s0, [x8]
	b	LBB9_19
LBB9_19:                                ;   in Loop: Header=BB9_17 Depth=3
	ldr	x8, [sp, #16]
	add	x8, x8, #1
	str	x8, [sp, #16]
	b	LBB9_17
LBB9_20:                                ;   in Loop: Header=BB9_15 Depth=2
	b	LBB9_21
LBB9_21:                                ;   in Loop: Header=BB9_15 Depth=2
	ldr	x8, [sp, #32]
	add	x8, x8, #1
	str	x8, [sp, #32]
	b	LBB9_15
LBB9_22:                                ;   in Loop: Header=BB9_9 Depth=1
	b	LBB9_23
LBB9_23:                                ;   in Loop: Header=BB9_9 Depth=1
	ldr	x8, [sp, #48]
	add	x8, x8, #1
	str	x8, [sp, #48]
	b	LBB9_9
LBB9_24:
	str	xzr, [sp, #8]
	b	LBB9_25
LBB9_25:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB9_27 Depth 2
	ldr	x8, [sp, #8]
	subs	x8, x8, #8
	cset	w8, hs
	tbnz	w8, #0, LBB9_32
	b	LBB9_26
LBB9_26:                                ;   in Loop: Header=BB9_25 Depth=1
	str	xzr, [sp]
	b	LBB9_27
LBB9_27:                                ;   Parent Loop BB9_25 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp]
	subs	x8, x8, #8
	cset	w8, hs
	tbnz	w8, #0, LBB9_30
	b	LBB9_28
LBB9_28:                                ;   in Loop: Header=BB9_27 Depth=2
	ldr	x9, [sp, #8]
	add	x8, sp, #152
	add	x8, x8, x9, lsl #5
	ldr	x9, [sp]
	ldr	s0, [x8, x9, lsl #2]
	ldr	x8, [sp, #96]
	ldr	x9, [sp, #8]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp]
	add	x9, x9, x10
	str	s0, [x8, x9, lsl #2]
	b	LBB9_29
LBB9_29:                                ;   in Loop: Header=BB9_27 Depth=2
	ldr	x8, [sp]
	add	x8, x8, #1
	str	x8, [sp]
	b	LBB9_27
LBB9_30:                                ;   in Loop: Header=BB9_25 Depth=1
	b	LBB9_31
LBB9_31:                                ;   in Loop: Header=BB9_25 Depth=1
	ldr	x8, [sp, #8]
	add	x8, x8, #1
	str	x8, [sp, #8]
	b	LBB9_25
LBB9_32:
	ldur	x9, [x29, #-24]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB9_34
	b	LBB9_33
LBB9_33:
	bl	___stack_chk_fail
LBB9_34:
	ldp	x29, x30, [sp, #432]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #416]            ; 16-byte Folded Reload
	add	sp, sp, #448
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm6detail10tile_16x16EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail10tile_16x16EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail10tile_16x16EPKfS2_Pfmmm: ; @_ZN4gemm6detail10tile_16x16EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	str	x2, [sp, #24]
	str	x3, [sp, #16]
	str	x4, [sp, #8]
	str	x5, [sp]
	ldur	x0, [x29, #-8]
	ldur	x1, [x29, #-16]
	ldr	x2, [sp, #24]
	ldr	x3, [sp, #16]
	ldr	x4, [sp, #8]
	ldr	x5, [sp]
	bl	__ZN4gemm6detail12_GLOBAL__N_14tileILm16ELm16EEEvPKfS4_Pfmmm
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN4gemm6detail12_GLOBAL__N_14tileILm16ELm16EEEvPKfS4_Pfmmm
__ZN4gemm6detail12_GLOBAL__N_14tileILm16ELm16EEEvPKfS4_Pfmmm: ; @_ZN4gemm6detail12_GLOBAL__N_14tileILm16ELm16EEEvPKfS4_Pfmmm
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-32]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	sub	sp, sp, #1216
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	str	x0, [sp, #112]
	str	x1, [sp, #104]
	str	x2, [sp, #96]
	str	x3, [sp, #88]
	str	x4, [sp, #80]
	str	x5, [sp, #72]
	str	xzr, [sp, #64]
	b	LBB11_1
LBB11_1:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB11_3 Depth 2
	ldr	x8, [sp, #64]
	subs	x8, x8, #16
	cset	w8, hs
	tbnz	w8, #0, LBB11_8
	b	LBB11_2
LBB11_2:                                ;   in Loop: Header=BB11_1 Depth=1
	str	xzr, [sp, #56]
	b	LBB11_3
LBB11_3:                                ;   Parent Loop BB11_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #56]
	subs	x8, x8, #16
	cset	w8, hs
	tbnz	w8, #0, LBB11_6
	b	LBB11_4
LBB11_4:                                ;   in Loop: Header=BB11_3 Depth=2
	ldr	x8, [sp, #96]
	ldr	x9, [sp, #64]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp, #56]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	x9, [sp, #64]
	add	x8, sp, #184
	add	x8, x8, x9, lsl #6
	ldr	x9, [sp, #56]
	str	s0, [x8, x9, lsl #2]
	b	LBB11_5
LBB11_5:                                ;   in Loop: Header=BB11_3 Depth=2
	ldr	x8, [sp, #56]
	add	x8, x8, #1
	str	x8, [sp, #56]
	b	LBB11_3
LBB11_6:                                ;   in Loop: Header=BB11_1 Depth=1
	b	LBB11_7
LBB11_7:                                ;   in Loop: Header=BB11_1 Depth=1
	ldr	x8, [sp, #64]
	add	x8, x8, #1
	str	x8, [sp, #64]
	b	LBB11_1
LBB11_8:
	str	xzr, [sp, #48]
	b	LBB11_9
LBB11_9:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB11_11 Depth 2
                                        ;     Child Loop BB11_15 Depth 2
                                        ;       Child Loop BB11_17 Depth 3
	ldr	x8, [sp, #48]
	ldr	x9, [sp, #72]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB11_24
	b	LBB11_10
LBB11_10:                               ;   in Loop: Header=BB11_9 Depth=1
	str	xzr, [sp, #40]
	b	LBB11_11
LBB11_11:                               ;   Parent Loop BB11_9 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #40]
	subs	x8, x8, #16
	cset	w8, hs
	tbnz	w8, #0, LBB11_14
	b	LBB11_12
LBB11_12:                               ;   in Loop: Header=BB11_11 Depth=2
	ldr	x8, [sp, #104]
	ldr	x9, [sp, #48]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp, #40]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	ldr	x9, [sp, #40]
	add	x8, sp, #120
	str	s0, [x8, x9, lsl #2]
	b	LBB11_13
LBB11_13:                               ;   in Loop: Header=BB11_11 Depth=2
	ldr	x8, [sp, #40]
	add	x8, x8, #1
	str	x8, [sp, #40]
	b	LBB11_11
LBB11_14:                               ;   in Loop: Header=BB11_9 Depth=1
	str	xzr, [sp, #32]
	b	LBB11_15
LBB11_15:                               ;   Parent Loop BB11_9 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB11_17 Depth 3
	ldr	x8, [sp, #32]
	subs	x8, x8, #16
	cset	w8, hs
	tbnz	w8, #0, LBB11_22
	b	LBB11_16
LBB11_16:                               ;   in Loop: Header=BB11_15 Depth=2
	ldr	x8, [sp, #112]
	ldr	x9, [sp, #32]
	ldr	x10, [sp, #88]
	mul	x9, x9, x10
	ldr	x10, [sp, #48]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	str	s0, [sp, #28]
	str	xzr, [sp, #16]
	b	LBB11_17
LBB11_17:                               ;   Parent Loop BB11_9 Depth=1
                                        ;     Parent Loop BB11_15 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	x8, [sp, #16]
	subs	x8, x8, #16
	cset	w8, hs
	tbnz	w8, #0, LBB11_20
	b	LBB11_18
LBB11_18:                               ;   in Loop: Header=BB11_17 Depth=3
	ldr	s0, [sp, #28]
	ldr	x9, [sp, #16]
	add	x8, sp, #120
	ldr	s1, [x8, x9, lsl #2]
	ldr	x9, [sp, #32]
	add	x8, sp, #184
	add	x8, x8, x9, lsl #6
	ldr	x9, [sp, #16]
	add	x8, x8, x9, lsl #2
	ldr	s2, [x8]
	fmadd	s0, s0, s1, s2
	str	s0, [x8]
	b	LBB11_19
LBB11_19:                               ;   in Loop: Header=BB11_17 Depth=3
	ldr	x8, [sp, #16]
	add	x8, x8, #1
	str	x8, [sp, #16]
	b	LBB11_17
LBB11_20:                               ;   in Loop: Header=BB11_15 Depth=2
	b	LBB11_21
LBB11_21:                               ;   in Loop: Header=BB11_15 Depth=2
	ldr	x8, [sp, #32]
	add	x8, x8, #1
	str	x8, [sp, #32]
	b	LBB11_15
LBB11_22:                               ;   in Loop: Header=BB11_9 Depth=1
	b	LBB11_23
LBB11_23:                               ;   in Loop: Header=BB11_9 Depth=1
	ldr	x8, [sp, #48]
	add	x8, x8, #1
	str	x8, [sp, #48]
	b	LBB11_9
LBB11_24:
	str	xzr, [sp, #8]
	b	LBB11_25
LBB11_25:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB11_27 Depth 2
	ldr	x8, [sp, #8]
	subs	x8, x8, #16
	cset	w8, hs
	tbnz	w8, #0, LBB11_32
	b	LBB11_26
LBB11_26:                               ;   in Loop: Header=BB11_25 Depth=1
	str	xzr, [sp]
	b	LBB11_27
LBB11_27:                               ;   Parent Loop BB11_25 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp]
	subs	x8, x8, #16
	cset	w8, hs
	tbnz	w8, #0, LBB11_30
	b	LBB11_28
LBB11_28:                               ;   in Loop: Header=BB11_27 Depth=2
	ldr	x9, [sp, #8]
	add	x8, sp, #184
	add	x8, x8, x9, lsl #6
	ldr	x9, [sp]
	ldr	s0, [x8, x9, lsl #2]
	ldr	x8, [sp, #96]
	ldr	x9, [sp, #8]
	ldr	x10, [sp, #80]
	mul	x9, x9, x10
	ldr	x10, [sp]
	add	x9, x9, x10
	str	s0, [x8, x9, lsl #2]
	b	LBB11_29
LBB11_29:                               ;   in Loop: Header=BB11_27 Depth=2
	ldr	x8, [sp]
	add	x8, x8, #1
	str	x8, [sp]
	b	LBB11_27
LBB11_30:                               ;   in Loop: Header=BB11_25 Depth=1
	b	LBB11_31
LBB11_31:                               ;   in Loop: Header=BB11_25 Depth=1
	ldr	x8, [sp, #8]
	add	x8, x8, #1
	str	x8, [sp, #8]
	b	LBB11_25
LBB11_32:
	ldur	x9, [x29, #-24]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB11_34
	b	LBB11_33
LBB11_33:
	bl	___stack_chk_fail
LBB11_34:
	add	sp, sp, #1216
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
