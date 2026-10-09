	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	__ZN4gemm11microkernelEPKfS1_PfmmmNS_9BlockSizeEmmm ; -- Begin function _ZN4gemm11microkernelEPKfS1_PfmmmNS_9BlockSizeEmmm
	.p2align	2
__ZN4gemm11microkernelEPKfS1_PfmmmNS_9BlockSizeEmmm: ; @_ZN4gemm11microkernelEPKfS1_PfmmmNS_9BlockSizeEmmm
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldp	x8, x9, [x29, #16]
	cmp	x7, #2
	cset	w10, eq
	cmp	x8, #4
	cset	w11, eq
Lloh0:
	adrp	x12, __ZN4gemm6detail8tile_2x4EPKfS2_Pfmmm@GOTPAGE
Lloh1:
	ldr	x12, [x12, __ZN4gemm6detail8tile_2x4EPKfS2_Pfmmm@GOTPAGEOFF]
	tst	w10, w11
	csel	x12, x12, xzr, ne
	cmp	x7, #4
	cset	w13, eq
Lloh2:
	adrp	x14, __ZN4gemm6detail8tile_4x4EPKfS2_Pfmmm@GOTPAGE
Lloh3:
	ldr	x14, [x14, __ZN4gemm6detail8tile_4x4EPKfS2_Pfmmm@GOTPAGEOFF]
	ands	w10, w13, w11
	csel	x12, x14, x12, ne
	cmp	x8, #8
	cset	w14, eq
Lloh4:
	adrp	x15, __ZN4gemm6detail8tile_4x8EPKfS2_Pfmmm@GOTPAGE
Lloh5:
	ldr	x15, [x15, __ZN4gemm6detail8tile_4x8EPKfS2_Pfmmm@GOTPAGEOFF]
	tst	w13, w14
	csel	x12, x15, x12, ne
	cmp	x7, #8
	cset	w13, eq
Lloh6:
	adrp	x15, __ZN4gemm6detail8tile_8x4EPKfS2_Pfmmm@GOTPAGE
Lloh7:
	ldr	x15, [x15, __ZN4gemm6detail8tile_8x4EPKfS2_Pfmmm@GOTPAGEOFF]
	tst	w13, w11
	csel	x11, x15, x12, ne
Lloh8:
	adrp	x12, __ZN4gemm6detail8tile_8x8EPKfS2_Pfmmm@GOTPAGE
Lloh9:
	ldr	x12, [x12, __ZN4gemm6detail8tile_8x8EPKfS2_Pfmmm@GOTPAGEOFF]
	tst	w13, w14
	csel	x11, x12, x11, ne
	cmp	x8, #16
	ccmp	x7, #16, #0, eq
Lloh10:
	adrp	x12, __ZN4gemm6detail10tile_16x16EPKfS2_Pfmmm@GOTPAGE
Lloh11:
	ldr	x12, [x12, __ZN4gemm6detail10tile_16x16EPKfS2_Pfmmm@GOTPAGEOFF]
	csel	x11, x12, x11, eq
	cmp	x9, #1
	csel	x11, x11, xzr, eq
	b.eq	LBB0_2
; %bb.1:
Lloh12:
	adrp	x12, __ZN4gemm6detail11tile_4x4_u2EPKfS2_Pfmmm@GOTPAGE
Lloh13:
	ldr	x12, [x12, __ZN4gemm6detail11tile_4x4_u2EPKfS2_Pfmmm@GOTPAGEOFF]
	cmp	x9, #2
	csel	x12, x12, xzr, eq
Lloh14:
	adrp	x13, __ZN4gemm6detail11tile_4x4_u4EPKfS2_Pfmmm@GOTPAGE
Lloh15:
	ldr	x13, [x13, __ZN4gemm6detail11tile_4x4_u4EPKfS2_Pfmmm@GOTPAGEOFF]
	cmp	x9, #4
	csel	x12, x13, x12, eq
Lloh16:
	adrp	x13, __ZN4gemm6detail11tile_4x4_u8EPKfS2_Pfmmm@GOTPAGE
Lloh17:
	ldr	x13, [x13, __ZN4gemm6detail11tile_4x4_u8EPKfS2_Pfmmm@GOTPAGEOFF]
	cmp	x9, #8
	csel	x9, x13, x12, eq
	tst	w10, #0x1
	csel	x11, x11, x9, eq
LBB0_2:
	ldr	q0, [x6]
	str	q0, [sp, #16]
	ldr	x9, [x6, #16]
	str	x9, [sp, #32]
	stp	x8, x11, [sp]
	add	x6, sp, #16
	bl	__ZN4gemm12_GLOBAL__N_116microkernel_implEPKfS2_PfmmmNS_9BlockSizeEmmPFvS2_S2_S3_mmmE
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.loh AdrpLdrGot	Lloh10, Lloh11
	.loh AdrpLdrGot	Lloh8, Lloh9
	.loh AdrpLdrGot	Lloh6, Lloh7
	.loh AdrpLdrGot	Lloh4, Lloh5
	.loh AdrpLdrGot	Lloh2, Lloh3
	.loh AdrpLdrGot	Lloh0, Lloh1
	.loh AdrpLdrGot	Lloh16, Lloh17
	.loh AdrpLdrGot	Lloh14, Lloh15
	.loh AdrpLdrGot	Lloh12, Lloh13
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _ZN4gemm12_GLOBAL__N_116microkernel_implEPKfS2_PfmmmNS_9BlockSizeEmmPFvS2_S2_S3_mmmE
__ZN4gemm12_GLOBAL__N_116microkernel_implEPKfS2_PfmmmNS_9BlockSizeEmmPFvS2_S2_S3_mmmE: ; @_ZN4gemm12_GLOBAL__N_116microkernel_implEPKfS2_PfmmmNS_9BlockSizeEmmPFvS2_S2_S3_mmmE
Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception0
; %bb.0:
	sub	sp, sp, #336
	.cfi_def_cfa_offset 336
	stp	x28, x27, [sp, #240]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #256]            ; 16-byte Folded Spill
	stp	x24, x23, [sp, #272]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #288]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #304]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #320]            ; 16-byte Folded Spill
	add	x29, sp, #320
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
	str	x0, [sp, #56]                   ; 8-byte Folded Spill
	ldr	x8, [x29, #24]
	stur	x8, [x29, #-112]                ; 8-byte Folded Spill
	cbz	x8, LBB1_69
; %bb.1:
	mov	x19, x6
	ldr	x8, [x6]
	cbz	x8, LBB1_69
; %bb.2:
	ldr	x8, [x19, #8]
	cbz	x8, LBB1_69
; %bb.3:
	ldr	x8, [x19, #16]
	cbz	x8, LBB1_69
; %bb.4:
	mov	x21, x3
	cbz	x3, LBB1_68
; %bb.5:
	cbz	x4, LBB1_68
; %bb.6:
	mov	x24, x2
	mov	x22, x1
	mul	x8, x4, x21
	stp	x5, x7, [x29, #-128]            ; 16-byte Folded Spill
	stur	x4, [x29, #-96]                 ; 8-byte Folded Spill
	cbz	x8, LBB1_8
; %bb.7:
	lsl	x1, x8, #2
	mov	x0, x24
	bl	_bzero
	ldur	x4, [x29, #-96]                 ; 8-byte Folded Reload
	ldp	x5, x7, [x29, #-128]            ; 16-byte Folded Reload
LBB1_8:
	cbz	x5, LBB1_68
; %bb.9:
	mov	x10, #0
	lsl	x20, x4, #2
	ldr	x3, [x29, #16]
	lsl	x6, x5, #2
	ldr	x8, [sp, #56]                   ; 8-byte Folded Reload
	add	x8, x8, #32
	str	x8, [sp, #32]                   ; 8-byte Folded Spill
	add	x8, x22, #32
	str	x8, [sp, #72]                   ; 8-byte Folded Spill
	lsl	x23, x4, #6
	str	x19, [sp, #16]                  ; 8-byte Folded Spill
	str	x22, [sp, #120]                 ; 8-byte Folded Spill
	stp	x6, x3, [x29, #-144]            ; 16-byte Folded Spill
	str	x21, [sp]                       ; 8-byte Folded Spill
	b	LBB1_11
LBB1_10:                                ;   in Loop: Header=BB1_11 Depth=1
	mov	x10, x11
	ldr	x21, [sp]                       ; 8-byte Folded Reload
	cmp	x11, x21
	b.hs	LBB1_68
LBB1_11:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_14 Depth 2
                                        ;       Child Loop BB1_55 Depth 3
                                        ;         Child Loop BB1_57 Depth 4
                                        ;           Child Loop BB1_61 Depth 5
                                        ;           Child Loop BB1_59 Depth 5
                                        ;           Child Loop BB1_66 Depth 5
                                        ;       Child Loop BB1_17 Depth 3
                                        ;         Child Loop BB1_19 Depth 4
                                        ;           Child Loop BB1_23 Depth 5
                                        ;             Child Loop BB1_44 Depth 6
                                        ;               Child Loop BB1_45 Depth 7
                                        ;                 Child Loop BB1_46 Depth 8
                                        ;             Child Loop BB1_36 Depth 6
                                        ;               Child Loop BB1_38 Depth 7
                                        ;                 Child Loop BB1_39 Depth 8
                                        ;                 Child Loop BB1_42 Depth 8
                                        ;             Child Loop BB1_28 Depth 6
                                        ;               Child Loop BB1_29 Depth 7
                                        ;                 Child Loop BB1_30 Depth 8
                                        ;           Child Loop BB1_51 Depth 5
	ldr	x8, [x19]
	sub	x9, x21, x10
	cmp	x9, x8
	csel	x8, x9, x8, lo
	add	x11, x8, x10
	cmp	x11, x10
	b.ls	LBB1_10
; %bb.12:                               ;   in Loop: Header=BB1_11 Depth=1
	mov	x12, #0
	str	x10, [sp, #24]                  ; 8-byte Folded Spill
	str	x11, [sp, #88]                  ; 8-byte Folded Spill
	b	LBB1_14
LBB1_13:                                ;   in Loop: Header=BB1_14 Depth=2
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	mov	x12, x8
	cmp	x8, x5
	ldr	x22, [sp, #120]                 ; 8-byte Folded Reload
	b.hs	LBB1_10
LBB1_14:                                ;   Parent Loop BB1_11 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB1_55 Depth 3
                                        ;         Child Loop BB1_57 Depth 4
                                        ;           Child Loop BB1_61 Depth 5
                                        ;           Child Loop BB1_59 Depth 5
                                        ;           Child Loop BB1_66 Depth 5
                                        ;       Child Loop BB1_17 Depth 3
                                        ;         Child Loop BB1_19 Depth 4
                                        ;           Child Loop BB1_23 Depth 5
                                        ;             Child Loop BB1_44 Depth 6
                                        ;               Child Loop BB1_45 Depth 7
                                        ;                 Child Loop BB1_46 Depth 8
                                        ;             Child Loop BB1_36 Depth 6
                                        ;               Child Loop BB1_38 Depth 7
                                        ;                 Child Loop BB1_39 Depth 8
                                        ;                 Child Loop BB1_42 Depth 8
                                        ;             Child Loop BB1_28 Depth 6
                                        ;               Child Loop BB1_29 Depth 7
                                        ;                 Child Loop BB1_30 Depth 8
                                        ;           Child Loop BB1_51 Depth 5
	ldr	x8, [x19, #16]
	sub	x9, x5, x12
	cmp	x9, x8
	csel	x27, x9, x8, lo
	mul	x8, x12, x4
	add	x8, x22, x8, lsl #2
	stur	x8, [x29, #-104]                ; 8-byte Folded Spill
	ldr	x8, [sp, #56]                   ; 8-byte Folded Reload
	add	x8, x8, x12, lsl #2
	str	x8, [sp, #96]                   ; 8-byte Folded Spill
	add	x8, x27, x12
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	cmp	x12, x8
	b.hs	LBB1_53
; %bb.15:                               ;   in Loop: Header=BB1_14 Depth=2
	mov	x13, #0
	and	x28, x27, #0xfffffffffffffff0
	add	x8, x12, x28
	stp	x8, x12, [sp, #40]              ; 16-byte Folded Spill
	mul	x9, x4, x12
	str	x9, [sp, #136]                  ; 8-byte Folded Spill
	sub	x21, x27, x28
	mul	x8, x4, x8
	add	x8, x22, x8, lsl #2
	str	x8, [sp, #80]                   ; 8-byte Folded Spill
	b	LBB1_17
LBB1_16:                                ;   in Loop: Header=BB1_17 Depth=3
	mov	x13, x30
	cmp	x30, x4
	ldp	x19, x10, [sp, #16]             ; 16-byte Folded Reload
	b.hs	LBB1_13
LBB1_17:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB1_19 Depth 4
                                        ;           Child Loop BB1_23 Depth 5
                                        ;             Child Loop BB1_44 Depth 6
                                        ;               Child Loop BB1_45 Depth 7
                                        ;                 Child Loop BB1_46 Depth 8
                                        ;             Child Loop BB1_36 Depth 6
                                        ;               Child Loop BB1_38 Depth 7
                                        ;                 Child Loop BB1_39 Depth 8
                                        ;                 Child Loop BB1_42 Depth 8
                                        ;             Child Loop BB1_28 Depth 6
                                        ;               Child Loop BB1_29 Depth 7
                                        ;                 Child Loop BB1_30 Depth 8
                                        ;           Child Loop BB1_51 Depth 5
	ldr	x8, [x19, #8]
	sub	x9, x4, x13
	cmp	x9, x8
	csel	x8, x9, x8, lo
	add	x30, x8, x13
	cmp	x30, x13
	mov	x19, x10
	str	x13, [sp, #64]                  ; 8-byte Folded Spill
	str	x30, [sp, #144]                 ; 8-byte Folded Spill
	b.hi	LBB1_19
	b	LBB1_16
LBB1_18:                                ;   in Loop: Header=BB1_19 Depth=4
	add	x19, x26, x19
	ldr	x11, [sp, #88]                  ; 8-byte Folded Reload
	cmp	x11, x19
	ldr	x13, [sp, #64]                  ; 8-byte Folded Reload
	b.ls	LBB1_16
LBB1_19:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_17 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB1_23 Depth 5
                                        ;             Child Loop BB1_44 Depth 6
                                        ;               Child Loop BB1_45 Depth 7
                                        ;                 Child Loop BB1_46 Depth 8
                                        ;             Child Loop BB1_36 Depth 6
                                        ;               Child Loop BB1_38 Depth 7
                                        ;                 Child Loop BB1_39 Depth 8
                                        ;                 Child Loop BB1_42 Depth 8
                                        ;             Child Loop BB1_28 Depth 6
                                        ;               Child Loop BB1_29 Depth 7
                                        ;                 Child Loop BB1_30 Depth 8
                                        ;           Child Loop BB1_51 Depth 5
	sub	x12, x11, x19
	cmp	x12, x7
	csel	x26, x12, x7, lo
	mul	x8, x19, x5
	ldr	x9, [sp, #96]                   ; 8-byte Folded Reload
	add	x10, x9, x8, lsl #2
	mul	x8, x19, x4
	add	x8, x24, x8, lsl #2
	stp	x8, x10, [sp, #152]             ; 16-byte Folded Spill
	cbz	x26, LBB1_49
; %bb.20:                               ;   in Loop: Header=BB1_19 Depth=4
	mul	x8, x5, x19
	ldp	x9, x10, [sp, #48]              ; 16-byte Folded Reload
	add	x9, x9, x8
	lsl	x9, x9, #2
	add	x11, x10, x9
	str	x11, [sp, #128]                 ; 8-byte Folded Spill
	ldr	x11, [sp, #32]                  ; 8-byte Folded Reload
	add	x9, x11, x9
	str	x9, [sp, #112]                  ; 8-byte Folded Spill
	ldr	x9, [sp, #40]                   ; 8-byte Folded Reload
	add	x8, x9, x8
	add	x8, x10, x8, lsl #2
	str	x8, [sp, #104]                  ; 8-byte Folded Spill
	mov	x22, x13
	stur	x12, [x29, #-152]               ; 8-byte Folded Spill
	b	LBB1_23
LBB1_21:                                ;   in Loop: Header=BB1_23 Depth=5
	lsl	x8, x22, #2
	ldp	x9, x4, [x29, #-104]            ; 16-byte Folded Reload
	add	x1, x9, x8
	ldp	x9, x0, [sp, #152]              ; 16-byte Folded Reload
	add	x2, x9, x8
	mov	x3, x5
	mov	x5, x27
	ldur	x8, [x29, #-112]                ; 8-byte Folded Reload
	blr	x8
	ldr	x30, [sp, #144]                 ; 8-byte Folded Reload
	ldp	x6, x3, [x29, #-144]            ; 16-byte Folded Reload
	ldur	x4, [x29, #-96]                 ; 8-byte Folded Reload
	ldp	x5, x7, [x29, #-128]            ; 16-byte Folded Reload
LBB1_22:                                ;   in Loop: Header=BB1_23 Depth=5
	add	x22, x25, x22
	cmp	x30, x22
	ldur	x12, [x29, #-152]               ; 8-byte Folded Reload
	b.ls	LBB1_18
LBB1_23:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_17 Depth=3
                                        ;         Parent Loop BB1_19 Depth=4
                                        ; =>        This Loop Header: Depth=5
                                        ;             Child Loop BB1_44 Depth 6
                                        ;               Child Loop BB1_45 Depth 7
                                        ;                 Child Loop BB1_46 Depth 8
                                        ;             Child Loop BB1_36 Depth 6
                                        ;               Child Loop BB1_38 Depth 7
                                        ;                 Child Loop BB1_39 Depth 8
                                        ;                 Child Loop BB1_42 Depth 8
                                        ;             Child Loop BB1_28 Depth 6
                                        ;               Child Loop BB1_29 Depth 7
                                        ;                 Child Loop BB1_30 Depth 8
	sub	x8, x30, x22
	cmp	x8, x3
	csel	x25, x8, x3, lo
	cmp	x12, x7
	b.lo	LBB1_25
; %bb.24:                               ;   in Loop: Header=BB1_23 Depth=5
	cmp	x8, x3
	b.hs	LBB1_21
LBB1_25:                                ;   in Loop: Header=BB1_23 Depth=5
	cbz	x25, LBB1_22
; %bb.26:                               ;   in Loop: Header=BB1_23 Depth=5
	cmp	x27, #15
	b.hi	LBB1_33
; %bb.27:                               ;   in Loop: Header=BB1_23 Depth=5
	mov	x8, #0
	ldr	x9, [sp, #136]                  ; 8-byte Folded Reload
	add	x9, x9, x22
	ldr	x10, [sp, #120]                 ; 8-byte Folded Reload
	add	x9, x10, x9, lsl #2
	ldr	x10, [sp, #128]                 ; 8-byte Folded Reload
LBB1_28:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_17 Depth=3
                                        ;         Parent Loop BB1_19 Depth=4
                                        ;           Parent Loop BB1_23 Depth=5
                                        ; =>          This Loop Header: Depth=6
                                        ;               Child Loop BB1_29 Depth 7
                                        ;                 Child Loop BB1_30 Depth 8
	mov	x11, #0
	add	x12, x8, x19
	mul	x12, x12, x4
	mov	x13, x9
LBB1_29:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_17 Depth=3
                                        ;         Parent Loop BB1_19 Depth=4
                                        ;           Parent Loop BB1_23 Depth=5
                                        ;             Parent Loop BB1_28 Depth=6
                                        ; =>            This Loop Header: Depth=7
                                        ;                 Child Loop BB1_30 Depth 8
	add	x14, x11, x22
	add	x14, x14, x12
	ldr	s0, [x24, x14, lsl #2]
	mov	x15, x10
	mov	x16, x13
	mov	x17, x27
LBB1_30:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_17 Depth=3
                                        ;         Parent Loop BB1_19 Depth=4
                                        ;           Parent Loop BB1_23 Depth=5
                                        ;             Parent Loop BB1_28 Depth=6
                                        ;               Parent Loop BB1_29 Depth=7
                                        ; =>              This Inner Loop Header: Depth=8
	ldr	s1, [x15], #4
	ldr	s2, [x16]
	fmadd	s0, s1, s2, s0
	add	x16, x16, x20
	subs	x17, x17, #1
	b.ne	LBB1_30
; %bb.31:                               ;   in Loop: Header=BB1_29 Depth=7
	str	s0, [x24, x14, lsl #2]
	add	x11, x11, #1
	add	x13, x13, #4
	cmp	x11, x25
	b.ne	LBB1_29
; %bb.32:                               ;   in Loop: Header=BB1_28 Depth=6
	add	x8, x8, #1
	add	x10, x10, x6
	cmp	x8, x26
	b.ne	LBB1_28
	b	LBB1_22
LBB1_33:                                ;   in Loop: Header=BB1_23 Depth=5
	cmp	x4, #1
	b.ne	LBB1_43
; %bb.34:                               ;   in Loop: Header=BB1_23 Depth=5
	mov	x8, #0
	ldr	x9, [sp, #136]                  ; 8-byte Folded Reload
	add	x9, x9, x22
	ldr	x10, [sp, #72]                  ; 8-byte Folded Reload
	add	x9, x10, x9, lsl #2
	ldr	x10, [sp, #80]                  ; 8-byte Folded Reload
	add	x10, x10, x22, lsl #2
	ldp	x11, x12, [sp, #104]            ; 16-byte Folded Reload
	b	LBB1_36
LBB1_35:                                ;   in Loop: Header=BB1_36 Depth=6
	add	x8, x8, #1
	add	x12, x12, x6
	add	x11, x11, x6
	cmp	x8, x26
	b.eq	LBB1_22
LBB1_36:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_17 Depth=3
                                        ;         Parent Loop BB1_19 Depth=4
                                        ;           Parent Loop BB1_23 Depth=5
                                        ; =>          This Loop Header: Depth=6
                                        ;               Child Loop BB1_38 Depth 7
                                        ;                 Child Loop BB1_39 Depth 8
                                        ;                 Child Loop BB1_42 Depth 8
	mov	x13, #0
	add	x14, x8, x19
	mul	x14, x14, x4
	mov	x15, x10
	mov	x16, x9
	b	LBB1_38
LBB1_37:                                ;   in Loop: Header=BB1_38 Depth=7
	str	s0, [x24, x17, lsl #2]
	add	x13, x13, #1
	add	x16, x16, #4
	add	x15, x15, #4
	cmp	x13, x25
	b.eq	LBB1_35
LBB1_38:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_17 Depth=3
                                        ;         Parent Loop BB1_19 Depth=4
                                        ;           Parent Loop BB1_23 Depth=5
                                        ;             Parent Loop BB1_36 Depth=6
                                        ; =>            This Loop Header: Depth=7
                                        ;                 Child Loop BB1_39 Depth 8
                                        ;                 Child Loop BB1_42 Depth 8
	add	x17, x13, x22
	add	x17, x17, x14
	ldr	s0, [x24, x17, lsl #2]
	mov	x0, x16
	mov	x1, x12
	mov	x2, x28
LBB1_39:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_17 Depth=3
                                        ;         Parent Loop BB1_19 Depth=4
                                        ;           Parent Loop BB1_23 Depth=5
                                        ;             Parent Loop BB1_36 Depth=6
                                        ;               Parent Loop BB1_38 Depth=7
                                        ; =>              This Inner Loop Header: Depth=8
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
	add	x0, x0, x23
	subs	x2, x2, #16
	b.ne	LBB1_39
; %bb.40:                               ;   in Loop: Header=BB1_38 Depth=7
	cmp	x27, x28
	b.eq	LBB1_37
; %bb.41:                               ;   in Loop: Header=BB1_38 Depth=7
	mov	x0, x11
	mov	x1, x15
	mov	x2, x21
LBB1_42:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_17 Depth=3
                                        ;         Parent Loop BB1_19 Depth=4
                                        ;           Parent Loop BB1_23 Depth=5
                                        ;             Parent Loop BB1_36 Depth=6
                                        ;               Parent Loop BB1_38 Depth=7
                                        ; =>              This Inner Loop Header: Depth=8
	ldr	s1, [x0], #4
	ldr	s2, [x1]
	fmadd	s0, s1, s2, s0
	add	x1, x1, x20
	subs	x2, x2, #1
	b.ne	LBB1_42
	b	LBB1_37
LBB1_43:                                ;   in Loop: Header=BB1_23 Depth=5
	mov	x8, #0
	ldr	x9, [sp, #136]                  ; 8-byte Folded Reload
	add	x9, x9, x22
	ldr	x10, [sp, #120]                 ; 8-byte Folded Reload
	add	x9, x10, x9, lsl #2
	ldr	x10, [sp, #128]                 ; 8-byte Folded Reload
LBB1_44:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_17 Depth=3
                                        ;         Parent Loop BB1_19 Depth=4
                                        ;           Parent Loop BB1_23 Depth=5
                                        ; =>          This Loop Header: Depth=6
                                        ;               Child Loop BB1_45 Depth 7
                                        ;                 Child Loop BB1_46 Depth 8
	mov	x11, #0
	add	x12, x8, x19
	mul	x12, x12, x4
	mov	x13, x9
LBB1_45:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_17 Depth=3
                                        ;         Parent Loop BB1_19 Depth=4
                                        ;           Parent Loop BB1_23 Depth=5
                                        ;             Parent Loop BB1_44 Depth=6
                                        ; =>            This Loop Header: Depth=7
                                        ;                 Child Loop BB1_46 Depth 8
	add	x14, x11, x22
	add	x14, x14, x12
	ldr	s0, [x24, x14, lsl #2]
	mov	x15, x10
	mov	x16, x13
	mov	x17, x27
LBB1_46:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_17 Depth=3
                                        ;         Parent Loop BB1_19 Depth=4
                                        ;           Parent Loop BB1_23 Depth=5
                                        ;             Parent Loop BB1_44 Depth=6
                                        ;               Parent Loop BB1_45 Depth=7
                                        ; =>              This Inner Loop Header: Depth=8
	ldr	s1, [x15], #4
	ldr	s2, [x16]
	fmadd	s0, s1, s2, s0
	add	x16, x16, x20
	subs	x17, x17, #1
	b.ne	LBB1_46
; %bb.47:                               ;   in Loop: Header=BB1_45 Depth=7
	str	s0, [x24, x14, lsl #2]
	add	x11, x11, #1
	add	x13, x13, #4
	cmp	x11, x25
	b.ne	LBB1_45
; %bb.48:                               ;   in Loop: Header=BB1_44 Depth=6
	add	x8, x8, #1
	add	x10, x10, x6
	cmp	x8, x26
	b.ne	LBB1_44
	b	LBB1_22
LBB1_49:                                ;   in Loop: Header=BB1_19 Depth=4
	mov	x22, x13
	cmp	x12, x7
	b.hs	LBB1_51
	b	LBB1_18
LBB1_50:                                ;   in Loop: Header=BB1_51 Depth=5
	add	x22, x25, x22
	cmp	x30, x22
	b.ls	LBB1_18
LBB1_51:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_17 Depth=3
                                        ;         Parent Loop BB1_19 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	sub	x8, x30, x22
	cmp	x8, x3
	csel	x25, x8, x3, lo
	b.lo	LBB1_50
; %bb.52:                               ;   in Loop: Header=BB1_51 Depth=5
	lsl	x8, x22, #2
	ldp	x9, x4, [x29, #-104]            ; 16-byte Folded Reload
	add	x1, x9, x8
	ldp	x9, x0, [sp, #152]              ; 16-byte Folded Reload
	add	x2, x9, x8
	mov	x3, x5
	mov	x5, x27
	ldur	x8, [x29, #-112]                ; 8-byte Folded Reload
	blr	x8
	ldr	x30, [sp, #144]                 ; 8-byte Folded Reload
	ldp	x6, x3, [x29, #-144]            ; 16-byte Folded Reload
	ldur	x4, [x29, #-96]                 ; 8-byte Folded Reload
	ldp	x5, x7, [x29, #-128]            ; 16-byte Folded Reload
	b	LBB1_50
LBB1_53:                                ;   in Loop: Header=BB1_14 Depth=2
	mov	x12, #0
	b	LBB1_55
LBB1_54:                                ;   in Loop: Header=BB1_55 Depth=3
	mov	x12, x21
	cmp	x21, x4
	ldp	x19, x10, [sp, #16]             ; 16-byte Folded Reload
	b.hs	LBB1_13
LBB1_55:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB1_57 Depth 4
                                        ;           Child Loop BB1_61 Depth 5
                                        ;           Child Loop BB1_59 Depth 5
                                        ;           Child Loop BB1_66 Depth 5
	ldr	x8, [x19, #8]
	sub	x9, x4, x12
	cmp	x9, x8
	csel	x8, x9, x8, lo
	add	x21, x8, x12
	str	x12, [sp, #160]                 ; 8-byte Folded Spill
	cmp	x21, x12
	mov	x22, x10
	b.hi	LBB1_57
	b	LBB1_54
LBB1_56:                                ;   in Loop: Header=BB1_57 Depth=4
	ldur	x8, [x29, #-152]                ; 8-byte Folded Reload
	add	x22, x8, x22
	ldr	x11, [sp, #88]                  ; 8-byte Folded Reload
	cmp	x11, x22
	b.ls	LBB1_54
LBB1_57:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_55 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB1_61 Depth 5
                                        ;           Child Loop BB1_59 Depth 5
                                        ;           Child Loop BB1_66 Depth 5
	sub	x8, x11, x22
	cmp	x8, x7
	csel	x11, x8, x7, lo
	mul	x9, x22, x5
	ldr	x10, [sp, #96]                  ; 8-byte Folded Reload
	add	x28, x10, x9, lsl #2
	mul	x9, x22, x4
	add	x26, x24, x9, lsl #2
	stur	x11, [x29, #-152]               ; 8-byte Folded Spill
	cbz	x11, LBB1_63
; %bb.58:                               ;   in Loop: Header=BB1_57 Depth=4
	ldr	x9, [sp, #160]                  ; 8-byte Folded Reload
	mov	x19, x9
	cmp	x8, x7
	b.hs	LBB1_61
LBB1_59:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_55 Depth=3
                                        ;         Parent Loop BB1_57 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	sub	x8, x21, x9
	cmp	x8, x3
	csel	x8, x8, x3, lo
	add	x9, x8, x9
	cmp	x21, x9
	b.hi	LBB1_59
	b	LBB1_56
LBB1_60:                                ;   in Loop: Header=BB1_61 Depth=5
	add	x19, x25, x19
	cmp	x21, x19
	b.ls	LBB1_56
LBB1_61:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_55 Depth=3
                                        ;         Parent Loop BB1_57 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	sub	x8, x21, x19
	cmp	x8, x3
	csel	x25, x8, x3, lo
	b.lo	LBB1_60
; %bb.62:                               ;   in Loop: Header=BB1_61 Depth=5
	lsl	x8, x19, #2
	ldp	x9, x4, [x29, #-104]            ; 16-byte Folded Reload
	add	x1, x9, x8
	add	x2, x26, x8
	mov	x0, x28
	mov	x3, x5
	mov	x5, x27
	ldur	x8, [x29, #-112]                ; 8-byte Folded Reload
	blr	x8
	ldp	x6, x3, [x29, #-144]            ; 16-byte Folded Reload
	ldur	x4, [x29, #-96]                 ; 8-byte Folded Reload
	ldp	x5, x7, [x29, #-128]            ; 16-byte Folded Reload
	b	LBB1_60
LBB1_63:                                ;   in Loop: Header=BB1_57 Depth=4
	cmp	x8, x7
	b.lo	LBB1_56
; %bb.64:                               ;   in Loop: Header=BB1_57 Depth=4
	ldr	x19, [sp, #160]                 ; 8-byte Folded Reload
	b	LBB1_66
LBB1_65:                                ;   in Loop: Header=BB1_66 Depth=5
	add	x19, x25, x19
	cmp	x21, x19
	b.ls	LBB1_56
LBB1_66:                                ;   Parent Loop BB1_11 Depth=1
                                        ;     Parent Loop BB1_14 Depth=2
                                        ;       Parent Loop BB1_55 Depth=3
                                        ;         Parent Loop BB1_57 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	sub	x8, x21, x19
	cmp	x8, x3
	csel	x25, x8, x3, lo
	b.lo	LBB1_65
; %bb.67:                               ;   in Loop: Header=BB1_66 Depth=5
	lsl	x8, x19, #2
	ldp	x9, x4, [x29, #-104]            ; 16-byte Folded Reload
	add	x1, x9, x8
	add	x2, x26, x8
	mov	x0, x28
	mov	x3, x5
	mov	x5, x27
	ldur	x8, [x29, #-112]                ; 8-byte Folded Reload
	blr	x8
	ldp	x6, x3, [x29, #-144]            ; 16-byte Folded Reload
	ldur	x4, [x29, #-96]                 ; 8-byte Folded Reload
	ldp	x5, x7, [x29, #-128]            ; 16-byte Folded Reload
	b	LBB1_65
LBB1_68:
	ldp	x29, x30, [sp, #320]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #304]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #288]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #272]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #256]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #240]            ; 16-byte Folded Reload
	add	sp, sp, #336
	ret
LBB1_69:
	mov	w0, #16
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp0:
Lloh18:
	adrp	x1, l_.str.1@PAGE
Lloh19:
	add	x1, x1, l_.str.1@PAGEOFF
	bl	__ZNSt16invalid_argumentC1B6v15006EPKc
Ltmp1:
; %bb.70:
Lloh20:
	adrp	x1, __ZTISt16invalid_argument@GOTPAGE
Lloh21:
	ldr	x1, [x1, __ZTISt16invalid_argument@GOTPAGEOFF]
Lloh22:
	adrp	x2, __ZNSt16invalid_argumentD1Ev@GOTPAGE
Lloh23:
	ldr	x2, [x2, __ZNSt16invalid_argumentD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
LBB1_71:
Ltmp2:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh18, Lloh19
	.loh AdrpLdrGot	Lloh22, Lloh23
	.loh AdrpLdrGot	Lloh20, Lloh21
Lfunc_end0:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table1:
Lexception0:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end0-Lcst_begin0
Lcst_begin0:
	.uleb128 Lfunc_begin0-Lfunc_begin0      ; >> Call Site 1 <<
	.uleb128 Ltmp0-Lfunc_begin0             ;   Call between Lfunc_begin0 and Ltmp0
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp0-Lfunc_begin0             ; >> Call Site 2 <<
	.uleb128 Ltmp1-Ltmp0                    ;   Call between Ltmp0 and Ltmp1
	.uleb128 Ltmp2-Lfunc_begin0             ;     jumps to Ltmp2
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp1-Lfunc_begin0             ; >> Call Site 3 <<
	.uleb128 Lfunc_end0-Ltmp1               ;   Call between Ltmp1 and Lfunc_end0
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end0:
	.p2align	2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__ZN4gemm8neon_4x4EPKfS1_PfmmmNS_9BlockSizeE ; -- Begin function _ZN4gemm8neon_4x4EPKfS1_PfmmmNS_9BlockSizeE
	.p2align	2
__ZN4gemm8neon_4x4EPKfS1_PfmmmNS_9BlockSizeE: ; @_ZN4gemm8neon_4x4EPKfS1_PfmmmNS_9BlockSizeE
Lfunc_begin1:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception1
; %bb.0:
	sub	sp, sp, #416
	.cfi_def_cfa_offset 416
	stp	x28, x27, [sp, #320]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #336]            ; 16-byte Folded Spill
	stp	x24, x23, [sp, #352]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #368]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #384]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #400]            ; 16-byte Folded Spill
	add	x29, sp, #400
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
	mov	x25, x6
	stp	x4, x5, [x29, #-104]            ; 16-byte Folded Spill
	str	x3, [sp, #8]                    ; 8-byte Folded Spill
	mov	x22, x2
	stur	x1, [x29, #-160]                ; 8-byte Folded Spill
	str	x0, [sp, #88]                   ; 8-byte Folded Spill
	bl	__ZN4gemm14neon_availableEv
	tbz	w0, #0, LBB2_173
; %bb.1:
	ldp	x8, x9, [x25]
	ldr	x10, [x25, #16]
	str	x8, [sp]                        ; 8-byte Folded Spill
	cmp	x8, #0
	str	x9, [sp, #32]                   ; 8-byte Folded Spill
	ccmp	x9, #0, #4, ne
	str	x10, [sp, #16]                  ; 8-byte Folded Spill
	ccmp	x10, #0, #4, ne
	b.eq	LBB2_175
; %bb.2:
	ldp	x4, x3, [x29, #-104]            ; 16-byte Folded Reload
	ldr	x19, [sp, #8]                   ; 8-byte Folded Reload
	cbz	x19, LBB2_172
; %bb.3:
	cbz	x4, LBB2_172
; %bb.4:
	mul	x8, x4, x19
	cbz	x8, LBB2_6
; %bb.5:
	lsl	x1, x8, #2
	mov	x0, x22
	bl	_bzero
	ldp	x4, x3, [x29, #-104]            ; 16-byte Folded Reload
LBB2_6:
	cbz	x3, LBB2_172
; %bb.7:
	mov	x10, #0
	lsl	x21, x4, #2
	ldur	x8, [x29, #-160]                ; 8-byte Folded Reload
	add	x9, x8, #4
	stur	x9, [x29, #-168]                ; 8-byte Folded Spill
	add	x9, x8, #8
	str	x9, [sp, #200]                  ; 8-byte Folded Spill
	add	x11, x8, #12
	ldr	x9, [sp, #88]                   ; 8-byte Folded Reload
	add	x9, x9, #32
	str	x9, [sp, #48]                   ; 8-byte Folded Spill
	lsl	x5, x3, #2
	add	x8, x8, #32
	stp	x11, x8, [sp, #128]             ; 16-byte Folded Spill
	lsl	x28, x4, #6
	mov	w6, #4
	stur	x5, [x29, #-120]                ; 8-byte Folded Spill
	b	LBB2_9
LBB2_8:                                 ;   in Loop: Header=BB2_9 Depth=1
	mov	x10, x11
	ldr	x19, [sp, #8]                   ; 8-byte Folded Reload
	cmp	x11, x19
	b.hs	LBB2_172
LBB2_9:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_12 Depth 2
                                        ;       Child Loop BB2_83 Depth 3
                                        ;         Child Loop BB2_85 Depth 4
                                        ;           Child Loop BB2_89 Depth 5
                                        ;           Child Loop BB2_94 Depth 5
                                        ;       Child Loop BB2_98 Depth 3
                                        ;         Child Loop BB2_100 Depth 4
                                        ;           Child Loop BB2_104 Depth 5
                                        ;             Child Loop BB2_118 Depth 6
                                        ;             Child Loop BB2_121 Depth 6
                                        ;             Child Loop BB2_124 Depth 6
                                        ;             Child Loop BB2_127 Depth 6
                                        ;             Child Loop BB2_131 Depth 6
                                        ;             Child Loop BB2_134 Depth 6
                                        ;             Child Loop BB2_137 Depth 6
                                        ;             Child Loop BB2_140 Depth 6
                                        ;             Child Loop BB2_144 Depth 6
                                        ;             Child Loop BB2_147 Depth 6
                                        ;             Child Loop BB2_150 Depth 6
                                        ;             Child Loop BB2_153 Depth 6
                                        ;             Child Loop BB2_157 Depth 6
                                        ;             Child Loop BB2_160 Depth 6
                                        ;             Child Loop BB2_163 Depth 6
                                        ;             Child Loop BB2_166 Depth 6
                                        ;             Child Loop BB2_110 Depth 6
                                        ;               Child Loop BB2_112 Depth 7
                                        ;                 Child Loop BB2_113 Depth 8
                                        ;                 Child Loop BB2_116 Depth 8
                                        ;           Child Loop BB2_170 Depth 5
                                        ;       Child Loop BB2_16 Depth 3
                                        ;         Child Loop BB2_18 Depth 4
                                        ;           Child Loop BB2_22 Depth 5
                                        ;             Child Loop BB2_26 Depth 6
                                        ;             Child Loop BB2_29 Depth 6
                                        ;             Child Loop BB2_32 Depth 6
                                        ;             Child Loop BB2_35 Depth 6
                                        ;             Child Loop BB2_39 Depth 6
                                        ;             Child Loop BB2_42 Depth 6
                                        ;             Child Loop BB2_45 Depth 6
                                        ;             Child Loop BB2_48 Depth 6
                                        ;             Child Loop BB2_52 Depth 6
                                        ;             Child Loop BB2_55 Depth 6
                                        ;             Child Loop BB2_58 Depth 6
                                        ;             Child Loop BB2_61 Depth 6
                                        ;             Child Loop BB2_65 Depth 6
                                        ;             Child Loop BB2_68 Depth 6
                                        ;             Child Loop BB2_71 Depth 6
                                        ;             Child Loop BB2_74 Depth 6
                                        ;           Child Loop BB2_79 Depth 5
	sub	x8, x19, x10
	ldr	x9, [sp]                        ; 8-byte Folded Reload
	cmp	x8, x9
	csel	x8, x8, x9, lo
	add	x11, x8, x10
	cmp	x11, x10
	b.ls	LBB2_8
; %bb.10:                               ;   in Loop: Header=BB2_9 Depth=1
	mov	x12, #0
	str	x10, [sp, #40]                  ; 8-byte Folded Spill
	str	x11, [sp, #184]                 ; 8-byte Folded Spill
	b	LBB2_12
LBB2_11:                                ;   in Loop: Header=BB2_12 Depth=2
	ldr	x8, [sp, #24]                   ; 8-byte Folded Reload
	mov	x12, x8
	cmp	x8, x3
	b.hs	LBB2_8
LBB2_12:                                ;   Parent Loop BB2_9 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_83 Depth 3
                                        ;         Child Loop BB2_85 Depth 4
                                        ;           Child Loop BB2_89 Depth 5
                                        ;           Child Loop BB2_94 Depth 5
                                        ;       Child Loop BB2_98 Depth 3
                                        ;         Child Loop BB2_100 Depth 4
                                        ;           Child Loop BB2_104 Depth 5
                                        ;             Child Loop BB2_118 Depth 6
                                        ;             Child Loop BB2_121 Depth 6
                                        ;             Child Loop BB2_124 Depth 6
                                        ;             Child Loop BB2_127 Depth 6
                                        ;             Child Loop BB2_131 Depth 6
                                        ;             Child Loop BB2_134 Depth 6
                                        ;             Child Loop BB2_137 Depth 6
                                        ;             Child Loop BB2_140 Depth 6
                                        ;             Child Loop BB2_144 Depth 6
                                        ;             Child Loop BB2_147 Depth 6
                                        ;             Child Loop BB2_150 Depth 6
                                        ;             Child Loop BB2_153 Depth 6
                                        ;             Child Loop BB2_157 Depth 6
                                        ;             Child Loop BB2_160 Depth 6
                                        ;             Child Loop BB2_163 Depth 6
                                        ;             Child Loop BB2_166 Depth 6
                                        ;             Child Loop BB2_110 Depth 6
                                        ;               Child Loop BB2_112 Depth 7
                                        ;                 Child Loop BB2_113 Depth 8
                                        ;                 Child Loop BB2_116 Depth 8
                                        ;           Child Loop BB2_170 Depth 5
                                        ;       Child Loop BB2_16 Depth 3
                                        ;         Child Loop BB2_18 Depth 4
                                        ;           Child Loop BB2_22 Depth 5
                                        ;             Child Loop BB2_26 Depth 6
                                        ;             Child Loop BB2_29 Depth 6
                                        ;             Child Loop BB2_32 Depth 6
                                        ;             Child Loop BB2_35 Depth 6
                                        ;             Child Loop BB2_39 Depth 6
                                        ;             Child Loop BB2_42 Depth 6
                                        ;             Child Loop BB2_45 Depth 6
                                        ;             Child Loop BB2_48 Depth 6
                                        ;             Child Loop BB2_52 Depth 6
                                        ;             Child Loop BB2_55 Depth 6
                                        ;             Child Loop BB2_58 Depth 6
                                        ;             Child Loop BB2_61 Depth 6
                                        ;             Child Loop BB2_65 Depth 6
                                        ;             Child Loop BB2_68 Depth 6
                                        ;             Child Loop BB2_71 Depth 6
                                        ;             Child Loop BB2_74 Depth 6
                                        ;           Child Loop BB2_79 Depth 5
	sub	x8, x3, x12
	ldr	x9, [sp, #16]                   ; 8-byte Folded Reload
	cmp	x8, x9
	csel	x25, x8, x9, lo
	mul	x8, x12, x4
	ldur	x9, [x29, #-160]                ; 8-byte Folded Reload
	add	x8, x9, x8, lsl #2
	stur	x8, [x29, #-112]                ; 8-byte Folded Spill
	ldr	x8, [sp, #88]                   ; 8-byte Folded Reload
	add	x8, x8, x12, lsl #2
	str	x8, [sp, #192]                  ; 8-byte Folded Spill
	add	x8, x25, x12
	cmp	x12, x8
	str	x8, [sp, #24]                   ; 8-byte Folded Spill
	b.hs	LBB2_81
; %bb.13:                               ;   in Loop: Header=BB2_12 Depth=2
	cmp	x25, #16
	str	x12, [sp, #80]                  ; 8-byte Folded Spill
	b.hs	LBB2_96
; %bb.14:                               ;   in Loop: Header=BB2_12 Depth=2
	mov	x13, #0
	mul	x8, x4, x12
	stur	x8, [x29, #-184]                ; 8-byte Folded Spill
	ldr	x8, [sp, #88]                   ; 8-byte Folded Reload
	add	x8, x8, x12, lsl #2
	str	x8, [sp, #120]                  ; 8-byte Folded Spill
	b	LBB2_16
LBB2_15:                                ;   in Loop: Header=BB2_16 Depth=3
	mov	x13, x24
	cmp	x24, x4
	ldr	x10, [sp, #40]                  ; 8-byte Folded Reload
	b.hs	LBB2_11
LBB2_16:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_18 Depth 4
                                        ;           Child Loop BB2_22 Depth 5
                                        ;             Child Loop BB2_26 Depth 6
                                        ;             Child Loop BB2_29 Depth 6
                                        ;             Child Loop BB2_32 Depth 6
                                        ;             Child Loop BB2_35 Depth 6
                                        ;             Child Loop BB2_39 Depth 6
                                        ;             Child Loop BB2_42 Depth 6
                                        ;             Child Loop BB2_45 Depth 6
                                        ;             Child Loop BB2_48 Depth 6
                                        ;             Child Loop BB2_52 Depth 6
                                        ;             Child Loop BB2_55 Depth 6
                                        ;             Child Loop BB2_58 Depth 6
                                        ;             Child Loop BB2_61 Depth 6
                                        ;             Child Loop BB2_65 Depth 6
                                        ;             Child Loop BB2_68 Depth 6
                                        ;             Child Loop BB2_71 Depth 6
                                        ;             Child Loop BB2_74 Depth 6
                                        ;           Child Loop BB2_79 Depth 5
	sub	x8, x4, x13
	ldr	x9, [sp, #32]                   ; 8-byte Folded Reload
	cmp	x8, x9
	csel	x8, x8, x9, lo
	add	x24, x8, x13
	str	x13, [sp, #144]                 ; 8-byte Folded Spill
	cmp	x24, x13
	mov	x12, x10
	b.hi	LBB2_18
	b	LBB2_15
LBB2_17:                                ;   in Loop: Header=BB2_18 Depth=4
	ldr	x12, [sp, #152]                 ; 8-byte Folded Reload
	ldur	x8, [x29, #-136]                ; 8-byte Folded Reload
	add	x12, x8, x12
	ldr	x11, [sp, #184]                 ; 8-byte Folded Reload
	cmp	x11, x12
	b.ls	LBB2_15
LBB2_18:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB2_22 Depth 5
                                        ;             Child Loop BB2_26 Depth 6
                                        ;             Child Loop BB2_29 Depth 6
                                        ;             Child Loop BB2_32 Depth 6
                                        ;             Child Loop BB2_35 Depth 6
                                        ;             Child Loop BB2_39 Depth 6
                                        ;             Child Loop BB2_42 Depth 6
                                        ;             Child Loop BB2_45 Depth 6
                                        ;             Child Loop BB2_48 Depth 6
                                        ;             Child Loop BB2_52 Depth 6
                                        ;             Child Loop BB2_55 Depth 6
                                        ;             Child Loop BB2_58 Depth 6
                                        ;             Child Loop BB2_61 Depth 6
                                        ;             Child Loop BB2_65 Depth 6
                                        ;             Child Loop BB2_68 Depth 6
                                        ;             Child Loop BB2_71 Depth 6
                                        ;             Child Loop BB2_74 Depth 6
                                        ;           Child Loop BB2_79 Depth 5
	sub	x19, x11, x12
	cmp	x19, #4
	csel	x10, x19, x6, lo
	mul	x8, x12, x3
	ldr	x9, [sp, #192]                  ; 8-byte Folded Reload
	add	x26, x9, x8, lsl #2
	mul	x27, x12, x4
	add	x8, x22, x27, lsl #2
	stp	x10, x8, [x29, #-136]           ; 16-byte Folded Spill
	str	x12, [sp, #152]                 ; 8-byte Folded Spill
	cbz	x10, LBB2_76
; %bb.19:                               ;   in Loop: Header=BB2_18 Depth=4
	add	x8, x12, #1
	mul	x9, x8, x4
	stur	x9, [x29, #-152]                ; 8-byte Folded Spill
	mul	x8, x8, x3
	add	x9, x12, #2
	mul	x10, x9, x4
	stur	x10, [x29, #-192]               ; 8-byte Folded Spill
	mul	x9, x9, x3
	add	x10, x12, #3
	mul	x11, x10, x4
	str	x11, [sp, #168]                 ; 8-byte Folded Spill
	ldr	x11, [sp, #80]                  ; 8-byte Folded Reload
	madd	x11, x12, x3, x11
	ldr	x12, [sp, #88]                  ; 8-byte Folded Reload
	add	x11, x12, x11, lsl #2
	stur	x11, [x29, #-144]               ; 8-byte Folded Spill
	ldr	x11, [sp, #120]                 ; 8-byte Folded Reload
	add	x8, x11, x8, lsl #2
	stur	x8, [x29, #-176]                ; 8-byte Folded Spill
	mul	x8, x10, x3
	add	x9, x11, x9, lsl #2
	str	x9, [sp, #176]                  ; 8-byte Folded Spill
	add	x8, x11, x8, lsl #2
	str	x8, [sp, #160]                  ; 8-byte Folded Spill
	ldr	x23, [sp, #144]                 ; 8-byte Folded Reload
	b	LBB2_22
LBB2_20:                                ;   in Loop: Header=BB2_22 Depth=5
	lsl	x8, x23, #2
	ldp	x9, x4, [x29, #-112]            ; 16-byte Folded Reload
	add	x1, x9, x8
	ldur	x9, [x29, #-128]                ; 8-byte Folded Reload
	add	x2, x9, x8
	mov	x0, x26
	ldur	x3, [x29, #-96]                 ; 8-byte Folded Reload
	mov	x5, x25
	bl	__ZN4gemm6detail13tile_4x4_neonEPKfS2_Pfmmm
	mov	w6, #4
	ldur	x5, [x29, #-120]                ; 8-byte Folded Reload
	ldp	x4, x3, [x29, #-104]            ; 16-byte Folded Reload
LBB2_21:                                ;   in Loop: Header=BB2_22 Depth=5
	add	x23, x20, x23
	cmp	x24, x23
	b.ls	LBB2_17
LBB2_22:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ; =>        This Loop Header: Depth=5
                                        ;             Child Loop BB2_26 Depth 6
                                        ;             Child Loop BB2_29 Depth 6
                                        ;             Child Loop BB2_32 Depth 6
                                        ;             Child Loop BB2_35 Depth 6
                                        ;             Child Loop BB2_39 Depth 6
                                        ;             Child Loop BB2_42 Depth 6
                                        ;             Child Loop BB2_45 Depth 6
                                        ;             Child Loop BB2_48 Depth 6
                                        ;             Child Loop BB2_52 Depth 6
                                        ;             Child Loop BB2_55 Depth 6
                                        ;             Child Loop BB2_58 Depth 6
                                        ;             Child Loop BB2_61 Depth 6
                                        ;             Child Loop BB2_65 Depth 6
                                        ;             Child Loop BB2_68 Depth 6
                                        ;             Child Loop BB2_71 Depth 6
                                        ;             Child Loop BB2_74 Depth 6
	sub	x8, x24, x23
	cmp	x8, #4
	csel	x20, x8, x6, lo
	cmp	x19, #4
	b.lo	LBB2_24
; %bb.23:                               ;   in Loop: Header=BB2_22 Depth=5
	cmp	x8, #3
	b.hi	LBB2_20
LBB2_24:                                ;   in Loop: Header=BB2_22 Depth=5
	cbz	x20, LBB2_21
; %bb.25:                               ;   in Loop: Header=BB2_22 Depth=5
	add	x10, x23, x27
	ldr	s0, [x22, x10, lsl #2]
	ldur	x8, [x29, #-184]                ; 8-byte Folded Reload
	add	x8, x8, x23
	ldur	x9, [x29, #-160]                ; 8-byte Folded Reload
	add	x9, x9, x8, lsl #2
	ldur	x11, [x29, #-144]               ; 8-byte Folded Reload
	mov	x12, x9
	mov	x13, x25
LBB2_26:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x11], #4
	ldr	s2, [x12]
	fmadd	s0, s1, s2, s0
	add	x12, x12, x21
	subs	x13, x13, #1
	b.ne	LBB2_26
; %bb.27:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x20, #1
	b.eq	LBB2_37
; %bb.28:                               ;   in Loop: Header=BB2_22 Depth=5
	add	x10, x23, x27
	add	x10, x10, #1
	ldr	s0, [x22, x10, lsl #2]
	ldur	x11, [x29, #-168]               ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	ldur	x12, [x29, #-144]               ; 8-byte Folded Reload
	mov	x13, x25
LBB2_29:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_29
; %bb.30:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x20, #2
	b.eq	LBB2_37
; %bb.31:                               ;   in Loop: Header=BB2_22 Depth=5
	add	x10, x23, x27
	add	x10, x10, #2
	ldr	s0, [x22, x10, lsl #2]
	ldr	x11, [sp, #200]                 ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	ldur	x12, [x29, #-144]               ; 8-byte Folded Reload
	mov	x13, x25
LBB2_32:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_32
; %bb.33:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x20, #3
	b.eq	LBB2_37
; %bb.34:                               ;   in Loop: Header=BB2_22 Depth=5
	add	x10, x23, x27
	add	x10, x10, #3
	ldr	s0, [x22, x10, lsl #2]
	ldr	x11, [sp, #128]                 ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	ldur	x12, [x29, #-144]               ; 8-byte Folded Reload
	mov	x13, x25
LBB2_35:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_35
; %bb.36:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x10, lsl #2]
LBB2_37:                                ;   in Loop: Header=BB2_22 Depth=5
	ldur	x10, [x29, #-136]               ; 8-byte Folded Reload
	cmp	x10, #1
	b.eq	LBB2_21
; %bb.38:                               ;   in Loop: Header=BB2_22 Depth=5
	ldur	x10, [x29, #-152]               ; 8-byte Folded Reload
	add	x10, x23, x10
	ldr	s0, [x22, x10, lsl #2]
	ldur	x11, [x29, #-176]               ; 8-byte Folded Reload
	mov	x12, x9
	mov	x13, x25
LBB2_39:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x11], #4
	ldr	s2, [x12]
	fmadd	s0, s1, s2, s0
	add	x12, x12, x21
	subs	x13, x13, #1
	b.ne	LBB2_39
; %bb.40:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x20, #1
	b.eq	LBB2_50
; %bb.41:                               ;   in Loop: Header=BB2_22 Depth=5
	ldur	x10, [x29, #-152]               ; 8-byte Folded Reload
	add	x10, x23, x10
	add	x10, x10, #1
	ldr	s0, [x22, x10, lsl #2]
	ldp	x12, x11, [x29, #-176]          ; 16-byte Folded Reload
	add	x11, x11, x8, lsl #2
	mov	x13, x25
LBB2_42:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_42
; %bb.43:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x20, #2
	b.eq	LBB2_50
; %bb.44:                               ;   in Loop: Header=BB2_22 Depth=5
	ldur	x10, [x29, #-152]               ; 8-byte Folded Reload
	add	x10, x23, x10
	add	x10, x10, #2
	ldr	s0, [x22, x10, lsl #2]
	ldr	x11, [sp, #200]                 ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	ldur	x12, [x29, #-176]               ; 8-byte Folded Reload
	mov	x13, x25
LBB2_45:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_45
; %bb.46:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x20, #3
	b.eq	LBB2_50
; %bb.47:                               ;   in Loop: Header=BB2_22 Depth=5
	ldur	x10, [x29, #-152]               ; 8-byte Folded Reload
	add	x10, x23, x10
	add	x10, x10, #3
	ldr	s0, [x22, x10, lsl #2]
	ldr	x11, [sp, #128]                 ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	ldur	x12, [x29, #-176]               ; 8-byte Folded Reload
	mov	x13, x25
LBB2_48:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_48
; %bb.49:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x10, lsl #2]
LBB2_50:                                ;   in Loop: Header=BB2_22 Depth=5
	ldur	x10, [x29, #-136]               ; 8-byte Folded Reload
	cmp	x10, #2
	b.eq	LBB2_21
; %bb.51:                               ;   in Loop: Header=BB2_22 Depth=5
	ldur	x10, [x29, #-192]               ; 8-byte Folded Reload
	add	x10, x23, x10
	ldr	s0, [x22, x10, lsl #2]
	ldr	x11, [sp, #176]                 ; 8-byte Folded Reload
	mov	x12, x9
	mov	x13, x25
LBB2_52:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x11], #4
	ldr	s2, [x12]
	fmadd	s0, s1, s2, s0
	add	x12, x12, x21
	subs	x13, x13, #1
	b.ne	LBB2_52
; %bb.53:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x20, #1
	b.eq	LBB2_63
; %bb.54:                               ;   in Loop: Header=BB2_22 Depth=5
	ldur	x10, [x29, #-192]               ; 8-byte Folded Reload
	add	x10, x23, x10
	add	x10, x10, #1
	ldr	s0, [x22, x10, lsl #2]
	ldur	x11, [x29, #-168]               ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	ldr	x12, [sp, #176]                 ; 8-byte Folded Reload
	mov	x13, x25
LBB2_55:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_55
; %bb.56:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x20, #2
	b.eq	LBB2_63
; %bb.57:                               ;   in Loop: Header=BB2_22 Depth=5
	ldur	x10, [x29, #-192]               ; 8-byte Folded Reload
	add	x10, x23, x10
	add	x10, x10, #2
	ldr	s0, [x22, x10, lsl #2]
	ldr	x11, [sp, #200]                 ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	ldr	x12, [sp, #176]                 ; 8-byte Folded Reload
	mov	x13, x25
LBB2_58:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_58
; %bb.59:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x20, #3
	b.eq	LBB2_63
; %bb.60:                               ;   in Loop: Header=BB2_22 Depth=5
	ldur	x10, [x29, #-192]               ; 8-byte Folded Reload
	add	x10, x23, x10
	add	x10, x10, #3
	ldr	s0, [x22, x10, lsl #2]
	ldr	x11, [sp, #128]                 ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	ldr	x12, [sp, #176]                 ; 8-byte Folded Reload
	mov	x13, x25
LBB2_61:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_61
; %bb.62:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x10, lsl #2]
LBB2_63:                                ;   in Loop: Header=BB2_22 Depth=5
	ldur	x10, [x29, #-136]               ; 8-byte Folded Reload
	cmp	x10, #3
	b.eq	LBB2_21
; %bb.64:                               ;   in Loop: Header=BB2_22 Depth=5
	ldp	x11, x10, [sp, #160]            ; 16-byte Folded Reload
	add	x10, x23, x10
	ldr	s0, [x22, x10, lsl #2]
	mov	x12, x25
LBB2_65:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x11], #4
	ldr	s2, [x9]
	fmadd	s0, s1, s2, s0
	add	x9, x9, x21
	subs	x12, x12, #1
	b.ne	LBB2_65
; %bb.66:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x20, #1
	b.eq	LBB2_21
; %bb.67:                               ;   in Loop: Header=BB2_22 Depth=5
	ldp	x11, x9, [sp, #160]             ; 16-byte Folded Reload
	add	x9, x23, x9
	add	x9, x9, #1
	ldr	s0, [x22, x9, lsl #2]
	ldur	x10, [x29, #-168]               ; 8-byte Folded Reload
	add	x10, x10, x8, lsl #2
	mov	x12, x25
LBB2_68:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x11], #4
	ldr	s2, [x10]
	fmadd	s0, s1, s2, s0
	add	x10, x10, x21
	subs	x12, x12, #1
	b.ne	LBB2_68
; %bb.69:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x9, lsl #2]
	cmp	x20, #2
	b.eq	LBB2_21
; %bb.70:                               ;   in Loop: Header=BB2_22 Depth=5
	ldp	x11, x9, [sp, #160]             ; 16-byte Folded Reload
	add	x9, x23, x9
	add	x9, x9, #2
	ldr	s0, [x22, x9, lsl #2]
	ldr	x10, [sp, #200]                 ; 8-byte Folded Reload
	add	x10, x10, x8, lsl #2
	mov	x12, x25
LBB2_71:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x11], #4
	ldr	s2, [x10]
	fmadd	s0, s1, s2, s0
	add	x10, x10, x21
	subs	x12, x12, #1
	b.ne	LBB2_71
; %bb.72:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x9, lsl #2]
	cmp	x20, #3
	b.eq	LBB2_21
; %bb.73:                               ;   in Loop: Header=BB2_22 Depth=5
	ldr	x9, [sp, #168]                  ; 8-byte Folded Reload
	add	x9, x23, x9
	add	x9, x9, #3
	ldr	s0, [x22, x9, lsl #2]
	ldr	x10, [sp, #128]                 ; 8-byte Folded Reload
	add	x8, x10, x8, lsl #2
	ldr	x10, [sp, #160]                 ; 8-byte Folded Reload
	mov	x11, x25
LBB2_74:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ;           Parent Loop BB2_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x10], #4
	ldr	s2, [x8]
	fmadd	s0, s1, s2, s0
	add	x8, x8, x21
	subs	x11, x11, #1
	b.ne	LBB2_74
; %bb.75:                               ;   in Loop: Header=BB2_22 Depth=5
	str	s0, [x22, x9, lsl #2]
	b	LBB2_21
LBB2_76:                                ;   in Loop: Header=BB2_18 Depth=4
	cmp	x19, #4
	b.lo	LBB2_17
; %bb.77:                               ;   in Loop: Header=BB2_18 Depth=4
	ldr	x19, [sp, #144]                 ; 8-byte Folded Reload
	b	LBB2_79
LBB2_78:                                ;   in Loop: Header=BB2_79 Depth=5
	add	x19, x20, x19
	cmp	x24, x19
	b.ls	LBB2_17
LBB2_79:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_16 Depth=3
                                        ;         Parent Loop BB2_18 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	sub	x8, x24, x19
	cmp	x8, #4
	csel	x20, x8, x6, lo
	b.lo	LBB2_78
; %bb.80:                               ;   in Loop: Header=BB2_79 Depth=5
	lsl	x8, x19, #2
	ldp	x9, x4, [x29, #-112]            ; 16-byte Folded Reload
	add	x1, x9, x8
	ldur	x9, [x29, #-128]                ; 8-byte Folded Reload
	add	x2, x9, x8
	mov	x0, x26
	ldur	x3, [x29, #-96]                 ; 8-byte Folded Reload
	mov	x5, x25
	bl	__ZN4gemm6detail13tile_4x4_neonEPKfS2_Pfmmm
	mov	w6, #4
	ldur	x5, [x29, #-120]                ; 8-byte Folded Reload
	ldp	x4, x3, [x29, #-104]            ; 16-byte Folded Reload
	b	LBB2_78
LBB2_81:                                ;   in Loop: Header=BB2_12 Depth=2
	mov	x12, #0
	b	LBB2_83
LBB2_82:                                ;   in Loop: Header=BB2_83 Depth=3
	mov	x12, x20
	cmp	x20, x4
	ldr	x10, [sp, #40]                  ; 8-byte Folded Reload
	b.hs	LBB2_11
LBB2_83:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_85 Depth 4
                                        ;           Child Loop BB2_89 Depth 5
                                        ;           Child Loop BB2_94 Depth 5
	sub	x8, x4, x12
	ldr	x9, [sp, #32]                   ; 8-byte Folded Reload
	cmp	x8, x9
	csel	x8, x8, x9, lo
	add	x20, x8, x12
	stur	x12, [x29, #-136]               ; 8-byte Folded Spill
	cmp	x20, x12
	mov	x23, x10
	b.hi	LBB2_85
	b	LBB2_82
LBB2_84:                                ;   in Loop: Header=BB2_85 Depth=4
	ldur	x8, [x29, #-128]                ; 8-byte Folded Reload
	add	x23, x8, x23
	ldr	x11, [sp, #184]                 ; 8-byte Folded Reload
	cmp	x11, x23
	b.ls	LBB2_82
LBB2_85:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_83 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB2_89 Depth 5
                                        ;           Child Loop BB2_94 Depth 5
	sub	x8, x11, x23
	cmp	x8, #4
	csel	x11, x8, x6, lo
	mul	x9, x23, x3
	ldr	x10, [sp, #192]                 ; 8-byte Folded Reload
	add	x26, x10, x9, lsl #2
	mul	x9, x23, x4
	add	x27, x22, x9, lsl #2
	stur	x11, [x29, #-128]               ; 8-byte Folded Spill
	cmp	x8, #4
	cbz	x11, LBB2_91
; %bb.86:                               ;   in Loop: Header=BB2_85 Depth=4
	b.lo	LBB2_84
; %bb.87:                               ;   in Loop: Header=BB2_85 Depth=4
	ldur	x19, [x29, #-136]               ; 8-byte Folded Reload
	b	LBB2_89
LBB2_88:                                ;   in Loop: Header=BB2_89 Depth=5
	add	x19, x24, x19
	cmp	x20, x19
	b.ls	LBB2_84
LBB2_89:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_83 Depth=3
                                        ;         Parent Loop BB2_85 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	sub	x8, x20, x19
	cmp	x8, #4
	csel	x24, x8, x6, lo
	b.lo	LBB2_88
; %bb.90:                               ;   in Loop: Header=BB2_89 Depth=5
	lsl	x8, x19, #2
	ldp	x9, x4, [x29, #-112]            ; 16-byte Folded Reload
	add	x1, x9, x8
	add	x2, x27, x8
	mov	x0, x26
	ldur	x3, [x29, #-96]                 ; 8-byte Folded Reload
	mov	x5, x25
	bl	__ZN4gemm6detail13tile_4x4_neonEPKfS2_Pfmmm
	mov	w6, #4
	ldur	x5, [x29, #-120]                ; 8-byte Folded Reload
	ldp	x4, x3, [x29, #-104]            ; 16-byte Folded Reload
	b	LBB2_88
LBB2_91:                                ;   in Loop: Header=BB2_85 Depth=4
	b.lo	LBB2_84
; %bb.92:                               ;   in Loop: Header=BB2_85 Depth=4
	ldur	x19, [x29, #-136]               ; 8-byte Folded Reload
	b	LBB2_94
LBB2_93:                                ;   in Loop: Header=BB2_94 Depth=5
	add	x19, x24, x19
	cmp	x20, x19
	b.ls	LBB2_84
LBB2_94:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_83 Depth=3
                                        ;         Parent Loop BB2_85 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	sub	x8, x20, x19
	cmp	x8, #4
	csel	x24, x8, x6, lo
	b.lo	LBB2_93
; %bb.95:                               ;   in Loop: Header=BB2_94 Depth=5
	lsl	x8, x19, #2
	ldp	x9, x4, [x29, #-112]            ; 16-byte Folded Reload
	add	x1, x9, x8
	add	x2, x27, x8
	mov	x0, x26
	ldur	x3, [x29, #-96]                 ; 8-byte Folded Reload
	mov	x5, x25
	bl	__ZN4gemm6detail13tile_4x4_neonEPKfS2_Pfmmm
	mov	w6, #4
	ldur	x5, [x29, #-120]                ; 8-byte Folded Reload
	ldp	x4, x3, [x29, #-104]            ; 16-byte Folded Reload
	b	LBB2_93
LBB2_96:                                ;   in Loop: Header=BB2_12 Depth=2
	mov	x20, #0
	and	x26, x25, #0xfffffffffffffff0
	add	x9, x12, x26
	mul	x8, x4, x12
	stur	x8, [x29, #-192]                ; 8-byte Folded Spill
	ldr	x8, [sp, #88]                   ; 8-byte Folded Reload
	add	x8, x8, x12, lsl #2
	stp	x8, x9, [sp, #56]               ; 16-byte Folded Spill
	sub	x23, x25, x26
	mul	x8, x4, x9
	ldur	x9, [x29, #-160]                ; 8-byte Folded Reload
	add	x8, x9, x8, lsl #2
	str	x8, [sp, #144]                  ; 8-byte Folded Spill
	b	LBB2_98
LBB2_97:                                ;   in Loop: Header=BB2_98 Depth=3
	mov	x20, x7
	cmp	x7, x4
	ldr	x10, [sp, #40]                  ; 8-byte Folded Reload
	b.hs	LBB2_11
LBB2_98:                                ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_100 Depth 4
                                        ;           Child Loop BB2_104 Depth 5
                                        ;             Child Loop BB2_118 Depth 6
                                        ;             Child Loop BB2_121 Depth 6
                                        ;             Child Loop BB2_124 Depth 6
                                        ;             Child Loop BB2_127 Depth 6
                                        ;             Child Loop BB2_131 Depth 6
                                        ;             Child Loop BB2_134 Depth 6
                                        ;             Child Loop BB2_137 Depth 6
                                        ;             Child Loop BB2_140 Depth 6
                                        ;             Child Loop BB2_144 Depth 6
                                        ;             Child Loop BB2_147 Depth 6
                                        ;             Child Loop BB2_150 Depth 6
                                        ;             Child Loop BB2_153 Depth 6
                                        ;             Child Loop BB2_157 Depth 6
                                        ;             Child Loop BB2_160 Depth 6
                                        ;             Child Loop BB2_163 Depth 6
                                        ;             Child Loop BB2_166 Depth 6
                                        ;             Child Loop BB2_110 Depth 6
                                        ;               Child Loop BB2_112 Depth 7
                                        ;                 Child Loop BB2_113 Depth 8
                                        ;                 Child Loop BB2_116 Depth 8
                                        ;           Child Loop BB2_170 Depth 5
	sub	x8, x4, x20
	ldr	x9, [sp, #32]                   ; 8-byte Folded Reload
	cmp	x8, x9
	csel	x8, x8, x9, lo
	add	x7, x8, x20
	cmp	x7, x20
	mov	x19, x10
	str	x20, [sp, #72]                  ; 8-byte Folded Spill
	stur	x7, [x29, #-144]                ; 8-byte Folded Spill
	b.hi	LBB2_100
	b	LBB2_97
LBB2_99:                                ;   in Loop: Header=BB2_100 Depth=4
	add	x19, x27, x19
	ldr	x11, [sp, #184]                 ; 8-byte Folded Reload
	cmp	x11, x19
	ldr	x20, [sp, #72]                  ; 8-byte Folded Reload
	b.ls	LBB2_97
LBB2_100:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB2_104 Depth 5
                                        ;             Child Loop BB2_118 Depth 6
                                        ;             Child Loop BB2_121 Depth 6
                                        ;             Child Loop BB2_124 Depth 6
                                        ;             Child Loop BB2_127 Depth 6
                                        ;             Child Loop BB2_131 Depth 6
                                        ;             Child Loop BB2_134 Depth 6
                                        ;             Child Loop BB2_137 Depth 6
                                        ;             Child Loop BB2_140 Depth 6
                                        ;             Child Loop BB2_144 Depth 6
                                        ;             Child Loop BB2_147 Depth 6
                                        ;             Child Loop BB2_150 Depth 6
                                        ;             Child Loop BB2_153 Depth 6
                                        ;             Child Loop BB2_157 Depth 6
                                        ;             Child Loop BB2_160 Depth 6
                                        ;             Child Loop BB2_163 Depth 6
                                        ;             Child Loop BB2_166 Depth 6
                                        ;             Child Loop BB2_110 Depth 6
                                        ;               Child Loop BB2_112 Depth 7
                                        ;                 Child Loop BB2_113 Depth 8
                                        ;                 Child Loop BB2_116 Depth 8
                                        ;           Child Loop BB2_170 Depth 5
	sub	x30, x11, x19
	cmp	x30, #4
	csel	x27, x30, x6, lo
	mul	x8, x19, x3
	ldr	x9, [sp, #192]                  ; 8-byte Folded Reload
	add	x10, x9, x8, lsl #2
	mul	x9, x19, x4
	stur	x9, [x29, #-176]                ; 8-byte Folded Spill
	add	x9, x22, x9, lsl #2
	stp	x9, x10, [x29, #-136]           ; 16-byte Folded Spill
	cbz	x27, LBB2_168
; %bb.101:                              ;   in Loop: Header=BB2_100 Depth=4
	add	x9, x19, #1
	mul	x10, x9, x4
	str	x10, [sp, #160]                 ; 8-byte Folded Spill
	mul	x9, x9, x3
	add	x10, x19, #2
	mul	x11, x10, x4
	str	x11, [sp, #120]                 ; 8-byte Folded Spill
	mul	x10, x10, x3
	add	x11, x19, #3
	mul	x12, x11, x4
	str	x12, [sp, #104]                 ; 8-byte Folded Spill
	ldr	x12, [sp, #80]                  ; 8-byte Folded Reload
	add	x12, x12, x8
	lsl	x12, x12, #2
	ldr	x13, [sp, #56]                  ; 8-byte Folded Reload
	add	x9, x13, x9, lsl #2
	str	x9, [sp, #152]                  ; 8-byte Folded Spill
	mul	x9, x11, x3
	ldr	x11, [sp, #88]                  ; 8-byte Folded Reload
	add	x14, x11, x12
	stur	x14, [x29, #-184]               ; 8-byte Folded Spill
	add	x10, x13, x10, lsl #2
	str	x10, [sp, #112]                 ; 8-byte Folded Spill
	add	x9, x13, x9, lsl #2
	str	x9, [sp, #96]                   ; 8-byte Folded Spill
	ldr	x9, [sp, #48]                   ; 8-byte Folded Reload
	add	x9, x9, x12
	str	x9, [sp, #176]                  ; 8-byte Folded Spill
	ldr	x9, [sp, #64]                   ; 8-byte Folded Reload
	add	x8, x9, x8
	add	x8, x11, x8, lsl #2
	str	x8, [sp, #168]                  ; 8-byte Folded Spill
	stur	x19, [x29, #-152]               ; 8-byte Folded Spill
	b	LBB2_104
LBB2_102:                               ;   in Loop: Header=BB2_104 Depth=5
	lsl	x8, x20, #2
	ldp	x9, x4, [x29, #-112]            ; 16-byte Folded Reload
	add	x1, x9, x8
	ldp	x9, x0, [x29, #-136]            ; 16-byte Folded Reload
	add	x2, x9, x8
	ldur	x3, [x29, #-96]                 ; 8-byte Folded Reload
	mov	x5, x25
	mov	x19, x27
	mov	x27, x30
	bl	__ZN4gemm6detail13tile_4x4_neonEPKfS2_Pfmmm
	mov	x30, x27
	mov	x27, x19
	ldp	x19, x7, [x29, #-152]           ; 16-byte Folded Reload
	mov	w6, #4
	ldur	x5, [x29, #-120]                ; 8-byte Folded Reload
	ldp	x4, x3, [x29, #-104]            ; 16-byte Folded Reload
LBB2_103:                               ;   in Loop: Header=BB2_104 Depth=5
	add	x20, x24, x20
	cmp	x7, x20
	b.ls	LBB2_99
LBB2_104:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ; =>        This Loop Header: Depth=5
                                        ;             Child Loop BB2_118 Depth 6
                                        ;             Child Loop BB2_121 Depth 6
                                        ;             Child Loop BB2_124 Depth 6
                                        ;             Child Loop BB2_127 Depth 6
                                        ;             Child Loop BB2_131 Depth 6
                                        ;             Child Loop BB2_134 Depth 6
                                        ;             Child Loop BB2_137 Depth 6
                                        ;             Child Loop BB2_140 Depth 6
                                        ;             Child Loop BB2_144 Depth 6
                                        ;             Child Loop BB2_147 Depth 6
                                        ;             Child Loop BB2_150 Depth 6
                                        ;             Child Loop BB2_153 Depth 6
                                        ;             Child Loop BB2_157 Depth 6
                                        ;             Child Loop BB2_160 Depth 6
                                        ;             Child Loop BB2_163 Depth 6
                                        ;             Child Loop BB2_166 Depth 6
                                        ;             Child Loop BB2_110 Depth 6
                                        ;               Child Loop BB2_112 Depth 7
                                        ;                 Child Loop BB2_113 Depth 8
                                        ;                 Child Loop BB2_116 Depth 8
	sub	x8, x7, x20
	cmp	x8, #4
	csel	x24, x8, x6, lo
	cmp	x30, #4
	b.lo	LBB2_106
; %bb.105:                              ;   in Loop: Header=BB2_104 Depth=5
	cmp	x8, #4
	b.hs	LBB2_102
LBB2_106:                               ;   in Loop: Header=BB2_104 Depth=5
	cbz	x24, LBB2_103
; %bb.107:                              ;   in Loop: Header=BB2_104 Depth=5
	cmp	x4, #1
	b.ne	LBB2_117
; %bb.108:                              ;   in Loop: Header=BB2_104 Depth=5
	mov	x8, #0
	ldur	x9, [x29, #-192]                ; 8-byte Folded Reload
	add	x9, x9, x20
	ldr	x10, [sp, #136]                 ; 8-byte Folded Reload
	add	x9, x10, x9, lsl #2
	ldr	x10, [sp, #144]                 ; 8-byte Folded Reload
	add	x10, x10, x20, lsl #2
	ldp	x11, x12, [sp, #168]            ; 16-byte Folded Reload
	b	LBB2_110
LBB2_109:                               ;   in Loop: Header=BB2_110 Depth=6
	add	x8, x8, #1
	add	x12, x12, x5
	add	x11, x11, x5
	cmp	x8, x27
	b.eq	LBB2_103
LBB2_110:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Loop Header: Depth=6
                                        ;               Child Loop BB2_112 Depth 7
                                        ;                 Child Loop BB2_113 Depth 8
                                        ;                 Child Loop BB2_116 Depth 8
	mov	x13, #0
	add	x14, x8, x19
	mul	x14, x14, x4
	mov	x15, x10
	mov	x16, x9
	b	LBB2_112
LBB2_111:                               ;   in Loop: Header=BB2_112 Depth=7
	str	s0, [x22, x17, lsl #2]
	add	x13, x13, #1
	add	x16, x16, #4
	add	x15, x15, #4
	cmp	x13, x24
	b.eq	LBB2_109
LBB2_112:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ;             Parent Loop BB2_110 Depth=6
                                        ; =>            This Loop Header: Depth=7
                                        ;                 Child Loop BB2_113 Depth 8
                                        ;                 Child Loop BB2_116 Depth 8
	add	x17, x13, x20
	add	x17, x17, x14
	ldr	s0, [x22, x17, lsl #2]
	mov	x0, x16
	mov	x1, x12
	mov	x2, x26
LBB2_113:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ;             Parent Loop BB2_110 Depth=6
                                        ;               Parent Loop BB2_112 Depth=7
                                        ; =>              This Inner Loop Header: Depth=8
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
	add	x0, x0, x28
	subs	x2, x2, #16
	b.ne	LBB2_113
; %bb.114:                              ;   in Loop: Header=BB2_112 Depth=7
	cmp	x25, x26
	b.eq	LBB2_111
; %bb.115:                              ;   in Loop: Header=BB2_112 Depth=7
	mov	x0, x11
	mov	x1, x15
	mov	x2, x23
LBB2_116:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ;             Parent Loop BB2_110 Depth=6
                                        ;               Parent Loop BB2_112 Depth=7
                                        ; =>              This Inner Loop Header: Depth=8
	ldr	s1, [x0], #4
	ldr	s2, [x1]
	fmadd	s0, s1, s2, s0
	add	x1, x1, x21
	subs	x2, x2, #1
	b.ne	LBB2_116
	b	LBB2_111
LBB2_117:                               ;   in Loop: Header=BB2_104 Depth=5
	ldp	x11, x8, [x29, #-184]           ; 16-byte Folded Reload
	add	x10, x20, x8
	ldr	s0, [x22, x10, lsl #2]
	ldur	x8, [x29, #-192]                ; 8-byte Folded Reload
	add	x8, x8, x20
	ldur	x9, [x29, #-160]                ; 8-byte Folded Reload
	add	x9, x9, x8, lsl #2
	mov	x12, x9
	mov	x13, x25
LBB2_118:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x11], #4
	ldr	s2, [x12]
	fmadd	s0, s1, s2, s0
	add	x12, x12, x21
	subs	x13, x13, #1
	b.ne	LBB2_118
; %bb.119:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x24, #1
	b.eq	LBB2_129
; %bb.120:                              ;   in Loop: Header=BB2_104 Depth=5
	ldp	x10, x11, [x29, #-176]          ; 16-byte Folded Reload
	add	x10, x20, x10
	add	x10, x10, #1
	ldr	s0, [x22, x10, lsl #2]
	add	x11, x11, x8, lsl #2
	ldur	x12, [x29, #-184]               ; 8-byte Folded Reload
	mov	x13, x25
LBB2_121:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_121
; %bb.122:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x24, #2
	b.eq	LBB2_129
; %bb.123:                              ;   in Loop: Header=BB2_104 Depth=5
	ldp	x12, x10, [x29, #-184]          ; 16-byte Folded Reload
	add	x10, x20, x10
	add	x10, x10, #2
	ldr	s0, [x22, x10, lsl #2]
	ldr	x11, [sp, #200]                 ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	mov	x13, x25
LBB2_124:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_124
; %bb.125:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x24, #3
	b.eq	LBB2_129
; %bb.126:                              ;   in Loop: Header=BB2_104 Depth=5
	ldp	x12, x10, [x29, #-184]          ; 16-byte Folded Reload
	add	x10, x20, x10
	add	x10, x10, #3
	ldr	s0, [x22, x10, lsl #2]
	ldr	x11, [sp, #128]                 ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	mov	x13, x25
LBB2_127:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_127
; %bb.128:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x10, lsl #2]
LBB2_129:                               ;   in Loop: Header=BB2_104 Depth=5
	cmp	x27, #1
	b.eq	LBB2_103
; %bb.130:                              ;   in Loop: Header=BB2_104 Depth=5
	ldp	x11, x10, [sp, #152]            ; 16-byte Folded Reload
	add	x10, x20, x10
	ldr	s0, [x22, x10, lsl #2]
	mov	x12, x9
	mov	x13, x25
LBB2_131:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x11], #4
	ldr	s2, [x12]
	fmadd	s0, s1, s2, s0
	add	x12, x12, x21
	subs	x13, x13, #1
	b.ne	LBB2_131
; %bb.132:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x24, #1
	b.eq	LBB2_142
; %bb.133:                              ;   in Loop: Header=BB2_104 Depth=5
	ldp	x12, x10, [sp, #152]            ; 16-byte Folded Reload
	add	x10, x20, x10
	add	x10, x10, #1
	ldr	s0, [x22, x10, lsl #2]
	ldur	x11, [x29, #-168]               ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	mov	x13, x25
LBB2_134:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_134
; %bb.135:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x24, #2
	b.eq	LBB2_142
; %bb.136:                              ;   in Loop: Header=BB2_104 Depth=5
	ldp	x12, x10, [sp, #152]            ; 16-byte Folded Reload
	add	x10, x20, x10
	add	x10, x10, #2
	ldr	s0, [x22, x10, lsl #2]
	ldr	x11, [sp, #200]                 ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	mov	x13, x25
LBB2_137:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_137
; %bb.138:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x24, #3
	b.eq	LBB2_142
; %bb.139:                              ;   in Loop: Header=BB2_104 Depth=5
	ldp	x12, x10, [sp, #152]            ; 16-byte Folded Reload
	add	x10, x20, x10
	add	x10, x10, #3
	ldr	s0, [x22, x10, lsl #2]
	ldr	x11, [sp, #128]                 ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	mov	x13, x25
LBB2_140:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_140
; %bb.141:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x10, lsl #2]
LBB2_142:                               ;   in Loop: Header=BB2_104 Depth=5
	cmp	x27, #2
	b.eq	LBB2_103
; %bb.143:                              ;   in Loop: Header=BB2_104 Depth=5
	ldp	x11, x10, [sp, #112]            ; 16-byte Folded Reload
	add	x10, x20, x10
	ldr	s0, [x22, x10, lsl #2]
	mov	x12, x9
	mov	x13, x25
LBB2_144:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x11], #4
	ldr	s2, [x12]
	fmadd	s0, s1, s2, s0
	add	x12, x12, x21
	subs	x13, x13, #1
	b.ne	LBB2_144
; %bb.145:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x24, #1
	b.eq	LBB2_155
; %bb.146:                              ;   in Loop: Header=BB2_104 Depth=5
	ldp	x12, x10, [sp, #112]            ; 16-byte Folded Reload
	add	x10, x20, x10
	add	x10, x10, #1
	ldr	s0, [x22, x10, lsl #2]
	ldur	x11, [x29, #-168]               ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	mov	x13, x25
LBB2_147:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_147
; %bb.148:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x24, #2
	b.eq	LBB2_155
; %bb.149:                              ;   in Loop: Header=BB2_104 Depth=5
	ldp	x12, x10, [sp, #112]            ; 16-byte Folded Reload
	add	x10, x20, x10
	add	x10, x10, #2
	ldr	s0, [x22, x10, lsl #2]
	ldr	x11, [sp, #200]                 ; 8-byte Folded Reload
	add	x11, x11, x8, lsl #2
	mov	x13, x25
LBB2_150:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_150
; %bb.151:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x24, #3
	b.eq	LBB2_155
; %bb.152:                              ;   in Loop: Header=BB2_104 Depth=5
	ldp	x10, x11, [sp, #120]            ; 16-byte Folded Reload
	add	x10, x20, x10
	add	x10, x10, #3
	ldr	s0, [x22, x10, lsl #2]
	add	x11, x11, x8, lsl #2
	ldr	x12, [sp, #112]                 ; 8-byte Folded Reload
	mov	x13, x25
LBB2_153:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x12], #4
	ldr	s2, [x11]
	fmadd	s0, s1, s2, s0
	add	x11, x11, x21
	subs	x13, x13, #1
	b.ne	LBB2_153
; %bb.154:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x10, lsl #2]
LBB2_155:                               ;   in Loop: Header=BB2_104 Depth=5
	cmp	x27, #3
	b.eq	LBB2_103
; %bb.156:                              ;   in Loop: Header=BB2_104 Depth=5
	ldp	x11, x10, [sp, #96]             ; 16-byte Folded Reload
	add	x10, x20, x10
	ldr	s0, [x22, x10, lsl #2]
	mov	x12, x25
LBB2_157:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x11], #4
	ldr	s2, [x9]
	fmadd	s0, s1, s2, s0
	add	x9, x9, x21
	subs	x12, x12, #1
	b.ne	LBB2_157
; %bb.158:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x10, lsl #2]
	cmp	x24, #1
	b.eq	LBB2_103
; %bb.159:                              ;   in Loop: Header=BB2_104 Depth=5
	ldp	x11, x9, [sp, #96]              ; 16-byte Folded Reload
	add	x9, x20, x9
	add	x9, x9, #1
	ldr	s0, [x22, x9, lsl #2]
	ldur	x10, [x29, #-168]               ; 8-byte Folded Reload
	add	x10, x10, x8, lsl #2
	mov	x12, x25
LBB2_160:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x11], #4
	ldr	s2, [x10]
	fmadd	s0, s1, s2, s0
	add	x10, x10, x21
	subs	x12, x12, #1
	b.ne	LBB2_160
; %bb.161:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x9, lsl #2]
	cmp	x24, #2
	b.eq	LBB2_103
; %bb.162:                              ;   in Loop: Header=BB2_104 Depth=5
	ldp	x11, x9, [sp, #96]              ; 16-byte Folded Reload
	add	x9, x20, x9
	add	x9, x9, #2
	ldr	s0, [x22, x9, lsl #2]
	ldr	x10, [sp, #200]                 ; 8-byte Folded Reload
	add	x10, x10, x8, lsl #2
	mov	x12, x25
LBB2_163:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x11], #4
	ldr	s2, [x10]
	fmadd	s0, s1, s2, s0
	add	x10, x10, x21
	subs	x12, x12, #1
	b.ne	LBB2_163
; %bb.164:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x9, lsl #2]
	cmp	x24, #3
	b.eq	LBB2_103
; %bb.165:                              ;   in Loop: Header=BB2_104 Depth=5
	ldr	x9, [sp, #104]                  ; 8-byte Folded Reload
	add	x9, x20, x9
	add	x9, x9, #3
	ldr	s0, [x22, x9, lsl #2]
	ldr	x10, [sp, #128]                 ; 8-byte Folded Reload
	add	x8, x10, x8, lsl #2
	ldr	x10, [sp, #96]                  ; 8-byte Folded Reload
	mov	x11, x25
LBB2_166:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ;           Parent Loop BB2_104 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x10], #4
	ldr	s2, [x8]
	fmadd	s0, s1, s2, s0
	add	x8, x8, x21
	subs	x11, x11, #1
	b.ne	LBB2_166
; %bb.167:                              ;   in Loop: Header=BB2_104 Depth=5
	str	s0, [x22, x9, lsl #2]
	b	LBB2_103
LBB2_168:                               ;   in Loop: Header=BB2_100 Depth=4
	cmp	x30, #4
	b.hs	LBB2_170
	b	LBB2_99
LBB2_169:                               ;   in Loop: Header=BB2_170 Depth=5
	add	x20, x24, x20
	cmp	x7, x20
	b.ls	LBB2_99
LBB2_170:                               ;   Parent Loop BB2_9 Depth=1
                                        ;     Parent Loop BB2_12 Depth=2
                                        ;       Parent Loop BB2_98 Depth=3
                                        ;         Parent Loop BB2_100 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	sub	x8, x7, x20
	cmp	x8, #4
	csel	x24, x8, x6, lo
	b.lo	LBB2_169
; %bb.171:                              ;   in Loop: Header=BB2_170 Depth=5
	lsl	x8, x20, #2
	ldp	x9, x4, [x29, #-112]            ; 16-byte Folded Reload
	add	x1, x9, x8
	ldp	x9, x0, [x29, #-136]            ; 16-byte Folded Reload
	add	x2, x9, x8
	ldur	x3, [x29, #-96]                 ; 8-byte Folded Reload
	mov	x5, x25
	bl	__ZN4gemm6detail13tile_4x4_neonEPKfS2_Pfmmm
	ldur	x7, [x29, #-144]                ; 8-byte Folded Reload
	mov	w6, #4
	ldur	x5, [x29, #-120]                ; 8-byte Folded Reload
	ldp	x4, x3, [x29, #-104]            ; 16-byte Folded Reload
	b	LBB2_169
LBB2_172:
	ldp	x29, x30, [sp, #400]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #384]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #368]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #352]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #336]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #320]            ; 16-byte Folded Reload
	add	sp, sp, #416
	ret
LBB2_173:
	mov	w0, #16
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp3:
Lloh24:
	adrp	x1, l_.str@PAGE
Lloh25:
	add	x1, x1, l_.str@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp4:
; %bb.174:
Lloh26:
	adrp	x1, __ZTISt13runtime_error@GOTPAGE
Lloh27:
	ldr	x1, [x1, __ZTISt13runtime_error@GOTPAGEOFF]
Lloh28:
	adrp	x2, __ZNSt13runtime_errorD1Ev@GOTPAGE
Lloh29:
	ldr	x2, [x2, __ZNSt13runtime_errorD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
LBB2_175:
	mov	w0, #16
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp6:
Lloh30:
	adrp	x1, l_.str.1@PAGE
Lloh31:
	add	x1, x1, l_.str.1@PAGEOFF
	bl	__ZNSt16invalid_argumentC1B6v15006EPKc
Ltmp7:
; %bb.176:
Lloh32:
	adrp	x1, __ZTISt16invalid_argument@GOTPAGE
Lloh33:
	ldr	x1, [x1, __ZTISt16invalid_argument@GOTPAGEOFF]
Lloh34:
	adrp	x2, __ZNSt16invalid_argumentD1Ev@GOTPAGE
Lloh35:
	ldr	x2, [x2, __ZNSt16invalid_argumentD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
LBB2_177:
Ltmp8:
	b	LBB2_179
LBB2_178:
Ltmp5:
LBB2_179:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh24, Lloh25
	.loh AdrpLdrGot	Lloh28, Lloh29
	.loh AdrpLdrGot	Lloh26, Lloh27
	.loh AdrpAdd	Lloh30, Lloh31
	.loh AdrpLdrGot	Lloh34, Lloh35
	.loh AdrpLdrGot	Lloh32, Lloh33
Lfunc_end1:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table2:
Lexception1:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end1-Lcst_begin1
Lcst_begin1:
	.uleb128 Lfunc_begin1-Lfunc_begin1      ; >> Call Site 1 <<
	.uleb128 Ltmp3-Lfunc_begin1             ;   Call between Lfunc_begin1 and Ltmp3
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp3-Lfunc_begin1             ; >> Call Site 2 <<
	.uleb128 Ltmp4-Ltmp3                    ;   Call between Ltmp3 and Ltmp4
	.uleb128 Ltmp5-Lfunc_begin1             ;     jumps to Ltmp5
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp4-Lfunc_begin1             ; >> Call Site 3 <<
	.uleb128 Ltmp6-Ltmp4                    ;   Call between Ltmp4 and Ltmp6
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp6-Lfunc_begin1             ; >> Call Site 4 <<
	.uleb128 Ltmp7-Ltmp6                    ;   Call between Ltmp6 and Ltmp7
	.uleb128 Ltmp8-Lfunc_begin1             ;     jumps to Ltmp8
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp7-Lfunc_begin1             ; >> Call Site 5 <<
	.uleb128 Lfunc_end1-Ltmp7               ;   Call between Ltmp7 and Lfunc_end1
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end1:
	.p2align	2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt16invalid_argumentC1B6v15006EPKc ; -- Begin function _ZNSt16invalid_argumentC1B6v15006EPKc
	.globl	__ZNSt16invalid_argumentC1B6v15006EPKc
	.weak_def_can_be_hidden	__ZNSt16invalid_argumentC1B6v15006EPKc
	.p2align	2
__ZNSt16invalid_argumentC1B6v15006EPKc: ; @_ZNSt16invalid_argumentC1B6v15006EPKc
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	__ZNSt11logic_errorC2EPKc
Lloh36:
	adrp	x8, __ZTVSt16invalid_argument@GOTPAGE
Lloh37:
	ldr	x8, [x8, __ZTVSt16invalid_argument@GOTPAGEOFF]
	add	x8, x8, #16
	str	x8, [x0]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh36, Lloh37
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"NEON 4x4 requires an enabled AArch64 NEON build"

l_.str.1:                               ; @.str.1
	.asciz	"Unsupported microtile or zero block dimension"

.subsections_via_symbols
