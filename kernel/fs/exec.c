#include "types.h"

static int
count(char** argv)
{
    char** s;
    uint i;
    // the last value is 0
    for (s=argv;*s != 0;s++,i++);
    return i;
}

#include "io.h"

int
exec(uint eip,char* path,char** argv)
{

    vprintf(" %d \n",count(argv));
    for(;;)
    {
        stihlt();
        printdate();
        // keyputc();
    }
    return -1;
}