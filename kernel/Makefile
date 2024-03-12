.DEFAULT_GOAL := all
OBJS = 	kernel.ld\
		console.c\
		init.c\
		memory.c\

CC = gcc
CCOPTS = -O1 -fno-pic -nostdinc -I. -I../include -c -m32  -w
LD = ld
LDOPTS = -m elf_i386 -N 
OBJCOPY = objcopy
OBJDUMP = objdump
KERNEL	 =  init.o\
			memory.o\
			console.o

#all strategy
all:OBJS
	${CC} init.c ${CCOPTS} -o init.o
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
