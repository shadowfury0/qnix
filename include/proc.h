#define TASK_NAME_LEN   16

//process table size
#define PT_SIZE         16

struct tss {
    uint link;
    uint _unused1;
    uint esp0;
    ushort ss0;
    ushort _unused2;
    uint esp1;
    ushort ss1;
    ushort _unused3;
    uint esp2;
    ushort ss2;
    ushort _unused4;
    uint cr3;
    uint eip;
    uint eflags;
    uint eax, ecx, edx, ebx;
    uint esp, ebp, esi, edi;
    ushort es, _es_unused;
    ushort cs, _cs_unused;
    ushort ss, _ss_unused;
    ushort ds, _ds_unused;
    ushort fs, _fs_unused;
    ushort gs, _gs_unused;
    ushort ldt_selector, _ldt_sel_unused;
    ushort _unused5;
    ushort iomap_base;
};

enum procstate { UNUSED, EMBRYO, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };

struct proc {
    volatile enum procstate state;                
    uint pid;
    uint reip;  //return eip
    // char* stack;
    struct  proc*  parent;  
    // struct gatedesc* ldt;       // ldt address
    // char comm[TASK_NAME_LEN];
    struct tss tss;
};