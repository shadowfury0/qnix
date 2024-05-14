#include "usr.h"

int
main(int argc)
{
    int pid = fork();
    if (pid > 0) {
        wait();
        for(;;)
        {
            sleep(1);
            yield();
            printf(pid);
        }
    }
    else if (pid == 0)
    {
        sleep(1);
        printf(pid);
        exit();
    }
    // exec("_SH         ",0);

}
