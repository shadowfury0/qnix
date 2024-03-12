.DEFAULT_GOAL := all

CC = gcc
CCOPTS = -O1 -fno-pic -nostdinc -I. -c -m32 -g
AS = as
LD = ld
LDOPTS = -m elf_i386 -N 
# -z common-page-size=8
OBJCOPY = objcopy
OBJDUMP = objdump
#qemu-system-i386
QEMU = qemu-system-i386
OS_IMG = qos.img
QEMUOPTS = -nographic -drive file=${OS_IMG},index=0,media=disk,format=raw -m 128 -smp ${CPUS}
CPUS = 1
GDBPORT = 2500
BOCHS	= 	bochs -f bochsrc.bxrc
MAGIC = echo -ne '\x55\xAA' | dd of=${OS_IMG} bs=1 seek=510 conv=notrunc
BOOT = 	boot.o bootmain.o 
KERNEL	 =  init.o\
			memory.o\
			console.o

BOOT_SOURCE = bootsource

qemu: all
	${QEMU} ${QEMUOPTS}
qemu-gdb: source
	${QEMU} -S ${QEMUOPTS} -gdb tcp::$(GDBPORT)
qemu-vnc: all
	${QEMU} ${OS_IMG} -vnc 192.168.88.128:5900

#如果是bochs硬盘创建就有点不同
bochs-img:
ifneq ($(wildcard ${OS_IMG}),)
	rm -f ${OS_IMG}
endif 
	bximage -mode=create -hd=10 -imgmode=flat -q ${OS_IMG}
# bximage -mode=create -fd=1.44M -imgmode=flat -q ${OS_IMG}

bochs: bochs-img all
	${BOCHS} -q 'gdbstub: enabled=0'
bochs-gdb: bochs-img source
	${BOCHS}

#启动扇区的代码部分
bootsector:boot.ld
	${CC} boot.S ${CCOPTS} -o boot.o
	${CC} bootmain.c ${CCOPTS} -o bootmain.o  
	${LD} ${LDOPTS} -e _start --oformat=binary -o boots.o ${BOOT} -Ttext=0x7c00
	dd if=boots.o of=${OS_IMG} bs=512 conv=notrunc
	${MAGIC}

kernel:kernel.ld
	${CC} init.c ${CCOPTS} -o init.o
	${CC} memory.c ${CCOPTS} -o memory.o
	${CC} console.c ${CCOPTS} -o console.o
	${LD} ${LDOPTS} -T kernel.ld -e init -o kernel.o ${KERNEL} 
# ${CC} entry.S ${CCOPTS} -o entry.o
# ${LD} ${LDOPTS} -e entry --oformat=binary -o kernel.o ${KERNEL}
	dd if=kernel.o of=${OS_IMG} bs=512 seek=1 conv=notrunc
#默认
all: bootsector kernel 

source:all
	${LD} ${LDOPTS} -T boot.ld -e _start -o ${BOOT_SOURCE} ${BOOT} -Ttext=0x7c00
# ${LD} ${LDOPTS} -T kernel.ld -o kernelsource ${KERNEL} -Ttext=0x100000
	${OBJDUMP} -d -M att ${BOOT_SOURCE} > boots.asm
	${OBJDUMP} -d -M att kernel.o > kernel.asm
clean:
	rm -f *.o *.tags *.log qos.img ${BOOT_SOURCE} boots.asm kernel.asm

#use this command with bochs-gdb
debug:
	gdb -ex "target extended-remote localhost:${GDBPORT}"  -ex "file kernel.o" 
# -ex "file ${BOOT_SOURCE}"

.PHONY: clean source bochs-img kernel
