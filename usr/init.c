#include "usr.h"

void
main(void)
{
<<<<<<< HEAD
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

=======
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
>>>>>>> 908ebe526930f5c722e4a4d266951b309b059a3d
}