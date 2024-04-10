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
    [SYS_FORK]  sys_fork,
    [SYS_EXIT]  sys_exit,
    [SYS_WAIT]  sys_wait,
    [SYS_GPID]  sys_getpid,
    [SYS_EXEC]  sys_exec, 
    [SYS_TIME]  sys_time,    
};
// define ths syscall_table_size
uint  syscall_table_size = NELEM(syscall_table);