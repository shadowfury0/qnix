OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(_start)

SECTIONS
{
	/*. = 0x100000 + SIZEOF_HEADERS;*/
	. = 0xc0100000 + SIZEOF_HEADERS;

	.text :{
		*(.text .stub .text.* .gnu.linkonce.t.*)
	}

	/*PROVIDE(etext = .);	 Define the 'etext' symbol to this value */

	.rodata : {
		*(.rodata .rodata.* .gnu.linkonce.r.*)
	}

	/* Include debugging information in kernel memory */
	.stab : {
		PROVIDE(__STAB_BEGIN__ = .);
		*(.stab);
		PROVIDE(__STAB_END__ = .);
	}

	.stabstr : {
		PROVIDE(__STABSTR_BEGIN__ = .);
		*(.stabstr);
		PROVIDE(__STABSTR_END__ = .);
	}

	/* Conventionally, Unix linkers provide pseudo-symbols
	 * etext, edata, and end, at the end of the text, data, and bss.
	 * For the kernel mapping, we need the address at the beginning
	 * of the data section, but that's not one of the conventional
	 * symbols, because the convention started before there was a
	 * read-only rodata section between text and data. */
	PROVIDE(data = .);

	/* The data segment */
	.data : {
		*(.data)
	}

	/*PROVIDE(edata = .);*/

	.bss : {
		*(.bss)
	}

	PROVIDE(kend = .);

	/DISCARD/ : {
		*(.eh_frame .note.GNU-stack)
	}

}

