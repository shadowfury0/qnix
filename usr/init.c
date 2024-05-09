#include "usr.h"

void
main(void)
{
    int pid = fork();
    if (pid == 0)
    {
        exit();
    }
    else if (pid > 0) {
        int n = yield();
        printf(pid);
    }
    for(;;)
        ;
}