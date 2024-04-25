.DEFAULT_GOAL := all
CC = gcc
CCOPTS = -O1 -fno-pic -fno-stack-protector -nostdinc -I../../include -I../../include/fs -I../../include/dev -c -m32  -w
LD = ld
KERNEL_SOURCE = kernelsource
LDOPTS = -m elf_i386 -N 
OBJCOPY = objcopy
OBJDUMP = objdump

OBJS = 	exec.c\
 		ext2.c\
		fat.c\
		fs.c\
	
all:OBJS
	${CC} exec.c ${CCOPTS} -o exec.o
	${CC} ext2.c ${CCOPTS} -o ext2.o
	${CC} fat.c ${CCOPTS} -o fat.o
	${CC} fs.c ${CCOPTS} -o fs.o
	
gdb: CCOPTS += -g
gdb: all

clean:
	rm -f *.o


.PHONY: clean OBJS gdb all
