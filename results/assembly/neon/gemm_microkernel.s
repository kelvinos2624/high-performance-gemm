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
	bl	__ZN4gemm6detail16microkernel_implEPKfS2_PfmmmNS_9BlockSizeEmmPFvS2_S2_S3_mmmE
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
	.globl	__ZN4gemm8neon_4x4EPKfS1_PfmmmNS_9BlockSizeE ; -- Begin function _ZN4gemm8neon_4x4EPKfS1_PfmmmNS_9BlockSizeE
	.p2align	2
__ZN4gemm8neon_4x4EPKfS1_PfmmmNS_9BlockSizeE: ; @_ZN4gemm8neon_4x4EPKfS1_PfmmmNS_9BlockSizeE
Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception0
; %bb.0:
	sub	sp, sp, #128
	.cfi_def_cfa_offset 128
	stp	x26, x25, [sp, #48]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #64]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #80]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #96]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #112]            ; 16-byte Folded Spill
	add	x29, sp, #112
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
	mov	x25, x6
	mov	x19, x5
	mov	x20, x4
	mov	x21, x3
	mov	x22, x2
	mov	x23, x1
	mov	x24, x0
	bl	__ZN4gemm14neon_availableEv
	tbz	w0, #0, LBB1_2
; %bb.1:
	ldr	q0, [x25]
	str	q0, [sp, #16]
	ldr	x8, [x25, #16]
	str	x8, [sp, #32]
Lloh18:
	adrp	x8, __ZN4gemm6detail13tile_4x4_neonEPKfS2_Pfmmm@GOTPAGE
Lloh19:
	ldr	x8, [x8, __ZN4gemm6detail13tile_4x4_neonEPKfS2_Pfmmm@GOTPAGEOFF]
	mov	w9, #4
	stp	x9, x8, [sp]
	add	x6, sp, #16
	mov	x0, x24
	mov	x1, x23
	mov	x2, x22
	mov	x3, x21
	mov	x4, x20
	mov	x5, x19
	mov	w7, #4
	bl	__ZN4gemm6detail16microkernel_implEPKfS2_PfmmmNS_9BlockSizeEmmPFvS2_S2_S3_mmmE
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #96]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #128
	ret
LBB1_2:
	mov	w0, #16
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp0:
Lloh20:
	adrp	x1, l_.str@PAGE
Lloh21:
	add	x1, x1, l_.str@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp1:
; %bb.3:
Lloh22:
	adrp	x1, __ZTISt13runtime_error@GOTPAGE
Lloh23:
	ldr	x1, [x1, __ZTISt13runtime_error@GOTPAGEOFF]
Lloh24:
	adrp	x2, __ZNSt13runtime_errorD1Ev@GOTPAGE
Lloh25:
	ldr	x2, [x2, __ZNSt13runtime_errorD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
LBB1_4:
Ltmp2:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpLdrGot	Lloh18, Lloh19
	.loh AdrpAdd	Lloh20, Lloh21
	.loh AdrpLdrGot	Lloh24, Lloh25
	.loh AdrpLdrGot	Lloh22, Lloh23
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
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"NEON 4x4 requires an enabled AArch64 NEON build"

.subsections_via_symbols
