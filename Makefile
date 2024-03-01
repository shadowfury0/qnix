.DEFAULT_GOAL := all
.PHONY: clean

CC = gcc
AS = as
LD = ld
OBJCOPY = objcopy
OBJDUMP = objdump
#qemu-system-i386
QEMU = qemu-system-i386

OS_IMG = qos.img

GDBPORT = 2500

MAGIC = echo -ne '\x55\xAA' | dd of=${OS_IMG} bs=1 seek=510 conv=notrunc

qemu:
	${QEMU} ${OS_IMG} -nographic
qemu-gdb:
	${QEMU} -nographic -S -hda ${OS_IMG}  -gdb tcp::$(GDBPORT)

all: 
	${AS} -gstabs boot.s -o boot.o
	${LD} -e main --oformat=binary -o ${OS_IMG} boot.o -Ttext=0x7c00
	${MAGIC}

clean:
	rm -f *.o *.bin *.elf qos.img
debug:
	gdb qos.img \
	-ex "target remote:${GDBPORT}"\
	-ex "b *0x7c00"\
	-ex "c"\
	-ex "layout asm"
