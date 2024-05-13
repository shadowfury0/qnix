#include "usr.h"

int
main(int argc)
{
    int pid = fork();
    if (pid > 0) {
        for(;;)
        {
            sleep(1);
            printf(pid);
        }
    }
    else if (pid == 0)
    {
        // for(;;)
        // {
            sleep(1);
            printf(pid);
        // }
        exit();
    }
    // exec("_SH         ",0);

    for(;;)
    {
    }
}
