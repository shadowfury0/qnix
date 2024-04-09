#include "usr.h"
int
exec(char* path,char** argv)
{
    char** s;

    for (s=argv;s<&argv[2];s++)
        vprintf("%s  ",*s);
    for(;;)
        ;
    // vprintf("%s--------\n",path);
    return -1;
}

int
sys_exec(void)
{
    return 0;
}