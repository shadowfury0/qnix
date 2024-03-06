.DEFAULT_GOAL := all

CC = gcc
CCOPTS = -O1 -fno-pic -nostdinc -I. -c -m32
AS = as
LD = ld
LDOPTS = -m elf_i386
OBJCOPY = objcopy
OBJDUMP = objdump
#qemu-system-i386
QEMU = qemu-system-i386
OS_IMG = qos.img
QEMUOPTS = -nographic -drive file=${OS_IMG},index=0,media=disk,format=raw -m 128 -smp ${CPUS}
CPUS = 1
GDBPORT = 2500

MAGIC = echo -ne '\x55\xAA' | dd of=${OS_IMG} bs=1 seek=510 conv=notrunc
OBJS = 	boot.o \
		bootmain.o \
		console.o \
		io.o 
qemu: all
	${QEMU} ${QEMUOPTS}
qemu-gdb: all
	${QEMU} -S ${QEMUOPTS} -gdb tcp::$(GDBPORT)
qemu-vnc: all
	${QEMU} ${OS_IMG} -vnc 192.168.88.128:5900
bochs: all
	bochs -f bochsrc.bxrc
all: 
	${CC} io.c ${CCOPTS} -o  io.o
	${CC} console.c ${CCOPTS} -o console.o
	${CC} boot.S ${CCOPTS} -o boot.o
	${CC} bootmain.c ${CCOPTS} -o bootmain.o
	${LD} ${LDOPTS} -e _start --oformat=binary -o ${OS_IMG} \
	${OBJS} -Ttext=0x7c00
	${MAGIC}

clean:
	rm -f *.o *.tags *.bin *.elf qos.img
debug:
	gdb qos.img \
	-ex "target remote:${GDBPORT}"\
	-ex "b *0x7c00"\
	-ex "c"\
	-ex "layout asm"

.PHONY: clean
