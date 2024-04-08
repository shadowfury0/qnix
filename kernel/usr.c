#include "types.h"
#include "io.h"
#include "usr.h"

void
kk(void)
{
    int pid;
    pid = fork();
    if (pid < 0) {
        return;
    }
    if (pid >0) {
        for (;;)
        {
            vprintf("fahter running\n");
            sleep(2);
            printdate();
        }
    }
    else {
        for (;;)
        {
            vprintf("child running\n");
            sleep(2);
        }
        // exit();
    }
}

char *argv[] = { "sh", 0 };

void
umain(void)
{
    volatile int pid;
    int upid;
    for (;;) {
        vprintf("user init: starting sh\n");
        pid = fork();
        if (pid < 0) {
            vprintf("user init error\n");
            exit();
        }
        else if (pid == 0) {
            exec("sh",argv);
            vprintf("init sh failed\n");
            exit();
        }
        for (;;)
            if ((upid = wait())) vprintf("pid:%d zombie!\n",upid);
    }

    exit();
}