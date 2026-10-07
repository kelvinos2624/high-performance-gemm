	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	__ZN4gemm7blockedEPKfS1_PfmmmNS_9BlockSizeE ; -- Begin function _ZN4gemm7blockedEPKfS1_PfmmmNS_9BlockSizeE
	.p2align	2
__ZN4gemm7blockedEPKfS1_PfmmmNS_9BlockSizeE: ; @_ZN4gemm7blockedEPKfS1_PfmmmNS_9BlockSizeE
Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception0
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
	ldr	x25, [x6]
	cbz	x25, LBB0_24
; %bb.1:
	ldr	x26, [x6, #8]
	cbz	x26, LBB0_24
; %bb.2:
	ldr	x27, [x6, #16]
	cbz	x27, LBB0_24
; %bb.3:
	mov	x21, x3
	cbz	x3, LBB0_23
; %bb.4:
	mov	x20, x4
	cbz	x4, LBB0_23
; %bb.5:
	mov	x19, x5
	mov	x22, x2
	mov	x23, x1
	mov	x24, x0
	mul	x8, x20, x21
	cbz	x8, LBB0_7
; %bb.6:
	lsl	x1, x8, #2
	mov	x0, x22
	bl	_bzero
LBB0_7:
	cbz	x19, LBB0_23
; %bb.8:
	mov	x9, #0
	lsl	x8, x20, #2
	b	LBB0_10
LBB0_9:                                 ;   in Loop: Header=BB0_10 Depth=1
	mov	x9, x10
	cmp	x10, x21
	b.hs	LBB0_23
LBB0_10:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_13 Depth 2
                                        ;       Child Loop BB0_16 Depth 3
                                        ;         Child Loop BB0_18 Depth 4
                                        ;           Child Loop BB0_19 Depth 5
                                        ;             Child Loop BB0_20 Depth 6
	sub	x10, x21, x9
	cmp	x10, x25
	csel	x10, x10, x25, lo
	add	x10, x10, x9
	cmp	x9, x10
	b.hs	LBB0_9
; %bb.11:                               ;   in Loop: Header=BB0_10 Depth=1
	mov	x12, #0
	mul	x11, x20, x9
	b	LBB0_13
LBB0_12:                                ;   in Loop: Header=BB0_13 Depth=2
	mov	x12, x13
	cmp	x13, x19
	b.hs	LBB0_9
LBB0_13:                                ;   Parent Loop BB0_10 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_16 Depth 3
                                        ;         Child Loop BB0_18 Depth 4
                                        ;           Child Loop BB0_19 Depth 5
                                        ;             Child Loop BB0_20 Depth 6
	sub	x13, x19, x12
	cmp	x13, x27
	csel	x13, x13, x27, lo
	add	x13, x13, x12
	cmp	x12, x13
	b.hs	LBB0_12
; %bb.14:                               ;   in Loop: Header=BB0_13 Depth=2
	mov	x0, #0
	mul	x14, x20, x12
	b	LBB0_16
LBB0_15:                                ;   in Loop: Header=BB0_16 Depth=3
	mov	x0, x15
	cmp	x15, x20
	b.hs	LBB0_12
LBB0_16:                                ;   Parent Loop BB0_10 Depth=1
                                        ;     Parent Loop BB0_13 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB0_18 Depth 4
                                        ;           Child Loop BB0_19 Depth 5
                                        ;             Child Loop BB0_20 Depth 6
	sub	x15, x20, x0
	cmp	x15, x26
	csel	x16, x15, x26, lo
	add	x15, x16, x0
	cmp	x0, x15
	b.hs	LBB0_15
; %bb.17:                               ;   in Loop: Header=BB0_16 Depth=3
	add	x17, x11, x0
	add	x17, x22, x17, lsl #2
	add	x0, x14, x0
	add	x0, x23, x0, lsl #2
	mov	x1, x9
LBB0_18:                                ;   Parent Loop BB0_10 Depth=1
                                        ;     Parent Loop BB0_13 Depth=2
                                        ;       Parent Loop BB0_16 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB0_19 Depth 5
                                        ;             Child Loop BB0_20 Depth 6
	mul	x2, x1, x19
	mov	x3, x0
	mov	x4, x12
LBB0_19:                                ;   Parent Loop BB0_10 Depth=1
                                        ;     Parent Loop BB0_13 Depth=2
                                        ;       Parent Loop BB0_16 Depth=3
                                        ;         Parent Loop BB0_18 Depth=4
                                        ; =>        This Loop Header: Depth=5
                                        ;             Child Loop BB0_20 Depth 6
	add	x5, x4, x2
	ldr	s0, [x24, x5, lsl #2]
	mov	x5, x3
	mov	x6, x17
	mov	x7, x16
LBB0_20:                                ;   Parent Loop BB0_10 Depth=1
                                        ;     Parent Loop BB0_13 Depth=2
                                        ;       Parent Loop BB0_16 Depth=3
                                        ;         Parent Loop BB0_18 Depth=4
                                        ;           Parent Loop BB0_19 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x5], #4
	ldr	s2, [x6]
	fmadd	s1, s0, s1, s2
	str	s1, [x6], #4
	subs	x7, x7, #1
	b.ne	LBB0_20
; %bb.21:                               ;   in Loop: Header=BB0_19 Depth=5
	add	x4, x4, #1
	add	x3, x3, x8
	cmp	x4, x13
	b.ne	LBB0_19
; %bb.22:                               ;   in Loop: Header=BB0_18 Depth=4
	add	x1, x1, #1
	add	x17, x17, x8
	cmp	x1, x10
	b.ne	LBB0_18
	b	LBB0_15
LBB0_23:
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB0_24:
	mov	w0, #16
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp0:
Lloh0:
	adrp	x1, l_.str@PAGE
Lloh1:
	add	x1, x1, l_.str@PAGEOFF
	bl	__ZNSt16invalid_argumentC1B6v15006EPKc
Ltmp1:
; %bb.25:
Lloh2:
	adrp	x1, __ZTISt16invalid_argument@GOTPAGE
Lloh3:
	ldr	x1, [x1, __ZTISt16invalid_argument@GOTPAGEOFF]
Lloh4:
	adrp	x2, __ZNSt16invalid_argumentD1Ev@GOTPAGE
Lloh5:
	ldr	x2, [x2, __ZNSt16invalid_argumentD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
LBB0_26:
Ltmp2:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh0, Lloh1
	.loh AdrpLdrGot	Lloh4, Lloh5
	.loh AdrpLdrGot	Lloh2, Lloh3
Lfunc_end0:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table0:
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
Lloh6:
	adrp	x8, __ZTVSt16invalid_argument@GOTPAGE
Lloh7:
	ldr	x8, [x8, __ZTVSt16invalid_argument@GOTPAGEOFF]
	add	x8, x8, #16
	str	x8, [x0]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh6, Lloh7
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"Block dimensions must be positive"

.subsections_via_symbols
