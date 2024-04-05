#include "types.h"
#include "io.h"

extern void exit(void);
void
umain(void){
    // vprintf("enter user space\n");
    int n, pid;

    for(n=0; n<2; n++){
        pid = fork();
        if(pid < 0) {
            break;
        }
        else if(pid == 0) {
            procdump();
            vprintf("child\n");
            exit();
        }
        else {
            vprintf("father\n");
        }
    }
    exit();
}