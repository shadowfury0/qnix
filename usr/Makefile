.DEFAULT_GOAL := all

SYSCALL = usys.c

CC = gcc
CCOPTS = -O2 -fno-pic -fno-stack-protector -nostdinc -I../include/  -c -m32 -w
LD = ld
LDOPTS = -m elf_i386 -N 
OBJCOPY = objcopy
OBJDUMP = objdump

# all:CCOPTS += -g
all:
	${CC} ${SYSCALL} ${CCOPTS} -o usys.o

	${CC} init.c ${CCOPTS} -o init.o
	${LD} ${LDOPTS} -T usr.ld -o _INIT usys.o init.o

# ${CC} test.c ${CCOPTS} -o test.o
# ${LD} ${LDOPTS} -T usr.ld -o _TEST usys.o test.o

clean:
	rm -f *.o _*

.PHONY: clean all test