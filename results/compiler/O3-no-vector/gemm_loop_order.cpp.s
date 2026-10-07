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
	cbz	x3, LBB0_11
; %bb.1:
	mov	x20, x4
	cbz	x4, LBB0_11
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
	cbz	x19, LBB0_11
; %bb.5:
	mov	x8, #0
	lsl	x9, x20, #2
LBB0_6:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_7 Depth 2
                                        ;       Child Loop BB0_8 Depth 3
	mov	x10, #0
	mul	x11, x8, x19
	mov	x12, x23
LBB0_7:                                 ;   Parent Loop BB0_6 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_8 Depth 3
	add	x13, x10, x11
	ldr	s0, [x24, x13, lsl #2]
	mov	x13, x12
	mov	x14, x22
	mov	x15, x20
LBB0_8:                                 ;   Parent Loop BB0_6 Depth=1
                                        ;     Parent Loop BB0_7 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x13], #4
	ldr	s2, [x14]
	fmadd	s1, s0, s1, s2
	str	s1, [x14], #4
	subs	x15, x15, #1
	b.ne	LBB0_8
; %bb.9:                                ;   in Loop: Header=BB0_7 Depth=2
	add	x10, x10, #1
	add	x12, x12, x9
	cmp	x10, x19
	b.ne	LBB0_7
; %bb.10:                               ;   in Loop: Header=BB0_6 Depth=1
	add	x8, x8, #1
	add	x22, x22, x9
	cmp	x8, x21
	b.ne	LBB0_6
LBB0_11:
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
	cbz	x3, LBB1_12
; %bb.1:
	cbz	x4, LBB1_12
; %bb.2:
	mov	x8, #0
	lsl	x9, x4, #2
	cbz	x5, LBB1_9
; %bb.3:
	lsl	x10, x5, #2
LBB1_4:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_5 Depth 2
                                        ;       Child Loop BB1_6 Depth 3
	mov	x11, #0
	mov	x12, x0
LBB1_5:                                 ;   Parent Loop BB1_4 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB1_6 Depth 3
	movi	d0, #0000000000000000
	mov	x13, x12
	mov	x14, x1
	mov	x15, x5
LBB1_6:                                 ;   Parent Loop BB1_4 Depth=1
                                        ;     Parent Loop BB1_5 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x13], #4
	ldr	s2, [x14]
	fmadd	s0, s1, s2, s0
	add	x14, x14, x9
	subs	x15, x15, #1
	b.ne	LBB1_6
; %bb.7:                                ;   in Loop: Header=BB1_5 Depth=2
	madd	x13, x11, x4, x8
	str	s0, [x2, x13, lsl #2]
	add	x11, x11, #1
	add	x12, x12, x10
	cmp	x11, x3
	b.ne	LBB1_5
; %bb.8:                                ;   in Loop: Header=BB1_4 Depth=1
	add	x8, x8, #1
	add	x1, x1, #4
	cmp	x8, x4
	b.ne	LBB1_4
	b	LBB1_12
LBB1_9:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_10 Depth 2
	mov	x10, x2
	mov	x11, x3
LBB1_10:                                ;   Parent Loop BB1_9 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	str	wzr, [x10]
	add	x10, x10, x9
	subs	x11, x11, #1
	b.ne	LBB1_10
; %bb.11:                               ;   in Loop: Header=BB1_9 Depth=1
	add	x8, x8, #1
	add	x2, x2, #4
	cmp	x8, x4
	b.ne	LBB1_9
LBB1_12:
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
	cbz	x3, LBB2_11
; %bb.1:
	mov	x20, x4
	cbz	x4, LBB2_11
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
	cbz	x19, LBB2_11
; %bb.5:
	mov	x8, #0
	lsl	x9, x20, #2
	lsl	x10, x19, #2
LBB2_6:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_7 Depth 2
                                        ;       Child Loop BB2_8 Depth 3
	mov	x11, #0
	mov	x12, x24
LBB2_7:                                 ;   Parent Loop BB2_6 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_8 Depth 3
	madd	x13, x11, x20, x8
	ldr	s0, [x23, x13, lsl #2]
	mov	x13, x12
	mov	x14, x22
	mov	x15, x21
LBB2_8:                                 ;   Parent Loop BB2_6 Depth=1
                                        ;     Parent Loop BB2_7 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x13]
	ldr	s2, [x14]
	fmadd	s1, s1, s0, s2
	str	s1, [x14]
	add	x14, x14, x9
	add	x13, x13, x10
	subs	x15, x15, #1
	b.ne	LBB2_8
; %bb.9:                                ;   in Loop: Header=BB2_7 Depth=2
	add	x11, x11, #1
	add	x12, x12, #4
	cmp	x11, x19
	b.ne	LBB2_7
; %bb.10:                               ;   in Loop: Header=BB2_6 Depth=1
	add	x8, x8, #1
	add	x22, x22, #4
	cmp	x8, x20
	b.ne	LBB2_6
LBB2_11:
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
	cbz	x3, LBB3_11
; %bb.1:
	mov	x20, x4
	cbz	x4, LBB3_11
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
	cbz	x19, LBB3_11
; %bb.5:
	mov	x8, #0
	lsl	x9, x20, #2
LBB3_6:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_7 Depth 2
                                        ;       Child Loop BB3_8 Depth 3
	mov	x10, #0
	mov	x11, x22
LBB3_7:                                 ;   Parent Loop BB3_6 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB3_8 Depth 3
	madd	x12, x10, x19, x8
	ldr	s0, [x24, x12, lsl #2]
	mov	x12, x23
	mov	x13, x11
	mov	x14, x20
LBB3_8:                                 ;   Parent Loop BB3_6 Depth=1
                                        ;     Parent Loop BB3_7 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x12], #4
	ldr	s2, [x13]
	fmadd	s1, s0, s1, s2
	str	s1, [x13], #4
	subs	x14, x14, #1
	b.ne	LBB3_8
; %bb.9:                                ;   in Loop: Header=BB3_7 Depth=2
	add	x10, x10, #1
	add	x11, x11, x9
	cmp	x10, x21
	b.ne	LBB3_7
; %bb.10:                               ;   in Loop: Header=BB3_6 Depth=1
	add	x8, x8, #1
	add	x23, x23, x9
	cmp	x8, x19
	b.ne	LBB3_6
LBB3_11:
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
	cbz	x3, LBB4_11
; %bb.1:
	mov	x20, x4
	cbz	x4, LBB4_11
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
	cbz	x19, LBB4_11
; %bb.5:
	mov	x8, #0
	lsl	x9, x20, #2
	lsl	x10, x19, #2
LBB4_6:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_7 Depth 2
                                        ;       Child Loop BB4_8 Depth 3
	mov	x11, #0
	mul	x12, x8, x20
	mov	x13, x22
LBB4_7:                                 ;   Parent Loop BB4_6 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB4_8 Depth 3
	add	x14, x11, x12
	ldr	s0, [x23, x14, lsl #2]
	mov	x14, x24
	mov	x15, x13
	mov	x16, x21
LBB4_8:                                 ;   Parent Loop BB4_6 Depth=1
                                        ;     Parent Loop BB4_7 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	s1, [x14]
	ldr	s2, [x15]
	fmadd	s1, s1, s0, s2
	str	s1, [x15]
	add	x15, x15, x9
	add	x14, x14, x10
	subs	x16, x16, #1
	b.ne	LBB4_8
; %bb.9:                                ;   in Loop: Header=BB4_7 Depth=2
	add	x11, x11, #1
	add	x13, x13, #4
	cmp	x11, x20
	b.ne	LBB4_7
; %bb.10:                               ;   in Loop: Header=BB4_6 Depth=1
	add	x8, x8, #1
	add	x24, x24, #4
	cmp	x8, x19
	b.ne	LBB4_6
LBB4_11:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
