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
	cbz	x3, LBB0_9
; %bb.1:
	cbz	x4, LBB0_9
; %bb.2:
	cbz	x5, LBB0_10
; %bb.3:
	mov	x8, #0
	lsl	x9, x4, #2
	lsl	x10, x5, #2
LBB0_4:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_5 Depth 2
                                        ;       Child Loop BB0_6 Depth 3
	mov	x11, #0
	mul	x12, x8, x4
	mov	x13, x1
LBB0_5:                                 ;   Parent Loop BB0_4 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_6 Depth 3
	movi	d0, #0000000000000000
	mov	x14, x0
	mov	x15, x13
	mov	x16, x5
LBB0_6:                                 ;   Parent Loop BB0_4 Depth=1
                                        ;     Parent Loop BB0_5 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x14], #4
	ldr	s2, [x15]
	fmadd	s0, s1, s2, s0
	add	x15, x15, x9
	subs	x16, x16, #1
	b.ne	LBB0_6
; %bb.7:                                ;   in Loop: Header=BB0_5 Depth=2
	add	x14, x11, x12
	str	s0, [x2, x14, lsl #2]
	add	x11, x11, #1
	add	x13, x13, #4
	cmp	x11, x4
	b.ne	LBB0_5
; %bb.8:                                ;   in Loop: Header=BB0_4 Depth=1
	add	x8, x8, #1
	add	x0, x0, x10
	cmp	x8, x3
	b.ne	LBB0_4
LBB0_9:
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB0_10:
	mul	x8, x4, x3
	lsl	x1, x8, #2
	mov	x0, x2
	bl	_bzero
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
