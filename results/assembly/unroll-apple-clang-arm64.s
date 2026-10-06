	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	__ZN4gemm6detail11tile_4x4_u2EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail11tile_4x4_u2EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail11tile_4x4_u2EPKfS2_Pfmmm: ; @_ZN4gemm6detail11tile_4x4_u2EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	ldp	s6, s17, [x2]
	ldp	s16, s7, [x2, #8]
	add	x8, x2, x4, lsl #2
	ldp	s21, s20, [x8]
	ldp	s19, s18, [x8, #8]
	add	x9, x2, x4, lsl #3
	ldp	s5, s4, [x9]
	ldp	s3, s2, [x9, #8]
	mov	w10, #12
	madd	x10, x4, x10, x2
	ldp	s1, s0, [x10]
	lsl	x11, x3, #3
	lsl	x12, x4, #2
	ldp	s22, s23, [x10, #8]
	cmp	x5, #2
	b.lo	LBB0_4
; %bb.1:
	lsl	x13, x4, #3
	add	x15, x3, x3, lsl #1
	lsl	x14, x3, #2
	add	x14, x14, #4
	lsl	x15, x15, #2
	mov	x16, x0
	mov	x17, x1
	mov	x6, x5
LBB0_2:                                 ; =>This Inner Loop Header: Depth=1
	ldp	s24, s25, [x17]
	ldp	s26, s27, [x17, #8]
	ldp	s28, s29, [x16]
	fmadd	s6, s28, s24, s6
	fmadd	s17, s28, s25, s17
	fmadd	s16, s28, s26, s16
	fmadd	s7, s28, s27, s7
	add	x7, x16, x14
	ldur	s28, [x7, #-4]
	fmadd	s21, s28, s24, s21
	fmadd	s20, s28, s25, s20
	fmadd	s19, s28, s26, s19
	fmadd	s18, s28, s27, s18
	add	x19, x16, x11
	ldp	s28, s30, [x19]
	fmadd	s5, s28, s24, s5
	fmadd	s4, s28, s25, s4
	fmadd	s3, s28, s26, s3
	fmadd	s2, s28, s27, s2
	add	x19, x16, x15
	ldp	s28, s31, [x19]
	fmadd	s1, s28, s24, s1
	fmadd	s0, s28, s25, s0
	fmadd	s22, s28, s26, s22
	fmadd	s23, s28, s27, s23
	add	x19, x17, x12
	ldp	s24, s25, [x19]
	ldp	s26, s27, [x19, #8]
	fmadd	s6, s29, s24, s6
	fmadd	s17, s29, s25, s17
	fmadd	s16, s29, s26, s16
	fmadd	s7, s29, s27, s7
	ldr	s28, [x7]
	fmadd	s21, s28, s24, s21
	fmadd	s20, s28, s25, s20
	fmadd	s19, s28, s26, s19
	fmadd	s18, s28, s27, s18
	fmadd	s5, s30, s24, s5
	fmadd	s4, s30, s25, s4
	fmadd	s3, s30, s26, s3
	fmadd	s2, s30, s27, s2
	fmadd	s1, s31, s24, s1
	fmadd	s0, s31, s25, s0
	sub	x6, x6, #2
	fmadd	s22, s31, s26, s22
	add	x17, x17, x13
	add	x16, x16, #8
	fmadd	s23, s31, s27, s23
	cmp	x6, #1
	b.hi	LBB0_2
; %bb.3:
	and	x17, x5, #0xfffffffffffffffe
	cmp	x17, x5
	b.lo	LBB0_5
	b	LBB0_7
LBB0_4:
	mov	x17, #0
	cmp	x17, x5
	b.hs	LBB0_7
LBB0_5:
	sub	x13, x5, x17
	add	x14, x3, x3, lsl #1
	lsl	x14, x14, #2
	add	x15, x0, x17, lsl #2
	add	x16, x17, x3
	add	x16, x0, x16, lsl #2
	mul	x17, x17, x4
	add	x17, x1, x17, lsl #2
	add	x17, x17, #8
LBB0_6:                                 ; =>This Inner Loop Header: Depth=1
	ldp	s24, s25, [x17, #-8]
	ldp	s26, s27, [x17]
	ldr	s28, [x15]
	fmadd	s6, s28, s24, s6
	fmadd	s17, s28, s25, s17
	fmadd	s16, s28, s26, s16
	fmadd	s7, s28, s27, s7
	ldr	s28, [x16], #4
	fmadd	s21, s28, s24, s21
	fmadd	s20, s28, s25, s20
	fmadd	s19, s28, s26, s19
	fmadd	s18, s28, s27, s18
	ldr	s28, [x15, x11]
	fmadd	s5, s28, s24, s5
	fmadd	s4, s28, s25, s4
	fmadd	s3, s28, s26, s3
	fmadd	s2, s28, s27, s2
	ldr	s28, [x15, x14]
	fmadd	s1, s28, s24, s1
	fmadd	s0, s28, s25, s0
	fmadd	s22, s28, s26, s22
	add	x15, x15, #4
	add	x17, x17, x12
	fmadd	s23, s28, s27, s23
	subs	x13, x13, #1
	b.ne	LBB0_6
LBB0_7:
	str	s6, [x2]
	str	s17, [x2, #4]
	str	s16, [x2, #8]
	str	s7, [x2, #12]
	str	s21, [x8]
	str	s20, [x8, #4]
	str	s19, [x8, #8]
	str	s18, [x8, #12]
	str	s5, [x9]
	str	s4, [x9, #4]
	str	s3, [x9, #8]
	str	s2, [x9, #12]
	str	s1, [x10]
	str	s0, [x10, #4]
	str	s22, [x10, #8]
	str	s23, [x10, #12]
	ldp	x20, x19, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm6detail11tile_4x4_u4EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail11tile_4x4_u4EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail11tile_4x4_u4EPKfS2_Pfmmm: ; @_ZN4gemm6detail11tile_4x4_u4EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	stp	d9, d8, [sp, #-64]!             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset b8, -56
	.cfi_offset b9, -64
	ldp	s18, s21, [x2]
	ldp	s20, s19, [x2, #8]
	add	x8, x2, x4, lsl #2
	ldp	s6, s17, [x8]
	ldp	s16, s7, [x8, #8]
	add	x9, x2, x4, lsl #3
	ldp	s2, s5, [x9]
	ldp	s4, s3, [x9, #8]
	mov	w10, #12
	madd	x10, x4, x10, x2
	ldp	s1, s0, [x10]
	lsl	x11, x3, #3
	lsl	x12, x4, #2
	ldp	s22, s23, [x10, #8]
	cmp	x5, #4
	b.lo	LBB1_4
; %bb.1:
	lsl	x13, x4, #4
	add	x14, x11, #8
	lsl	x15, x3, #2
	add	x15, x15, #12
	mov	w16, #12
	orr	x17, xzr, #0x8
	madd	x16, x3, x16, x17
	mov	x17, x0
	mov	x6, x1
	mov	x7, x5
LBB1_2:                                 ; =>This Inner Loop Header: Depth=1
	ldp	s24, s25, [x6]
	ldp	s26, s27, [x6, #8]
	ldp	s28, s29, [x17]
	fmadd	s18, s28, s24, s18
	fmadd	s21, s28, s25, s21
	fmadd	s20, s28, s26, s20
	fmadd	s19, s28, s27, s19
	add	x19, x17, x15
	ldp	s28, s30, [x19, #-12]
	fmadd	s6, s28, s24, s6
	fmadd	s17, s28, s25, s17
	fmadd	s16, s28, s26, s16
	fmadd	s7, s28, s27, s7
	add	x20, x17, x14
	ldp	s28, s31, [x20, #-8]
	fmadd	s2, s28, s24, s2
	fmadd	s5, s28, s25, s5
	fmadd	s4, s28, s26, s4
	fmadd	s3, s28, s27, s3
	add	x21, x17, x16
	ldp	s28, s8, [x21, #-8]
	fmadd	s1, s28, s24, s1
	fmadd	s0, s28, s25, s0
	fmadd	s22, s28, s26, s22
	fmadd	s23, s28, s27, s23
	add	x22, x6, x12
	add	x23, x22, x12
	ldp	s24, s25, [x22]
	ldp	s26, s27, [x22, #8]
	fmadd	s18, s29, s24, s18
	fmadd	s21, s29, s25, s21
	fmadd	s20, s29, s26, s20
	fmadd	s19, s29, s27, s19
	fmadd	s6, s30, s24, s6
	fmadd	s17, s30, s25, s17
	fmadd	s16, s30, s26, s16
	fmadd	s7, s30, s27, s7
	fmadd	s2, s31, s24, s2
	fmadd	s5, s31, s25, s5
	fmadd	s4, s31, s26, s4
	fmadd	s3, s31, s27, s3
	fmadd	s1, s8, s24, s1
	fmadd	s0, s8, s25, s0
	fmadd	s22, s8, s26, s22
	fmadd	s23, s8, s27, s23
	ldp	s24, s25, [x23]
	ldp	s26, s27, [x23, #8]
	ldp	s28, s29, [x17, #8]
	fmadd	s18, s28, s24, s18
	fmadd	s21, s28, s25, s21
	fmadd	s20, s28, s26, s20
	fmadd	s19, s28, s27, s19
	ldur	s28, [x19, #-4]
	fmadd	s6, s28, s24, s6
	fmadd	s17, s28, s25, s17
	fmadd	s16, s28, s26, s16
	fmadd	s7, s28, s27, s7
	ldp	s28, s30, [x20]
	fmadd	s2, s28, s24, s2
	fmadd	s5, s28, s25, s5
	fmadd	s4, s28, s26, s4
	fmadd	s3, s28, s27, s3
	ldp	s28, s31, [x21]
	fmadd	s1, s28, s24, s1
	fmadd	s0, s28, s25, s0
	fmadd	s22, s28, s26, s22
	fmadd	s23, s28, s27, s23
	add	x20, x23, x12
	ldp	s24, s25, [x20]
	ldp	s26, s27, [x20, #8]
	fmadd	s18, s29, s24, s18
	fmadd	s21, s29, s25, s21
	fmadd	s20, s29, s26, s20
	fmadd	s19, s29, s27, s19
	ldr	s28, [x19]
	fmadd	s6, s28, s24, s6
	fmadd	s17, s28, s25, s17
	fmadd	s16, s28, s26, s16
	fmadd	s7, s28, s27, s7
	fmadd	s2, s30, s24, s2
	fmadd	s5, s30, s25, s5
	fmadd	s4, s30, s26, s4
	fmadd	s3, s30, s27, s3
	fmadd	s1, s31, s24, s1
	fmadd	s0, s31, s25, s0
	sub	x7, x7, #4
	fmadd	s22, s31, s26, s22
	add	x6, x6, x13
	add	x17, x17, #16
	fmadd	s23, s31, s27, s23
	cmp	x7, #3
	b.hi	LBB1_2
; %bb.3:
	and	x17, x5, #0xfffffffffffffffc
	cmp	x17, x5
	b.lo	LBB1_5
	b	LBB1_7
LBB1_4:
	mov	x17, #0
	cmp	x17, x5
	b.hs	LBB1_7
LBB1_5:
	sub	x13, x5, x17
	add	x14, x3, x3, lsl #1
	lsl	x14, x14, #2
	add	x15, x0, x17, lsl #2
	add	x16, x17, x3
	add	x16, x0, x16, lsl #2
	mul	x17, x17, x4
	add	x17, x1, x17, lsl #2
	add	x17, x17, #8
LBB1_6:                                 ; =>This Inner Loop Header: Depth=1
	ldp	s24, s25, [x17, #-8]
	ldp	s26, s27, [x17]
	ldr	s28, [x15]
	fmadd	s18, s28, s24, s18
	fmadd	s21, s28, s25, s21
	fmadd	s20, s28, s26, s20
	fmadd	s19, s28, s27, s19
	ldr	s28, [x16], #4
	fmadd	s6, s28, s24, s6
	fmadd	s17, s28, s25, s17
	fmadd	s16, s28, s26, s16
	fmadd	s7, s28, s27, s7
	ldr	s28, [x15, x11]
	fmadd	s2, s28, s24, s2
	fmadd	s5, s28, s25, s5
	fmadd	s4, s28, s26, s4
	fmadd	s3, s28, s27, s3
	ldr	s28, [x15, x14]
	fmadd	s1, s28, s24, s1
	fmadd	s0, s28, s25, s0
	fmadd	s22, s28, s26, s22
	add	x15, x15, #4
	add	x17, x17, x12
	fmadd	s23, s28, s27, s23
	subs	x13, x13, #1
	b.ne	LBB1_6
LBB1_7:
	str	s18, [x2]
	str	s21, [x2, #4]
	str	s20, [x2, #8]
	str	s19, [x2, #12]
	str	s6, [x8]
	str	s17, [x8, #4]
	str	s16, [x8, #8]
	str	s7, [x8, #12]
	str	s2, [x9]
	str	s5, [x9, #4]
	str	s4, [x9, #8]
	str	s3, [x9, #12]
	str	s1, [x10]
	str	s0, [x10, #4]
	str	s22, [x10, #8]
	str	s23, [x10, #12]
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	d9, d8, [sp], #64               ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm6detail11tile_4x4_u8EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail11tile_4x4_u8EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail11tile_4x4_u8EPKfS2_Pfmmm: ; @_ZN4gemm6detail11tile_4x4_u8EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	stp	d9, d8, [sp, #-64]!             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset b8, -56
	.cfi_offset b9, -64
	ldp	s18, s21, [x2]
	ldp	s20, s19, [x2, #8]
	add	x8, x2, x4, lsl #2
	ldp	s17, s16, [x8]
	ldp	s7, s1, [x8, #8]
	add	x9, x2, x4, lsl #3
	ldp	s6, s5, [x9]
	ldp	s4, s0, [x9, #8]
	mov	w10, #12
	madd	x10, x4, x10, x2
	ldp	s3, s2, [x10]
	lsl	x11, x3, #3
	lsl	x12, x4, #2
	ldp	s22, s23, [x10, #8]
	cmp	x5, #8
	b.lo	LBB2_4
; %bb.1:
	lsl	x13, x4, #5
	add	x14, x11, #16
	lsl	x15, x3, #2
	add	x15, x15, #28
	mov	w16, #12
	orr	x17, xzr, #0x10
	madd	x16, x3, x16, x17
	mov	x17, x0
	mov	x6, x1
	mov	x7, x5
LBB2_2:                                 ; =>This Inner Loop Header: Depth=1
	ldp	s24, s25, [x6]
	ldp	s26, s27, [x6, #8]
	ldp	s28, s29, [x17]
	fmadd	s18, s28, s24, s18
	fmadd	s21, s28, s25, s21
	fmadd	s20, s28, s26, s20
	fmadd	s19, s28, s27, s19
	add	x19, x17, x15
	ldp	s28, s30, [x19, #-28]
	fmadd	s17, s28, s24, s17
	fmadd	s16, s28, s25, s16
	fmadd	s7, s28, s26, s7
	add	x20, x17, x14
	ldp	s31, s8, [x20, #-16]
	fmadd	s1, s28, s27, s1
	fmadd	s6, s31, s24, s6
	fmadd	s5, s31, s25, s5
	fmadd	s4, s31, s26, s4
	add	x21, x17, x16
	fmadd	s0, s31, s27, s0
	ldp	s28, s31, [x21, #-16]
	fmadd	s3, s28, s24, s3
	fmadd	s2, s28, s25, s2
	fmadd	s22, s28, s26, s22
	fmadd	s23, s28, s27, s23
	add	x22, x6, x12
	add	x23, x22, x12
	ldp	s24, s25, [x22]
	ldp	s26, s27, [x22, #8]
	fmadd	s18, s29, s24, s18
	fmadd	s21, s29, s25, s21
	fmadd	s20, s29, s26, s20
	fmadd	s19, s29, s27, s19
	fmadd	s17, s30, s24, s17
	fmadd	s16, s30, s25, s16
	fmadd	s7, s30, s26, s7
	fmadd	s1, s30, s27, s1
	fmadd	s6, s8, s24, s6
	fmadd	s5, s8, s25, s5
	fmadd	s4, s8, s26, s4
	fmadd	s0, s8, s27, s0
	fmadd	s3, s31, s24, s3
	fmadd	s2, s31, s25, s2
	fmadd	s22, s31, s26, s22
	fmadd	s23, s31, s27, s23
	ldp	s24, s25, [x23]
	ldp	s26, s27, [x23, #8]
	ldp	s28, s29, [x17, #8]
	fmadd	s18, s28, s24, s18
	fmadd	s21, s28, s25, s21
	fmadd	s20, s28, s26, s20
	fmadd	s19, s28, s27, s19
	ldp	s28, s30, [x19, #-20]
	fmadd	s17, s28, s24, s17
	fmadd	s16, s28, s25, s16
	fmadd	s7, s28, s26, s7
	fmadd	s1, s28, s27, s1
	ldp	s28, s31, [x20, #-8]
	fmadd	s6, s28, s24, s6
	fmadd	s5, s28, s25, s5
	fmadd	s4, s28, s26, s4
	fmadd	s0, s28, s27, s0
	ldp	s28, s8, [x21, #-8]
	fmadd	s3, s28, s24, s3
	fmadd	s2, s28, s25, s2
	fmadd	s22, s28, s26, s22
	fmadd	s23, s28, s27, s23
	add	x22, x23, x12
	add	x23, x22, x12
	ldp	s24, s25, [x22]
	ldp	s26, s27, [x22, #8]
	fmadd	s18, s29, s24, s18
	fmadd	s21, s29, s25, s21
	fmadd	s20, s29, s26, s20
	fmadd	s19, s29, s27, s19
	fmadd	s17, s30, s24, s17
	fmadd	s16, s30, s25, s16
	fmadd	s7, s30, s26, s7
	fmadd	s1, s30, s27, s1
	fmadd	s6, s31, s24, s6
	fmadd	s5, s31, s25, s5
	fmadd	s4, s31, s26, s4
	fmadd	s0, s31, s27, s0
	fmadd	s3, s8, s24, s3
	fmadd	s2, s8, s25, s2
	fmadd	s22, s8, s26, s22
	fmadd	s23, s8, s27, s23
	ldp	s24, s25, [x23]
	ldp	s26, s27, [x23, #8]
	ldp	s28, s29, [x17, #16]
	fmadd	s18, s28, s24, s18
	fmadd	s21, s28, s25, s21
	fmadd	s20, s28, s26, s20
	fmadd	s19, s28, s27, s19
	ldp	s28, s30, [x19, #-12]
	fmadd	s17, s28, s24, s17
	fmadd	s16, s28, s25, s16
	fmadd	s7, s28, s26, s7
	fmadd	s1, s28, s27, s1
	ldp	s28, s31, [x20]
	fmadd	s6, s28, s24, s6
	fmadd	s5, s28, s25, s5
	fmadd	s4, s28, s26, s4
	fmadd	s0, s28, s27, s0
	ldp	s28, s8, [x21]
	fmadd	s3, s28, s24, s3
	fmadd	s2, s28, s25, s2
	fmadd	s22, s28, s26, s22
	fmadd	s23, s28, s27, s23
	add	x22, x23, x12
	add	x23, x22, x12
	ldp	s24, s25, [x22]
	ldp	s26, s27, [x22, #8]
	fmadd	s18, s29, s24, s18
	fmadd	s21, s29, s25, s21
	fmadd	s20, s29, s26, s20
	fmadd	s19, s29, s27, s19
	fmadd	s17, s30, s24, s17
	fmadd	s16, s30, s25, s16
	fmadd	s7, s30, s26, s7
	fmadd	s1, s30, s27, s1
	fmadd	s6, s31, s24, s6
	fmadd	s5, s31, s25, s5
	fmadd	s4, s31, s26, s4
	fmadd	s0, s31, s27, s0
	fmadd	s3, s8, s24, s3
	fmadd	s2, s8, s25, s2
	fmadd	s22, s8, s26, s22
	fmadd	s23, s8, s27, s23
	ldp	s24, s25, [x23]
	ldp	s26, s29, [x17, #24]
	ldp	s27, s28, [x23, #8]
	fmadd	s18, s26, s24, s18
	fmadd	s21, s26, s25, s21
	fmadd	s20, s26, s27, s20
	ldur	s30, [x19, #-4]
	fmadd	s19, s26, s28, s19
	fmadd	s17, s30, s24, s17
	fmadd	s16, s30, s25, s16
	fmadd	s7, s30, s27, s7
	ldp	s26, s31, [x20, #8]
	fmadd	s1, s30, s28, s1
	fmadd	s6, s26, s24, s6
	fmadd	s5, s26, s25, s5
	fmadd	s4, s26, s27, s4
	ldp	s30, s8, [x21, #8]
	fmadd	s0, s26, s28, s0
	fmadd	s3, s30, s24, s3
	fmadd	s2, s30, s25, s2
	fmadd	s22, s30, s27, s22
	fmadd	s23, s30, s28, s23
	add	x20, x23, x12
	ldp	s24, s25, [x20]
	ldp	s26, s27, [x20, #8]
	fmadd	s18, s29, s24, s18
	fmadd	s21, s29, s25, s21
	fmadd	s20, s29, s26, s20
	fmadd	s19, s29, s27, s19
	ldr	s28, [x19]
	fmadd	s17, s28, s24, s17
	fmadd	s16, s28, s25, s16
	fmadd	s7, s28, s26, s7
	fmadd	s1, s28, s27, s1
	fmadd	s6, s31, s24, s6
	fmadd	s5, s31, s25, s5
	fmadd	s4, s31, s26, s4
	fmadd	s0, s31, s27, s0
	fmadd	s3, s8, s24, s3
	fmadd	s2, s8, s25, s2
	sub	x7, x7, #8
	fmadd	s22, s8, s26, s22
	add	x6, x6, x13
	add	x17, x17, #32
	fmadd	s23, s8, s27, s23
	cmp	x7, #7
	b.hi	LBB2_2
; %bb.3:
	and	x17, x5, #0xfffffffffffffff8
	cmp	x17, x5
	b.lo	LBB2_5
	b	LBB2_7
LBB2_4:
	mov	x17, #0
	cmp	x17, x5
	b.hs	LBB2_7
LBB2_5:
	sub	x13, x5, x17
	add	x14, x3, x3, lsl #1
	lsl	x14, x14, #2
	add	x15, x0, x17, lsl #2
	add	x16, x17, x3
	add	x16, x0, x16, lsl #2
	mul	x17, x17, x4
	add	x17, x1, x17, lsl #2
	add	x17, x17, #8
LBB2_6:                                 ; =>This Inner Loop Header: Depth=1
	ldp	s24, s25, [x17, #-8]
	ldp	s26, s27, [x17]
	ldr	s28, [x15]
	fmadd	s18, s28, s24, s18
	fmadd	s21, s28, s25, s21
	fmadd	s20, s28, s26, s20
	fmadd	s19, s28, s27, s19
	ldr	s28, [x16], #4
	fmadd	s17, s28, s24, s17
	fmadd	s16, s28, s25, s16
	fmadd	s7, s28, s26, s7
	fmadd	s1, s28, s27, s1
	ldr	s28, [x15, x11]
	fmadd	s6, s28, s24, s6
	fmadd	s5, s28, s25, s5
	fmadd	s4, s28, s26, s4
	fmadd	s0, s28, s27, s0
	ldr	s28, [x15, x14]
	fmadd	s3, s28, s24, s3
	fmadd	s2, s28, s25, s2
	fmadd	s22, s28, s26, s22
	add	x15, x15, #4
	add	x17, x17, x12
	fmadd	s23, s28, s27, s23
	subs	x13, x13, #1
	b.ne	LBB2_6
LBB2_7:
	str	s18, [x2]
	str	s21, [x2, #4]
	str	s20, [x2, #8]
	str	s19, [x2, #12]
	str	s17, [x8]
	str	s16, [x8, #4]
	str	s7, [x8, #8]
	str	s1, [x8, #12]
	str	s6, [x9]
	str	s5, [x9, #4]
	str	s4, [x9, #8]
	str	s0, [x9, #12]
	str	s3, [x10]
	str	s2, [x10, #4]
	str	s22, [x10, #8]
	str	s23, [x10, #12]
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	d9, d8, [sp], #64               ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
