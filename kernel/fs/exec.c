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
struct fat_dir rd;

int
exec(uint eip,char* path,char** argv)
{
    // init fat code
    f.index = 1;
    fat_init(&f);
    fat_rootdir_init(&f);
    rd.file_size = 2000;
    rd.name[0] = 'a';

    fat_test(&f,&rd);
    for(;;)
        ;

    return -1;
}
