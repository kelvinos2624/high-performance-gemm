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
	sub	sp, sp, #208
	.cfi_def_cfa_offset 208
	stp	x28, x27, [sp, #112]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #128]            ; 16-byte Folded Spill
	stp	x24, x23, [sp, #144]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #160]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #176]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #192]            ; 16-byte Folded Spill
	add	x29, sp, #192
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
	ldr	x8, [x6]
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	cbz	x8, LBB0_35
; %bb.1:
	ldr	x8, [x6, #8]
	str	x8, [sp, #56]                   ; 8-byte Folded Spill
	cbz	x8, LBB0_35
; %bb.2:
	ldr	x8, [x6, #16]
	str	x8, [sp, #16]                   ; 8-byte Folded Spill
	cbz	x8, LBB0_35
; %bb.3:
	mov	x19, x3
	cbz	x3, LBB0_34
; %bb.4:
	mov	x20, x4
	cbz	x4, LBB0_34
; %bb.5:
	mov	x26, x5
	mov	x22, x2
	mov	x23, x1
	mov	x24, x0
	mul	x8, x20, x19
	cbz	x8, LBB0_7
; %bb.6:
	lsl	x1, x8, #2
	mov	x0, x22
	bl	_bzero
LBB0_7:
	cbz	x26, LBB0_34
; %bb.8:
	mov	x11, #0
	add	x10, x22, #32
	lsl	x9, x20, #2
	add	x8, x23, #32
	stp	x8, x10, [sp, #24]              ; 16-byte Folded Spill
	str	x19, [sp]                       ; 8-byte Folded Spill
	b	LBB0_10
LBB0_9:                                 ;   in Loop: Header=BB0_10 Depth=1
	mov	x11, x7
	ldr	x19, [sp]                       ; 8-byte Folded Reload
	cmp	x7, x19
	b.hs	LBB0_34
LBB0_10:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_13 Depth 2
                                        ;       Child Loop BB0_16 Depth 3
                                        ;         Child Loop BB0_26 Depth 4
                                        ;           Child Loop BB0_28 Depth 5
                                        ;             Child Loop BB0_30 Depth 6
                                        ;             Child Loop BB0_33 Depth 6
                                        ;         Child Loop BB0_19 Depth 4
                                        ;           Child Loop BB0_20 Depth 5
                                        ;             Child Loop BB0_21 Depth 6
	sub	x8, x19, x11
	ldr	x10, [sp, #8]                   ; 8-byte Folded Reload
	cmp	x8, x10
	csel	x8, x8, x10, lo
	add	x7, x8, x11
	str	x11, [sp, #48]                  ; 8-byte Folded Spill
	cmp	x11, x7
	b.hs	LBB0_9
; %bb.11:                               ;   in Loop: Header=BB0_10 Depth=1
	mov	x27, #0
	ldr	x8, [sp, #48]                   ; 8-byte Folded Reload
	mul	x8, x8, x20
	str	x8, [sp, #40]                   ; 8-byte Folded Spill
	str	x7, [sp, #72]                   ; 8-byte Folded Spill
	b	LBB0_13
LBB0_12:                                ;   in Loop: Header=BB0_13 Depth=2
	mov	x27, x15
	cmp	x15, x26
	b.hs	LBB0_9
LBB0_13:                                ;   Parent Loop BB0_10 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_16 Depth 3
                                        ;         Child Loop BB0_26 Depth 4
                                        ;           Child Loop BB0_28 Depth 5
                                        ;             Child Loop BB0_30 Depth 6
                                        ;             Child Loop BB0_33 Depth 6
                                        ;         Child Loop BB0_19 Depth 4
                                        ;           Child Loop BB0_20 Depth 5
                                        ;             Child Loop BB0_21 Depth 6
	sub	x8, x26, x27
	ldr	x10, [sp, #16]                  ; 8-byte Folded Reload
	cmp	x8, x10
	csel	x8, x8, x10, lo
	add	x15, x8, x27
	cmp	x27, x15
	b.hs	LBB0_12
; %bb.14:                               ;   in Loop: Header=BB0_13 Depth=2
	mov	x1, #0
	mul	x8, x27, x20
	stur	x8, [x29, #-88]                 ; 8-byte Folded Spill
	b	LBB0_16
LBB0_15:                                ;   in Loop: Header=BB0_16 Depth=3
	ldr	x8, [sp, #64]                   ; 8-byte Folded Reload
	mov	x1, x8
	cmp	x8, x20
	b.hs	LBB0_12
LBB0_16:                                ;   Parent Loop BB0_10 Depth=1
                                        ;     Parent Loop BB0_13 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB0_26 Depth 4
                                        ;           Child Loop BB0_28 Depth 5
                                        ;             Child Loop BB0_30 Depth 6
                                        ;             Child Loop BB0_33 Depth 6
                                        ;         Child Loop BB0_19 Depth 4
                                        ;           Child Loop BB0_20 Depth 5
                                        ;             Child Loop BB0_21 Depth 6
	sub	x8, x20, x1
	ldr	x10, [sp, #56]                  ; 8-byte Folded Reload
	cmp	x8, x10
	csel	x0, x8, x10, lo
	add	x8, x0, x1
	str	x8, [sp, #64]                   ; 8-byte Folded Spill
	cmp	x1, x8
	b.hs	LBB0_15
; %bb.17:                               ;   in Loop: Header=BB0_16 Depth=3
	ldr	x13, [sp, #40]                  ; 8-byte Folded Reload
	add	x12, x13, x1
	ldur	x8, [x29, #-88]                 ; 8-byte Folded Reload
	add	x2, x8, x1
	cmp	x0, #16
	b.hs	LBB0_24
; %bb.18:                               ;   in Loop: Header=BB0_16 Depth=3
	add	x8, x22, x12, lsl #2
	ldr	x10, [sp, #48]                  ; 8-byte Folded Reload
	add	x11, x23, x2, lsl #2
LBB0_19:                                ;   Parent Loop BB0_10 Depth=1
                                        ;     Parent Loop BB0_13 Depth=2
                                        ;       Parent Loop BB0_16 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB0_20 Depth 5
                                        ;             Child Loop BB0_21 Depth 6
	mul	x13, x10, x26
	mov	x14, x11
	mov	x16, x27
LBB0_20:                                ;   Parent Loop BB0_10 Depth=1
                                        ;     Parent Loop BB0_13 Depth=2
                                        ;       Parent Loop BB0_16 Depth=3
                                        ;         Parent Loop BB0_19 Depth=4
                                        ; =>        This Loop Header: Depth=5
                                        ;             Child Loop BB0_21 Depth 6
	add	x17, x16, x13
	ldr	s0, [x24, x17, lsl #2]
	mov	x17, x14
	mov	x1, x8
	mov	x2, x0
LBB0_21:                                ;   Parent Loop BB0_10 Depth=1
                                        ;     Parent Loop BB0_13 Depth=2
                                        ;       Parent Loop BB0_16 Depth=3
                                        ;         Parent Loop BB0_19 Depth=4
                                        ;           Parent Loop BB0_20 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x17], #4
	ldr	s2, [x1]
	fmadd	s1, s0, s1, s2
	str	s1, [x1], #4
	subs	x2, x2, #1
	b.ne	LBB0_21
; %bb.22:                               ;   in Loop: Header=BB0_20 Depth=5
	add	x16, x16, #1
	add	x14, x14, x9
	cmp	x16, x15
	b.ne	LBB0_20
; %bb.23:                               ;   in Loop: Header=BB0_19 Depth=4
	add	x10, x10, #1
	add	x8, x8, x9
	cmp	x10, x7
	b.ne	LBB0_19
	b	LBB0_15
LBB0_24:                                ;   in Loop: Header=BB0_16 Depth=3
	mov	x4, #0
	add	x8, x12, x0
	stp	x8, x12, [sp, #88]              ; 16-byte Folded Spill
	add	x6, x2, x0
	and	x19, x0, #0xfffffffffffffff0
	add	x28, x1, x19
	add	x30, x1, x0
	ldr	x11, [sp, #48]                  ; 8-byte Folded Reload
	ldr	x8, [sp, #32]                   ; 8-byte Folded Reload
	add	x3, x8, x12, lsl #2
	ldr	x8, [sp, #24]                   ; 8-byte Folded Reload
	add	x8, x8, x2, lsl #2
	str	x8, [sp, #80]                   ; 8-byte Folded Spill
	b	LBB0_26
LBB0_25:                                ;   in Loop: Header=BB0_26 Depth=4
	add	x11, x11, #1
	add	x4, x4, #1
	add	x3, x3, x9
	add	x13, x13, x20
	ldr	x7, [sp, #72]                   ; 8-byte Folded Reload
	cmp	x11, x7
	mov	x26, x12
	mov	x27, x5
	ldr	x12, [sp, #96]                  ; 8-byte Folded Reload
	b.eq	LBB0_15
LBB0_26:                                ;   Parent Loop BB0_10 Depth=1
                                        ;     Parent Loop BB0_13 Depth=2
                                        ;       Parent Loop BB0_16 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB0_28 Depth 5
                                        ;             Child Loop BB0_30 Depth 6
                                        ;             Child Loop BB0_33 Depth 6
	mov	x10, #0
	mul	x8, x4, x20
	add	x14, x12, x8
	add	x21, x22, x14, lsl #2
	ldp	x17, x12, [sp, #80]             ; 16-byte Folded Reload
	add	x8, x12, x8
	add	x25, x22, x8, lsl #2
	mov	x12, x26
	mul	x26, x11, x26
	ldur	x16, [x29, #-88]                ; 8-byte Folded Reload
	mov	x5, x27
	mov	x14, x27
	b	LBB0_28
LBB0_27:                                ;   in Loop: Header=BB0_28 Depth=5
	add	x14, x14, #1
	add	x10, x10, #1
	add	x17, x17, x9
	add	x16, x16, x20
	cmp	x14, x15
	b.eq	LBB0_25
LBB0_28:                                ;   Parent Loop BB0_10 Depth=1
                                        ;     Parent Loop BB0_13 Depth=2
                                        ;       Parent Loop BB0_16 Depth=3
                                        ;         Parent Loop BB0_26 Depth=4
                                        ; =>        This Loop Header: Depth=5
                                        ;             Child Loop BB0_30 Depth 6
                                        ;             Child Loop BB0_33 Depth 6
	add	x8, x14, x26
	ldr	s0, [x24, x8, lsl #2]
	mul	x8, x10, x20
	add	x7, x6, x8
	add	x7, x23, x7, lsl #2
	add	x8, x2, x8
	add	x8, x23, x8, lsl #2
	cmp	x21, x7
	ccmp	x8, x25, #2, lo
	mov	x27, x1
	b.lo	LBB0_32
; %bb.29:                               ;   in Loop: Header=BB0_28 Depth=5
	dup.4s	v1, v0[0]
	mov	x8, x17
	mov	x27, x3
	mov	x7, x19
LBB0_30:                                ;   Parent Loop BB0_10 Depth=1
                                        ;     Parent Loop BB0_13 Depth=2
                                        ;       Parent Loop BB0_16 Depth=3
                                        ;         Parent Loop BB0_26 Depth=4
                                        ;           Parent Loop BB0_28 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldp	q2, q3, [x8, #-32]
	ldp	q4, q5, [x8], #64
	ldp	q6, q7, [x27, #-32]
	ldp	q16, q17, [x27]
	fmla.4s	v6, v2, v1
	fmla.4s	v7, v3, v1
	fmla.4s	v16, v4, v1
	fmla.4s	v17, v5, v1
	stp	q6, q7, [x27, #-32]
	stp	q16, q17, [x27], #64
	subs	x7, x7, #16
	b.ne	LBB0_30
; %bb.31:                               ;   in Loop: Header=BB0_28 Depth=5
	mov	x27, x28
	cmp	x0, x19
	b.eq	LBB0_27
LBB0_32:                                ;   in Loop: Header=BB0_28 Depth=5
	sub	x8, x30, x27
	add	x7, x13, x27
	add	x7, x22, x7, lsl #2
	add	x27, x27, x16
	add	x27, x23, x27, lsl #2
LBB0_33:                                ;   Parent Loop BB0_10 Depth=1
                                        ;     Parent Loop BB0_13 Depth=2
                                        ;       Parent Loop BB0_16 Depth=3
                                        ;         Parent Loop BB0_26 Depth=4
                                        ;           Parent Loop BB0_28 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ldr	s1, [x27], #4
	ldr	s2, [x7]
	fmadd	s1, s0, s1, s2
	str	s1, [x7], #4
	subs	x8, x8, #1
	b.ne	LBB0_33
	b	LBB0_27
LBB0_34:
	ldp	x29, x30, [sp, #192]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #176]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #160]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #144]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #128]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #112]            ; 16-byte Folded Reload
	add	sp, sp, #208
	ret
LBB0_35:
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
; %bb.36:
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
LBB0_37:
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
