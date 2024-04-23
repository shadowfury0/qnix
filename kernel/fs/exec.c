#include "types.h"
#include "io.h"
#include "mmu.h"
#include "dev/ide.h"
#include "fs/fat.h"

static int
count(char** argv)
{
    char** s;
    uint i;
    // the last value is 0
    for (s=argv;*s != 0;s++,i++);
    return i;
}

struct fat_info f;

int
exec(uint eip,char* path,char** argv)
{
    // init fat code
    f.index = 1;
    fat_init(&f);

    uint p = PGROUNDUP(f.fat_size*f.bpb.bytes_per_sector);
    char* d = kalloc(p);
    fat_root_directory(&f,d);
    kfree(d,p);

    for(;;)
        ;

    return -1;
}
