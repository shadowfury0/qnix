#include "usr.h"

void
main(void)
{
    // attention must volatile fork
    volatile int pid = fork();

    if (pid == 0)
    {
        for(;;)
        {
            // sleep(1);
            // time();
            printf(pid);
        }
    }
    else if (pid > 0) {
        for(;;)
        {
            // eax 返回值有问题
            // sleep(1);
            // time();
            printf(pid);
        }
    }

}