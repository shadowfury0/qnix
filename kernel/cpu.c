#include "type.h"
// cpuid 指令的函数封装
void 
cpuid(unsigned int op, unsigned int *eax, unsigned int *ebx, unsigned int *ecx, unsigned int *edx)
{
	*eax = op;
	*ecx = 0;
	asm volatile("cpuid"
	    : "=a" (*eax),
	      "=b" (*ebx),
	      "=c" (*ecx),
	      "=d" (*edx)
	    : "0" (*eax), "2" (*ecx)
	    : "memory");
}

// print the cpu info message
void
cpuinfo(void)
{
	uint a = 0;
    char s[13];
    s[12] = '\0';
    cpuid(0,&a,&s[0],&s[4],&s[8]);
    vprintf("%s ",s);
    cpuid(0x80000002,&a,&s[0],&s[4],&s[8]);
    vprintf("%s ",s);
    cpuid(0x80000003,&a,&s[0],&s[4],&s[8]);
    vprintf("%s \n",s);
}
