.DEFAULT_GOAL := all
OBJS = 	kernel.ld\
		idt.S\
		init.c\
		trap.c\
		kyb.c\
		memory.c\
		console.c\

CC = gcc
CCOPTS = -O1 -fno-pic -fno-stack-protector -nostdinc -I../include -c -m32  -w
LD = ld
KERNEL_SOURCE = kernelsource
LDOPTS = -m elf_i386 -N 
OBJCOPY = objcopy
OBJDUMP = objdump
KERNEL	 =  init.o\
			idt.o\
			trap.o\
			kyb.o\
			memory.o\
			console.o\

#all strategy
compile:
	${CC} idt.S ${CCOPTS} -o idt.o
	${CC} init.c ${CCOPTS} -o init.o
	${CC} trap.c ${CCOPTS} -o trap.o
	${CC} memory.c ${CCOPTS} -o memory.o
	${CC} kyb.c ${CCOPTS} -o kyb.o
	${CC} console.c ${CCOPTS} -o console.o

all:OBJS compile
	${LD} ${LDOPTS} -T kernel.ld -e init -o kernel.o ${KERNEL}

# magic !!!
gdb: CCOPTS += -g
gdb:compile
	${LD} ${LDOPTS} -T kernel.ld -e init -o ${KERNEL_SOURCE} ${KERNEL}
	${OBJCOPY} --strip-debug ${KERNEL_SOURCE} kernel.o 
	${OBJDUMP} -d -M att kernel.o > kernel.asm

clean:
	rm -f *.o kernel.asm KERNEL_SOURCE


.PHONY: clean OBJS gdb all
