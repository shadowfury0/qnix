#include "types.h"
#include "syscall.h"
#include "mmu.h"

extern  int sys_fork(void);
extern  int sys_exit(void);
extern  int sys_wait(void);
extern  int sys_getpid(void);
extern  int sys_exec(void);
extern  int sys_time(void);

int (*syscall_table[])(void) = {
    [SYS_fork]  sys_fork,
    [SYS_exit]  sys_exit,
    [SYS_wait]  sys_wait,
    [SYS_gpid]  sys_getpid,
    [SYS_exec]  sys_exec, 
    [SYS_time]  sys_time,    
};
// define ths syscall_table_size
uint  syscall_table_size = NELEM(syscall_table);