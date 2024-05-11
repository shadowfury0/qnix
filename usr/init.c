#include "usr.h"

int
main(void)
{
    int pid = fork();

    if (pid == 0)
    {
        for(;;)
        {
            sleep(1);
            printf(pid);
        }
    }
    else if (pid > 0) {
        for(;;)
        {
            sleep(1);
            printf(pid);
        }
    }
    for(;;)
        ;
}
