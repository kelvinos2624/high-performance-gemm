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
	sub	sp, sp, #240
	.cfi_def_cfa_offset 240
	stp	x29, x30, [sp, #224]            ; 16-byte Folded Spill
	add	x29, sp, #224
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x6, [sp, #40]                   ; 8-byte Folded Spill
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	stur	x2, [x29, #-24]
	stur	x3, [x29, #-32]
	stur	x4, [x29, #-40]
	stur	x5, [x29, #-48]
	ldr	x8, [x6]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB0_3
	b	LBB0_1
LBB0_1:
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	ldr	x8, [x8, #8]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB0_3
	b	LBB0_2
LBB0_2:
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	ldr	x8, [x8, #16]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB0_6
	b	LBB0_3
LBB0_3:
	mov	x0, #16
	bl	___cxa_allocate_exception
	str	x0, [sp, #32]                   ; 8-byte Folded Spill
Ltmp0:
	adrp	x1, l_.str@PAGE
	add	x1, x1, l_.str@PAGEOFF
	bl	__ZNSt16invalid_argumentC1B6v15006EPKc
Ltmp1:
	b	LBB0_4
LBB0_4:
	ldr	x0, [sp, #32]                   ; 8-byte Folded Reload
	adrp	x1, __ZTISt16invalid_argument@GOTPAGE
	ldr	x1, [x1, __ZTISt16invalid_argument@GOTPAGEOFF]
	adrp	x2, __ZNSt16invalid_argumentD1Ev@GOTPAGE
	ldr	x2, [x2, __ZNSt16invalid_argumentD1Ev@GOTPAGEOFF]
	bl	___cxa_throw
LBB0_5:
Ltmp2:
	mov	x9, x0
	ldr	x0, [sp, #32]                   ; 8-byte Folded Reload
	mov	x8, x1
	stur	x9, [x29, #-56]
	stur	w8, [x29, #-60]
	bl	___cxa_free_exception
	b	LBB0_35
LBB0_6:
	ldur	x8, [x29, #-32]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB0_8
	b	LBB0_7
LBB0_7:
	ldur	x8, [x29, #-40]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB0_9
	b	LBB0_8
LBB0_8:
	b	LBB0_34
LBB0_9:
	stur	xzr, [x29, #-72]
	b	LBB0_10
LBB0_10:                                ; =>This Inner Loop Header: Depth=1
	ldur	x8, [x29, #-72]
	ldur	x9, [x29, #-32]
	ldur	x10, [x29, #-40]
	mul	x9, x9, x10
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB0_13
	b	LBB0_11
LBB0_11:                                ;   in Loop: Header=BB0_10 Depth=1
	ldur	x8, [x29, #-24]
	ldur	x9, [x29, #-72]
	movi	d0, #0000000000000000
	str	s0, [x8, x9, lsl #2]
	b	LBB0_12
LBB0_12:                                ;   in Loop: Header=BB0_10 Depth=1
	ldur	x8, [x29, #-72]
	add	x8, x8, #1
	stur	x8, [x29, #-72]
	b	LBB0_10
LBB0_13:
	stur	xzr, [x29, #-80]
	b	LBB0_14
LBB0_14:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_16 Depth 2
                                        ;       Child Loop BB0_18 Depth 3
                                        ;         Child Loop BB0_20 Depth 4
                                        ;           Child Loop BB0_22 Depth 5
                                        ;             Child Loop BB0_24 Depth 6
	ldur	x8, [x29, #-80]
	ldur	x9, [x29, #-32]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB0_34
	b	LBB0_15
LBB0_15:                                ;   in Loop: Header=BB0_14 Depth=1
	ldr	x0, [sp, #40]                   ; 8-byte Folded Reload
	ldur	x8, [x29, #-80]
	str	x8, [sp, #24]                   ; 8-byte Folded Spill
	ldur	x8, [x29, #-32]
	ldur	x9, [x29, #-80]
	subs	x8, x8, x9
	sub	x1, x29, #96
	stur	x8, [x29, #-96]
	bl	__ZNSt3__13minB6v15006ImEERKT_S3_S3_
	ldr	x8, [sp, #24]                   ; 8-byte Folded Reload
	ldr	x9, [x0]
	add	x8, x8, x9
	stur	x8, [x29, #-88]
	stur	xzr, [x29, #-104]
	b	LBB0_16
LBB0_16:                                ;   Parent Loop BB0_14 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_18 Depth 3
                                        ;         Child Loop BB0_20 Depth 4
                                        ;           Child Loop BB0_22 Depth 5
                                        ;             Child Loop BB0_24 Depth 6
	ldur	x8, [x29, #-104]
	ldur	x9, [x29, #-48]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB0_33
	b	LBB0_17
LBB0_17:                                ;   in Loop: Header=BB0_16 Depth=2
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	ldur	x9, [x29, #-104]
	str	x9, [sp, #16]                   ; 8-byte Folded Spill
	add	x0, x8, #16
	ldur	x8, [x29, #-48]
	ldur	x9, [x29, #-104]
	subs	x8, x8, x9
	add	x1, sp, #104
	str	x8, [sp, #104]
	bl	__ZNSt3__13minB6v15006ImEERKT_S3_S3_
	ldr	x8, [sp, #16]                   ; 8-byte Folded Reload
	ldr	x9, [x0]
	add	x8, x8, x9
	str	x8, [sp, #112]
	str	xzr, [sp, #96]
	b	LBB0_18
LBB0_18:                                ;   Parent Loop BB0_14 Depth=1
                                        ;     Parent Loop BB0_16 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB0_20 Depth 4
                                        ;           Child Loop BB0_22 Depth 5
                                        ;             Child Loop BB0_24 Depth 6
	ldr	x8, [sp, #96]
	ldur	x9, [x29, #-40]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB0_32
	b	LBB0_19
LBB0_19:                                ;   in Loop: Header=BB0_18 Depth=3
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	ldr	x9, [sp, #96]
	str	x9, [sp, #8]                    ; 8-byte Folded Spill
	add	x0, x8, #8
	ldur	x8, [x29, #-40]
	ldr	x9, [sp, #96]
	subs	x8, x8, x9
	add	x1, sp, #80
	str	x8, [sp, #80]
	bl	__ZNSt3__13minB6v15006ImEERKT_S3_S3_
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	ldr	x9, [x0]
	add	x8, x8, x9
	str	x8, [sp, #88]
	ldur	x8, [x29, #-80]
	str	x8, [sp, #72]
	b	LBB0_20
LBB0_20:                                ;   Parent Loop BB0_14 Depth=1
                                        ;     Parent Loop BB0_16 Depth=2
                                        ;       Parent Loop BB0_18 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB0_22 Depth 5
                                        ;             Child Loop BB0_24 Depth 6
	ldr	x8, [sp, #72]
	ldur	x9, [x29, #-88]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB0_31
	b	LBB0_21
LBB0_21:                                ;   in Loop: Header=BB0_20 Depth=4
	ldur	x8, [x29, #-104]
	str	x8, [sp, #64]
	b	LBB0_22
LBB0_22:                                ;   Parent Loop BB0_14 Depth=1
                                        ;     Parent Loop BB0_16 Depth=2
                                        ;       Parent Loop BB0_18 Depth=3
                                        ;         Parent Loop BB0_20 Depth=4
                                        ; =>        This Loop Header: Depth=5
                                        ;             Child Loop BB0_24 Depth 6
	ldr	x8, [sp, #64]
	ldr	x9, [sp, #112]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB0_29
	b	LBB0_23
LBB0_23:                                ;   in Loop: Header=BB0_22 Depth=5
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #72]
	ldur	x10, [x29, #-48]
	mul	x9, x9, x10
	ldr	x10, [sp, #64]
	add	x9, x9, x10
	ldr	s0, [x8, x9, lsl #2]
	str	s0, [sp, #60]
	ldr	x8, [sp, #96]
	str	x8, [sp, #48]
	b	LBB0_24
LBB0_24:                                ;   Parent Loop BB0_14 Depth=1
                                        ;     Parent Loop BB0_16 Depth=2
                                        ;       Parent Loop BB0_18 Depth=3
                                        ;         Parent Loop BB0_20 Depth=4
                                        ;           Parent Loop BB0_22 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	x8, [sp, #48]
	ldr	x9, [sp, #88]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB0_27
	b	LBB0_25
LBB0_25:                                ;   in Loop: Header=BB0_24 Depth=6
	ldr	s0, [sp, #60]
	ldur	x8, [x29, #-16]
	ldr	x9, [sp, #64]
	ldur	x10, [x29, #-40]
	mul	x9, x9, x10
	ldr	x10, [sp, #48]
	add	x9, x9, x10
	ldr	s1, [x8, x9, lsl #2]
	ldur	x8, [x29, #-24]
	ldr	x9, [sp, #72]
	ldur	x10, [x29, #-40]
	mul	x9, x9, x10
	ldr	x10, [sp, #48]
	add	x9, x9, x10
	add	x8, x8, x9, lsl #2
	ldr	s2, [x8]
	fmadd	s0, s0, s1, s2
	str	s0, [x8]
	b	LBB0_26
LBB0_26:                                ;   in Loop: Header=BB0_24 Depth=6
	ldr	x8, [sp, #48]
	add	x8, x8, #1
	str	x8, [sp, #48]
	b	LBB0_24
LBB0_27:                                ;   in Loop: Header=BB0_22 Depth=5
	b	LBB0_28
LBB0_28:                                ;   in Loop: Header=BB0_22 Depth=5
	ldr	x8, [sp, #64]
	add	x8, x8, #1
	str	x8, [sp, #64]
	b	LBB0_22
LBB0_29:                                ;   in Loop: Header=BB0_20 Depth=4
	b	LBB0_30
LBB0_30:                                ;   in Loop: Header=BB0_20 Depth=4
	ldr	x8, [sp, #72]
	add	x8, x8, #1
	str	x8, [sp, #72]
	b	LBB0_20
LBB0_31:                                ;   in Loop: Header=BB0_18 Depth=3
	ldr	x8, [sp, #88]
	str	x8, [sp, #96]
	b	LBB0_18
LBB0_32:                                ;   in Loop: Header=BB0_16 Depth=2
	ldr	x8, [sp, #112]
	stur	x8, [x29, #-104]
	b	LBB0_16
LBB0_33:                                ;   in Loop: Header=BB0_14 Depth=1
	ldur	x8, [x29, #-88]
	stur	x8, [x29, #-80]
	b	LBB0_14
LBB0_34:
	ldp	x29, x30, [sp, #224]            ; 16-byte Folded Reload
	add	sp, sp, #240
	ret
LBB0_35:
	ldur	x0, [x29, #-56]
	bl	__Unwind_Resume
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
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	ldur	x0, [x29, #-8]
	str	x0, [sp, #8]                    ; 8-byte Folded Spill
	ldr	x1, [sp, #16]
	bl	__ZNSt16invalid_argumentC2B6v15006EPKc
	ldr	x0, [sp, #8]                    ; 8-byte Folded Reload
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__13minB6v15006ImEERKT_S3_S3_ ; -- Begin function _ZNSt3__13minB6v15006ImEERKT_S3_S3_
	.globl	__ZNSt3__13minB6v15006ImEERKT_S3_S3_
	.weak_definition	__ZNSt3__13minB6v15006ImEERKT_S3_S3_
	.p2align	2
__ZNSt3__13minB6v15006ImEERKT_S3_S3_:   ; @_ZNSt3__13minB6v15006ImEERKT_S3_S3_
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	ldur	x0, [x29, #-8]
	ldr	x1, [sp, #16]
	bl	__ZNSt3__13minB6v15006ImNS_6__lessImmEEEERKT_S5_S5_T0_
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt16invalid_argumentC2B6v15006EPKc ; -- Begin function _ZNSt16invalid_argumentC2B6v15006EPKc
	.globl	__ZNSt16invalid_argumentC2B6v15006EPKc
	.weak_def_can_be_hidden	__ZNSt16invalid_argumentC2B6v15006EPKc
	.p2align	2
__ZNSt16invalid_argumentC2B6v15006EPKc: ; @_ZNSt16invalid_argumentC2B6v15006EPKc
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, __ZTVSt16invalid_argument@GOTPAGE
	ldr	x8, [x8, __ZTVSt16invalid_argument@GOTPAGEOFF]
	add	x8, x8, #16
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	ldur	x0, [x29, #-8]
	str	x0, [sp]                        ; 8-byte Folded Spill
	ldr	x1, [sp, #16]
	bl	__ZNSt11logic_errorC2EPKc
	ldr	x0, [sp]                        ; 8-byte Folded Reload
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	str	x8, [x0]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__13minB6v15006ImNS_6__lessImmEEEERKT_S5_S5_T0_ ; -- Begin function _ZNSt3__13minB6v15006ImNS_6__lessImmEEEERKT_S5_S5_T0_
	.globl	__ZNSt3__13minB6v15006ImNS_6__lessImmEEEERKT_S5_S5_T0_
	.weak_definition	__ZNSt3__13minB6v15006ImNS_6__lessImmEEEERKT_S5_S5_T0_
	.p2align	2
__ZNSt3__13minB6v15006ImNS_6__lessImmEEEERKT_S5_S5_T0_: ; @_ZNSt3__13minB6v15006ImNS_6__lessImmEEEERKT_S5_S5_T0_
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #16]
	str	x1, [sp, #8]
	ldr	x1, [sp, #8]
	ldr	x2, [sp, #16]
	sub	x0, x29, #1
	bl	__ZNKSt3__16__lessImmEclB6v15006ERKmS3_
	tbz	w0, #0, LBB4_2
	b	LBB4_1
LBB4_1:
	ldr	x8, [sp, #8]
	str	x8, [sp]                        ; 8-byte Folded Spill
	b	LBB4_3
LBB4_2:
	ldr	x8, [sp, #16]
	str	x8, [sp]                        ; 8-byte Folded Spill
	b	LBB4_3
LBB4_3:
	ldr	x0, [sp]                        ; 8-byte Folded Reload
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNKSt3__16__lessImmEclB6v15006ERKmS3_ ; -- Begin function _ZNKSt3__16__lessImmEclB6v15006ERKmS3_
	.globl	__ZNKSt3__16__lessImmEclB6v15006ERKmS3_
	.weak_definition	__ZNKSt3__16__lessImmEclB6v15006ERKmS3_
	.p2align	2
__ZNKSt3__16__lessImmEclB6v15006ERKmS3_: ; @_ZNKSt3__16__lessImmEclB6v15006ERKmS3_
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	str	x0, [sp, #24]
	str	x1, [sp, #16]
	str	x2, [sp, #8]
	ldr	x8, [sp, #16]
	ldr	x8, [x8]
	ldr	x9, [sp, #8]
	ldr	x9, [x9]
	subs	x8, x8, x9
	cset	w8, lo
	and	w0, w8, #0x1
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"Block dimensions must be positive"

.subsections_via_symbols
