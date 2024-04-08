#include "usr.h"
int
exec(char* path,char** argv)
{
    char** s;

    for (s=argv;s<&argv[2];s++)
        vprintf("%s  ",*s);
    // vprintf("%s--------\n",path);
    return -1;
}