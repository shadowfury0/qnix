#include "types.h"
#include "io.h"

extern void exit(void);
void
kk(void)
{
    int pid;
    pid = fork();
    if (pid < 0) {
        return;
    }
    if (pid >0) {
        vprintf("--------------%d \n",pid);
    }
    else {
        vprintf("==============\n");
        exit();
    }
}

void
umain(void){
    // vprintf("enter user space\n");
    int n;
    volatile int pid;
    // for(n=0; n<4; n++){
    //     kk();
    // }
    // yield();

    // pid = fork();
    
    // if (pid > 0) {
    //     vprintf("--------------\n");
    //     yield();
    //     vprintf("xxxxxxxxxxxxxx\n");
    // }
    // else {
    //     vprintf("aaaaaaaaaaaaaaa\n");
    //     exit();
    // }

    for(;;)
        ;
    exit();
}