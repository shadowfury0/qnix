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
        // wait();
    }
    else {
        vprintf("==============\n");
        exit();
    }
}

void
umain(void)
{
    // vprintf("enter user space\n");
    // int n;
    // for(n=0; n<4; n++){
    //     kk();
    // }
    volatile int pid;
    pid = fork();
    
    if (pid > 0) {
        for(;;) {
            stihlt();
            // printdate();
	        keyputc();
        }
    }
    else {
        for(;;) {
            stihlt();
            printdate();
	        keyputc();
        }
    }

    for(;;)
        ;
    exit();
}