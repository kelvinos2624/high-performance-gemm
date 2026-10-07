	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	__ZN4gemm6detail8tile_2x4EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail8tile_2x4EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail8tile_2x4EPKfS2_Pfmmm:  ; @_ZN4gemm6detail8tile_2x4EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	ldp	s3, s2, [x2]
	ldp	s1, s0, [x2, #8]
	add	x8, x2, x4, lsl #2
	ldp	s4, s5, [x8]
	ldp	s6, s7, [x8, #8]
	cbz	x5, LBB0_3
; %bb.1:
	add	x9, x1, #8
	lsl	x10, x4, #2
LBB0_2:                                 ; =>This Inner Loop Header: Depth=1
	ldp	s16, s17, [x9, #-8]
	ldp	s18, s19, [x9]
	ldr	s20, [x0]
	fmadd	s3, s20, s16, s3
	fmadd	s2, s20, s17, s2
	fmadd	s1, s20, s18, s1
	fmadd	s0, s20, s19, s0
	ldr	s20, [x0, x3, lsl #2]
	fmadd	s4, s20, s16, s4
	fmadd	s5, s20, s17, s5
	fmadd	s6, s20, s18, s6
	fmadd	s7, s20, s19, s7
	add	x0, x0, #4
	add	x9, x9, x10
	subs	x5, x5, #1
	b.ne	LBB0_2
LBB0_3:
	str	s3, [x2]
	str	s2, [x2, #4]
	str	s1, [x2, #8]
	str	s0, [x2, #12]
	str	s4, [x8]
	str	s5, [x8, #4]
	str	s6, [x8, #8]
	str	s7, [x8, #12]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm6detail8tile_4x4EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail8tile_4x4EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail8tile_4x4EPKfS2_Pfmmm:  ; @_ZN4gemm6detail8tile_4x4EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	ldp	s3, s2, [x2]
	ldp	s1, s0, [x2, #8]
	add	x8, x2, x4, lsl #2
	ldp	s7, s6, [x8]
	ldp	s5, s4, [x8, #8]
	add	x9, x2, x4, lsl #3
	ldp	s19, s18, [x9]
	ldp	s17, s16, [x9, #8]
	mov	w10, #12
	madd	x10, x4, x10, x2
	ldp	s20, s21, [x10]
	ldp	s22, s23, [x10, #8]
	cbz	x5, LBB1_3
; %bb.1:
	add	x11, x3, x3, lsl #1
	lsl	x11, x11, #2
	lsl	x12, x3, #3
	add	x13, x1, #8
	lsl	x14, x4, #2
LBB1_2:                                 ; =>This Inner Loop Header: Depth=1
	ldp	s24, s25, [x13, #-8]
	ldp	s26, s27, [x13]
	ldr	s28, [x0]
	fmadd	s3, s28, s24, s3
	fmadd	s2, s28, s25, s2
	fmadd	s1, s28, s26, s1
	fmadd	s0, s28, s27, s0
	ldr	s28, [x0, x3, lsl #2]
	fmadd	s7, s28, s24, s7
	fmadd	s6, s28, s25, s6
	fmadd	s5, s28, s26, s5
	fmadd	s4, s28, s27, s4
	ldr	s28, [x0, x12]
	fmadd	s19, s28, s24, s19
	fmadd	s18, s28, s25, s18
	fmadd	s17, s28, s26, s17
	fmadd	s16, s28, s27, s16
	ldr	s28, [x0, x11]
	fmadd	s20, s28, s24, s20
	fmadd	s21, s28, s25, s21
	fmadd	s22, s28, s26, s22
	add	x0, x0, #4
	add	x13, x13, x14
	fmadd	s23, s28, s27, s23
	subs	x5, x5, #1
	b.ne	LBB1_2
LBB1_3:
	str	s3, [x2]
	str	s2, [x2, #4]
	str	s1, [x2, #8]
	str	s0, [x2, #12]
	str	s7, [x8]
	str	s6, [x8, #4]
	str	s5, [x8, #8]
	str	s4, [x8, #12]
	str	s19, [x9]
	str	s18, [x9, #4]
	str	s17, [x9, #8]
	str	s16, [x9, #12]
	str	s20, [x10]
	str	s21, [x10, #4]
	str	s22, [x10, #8]
	str	s23, [x10, #12]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm6detail8tile_4x8EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail8tile_4x8EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail8tile_4x8EPKfS2_Pfmmm:  ; @_ZN4gemm6detail8tile_4x8EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
	stp	d15, d14, [sp, #48]             ; 16-byte Folded Spill
	stp	d13, d12, [sp, #64]             ; 16-byte Folded Spill
	stp	d11, d10, [sp, #80]             ; 16-byte Folded Spill
	stp	d9, d8, [sp, #96]               ; 16-byte Folded Spill
	.cfi_offset b8, -8
	.cfi_offset b9, -16
	.cfi_offset b10, -24
	.cfi_offset b11, -32
	.cfi_offset b12, -40
	.cfi_offset b13, -48
	.cfi_offset b14, -56
	.cfi_offset b15, -64
	ldp	s4, s3, [x2]
	ldp	s6, s5, [x2, #8]
	ldp	s16, s7, [x2, #16]
	ldp	s1, s0, [x2, #24]
	stp	s1, s0, [sp, #40]               ; 8-byte Folded Spill
	add	x8, x2, x4, lsl #2
	ldp	s8, s31, [x8]
	ldp	s30, s29, [x8, #8]
	ldp	s28, s27, [x8, #16]
	ldp	s26, s17, [x8, #24]
	add	x9, x2, x4, lsl #3
	ldp	s22, s15, [x9]
	ldp	s14, s13, [x9, #8]
	ldp	s12, s11, [x9, #16]
	ldp	s9, s2, [x9, #24]
	mov	w10, #12
	madd	x10, x4, x10, x2
	ldp	s0, s1, [x10]
	ldp	s18, s23, [x10, #8]
	ldp	s24, s19, [x10, #16]
	ldp	s25, s10, [x10, #24]
	cbz	x5, LBB2_3
; %bb.1:
	add	x11, x3, x3, lsl #1
	lsl	x11, x11, #2
	lsl	x12, x3, #3
	add	x13, x1, #16
	lsl	x14, x4, #2
LBB2_2:                                 ; =>This Inner Loop Header: Depth=1
	stp	s10, s25, [sp, #4]              ; 8-byte Folded Spill
	stp	s19, s23, [sp, #12]             ; 8-byte Folded Spill
	str	s18, [sp, #20]                  ; 4-byte Folded Spill
	fmov	s23, s0
	fmov	s18, s1
	ldp	s0, s1, [x13, #-16]
	fmov	s10, s2
	ldr	s2, [x0]
	fmadd	s4, s2, s0, s4
	str	s4, [sp, #28]                   ; 4-byte Folded Spill
	fmadd	s3, s2, s1, s3
	fmov	s19, s24
	fmov	s24, s3
	ldp	s3, s4, [x13, #-8]
	fmadd	s6, s2, s3, s6
	str	s6, [sp, #32]                   ; 4-byte Folded Spill
	fmadd	s25, s2, s4, s5
	ldp	s5, s6, [x13]
	fmadd	s20, s2, s5, s16
	fmadd	s7, s2, s6, s7
	str	s7, [sp, #24]                   ; 4-byte Folded Spill
	ldp	s7, s16, [x13, #8]
	ldr	s21, [sp, #40]                  ; 4-byte Folded Reload
	fmadd	s21, s2, s7, s21
	stp	s20, s21, [sp, #36]             ; 8-byte Folded Spill
	ldr	s21, [sp, #44]                  ; 4-byte Folded Reload
	fmadd	s21, s2, s16, s21
	str	s21, [sp, #44]                  ; 4-byte Folded Spill
	ldr	s2, [x0, x3, lsl #2]
	fmadd	s8, s2, s0, s8
	fmadd	s31, s2, s1, s31
	fmadd	s30, s2, s3, s30
	fmadd	s29, s2, s4, s29
	fmadd	s28, s2, s5, s28
	fmadd	s27, s2, s6, s27
	fmadd	s26, s2, s7, s26
	fmadd	s17, s2, s16, s17
	ldr	s2, [x0, x12]
	fmadd	s22, s2, s0, s22
	fmadd	s21, s2, s1, s15
	fmadd	s15, s2, s3, s14
	fmadd	s13, s2, s4, s13
	fmadd	s12, s2, s5, s12
	fmadd	s11, s2, s6, s11
	fmadd	s9, s2, s7, s9
	fmov	s14, s13
	fmov	s13, s12
	fmov	s12, s11
	fmov	s11, s9
	fmov	s9, s8
	fmov	s8, s31
	fmov	s31, s30
	fmov	s30, s29
	fmov	s29, s28
	fmov	s28, s27
	fmov	s27, s26
	fmov	s26, s17
	ldr	s17, [x0, x11]
	fmadd	s2, s2, s16, s10
	fmadd	s0, s17, s0, s23
	fmadd	s1, s17, s1, s18
	ldp	s23, s18, [sp, #16]             ; 8-byte Folded Reload
	fmadd	s18, s17, s3, s18
	fmov	s3, s24
	fmov	s24, s19
	ldr	s19, [sp, #12]                  ; 4-byte Folded Reload
	fmadd	s23, s17, s4, s23
	fmadd	s24, s17, s5, s24
	fmov	s5, s25
	ldp	s10, s25, [sp, #4]              ; 8-byte Folded Reload
	fmadd	s19, s17, s6, s19
	ldp	s4, s6, [sp, #28]               ; 8-byte Folded Reload
	fmadd	s25, s17, s7, s25
	ldr	s7, [sp, #24]                   ; 4-byte Folded Reload
	fmadd	s10, s17, s16, s10
	ldr	s16, [sp, #36]                  ; 4-byte Folded Reload
	fmov	s17, s26
	fmov	s26, s27
	fmov	s27, s28
	fmov	s28, s29
	fmov	s29, s30
	fmov	s30, s31
	fmov	s31, s8
	fmov	s8, s9
	fmov	s9, s11
	fmov	s11, s12
	fmov	s12, s13
	fmov	s13, s14
	fmov	s14, s15
	fmov	s15, s21
	add	x0, x0, #4
	add	x13, x13, x14
	subs	x5, x5, #1
	b.ne	LBB2_2
LBB2_3:
	str	s4, [x2]
	str	s3, [x2, #4]
	str	s6, [x2, #8]
	str	s5, [x2, #12]
	str	s16, [x2, #16]
	str	s7, [x2, #20]
	ldr	s3, [sp, #40]                   ; 4-byte Folded Reload
	str	s3, [x2, #24]
	ldr	s3, [sp, #44]                   ; 4-byte Folded Reload
	str	s3, [x2, #28]
	str	s8, [x8]
	str	s31, [x8, #4]
	str	s30, [x8, #8]
	str	s29, [x8, #12]
	str	s28, [x8, #16]
	str	s27, [x8, #20]
	str	s26, [x8, #24]
	str	s17, [x8, #28]
	str	s22, [x9]
	str	s15, [x9, #4]
	str	s14, [x9, #8]
	str	s13, [x9, #12]
	str	s12, [x9, #16]
	str	s11, [x9, #20]
	str	s9, [x9, #24]
	str	s2, [x9, #28]
	str	s0, [x10]
	str	s1, [x10, #4]
	str	s18, [x10, #8]
	str	s23, [x10, #12]
	str	s24, [x10, #16]
	str	s19, [x10, #20]
	str	s25, [x10, #24]
	str	s10, [x10, #28]
	ldp	d9, d8, [sp, #96]               ; 16-byte Folded Reload
	ldp	d11, d10, [sp, #80]             ; 16-byte Folded Reload
	ldp	d13, d12, [sp, #64]             ; 16-byte Folded Reload
	ldp	d15, d14, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm6detail8tile_8x4EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail8tile_8x4EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail8tile_8x4EPKfS2_Pfmmm:  ; @_ZN4gemm6detail8tile_8x4EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
	stp	d15, d14, [sp, #32]             ; 16-byte Folded Spill
	stp	d13, d12, [sp, #48]             ; 16-byte Folded Spill
	stp	d11, d10, [sp, #64]             ; 16-byte Folded Spill
	stp	d9, d8, [sp, #80]               ; 16-byte Folded Spill
	.cfi_offset b8, -8
	.cfi_offset b9, -16
	.cfi_offset b10, -24
	.cfi_offset b11, -32
	.cfi_offset b12, -40
	.cfi_offset b13, -48
	.cfi_offset b14, -56
	.cfi_offset b15, -64
	ldp	s4, s3, [x2]
	ldp	s6, s5, [x2, #8]
	add	x8, x2, x4, lsl #2
	ldp	s20, s19, [x8]
	ldp	s7, s18, [x8, #8]
	add	x9, x2, x4, lsl #3
	ldp	s25, s17, [x9]
	ldp	s23, s22, [x9, #8]
	mov	w10, #12
	madd	x10, x4, x10, x2
	ldp	s28, s27, [x10]
	ldp	s26, s21, [x10, #8]
	add	x11, x2, x4, lsl #4
	ldp	s8, s31, [x11]
	ldp	s30, s29, [x11, #8]
	mov	w12, #20
	madd	x12, x4, x12, x2
	ldp	s12, s11, [x12]
	ldp	s10, s9, [x12, #8]
	mov	w13, #24
	madd	x13, x4, x13, x2
	ldp	s24, s15, [x13]
	ldp	s14, s13, [x13, #8]
	mov	w14, #28
	madd	x14, x4, x14, x2
	ldp	s0, s1, [x14]
	ldp	s16, s2, [x14, #8]
	stp	s18, s22, [sp, #24]             ; 8-byte Folded Spill
	stp	s25, s17, [sp, #16]             ; 8-byte Folded Spill
	cbz	x5, LBB3_3
; %bb.1:
	lsl	x15, x3, #2
	add	x16, x1, #8
	lsl	x17, x4, #2
	fmov	s22, s23
LBB3_2:                                 ; =>This Inner Loop Header: Depth=1
	fmov	s23, s0
	fmov	s17, s1
	ldp	s0, s1, [x16, #-8]
	fmov	s25, s2
	ldr	s2, [x0]
	fmadd	s4, s2, s0, s4
	stp	s4, s16, [sp, #8]               ; 8-byte Folded Spill
	fmadd	s3, s2, s1, s3
	str	s3, [sp, #4]                    ; 4-byte Folded Spill
	ldp	s3, s4, [x16]
	fmadd	s16, s2, s3, s6
	fmadd	s5, s2, s4, s5
	ldr	s2, [x0, x15]
	fmadd	s20, s2, s0, s20
	fmadd	s19, s2, s1, s19
	fmadd	s7, s2, s3, s7
	add	x1, x0, x15
	add	x3, x1, x15
	fmov	s18, s24
	fmov	s24, s15
	fmov	s15, s14
	fmov	s14, s13
	fmov	s13, s12
	fmov	s12, s11
	fmov	s11, s10
	fmov	s10, s9
	fmov	s9, s8
	fmov	s8, s31
	fmov	s31, s30
	fmov	s30, s29
	fmov	s29, s28
	fmov	s28, s27
	fmov	s27, s26
	fmov	s26, s21
	fmov	s21, s20
	fmov	s20, s19
	fmov	s19, s7
	fmov	s7, s5
	ldr	s5, [x1, x15]
	ldr	s6, [sp, #24]                   ; 4-byte Folded Reload
	fmadd	s6, s2, s4, s6
	ldr	s2, [sp, #16]                   ; 4-byte Folded Reload
	fmadd	s2, s5, s0, s2
	str	s2, [sp, #16]                   ; 4-byte Folded Spill
	ldr	s2, [sp, #20]                   ; 4-byte Folded Reload
	fmadd	s2, s5, s1, s2
	stp	s2, s6, [sp, #20]               ; 8-byte Folded Spill
	fmadd	s6, s5, s3, s22
	ldr	s2, [x3, x15]
	ldr	s22, [sp, #28]                  ; 4-byte Folded Reload
	fmadd	s22, s5, s4, s22
	str	s22, [sp, #28]                  ; 4-byte Folded Spill
	fmov	s22, s6
	fmov	s5, s7
	fmov	s6, s16
	fmov	s7, s19
	fmov	s19, s20
	fmov	s20, s21
	fmov	s21, s26
	fmov	s26, s27
	fmov	s27, s28
	fmov	s28, s29
	fmov	s29, s30
	fmov	s30, s31
	fmov	s31, s8
	fmov	s8, s9
	fmov	s9, s10
	fmov	s10, s11
	fmov	s11, s12
	fmov	s12, s13
	fmov	s13, s14
	fmov	s14, s15
	fmov	s15, s24
	fmov	s24, s18
	fmadd	s28, s2, s0, s28
	fmadd	s27, s2, s1, s27
	fmadd	s26, s2, s3, s26
	fmadd	s21, s2, s4, s21
	add	x1, x3, x15
	add	x3, x1, x15
	ldr	s2, [x1, x15]
	fmadd	s8, s2, s0, s8
	fmadd	s31, s2, s1, s31
	fmadd	s30, s2, s3, s30
	fmadd	s29, s2, s4, s29
	ldr	s2, [x3, x15]
	fmadd	s12, s2, s0, s12
	fmadd	s11, s2, s1, s11
	fmadd	s10, s2, s3, s10
	fmadd	s9, s2, s4, s9
	add	x1, x3, x15
	add	x3, x1, x15
	ldr	s2, [x1, x15]
	fmadd	s24, s2, s0, s18
	fmadd	s15, s2, s1, s15
	fmadd	s14, s2, s3, s14
	fmadd	s13, s2, s4, s13
	ldr	s2, [x3, x15]
	fmadd	s0, s2, s0, s23
	fmadd	s1, s2, s1, s17
	ldr	s16, [sp, #12]                  ; 4-byte Folded Reload
	fmadd	s16, s2, s3, s16
	fmadd	s2, s2, s4, s25
	ldp	s3, s4, [sp, #4]                ; 8-byte Folded Reload
	add	x0, x0, #4
	add	x16, x16, x17
	subs	x5, x5, #1
	b.ne	LBB3_2
	b	LBB3_4
LBB3_3:
	fmov	s22, s23
LBB3_4:
	str	s4, [x2]
	str	s3, [x2, #4]
	str	s6, [x2, #8]
	str	s5, [x2, #12]
	str	s20, [x8]
	str	s19, [x8, #4]
	str	s7, [x8, #8]
	ldr	s3, [sp, #24]                   ; 4-byte Folded Reload
	str	s3, [x8, #12]
	ldr	s3, [sp, #16]                   ; 4-byte Folded Reload
	str	s3, [x9]
	ldr	s3, [sp, #20]                   ; 4-byte Folded Reload
	str	s3, [x9, #4]
	str	s22, [x9, #8]
	ldr	s3, [sp, #28]                   ; 4-byte Folded Reload
	str	s3, [x9, #12]
	str	s28, [x10]
	str	s27, [x10, #4]
	str	s26, [x10, #8]
	str	s21, [x10, #12]
	str	s8, [x11]
	str	s31, [x11, #4]
	str	s30, [x11, #8]
	str	s29, [x11, #12]
	str	s12, [x12]
	str	s11, [x12, #4]
	str	s10, [x12, #8]
	str	s9, [x12, #12]
	str	s24, [x13]
	str	s15, [x13, #4]
	str	s14, [x13, #8]
	str	s13, [x13, #12]
	str	s0, [x14]
	str	s1, [x14, #4]
	str	s16, [x14, #8]
	str	s2, [x14, #12]
	ldp	d9, d8, [sp, #80]               ; 16-byte Folded Reload
	ldp	d11, d10, [sp, #64]             ; 16-byte Folded Reload
	ldp	d13, d12, [sp, #48]             ; 16-byte Folded Reload
	ldp	d15, d14, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm6detail8tile_8x8EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail8tile_8x8EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail8tile_8x8EPKfS2_Pfmmm:  ; @_ZN4gemm6detail8tile_8x8EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #272
	.cfi_def_cfa_offset 272
	stp	d15, d14, [sp, #192]            ; 16-byte Folded Spill
	stp	d13, d12, [sp, #208]            ; 16-byte Folded Spill
	stp	d11, d10, [sp, #224]            ; 16-byte Folded Spill
	stp	d9, d8, [sp, #240]              ; 16-byte Folded Spill
	stp	x28, x27, [sp, #256]            ; 16-byte Folded Spill
	.cfi_offset w27, -8
	.cfi_offset w28, -16
	.cfi_offset b8, -24
	.cfi_offset b9, -32
	.cfi_offset b10, -40
	.cfi_offset b11, -48
	.cfi_offset b12, -56
	.cfi_offset b13, -64
	.cfi_offset b14, -72
	.cfi_offset b15, -80
	ldp	s5, s2, [x2]
	ldp	s6, s3, [x2, #8]
	ldp	s7, s4, [x2, #16]
	ldp	s17, s18, [x2, #24]
	add	x8, x2, x4, lsl #2
	ldp	s1, s8, [x8]
	ldp	s31, s30, [x8, #8]
	ldp	s29, s28, [x8, #16]
	ldp	s12, s9, [x8, #24]
	add	x9, x2, x4, lsl #3
	ldr	s0, [x9]
	str	s0, [sp, #20]                   ; 4-byte Folded Spill
	ldr	s0, [x9, #4]
	stp	s1, s0, [sp, #12]               ; 8-byte Folded Spill
	ldr	s1, [x9, #8]
	ldp	s0, s27, [x9, #12]
	str	s0, [sp, #84]                   ; 4-byte Folded Spill
	ldp	s15, s11, [x9, #20]
	ldr	s10, [x9, #28]
	mov	w10, #12
	madd	x10, x4, x10, x2
	ldr	s0, [x10]
	stp	s0, s1, [sp, #184]              ; 8-byte Folded Spill
	ldp	s1, s0, [x10, #4]
	stp	s0, s1, [sp, #176]              ; 8-byte Folded Spill
	ldp	s1, s0, [x10, #12]
	stp	s0, s1, [sp, #168]              ; 8-byte Folded Spill
	ldp	s1, s0, [x10, #20]
	stp	s0, s1, [sp, #160]              ; 8-byte Folded Spill
	ldr	s1, [x10, #28]
	add	x11, x2, x4, lsl #4
	mov	w12, #20
	madd	x12, x4, x12, x2
	mov	w13, #24
	madd	x13, x4, x13, x2
	mov	w14, #28
	madd	x14, x4, x14, x2
	ldp	s26, s0, [x11]
	stp	s0, s1, [sp, #76]               ; 8-byte Folded Spill
	ldp	s13, s14, [x11, #8]
	ldp	s1, s0, [x11, #16]
	stp	s1, s0, [sp, #88]               ; 8-byte Folded Spill
	ldp	s1, s0, [x11, #24]
	stp	s1, s0, [sp, #96]               ; 8-byte Folded Spill
	ldp	s1, s0, [x12]
	stp	s1, s0, [sp, #104]              ; 8-byte Folded Spill
	ldp	s1, s0, [x12, #8]
	stp	s1, s0, [sp, #112]              ; 8-byte Folded Spill
	ldp	s1, s0, [x12, #16]
	stp	s1, s0, [sp, #120]              ; 8-byte Folded Spill
	ldp	s1, s0, [x12, #24]
	stp	s1, s0, [sp, #128]              ; 8-byte Folded Spill
	ldp	s1, s0, [x13]
	stp	s1, s0, [sp, #136]              ; 8-byte Folded Spill
	ldp	s1, s0, [x13, #8]
	stp	s1, s0, [sp, #144]              ; 8-byte Folded Spill
	ldr	s1, [x13, #16]
	ldp	s0, s16, [x13, #20]
	stp	s1, s0, [sp, #152]              ; 8-byte Folded Spill
	ldr	s19, [x13, #28]
	ldp	s20, s21, [x14]
	ldp	s22, s23, [x14, #8]
	ldp	s24, s25, [x14, #16]
	ldp	s0, s1, [x14, #24]
	stp	s21, s22, [sp, #68]             ; 8-byte Folded Spill
	stp	s19, s20, [sp, #60]             ; 8-byte Folded Spill
	stp	s9, s16, [sp, #52]              ; 8-byte Folded Spill
	stp	s27, s12, [sp, #44]             ; 8-byte Folded Spill
	stp	s15, s10, [sp, #36]             ; 8-byte Folded Spill
	stp	s14, s11, [sp, #28]             ; 8-byte Folded Spill
	str	s13, [sp, #24]                  ; 4-byte Folded Spill
	cbz	x5, LBB4_3
; %bb.1:
	lsl	x15, x3, #2
	add	x16, x1, #16
	lsl	x17, x4, #2
	ldp	s9, s11, [sp, #12]              ; 8-byte Folded Reload
	ldr	s10, [sp, #20]                  ; 4-byte Folded Reload
	fmov	s12, s23
LBB4_2:                                 ; =>This Inner Loop Header: Depth=1
	str	s0, [sp, #20]                   ; 4-byte Folded Spill
	fmov	s13, s1
	ldp	s0, s1, [x16, #-16]
	ldr	s16, [x0]
	fmadd	s5, s16, s0, s5
	fmadd	s27, s16, s1, s2
	fmov	s15, s25
	fmov	s25, s5
	ldp	s5, s2, [x16, #-8]
	fmadd	s23, s16, s5, s6
	fmadd	s22, s16, s2, s3
	ldp	s6, s3, [x16]
	fmadd	s21, s16, s6, s7
	fmadd	s20, s16, s3, s4
	ldp	s7, s4, [x16, #8]
	fmadd	s19, s16, s7, s17
	ldr	s17, [x0, x15]
	fmadd	s18, s16, s4, s18
	fmadd	s9, s17, s0, s9
	fmadd	s8, s17, s1, s8
	fmadd	s31, s17, s5, s31
	fmadd	s30, s17, s2, s30
	fmadd	s29, s17, s6, s29
	fmadd	s28, s17, s3, s28
	ldp	s16, s14, [sp, #48]             ; 8-byte Folded Reload
	fmadd	s16, s17, s7, s16
	str	s16, [sp, #48]                  ; 4-byte Folded Spill
	add	x1, x0, x15
	add	x3, x1, x15
	ldr	s16, [x1, x15]
	fmadd	s14, s17, s4, s14
	str	s14, [sp, #52]                  ; 4-byte Folded Spill
	fmadd	s10, s16, s0, s10
	fmadd	s11, s16, s1, s11
	ldr	s17, [sp, #188]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s5, s17
	str	s17, [sp, #188]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #84]                  ; 4-byte Folded Reload
	fmadd	s17, s16, s2, s17
	str	s17, [sp, #84]                  ; 4-byte Folded Spill
	ldr	s17, [sp, #44]                  ; 4-byte Folded Reload
	fmadd	s17, s16, s6, s17
	str	s17, [sp, #44]                  ; 4-byte Folded Spill
	ldr	s17, [sp, #36]                  ; 4-byte Folded Reload
	fmadd	s17, s16, s3, s17
	str	s17, [sp, #36]                  ; 4-byte Folded Spill
	ldr	s17, [sp, #32]                  ; 4-byte Folded Reload
	fmadd	s17, s16, s7, s17
	str	s17, [sp, #32]                  ; 4-byte Folded Spill
	ldr	s17, [sp, #40]                  ; 4-byte Folded Reload
	fmadd	s17, s16, s4, s17
	str	s17, [sp, #40]                  ; 4-byte Folded Spill
	ldr	s16, [x3, x15]
	ldr	s17, [sp, #184]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s0, s17
	str	s17, [sp, #184]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #180]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s1, s17
	str	s17, [sp, #180]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #176]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s5, s17
	str	s17, [sp, #176]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #172]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s2, s17
	str	s17, [sp, #172]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #168]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s6, s17
	str	s17, [sp, #168]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #164]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s3, s17
	str	s17, [sp, #164]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #160]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s7, s17
	str	s17, [sp, #160]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #80]                  ; 4-byte Folded Reload
	fmadd	s17, s16, s4, s17
	str	s17, [sp, #80]                  ; 4-byte Folded Spill
	add	x1, x3, x15
	add	x3, x1, x15
	ldr	s16, [x1, x15]
	fmadd	s26, s16, s0, s26
	ldr	s17, [sp, #76]                  ; 4-byte Folded Reload
	fmadd	s17, s16, s1, s17
	str	s17, [sp, #76]                  ; 4-byte Folded Spill
	ldr	s17, [sp, #24]                  ; 4-byte Folded Reload
	fmadd	s17, s16, s5, s17
	str	s17, [sp, #24]                  ; 4-byte Folded Spill
	ldr	s17, [sp, #28]                  ; 4-byte Folded Reload
	fmadd	s17, s16, s2, s17
	str	s17, [sp, #28]                  ; 4-byte Folded Spill
	ldr	s17, [sp, #88]                  ; 4-byte Folded Reload
	fmadd	s17, s16, s6, s17
	str	s17, [sp, #88]                  ; 4-byte Folded Spill
	ldr	s17, [sp, #92]                  ; 4-byte Folded Reload
	fmadd	s17, s16, s3, s17
	str	s17, [sp, #92]                  ; 4-byte Folded Spill
	ldr	s17, [sp, #96]                  ; 4-byte Folded Reload
	fmadd	s17, s16, s7, s17
	str	s17, [sp, #96]                  ; 4-byte Folded Spill
	ldr	s17, [sp, #100]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s4, s17
	str	s17, [sp, #100]                 ; 4-byte Folded Spill
	ldr	s16, [x3, x15]
	ldr	s17, [sp, #104]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s0, s17
	str	s17, [sp, #104]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #108]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s1, s17
	str	s17, [sp, #108]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #112]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s5, s17
	str	s17, [sp, #112]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #116]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s2, s17
	str	s17, [sp, #116]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #120]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s6, s17
	str	s17, [sp, #120]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #124]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s3, s17
	str	s17, [sp, #124]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #128]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s7, s17
	str	s17, [sp, #128]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #132]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s4, s17
	str	s17, [sp, #132]                 ; 4-byte Folded Spill
	add	x1, x3, x15
	add	x3, x1, x15
	ldr	s16, [x1, x15]
	ldr	s17, [sp, #136]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s0, s17
	str	s17, [sp, #136]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #140]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s1, s17
	str	s17, [sp, #140]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #144]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s5, s17
	str	s17, [sp, #144]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #148]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s2, s17
	str	s17, [sp, #148]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #152]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s6, s17
	str	s17, [sp, #152]                 ; 4-byte Folded Spill
	ldr	s17, [sp, #156]                 ; 4-byte Folded Reload
	fmadd	s17, s16, s3, s17
	str	s17, [sp, #156]                 ; 4-byte Folded Spill
	ldp	s17, s14, [sp, #56]             ; 8-byte Folded Reload
	fmadd	s17, s16, s7, s17
	str	s17, [sp, #56]                  ; 4-byte Folded Spill
	ldr	s17, [x3, x15]
	fmadd	s14, s16, s4, s14
	ldr	s16, [sp, #64]                  ; 4-byte Folded Reload
	fmadd	s16, s17, s0, s16
	stp	s14, s16, [sp, #60]             ; 8-byte Folded Spill
	ldr	s0, [sp, #20]                   ; 4-byte Folded Reload
	ldr	s16, [sp, #68]                  ; 4-byte Folded Reload
	fmadd	s16, s17, s1, s16
	str	s16, [sp, #68]                  ; 4-byte Folded Spill
	fmov	s1, s13
	ldr	s16, [sp, #72]                  ; 4-byte Folded Reload
	fmadd	s16, s17, s5, s16
	str	s16, [sp, #72]                  ; 4-byte Folded Spill
	fmov	s5, s25
	fmov	s25, s15
	fmadd	s12, s17, s2, s12
	fmov	s2, s27
	fmadd	s24, s17, s6, s24
	fmov	s6, s23
	fmadd	s25, s17, s3, s15
	fmov	s3, s22
	fmadd	s0, s17, s7, s0
	fmov	s7, s21
	fmadd	s1, s17, s4, s13
	fmov	s4, s20
	fmov	s17, s19
	add	x0, x0, #4
	add	x16, x16, x17
	subs	x5, x5, #1
	b.ne	LBB4_2
	b	LBB4_4
LBB4_3:
	ldp	s9, s11, [sp, #12]              ; 8-byte Folded Reload
	ldr	s10, [sp, #20]                  ; 4-byte Folded Reload
	fmov	s12, s23
LBB4_4:
	str	s5, [x2]
	str	s2, [x2, #4]
	str	s6, [x2, #8]
	str	s3, [x2, #12]
	str	s7, [x2, #16]
	str	s4, [x2, #20]
	str	s17, [x2, #24]
	str	s18, [x2, #28]
	str	s9, [x8]
	str	s8, [x8, #4]
	str	s31, [x8, #8]
	str	s30, [x8, #12]
	str	s29, [x8, #16]
	str	s28, [x8, #20]
	ldr	s2, [sp, #48]                   ; 4-byte Folded Reload
	str	s2, [x8, #24]
	ldr	s2, [sp, #52]                   ; 4-byte Folded Reload
	str	s2, [x8, #28]
	str	s10, [x9]
	str	s11, [x9, #4]
	ldr	s2, [sp, #188]                  ; 4-byte Folded Reload
	str	s2, [x9, #8]
	ldr	s2, [sp, #84]                   ; 4-byte Folded Reload
	str	s2, [x9, #12]
	ldr	s2, [sp, #44]                   ; 4-byte Folded Reload
	str	s2, [x9, #16]
	ldr	s2, [sp, #36]                   ; 4-byte Folded Reload
	str	s2, [x9, #20]
	ldr	s2, [sp, #32]                   ; 4-byte Folded Reload
	str	s2, [x9, #24]
	ldr	s2, [sp, #40]                   ; 4-byte Folded Reload
	str	s2, [x9, #28]
	ldr	s2, [sp, #184]                  ; 4-byte Folded Reload
	str	s2, [x10]
	ldr	s2, [sp, #180]                  ; 4-byte Folded Reload
	str	s2, [x10, #4]
	ldr	s2, [sp, #176]                  ; 4-byte Folded Reload
	str	s2, [x10, #8]
	ldr	s2, [sp, #172]                  ; 4-byte Folded Reload
	str	s2, [x10, #12]
	ldr	s2, [sp, #168]                  ; 4-byte Folded Reload
	str	s2, [x10, #16]
	ldr	s2, [sp, #164]                  ; 4-byte Folded Reload
	str	s2, [x10, #20]
	ldr	s2, [sp, #160]                  ; 4-byte Folded Reload
	str	s2, [x10, #24]
	ldr	s2, [sp, #80]                   ; 4-byte Folded Reload
	str	s2, [x10, #28]
	str	s26, [x11]
	ldr	s2, [sp, #76]                   ; 4-byte Folded Reload
	str	s2, [x11, #4]
	ldr	s2, [sp, #24]                   ; 4-byte Folded Reload
	str	s2, [x11, #8]
	ldr	s2, [sp, #28]                   ; 4-byte Folded Reload
	str	s2, [x11, #12]
	ldr	s2, [sp, #88]                   ; 4-byte Folded Reload
	str	s2, [x11, #16]
	ldr	s2, [sp, #92]                   ; 4-byte Folded Reload
	str	s2, [x11, #20]
	ldr	s2, [sp, #96]                   ; 4-byte Folded Reload
	str	s2, [x11, #24]
	ldr	s2, [sp, #100]                  ; 4-byte Folded Reload
	str	s2, [x11, #28]
	ldr	s2, [sp, #104]                  ; 4-byte Folded Reload
	str	s2, [x12]
	ldr	s2, [sp, #108]                  ; 4-byte Folded Reload
	str	s2, [x12, #4]
	ldr	s2, [sp, #112]                  ; 4-byte Folded Reload
	str	s2, [x12, #8]
	ldr	s2, [sp, #116]                  ; 4-byte Folded Reload
	str	s2, [x12, #12]
	ldr	s2, [sp, #120]                  ; 4-byte Folded Reload
	str	s2, [x12, #16]
	ldr	s2, [sp, #124]                  ; 4-byte Folded Reload
	str	s2, [x12, #20]
	ldr	s2, [sp, #128]                  ; 4-byte Folded Reload
	str	s2, [x12, #24]
	ldr	s2, [sp, #132]                  ; 4-byte Folded Reload
	str	s2, [x12, #28]
	ldr	s2, [sp, #136]                  ; 4-byte Folded Reload
	str	s2, [x13]
	ldr	s2, [sp, #140]                  ; 4-byte Folded Reload
	str	s2, [x13, #4]
	ldr	s2, [sp, #144]                  ; 4-byte Folded Reload
	str	s2, [x13, #8]
	ldr	s2, [sp, #148]                  ; 4-byte Folded Reload
	str	s2, [x13, #12]
	ldr	s2, [sp, #152]                  ; 4-byte Folded Reload
	str	s2, [x13, #16]
	ldr	s2, [sp, #156]                  ; 4-byte Folded Reload
	str	s2, [x13, #20]
	ldr	s2, [sp, #56]                   ; 4-byte Folded Reload
	str	s2, [x13, #24]
	ldr	s2, [sp, #60]                   ; 4-byte Folded Reload
	str	s2, [x13, #28]
	ldr	s2, [sp, #64]                   ; 4-byte Folded Reload
	str	s2, [x14]
	ldr	s2, [sp, #68]                   ; 4-byte Folded Reload
	str	s2, [x14, #4]
	ldr	s2, [sp, #72]                   ; 4-byte Folded Reload
	str	s2, [x14, #8]
	str	s12, [x14, #12]
	str	s24, [x14, #16]
	str	s25, [x14, #20]
	str	s0, [x14, #24]
	str	s1, [x14, #28]
	ldp	x28, x27, [sp, #256]            ; 16-byte Folded Reload
	ldp	d9, d8, [sp, #240]              ; 16-byte Folded Reload
	ldp	d11, d10, [sp, #224]            ; 16-byte Folded Reload
	ldp	d13, d12, [sp, #208]            ; 16-byte Folded Reload
	ldp	d15, d14, [sp, #192]            ; 16-byte Folded Reload
	add	sp, sp, #272
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZN4gemm6detail10tile_16x16EPKfS2_Pfmmm ; -- Begin function _ZN4gemm6detail10tile_16x16EPKfS2_Pfmmm
	.p2align	2
__ZN4gemm6detail10tile_16x16EPKfS2_Pfmmm: ; @_ZN4gemm6detail10tile_16x16EPKfS2_Pfmmm
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 96
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	sub	sp, sp, #1136
Lloh0:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh1:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh2:
	ldr	x8, [x8]
	stur	x8, [x29, #-96]
	ldp	q0, q1, [x2]
	stp	q0, q1, [sp, #96]
	ldp	q0, q1, [x2, #32]
	stp	q0, q1, [sp, #128]
	add	x17, sp, #96
	add	x10, x17, #64
	add	x8, x2, x4, lsl #2
	ldp	q0, q1, [x8]
	stp	q0, q1, [sp, #160]
	ldp	q0, q1, [x8, #32]
	stp	q0, q1, [sp, #192]
	add	x9, x17, #128
	stp	x9, x10, [sp, #80]              ; 16-byte Folded Spill
	add	x10, x2, x4, lsl #3
	ldp	q0, q1, [x10]
	ldp	q2, q3, [x10, #32]
	stp	q2, q3, [sp, #256]
	stp	q0, q1, [sp, #224]
	add	x11, x17, #192
	mov	w9, #12
	madd	x12, x4, x9, x2
	ldp	q1, q0, [x12, #32]
	stp	q1, q0, [sp, #320]
	ldp	q1, q0, [x12]
	stp	q1, q0, [sp, #288]
	add	x9, x17, #256
	stp	x9, x11, [sp, #64]              ; 16-byte Folded Spill
	add	x14, x2, x4, lsl #4
	ldp	q1, q0, [x14, #32]
	stp	q1, q0, [sp, #384]
	ldp	q0, q1, [x14]
	stp	q0, q1, [sp, #352]
	add	x11, x17, #320
	mov	w9, #20
	madd	x6, x4, x9, x2
	ldp	q0, q1, [x6]
	ldp	q2, q3, [x6, #32]
	stp	q2, q3, [sp, #448]
	stp	q0, q1, [sp, #416]
	add	x9, x17, #384
	stp	x9, x11, [sp, #48]              ; 16-byte Folded Spill
	mov	w9, #24
	madd	x19, x4, x9, x2
	ldp	q0, q1, [x19]
	ldp	q2, q3, [x19, #32]
	stp	q2, q3, [sp, #512]
	stp	q0, q1, [sp, #480]
	add	x9, x17, #448
	str	x9, [sp, #40]                   ; 8-byte Folded Spill
	mov	w9, #28
	madd	x21, x4, x9, x2
	ldp	q0, q1, [x21]
	ldp	q2, q3, [x21, #32]
	stp	q2, q3, [sp, #576]
	stp	q0, q1, [sp, #544]
	add	x22, x2, x4, lsl #5
	ldp	q0, q1, [x22]
	ldp	q2, q3, [x22, #32]
	stp	q2, q3, [sp, #640]
	stp	q0, q1, [sp, #608]
	mov	w9, #36
	madd	x23, x4, x9, x2
	ldp	q0, q1, [x23]
	ldp	q2, q3, [x23, #32]
	stp	q2, q3, [sp, #704]
	stp	q0, q1, [sp, #672]
	mov	w9, #40
	madd	x24, x4, x9, x2
	ldp	q0, q1, [x24]
	ldp	q2, q3, [x24, #32]
	stp	q2, q3, [sp, #768]
	stp	q0, q1, [sp, #736]
	mov	w9, #44
	madd	x25, x4, x9, x2
	ldp	q0, q1, [x25]
	ldp	q2, q3, [x25, #32]
	stp	q2, q3, [sp, #832]
	stp	q0, q1, [sp, #800]
	mov	w9, #48
	madd	x26, x4, x9, x2
	ldp	q0, q1, [x26]
	ldp	q2, q3, [x26, #32]
	stp	q2, q3, [sp, #896]
	stp	q0, q1, [sp, #864]
	mov	w9, #52
	madd	x27, x4, x9, x2
	ldp	q0, q1, [x27]
	ldp	q2, q3, [x27, #32]
	stp	q2, q3, [sp, #960]
	stp	q0, q1, [sp, #928]
	mov	w9, #56
	madd	x28, x4, x9, x2
	ldp	q0, q1, [x28]
	ldp	q2, q3, [x28, #32]
	str	q3, [sp, #1040]
	stp	q1, q2, [sp, #1008]
	str	q0, [sp, #992]
	mov	w9, #60
	madd	x30, x4, x9, x2
	ldp	q0, q1, [x30]
	ldp	q2, q3, [x30, #32]
	str	q3, [sp, #1104]
	str	q2, [sp, #1088]
	str	q1, [sp, #1072]
	str	q0, [sp, #1056]
	add	x20, x17, #512
	add	x7, x17, #576
	add	x16, x17, #640
	add	x11, x17, #704
	add	x9, x17, #768
	stp	x11, x9, [sp]                   ; 16-byte Folded Spill
	add	x11, x17, #832
	add	x9, x17, #896
	stp	x11, x9, [sp, #16]              ; 16-byte Folded Spill
	add	x9, x17, #960
	str	x9, [sp, #32]                   ; 8-byte Folded Spill
	cbz	x5, LBB5_5
; %bb.1:
	mov	x13, x0
	mov	x9, #0
	lsl	x3, x3, #2
LBB5_2:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB5_3 Depth 2
	mov	x11, #0
	mul	x0, x9, x4
	add	x0, x1, x0, lsl #2
	ldr	q0, [x0]
	ldp	d1, d2, [x0, #16]
	ldp	d3, d4, [x0, #32]
	ldp	d5, d6, [x0, #48]
	mov	x0, x13
LBB5_3:                                 ;   Parent Loop BB5_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	s7, [x0]
	add	x15, x17, x11
	ldr	q16, [x15]
	fmla.4s	v16, v0, v7[0]
	str	q16, [x15]
	ldp	d16, d17, [x15, #16]
	fmla.2s	v16, v1, v7[0]
	fmla.2s	v17, v2, v7[0]
	stp	d16, d17, [x15, #16]
	ldp	d16, d17, [x15, #32]
	fmla.2s	v16, v3, v7[0]
	fmla.2s	v17, v4, v7[0]
	stp	d16, d17, [x15, #32]
	ldp	d16, d17, [x15, #48]
	fmla.2s	v16, v5, v7[0]
	fmla.2s	v17, v6, v7[0]
	stp	d16, d17, [x15, #48]
	add	x11, x11, #64
	add	x0, x0, x3
	cmp	x11, #1024
	b.ne	LBB5_3
; %bb.4:                                ;   in Loop: Header=BB5_2 Depth=1
	add	x9, x9, #1
	add	x13, x13, #4
	cmp	x9, x5
	b.ne	LBB5_2
LBB5_5:
	ldp	q0, q1, [sp, #96]
	stp	q0, q1, [x2]
	ldp	q0, q1, [sp, #128]
	stp	q0, q1, [x2, #32]
	ldr	x9, [sp, #88]                   ; 8-byte Folded Reload
	ldp	q0, q1, [x9]
	ldp	q2, q3, [x9, #32]
	stp	q0, q1, [x8]
	stp	q2, q3, [x8, #32]
	ldr	x8, [sp, #80]                   ; 8-byte Folded Reload
	ldp	q0, q1, [x8]
	ldp	q2, q3, [x8, #32]
	stp	q0, q1, [x10]
	stp	q2, q3, [x10, #32]
	ldr	x8, [sp, #72]                   ; 8-byte Folded Reload
	ldp	q0, q1, [x8]
	ldp	q2, q3, [x8, #32]
	stp	q2, q3, [x12, #32]
	stp	q0, q1, [x12]
	ldr	x8, [sp, #64]                   ; 8-byte Folded Reload
	ldp	q1, q0, [x8, #32]
	ldp	q3, q2, [x8]
	stp	q1, q0, [x14, #32]
	stp	q3, q2, [x14]
	ldr	x8, [sp, #56]                   ; 8-byte Folded Reload
	ldp	q1, q0, [x8, #32]
	ldp	q3, q2, [x8]
	stp	q1, q0, [x6, #32]
	stp	q3, q2, [x6]
	ldr	x8, [sp, #48]                   ; 8-byte Folded Reload
	ldp	q1, q0, [x8, #32]
	ldp	q3, q2, [x8]
	stp	q1, q0, [x19, #32]
	stp	q3, q2, [x19]
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	ldp	q1, q0, [x8, #32]
	ldp	q3, q2, [x8]
	stp	q1, q0, [x21, #32]
	stp	q3, q2, [x21]
	ldp	q1, q0, [x20, #32]
	ldp	q3, q2, [x20]
	stp	q1, q0, [x22, #32]
	stp	q3, q2, [x22]
	ldp	q1, q0, [x7, #32]
	ldp	q3, q2, [x7]
	stp	q1, q0, [x23, #32]
	stp	q3, q2, [x23]
	ldp	q1, q0, [x16, #32]
	ldp	q3, q2, [x16]
	stp	q1, q0, [x24, #32]
	stp	q3, q2, [x24]
	ldr	x8, [sp]                        ; 8-byte Folded Reload
	ldp	q1, q0, [x8, #32]
	ldp	q3, q2, [x8]
	stp	q1, q0, [x25, #32]
	stp	q3, q2, [x25]
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	ldp	q1, q0, [x8, #32]
	ldp	q3, q2, [x8]
	stp	q1, q0, [x26, #32]
	stp	q3, q2, [x26]
	ldr	x8, [sp, #16]                   ; 8-byte Folded Reload
	ldp	q1, q0, [x8, #32]
	ldp	q3, q2, [x8]
	stp	q1, q0, [x27, #32]
	stp	q3, q2, [x27]
	ldr	x8, [sp, #24]                   ; 8-byte Folded Reload
	ldp	q1, q0, [x8, #32]
	ldp	q3, q2, [x8]
	stp	q1, q0, [x28, #32]
	stp	q3, q2, [x28]
	ldr	x8, [sp, #32]                   ; 8-byte Folded Reload
	ldp	q1, q0, [x8, #32]
	stp	q1, q0, [x30, #32]
	ldp	q1, q0, [x8]
	stp	q1, q0, [x30]
Lloh3:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh4:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh5:
	ldr	x8, [x8]
	ldur	x9, [x29, #-96]
	cmp	x8, x9
	b.ne	LBB5_7
; %bb.6:
	add	sp, sp, #1136
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB5_7:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh0, Lloh1, Lloh2
	.loh AdrpLdrGotLdr	Lloh3, Lloh4, Lloh5
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
