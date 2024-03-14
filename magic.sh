#! /bin/bash
# 只能通过间接方式直接方式在makefile中不行
echo -ne '\x55\xAA' | dd of=qos.img bs=1 seek=510 conv=notrunc