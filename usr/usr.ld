OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(main)

/* user program general linker */
SECTIONS
{
	/*. = 0x100000 + SIZEOF_HEADERS;*/
	. = 0x0 + SIZEOF_HEADERS;

	.text :{
		*(.text .stub .text.* .gnu.linkonce.t.*)
	}

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

	/* The data segment */
	.data : {
		*(.data)
	}

	.bss : {
		*(.bss)
	}

	PROVIDE(kend = .);

	/DISCARD/ : {
		*(.eh_frame .note.GNU-stack)
	}

}
