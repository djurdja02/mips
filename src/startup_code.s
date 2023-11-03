.cpu cortex-m3
.fpu softvfp
.syntax unified
.thumb

.extern _main_stack_pointer
.extern _vma_start_adr_
.extern _vma_end_adr_
.extern _lma_start_adr_
.extern main
.extern test5

.weak systick_handler
.thumb_set systick_handler, default_handler

.section .vector_table , "a"
.word _main_stack_pointer
.word reset_handler
.rept 12
	.word default_handler
.endr
.word test5
.word systick_handler
.rept 68
	.word default_handler
.endr

.section .text.reset_handler
.type reset_handler, %function
reset_handler:
	ldr r0,=_lma_start_adr_
	ldr r1,=_vma_start_adr_
	ldr r2,=_vma_end_adr_

	cmp r1,r2
	beq bmain
copy_loop:
	ldr r3, [r0],4
	str r3, [r1],4

	cmp r1,r2
	blo copy_loop
bmain:
	b main
.section .text.default_handler
.type default_handler, %function
default_handler:
	b default_handler
.end
