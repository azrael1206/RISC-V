ENTRY(_start)

PHDRS
{
	ROM PT_LOAD FLAGS(5);
	RAM PT_LOAD FLAGS(6);
}

SECTIONS
{
	.text 0x00000000 : {
		*(.text.start)
		*(.text)
		*(.text.*)
	} : ROM

	.rodata : {
		*(.rodata)
		*(.rodata.*)
		*(.rodata1)

		/* initialized data is placed right behind the text segment */
		. = ALIGN(16);
		__rom_data_start = .;
	} : ROM

	.data 0x00008000 : AT (__rom_data_start) {
		__ram_data_start = .;
		__data_start = .;
		*(.data)
		*(.data.*)
		*(.data1)
		. = ALIGN(16);
		__data_end = .;
		__rom_data_end = . - ABSOLUTE(__ram_data_start) + __rom_data_start;
	} : RAM

	.bss ALIGN(16) : {
		__bss_start = .;
		*(.bss)
		*(.bss.*)
		*(COMMON)

		/* stack area */
		. = ALIGN(16);
		__stack = .;
		. += 0x1000;
		__stack_end = .;
		__bss_end = .;
	} : NONE

	/DISCARD/ : {
		*(.eh_frame)
	}
}
