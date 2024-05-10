// kernel function declaretion for user init
int exit(void);
int yield(void);
int fork(void);
int exec(char*,char**);
int time(void);
<<<<<<< HEAD
int sleep(uint);
=======
>>>>>>> 908ebe526930f5c722e4a4d266951b309b059a3d

// test
int printf(uint);


#define SYSCALL(name) \
<<<<<<< HEAD
volatile int name(void) \
=======
int name(void) \
>>>>>>> 908ebe526930f5c722e4a4d266951b309b059a3d
{\
int res;\
__asm__ volatile ("int $0x80" \
	: "=a" (res) \
	: "0" (SYS_##name)); \
if (res >= 0) return (int) res; \
return -1; \
}

#define SYSCALL1(name,t1,arg1) \
<<<<<<< HEAD
volatile int name(t1 arg1) \
{\
int res;\
__asm__ volatile ("int $0x80;" \
=======
int name(t1 arg1) \
{\
int res;\
__asm__ volatile ("int $0x80" \
>>>>>>> 908ebe526930f5c722e4a4d266951b309b059a3d
	: "=a" (res) \
	: "0" (SYS_##name),"c" ((t1)(arg1))); \
if (res >= 0) return (int) res; \
return -1; \
}

#define SYSCALL2(name,t1,arg1,t2,arg2) \
<<<<<<< HEAD
volatile int name(t1 arg1,t2 arg2) \
{\
int res;\
__asm__ volatile ("int $0x80;" \
=======
int name(t1 arg1,t2 arg2) \
{\
int res;\
__asm__ volatile ("int $0x80" \
>>>>>>> 908ebe526930f5c722e4a4d266951b309b059a3d
	: "=a" (res) \
	: "0" (SYS_##name),"c" ((t1)(arg1)),"d"((t2)(arg2)) ); \
if (res >= 0) return (int) res; \
return -1; \
}