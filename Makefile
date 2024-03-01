.DEFAULT_GOAL := all
.PHONY: clean

CC = gcc
AS = as
LD = ld
OBJ = objcopy
#qemu-system-i386
QEMU = qemu-system-x86_64

qemu:
	${QEMU} boot.img --nographic

all:
	${AS} boot.s -o boot.o
	${LD} -e main --oformat=binary -o boot.bin boot.o -Ttext=0x7c00

clean:
	rm -f *.o *.bin *.elf