#include "types.h"
#include "io.h"
#include "mmu.h"
#include "dev/ide.h"
#include "fs/fat.h"
#include "fs/fs.h"

static int
count(char** argv)
{
    char** s;
    uint i;
    // the last value is 0
    for (s=argv;*s != 0;s++,i++);
    return i;
}

struct fdir  root;

int
exec(uint eip,char* path,char** argv)
{
    sti();
    sleep(1);
    
    fat_init(&root,1,"root");
    // fat_create(&root,"tmp",2048,FT_DIR);

    fat_delete(&root,"b.txt");
    fat_create(&root,"b.txt",2048,FT_FILE);

    // fat_create(&root,"a.txt",4096,FT_FILE);
    fat_init_fdir(&root);
    
    // fat_create(root.cur[2].p->cur[2].p,"c.txt",2048,FT_FILE);

    // fat_create(root.cur[2].p,"opt",2048,FT_DIR);
    // fat_create(root.cur[2].p,"a.txt",2048,FT_FILE);
    // fnode_dump(&root.cur[2].p->cur[2]);

    // fs_ls(&root);
    // fs_tree(&root,0);

    // char* buf = alloc_page();
    // char* nn = "vvddds"; 
    // fat_read(&root,"A           ",buf,7);
    // fat_write(&root,"A           ",nn,6);
    // vprintf("%d \n",buf[1]);
    // free_page(buf);
    

    // fat_delete(&root,"tmp");

    // fnode_dump(&root.cur[2].p->cur[2].p->cur[2]);
    fat_clean(1);

    for(;;)
        ;

    return -1;
}
