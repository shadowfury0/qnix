#include "types.h"
#include "io.h"

extern void exit(void);
void
kk(void)
{
    int pid;
    
}

void
umain(void){
    // vprintf("enter user space\n");
    int n, pid;
    // for(n=0; n<4; n++){
    //     // kk();
    // }
    pid = fork();
    if (pid >0) {
        vprintf("---------\n");
        wait();
        vprintf("---------\n");
    }
    else {
        vprintf("==============\n");
        exit();
    }
    vprintf("aaaaaaaaaaaa\n");
    exit();
}