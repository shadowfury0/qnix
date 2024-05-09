#include "usr.h"
#include "syscall.h"

SYSCALL(fork)
SYSCALL(exit)
SYSCALL(wait)
SYSCALL(yield)
SYSCALL(time)
SYSCALL(getpid)

SYSCALL1(printf,int,c)

SYSCALL2(exec,char*,path,char**,argv)