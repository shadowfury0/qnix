#include "usr.h"
#include "syscall.h"

SYSCALL(fork)
SYSCALL(exit)
SYSCALL(wait)
SYSCALL(yield)
SYSCALL(time)
SYSCALL(getpid)

<<<<<<< HEAD
SYSCALL1(sleep,int,t)
SYSCALL1(printf,int,arg)
=======
SYSCALL1(printf,int,c)
>>>>>>> 908ebe526930f5c722e4a4d266951b309b059a3d

SYSCALL2(exec,char*,path,char**,argv)