.DEFAULT_GOAL := all

SYSCALL = usys.c

CC = gcc
CCOPTS = -O1 -fno-pic -fno-stack-protector -nostdinc -I../include/  -c -m32 -w
LD = ld
LDOPTS = -m elf_i386 -N 
OBJCOPY = objcopy
OBJDUMP = objdump

debug:
	objdump -d -M att _INIT > init.asm
	
# all:CCOPTS += -g
all:
	${CC} ${SYSCALL} ${CCOPTS} -o usys.o

	${CC} init.c ${CCOPTS} -o init.o
	${LD} ${LDOPTS} -T usr.ld -o _INIT usys.o init.o

	${CC} sh.c ${CCOPTS} -o sh.o
	${LD} ${LDOPTS} -T usr.ld -o _SH usys.o sh.o


clean:
	rm -f *.o _*

.PHONY: clean all test