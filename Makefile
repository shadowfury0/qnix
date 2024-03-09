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
USR	 =  console.o

qemu: all
	${QEMU} ${QEMUOPTS}
qemu-gdb: all
	${LD} ${LDOPTS} -T kernel.ld -o kernel ${BOOT}
	${QEMU} -S ${QEMUOPTS} -gdb tcp::$(GDBPORT)
qemu-vnc: all
	${QEMU} ${OS_IMG} -vnc 192.168.88.128:5900

#如果是bochs硬盘创建就有点不同
bochs-img:
ifeq ($(wildcard ${OS_IMG}),)
	bximage -mode=create -hd=10 -imgmode=flat -q ${OS_IMG}
else 
	bximage -mode=resize -hd=10 -imgmode=flat -q ${OS_IMG}
endif

bochs: all bochs-img
	${BOCHS} -q 'gdbstub: enabled=0'
bochs-gdb: bochs-img all  
	${LD} ${LDOPTS} -T kernel.ld -o kernel ${BOOT}
	${BOCHS}

#启动扇区的代码部分
bootsector: 
	${CC} boot.S ${CCOPTS} -o boot.o
	${CC} bootmain.c ${CCOPTS} -o bootmain.o  
	${LD} ${LDOPTS} -e _start --oformat=binary -o kernel.o ${BOOT} -Ttext=0x7c00
	dd if=kernel.o of=${OS_IMG} bs=512 conv=notrunc
	${MAGIC}
# objcopy -O binary -j .text -j .data kernel.o ${OS_IMG}

usrsector:
	${CC} console.c ${CCOPTS} -o console.o
	${LD} ${LDOPTS} --oformat=binary -o usr.o ${USR}
	dd if=usr.o of=${OS_IMG} bs=512 seek=1 conv=notrunc
#默认
all: bootsector usrsector 

kernel:
	objdump -d -M att kernel > 1.txt
clean:
	rm -f *.o *.tags *.log qos.img kernel

#use this command with bochs-gdb
debug:
	gdb -ex "target extended-remote localhost:${GDBPORT}" -ex "file kernel"



.PHONY: clean kernel bochs-img
