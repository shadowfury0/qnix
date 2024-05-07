.DEFAULT_GOAL := all

SYSCALL = usys.S

CC = gcc
CCOPTS = -O2 -fno-pic -fno-stack-protector -nostdinc -I../include/  -c -m32 -w
LD = ld
LDOPTS = -m elf_i386 -N 
OBJCOPY = objcopy
OBJDUMP = objdump

all:
	${CC} usys.S ${CCOPTS} -o usys.o
	${CC} test.c ${CCOPTS} -o test.o

test:CCOPTS += -g
test:all
	${LD} ${LDOPTS} -T usr.ld -o _TEST usys.o test.o
# ${OBJDUMP} -d -M att _TEST > test.asm

clean:
	rm -f *.o

.PHONY: clean all test