#include "type.h"
// ELF32 头部结构体
#define ELF32_MAGIC  0x464c457f

struct elf32_hdr {
    uint      e_magic;            // ELF 标识
    uchar     e_elf[12];          // ELF头其他部分
    ushort    e_type;             // 对象文件类型
    ushort    e_machine;          // 目标体系结构
    uint      e_version;          // 对象文件版本
    uint      e_entry;            // 程序入口点的虚拟地址
    uint      e_phoff;            // 程序头表在文件中的偏移
    uint      e_shoff;            // 节头表在文件中的偏移
    ushort    e_flags;            // 处理器特定标志
    ushort    e_ehsize;           // ELF 头的大小
    ushort    e_phentsize;        // 程序头表项大小
    ushort    e_phnum;            // 程序头表中的项数
    ushort    e_shentsize;        // 节头表项大小
    ushort    e_shnum;            // 节头表中的项数
    ushort    e_shstrndx;         // 节头表字符串表的索引
};
