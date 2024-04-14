.DEFAULT_GOAL := all
CC = gcc
CCOPTS = -O1 -fno-pic -fno-stack-protector -nostdinc -I../../include   -c -m32  -w
LD = ld
KERNEL_SOURCE = kernelsource
LDOPTS = -m elf_i386 -N 
OBJCOPY = objcopy
OBJDUMP = objdump

OBJS = exec.c\
	
all:OBJS
	${CC} exec.c ${CCOPTS} -o exec.o
	
gdb: CCOPTS += -g
gdb: all

clean:
	rm -f *.o


.PHONY: clean OBJS gdb all
