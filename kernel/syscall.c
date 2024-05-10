#include "types.h"
#include "mmu.h"
#include "syscall.h"

<<<<<<< HEAD
extern  int   sys_fork(void);
extern  int   sys_exit(void);
extern  int   sys_wait(void);
extern  int   sys_yield(void);
extern  int   sys_exec(void);
extern  int   sys_time(void);
extern  int   sys_getpid(void);
extern  int   sys_sleep(void);
extern  int   sys_printf(void);
=======
extern  int sys_fork(void);
extern  int sys_exit(void);
extern  int sys_wait(void);
extern  int sys_yield(void);
extern  int sys_exec(void);
extern  int sys_time(void);
extern  int sys_getpid(void);
extern  int sys_printf(void);
>>>>>>> 908ebe526930f5c722e4a4d266951b309b059a3d

int (*syscall_table[])(void) = {
    [SYS_exit]      sys_exit,
    [SYS_fork]      sys_fork,
    [SYS_wait]      sys_wait,
    [SYS_yield]     sys_yield,
    [SYS_exec]      sys_exec, 
    [SYS_time]      sys_time, 
    [SYS_getpid]    sys_getpid,
<<<<<<< HEAD
    [SYS_sleep]     sys_sleep,
=======
>>>>>>> 908ebe526930f5c722e4a4d266951b309b059a3d
    // test
    [SYS_printf]    sys_printf,
};
// define ths syscall_table_size
uint  syscall_table_size = NELEM(syscall_table);