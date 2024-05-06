// ELF32 Header Structure
#define     ELF32_MAGIC  0x464c457f

struct elf32_hdr {
    uint      e_magic;            // ELF identification
    uchar     e_elf[12];          // Other parts of the ELF header
    ushort    e_type;             // Object file type
    ushort    e_machine;          // Target architecture
    uint      e_version;          // Object file version
    uint      e_entry;            // Entry point virtual address
    uint      e_phoff;            // Program header table offset in the file
    uint      e_shoff;            // Section header table offset in the file
    ushort    e_flags;            // Processor-specific flags
    ushort    e_ehsize;           // Size of the ELF header
    ushort    e_phentsize;        // Size of a program header table entry
    ushort    e_phnum;            // Number of entries in the program header table
    ushort    e_shentsize;        // Size of a section header table entry
    ushort    e_shnum;            // Number of entries in the section header table
    ushort    e_shstrndx;         // Index of the section header string table
};
