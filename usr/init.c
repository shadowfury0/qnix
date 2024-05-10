#include "usr.h"

void
main(void)
{
    int pid = fork();
    if (pid == 0)
    {
        printf(pid);
        exit();
    }
    else if (pid > 0) {
        // int n = yield();
        // time();
        // exit();
        printf(pid);
    }
    for(;;)
        ;
}