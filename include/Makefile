.DEFAULT_GOAL := all
INDS = 	elf32.h\
		idt.h\
		io.h\
		mmu.h\
		type.h\
		proc.h\
		syscall.h\
		tty.h\
		types.h\
		usr.h\

all:INDS
	${MAKE} -C dev
	${MAKE} -C fs

.PHONY: INDS all