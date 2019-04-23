	.global _start

	.text
	.section .text.start, "ax"

	/* entry point from boot loader */
_start:
	/*
	 * copy .data and clear .bss
	 */
	la		a0, __rom_data_start
	la		a1, __data_start
	la		a2, __data_end

1:	lw		t0, 0(a0)
	addi	a0, a0, 4
	sw		t0, 0(a1)
	addi	a1, a1, 4
	bltu	a1, a2, 1b

	la		a2, __bss_end

2:	sw		zero, 0(a1)
	addi	a1, a1, 4
	bleu	a1, a2, 2b

	/* ... invoke C level, put invalid return address on stack */
	la		sp, __stack_end

	/* invalidate thread pointer, return address and frame pointer */
	li		tp, 0
	li		ra, 0
	li		s0, 0

	/* continue in C code -> void main(void) */
	tail	main
	/* does not return */

