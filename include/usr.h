// kernel function declaretion for user init
int exit(void);
int fork(void);
int wait(void);
int yield(void);
int getpid(void);
int exec(char*,char**);
int time(void);
int sleep(uint);

// test
int printf(uint);


#define SYSCALL(name) \
volatile int name(void) \
{\
int res;\
__asm__ volatile (\
	"pusha;int $0x80;popa;" \
	: "=a" (res) \
	: "a" (SYS_##name) \
); \
return (int) res; \
}

#define SYSCALL1(name,t1,arg1) \
volatile int name(t1 arg1) \
{\
int res;\
__asm__ volatile ("pusha;int $0x80;popa;" \
	: "=a" (res) \
	: "a" (SYS_##name),"b" ((t1)(arg1)) \
	); \
return (int) res; \
}

#define SYSCALL2(name,t1,arg1,t2,arg2) \
volatile int name(t1 arg1,t2 arg2) \
{\
int res;\
__asm__ volatile ("int $0x80;" \
	: "=a" (res) \
	: "a" (SYS_##name),"b" ((t1)(arg1)),"c"((t2)(arg2)) \
	);\
if (res >= 0) return (int) res; \
return -1; \
}