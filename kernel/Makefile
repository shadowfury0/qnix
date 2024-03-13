.DEFAULT_GOAL := all
OBJS = 	kernel.ld\
		idt.S\
		init.c\
		trap.c\
		memory.c\
		console.c\

CC = gcc
CCOPTS = -O1 -fno-pic -nostdinc -I../include -c -m32  -w
LD = ld
LDOPTS = -m elf_i386 -N 
OBJCOPY = objcopy
OBJDUMP = objdump
KERNEL	 =  init.o\
			idt.o\
			trap.o\
			memory.o\
			console.o\

#all strategy
all:OBJS
	${CC} idt.S ${CCOPTS} -o idt.o
	${CC} init.c ${CCOPTS} -o init.o
	${CC} trap.c ${CCOPTS} -o trap.o
	${CC} memory.c ${CCOPTS} -o memory.o
	${CC} console.c ${CCOPTS} -o console.o
	${LD} ${LDOPTS} -T kernel.ld -e init -o kernel.o ${KERNEL} 

# magic !!!
gdb: CCOPTS += -g
gdb: all
	${OBJDUMP} -d -M att kernel.o > kernel.asm

clean:
	rm -f *.o kernel.asm


.PHONY: clean OBJS gdb
