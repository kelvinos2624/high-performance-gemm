	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	__ZN4gemm14neon_availableEv     ; -- Begin function _ZN4gemm14neon_availableEv
	.p2align	2
__ZN4gemm14neon_availableEv:            ; @_ZN4gemm14neon_availableEv
	.cfi_startproc
; %bb.0:
	mov	w0, #1
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm6detail13tile_4x4_neonEPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail13tile_4x4_neonEPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail13tile_4x4_neonEPKfS2_Pfmmm: ; @_ZN4gemm6detail13tile_4x4_neonEPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	ldr	q0, [x2]
	add	x8, x2, x4, lsl #2
	ldr	q1, [x8]
	add	x9, x2, x4, lsl #3
	ldr	q2, [x9]
	mov	w10, #12
	madd	x10, x4, x10, x2
	ldr	q3, [x10]
	cbz	x5, LBB1_3
; %bb.1:
	add	x11, x3, x3, lsl #1
	lsl	x11, x11, #2
	lsl	x12, x3, #3
	lsl	x13, x4, #2
	mov	x14, x0
LBB1_2:                                 ; =>This Inner Loop Header: Depth=1
	ldr	q4, [x1]
	ld1r.4s	{ v5 }, [x14], #4
	fmla.4s	v0, v5, v4
	ldr	s5, [x0, x3, lsl #2]
	fmla.4s	v1, v4, v5[0]
	ldr	s5, [x0, x12]
	fmla.4s	v2, v4, v5[0]
	ldr	s5, [x0, x11]
	fmla.4s	v3, v4, v5[0]
	add	x1, x1, x13
	mov	x0, x14
	subs	x5, x5, #1
	b.ne	LBB1_2
LBB1_3:
	str	q0, [x2]
	str	q1, [x8]
	str	q2, [x9]
	str	q3, [x10]
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
