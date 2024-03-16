// 该函数用来显示内核中出现重大错误信息，并运行文件系统同步函数，然后进入
// 死循环——死机。如果当前进程是任务0的话，还说明是交换任务出错，
// 并且还没有运行文件系统同步函数。函数名前的关键字 volatile 用于告诉编译器gcc
// 该函数不会返回。这样可以让gcc产生更好的代码，更重要的是使用这个关键字可以避免
// 产生某些（未初始化变量的）假警告信息。
// 等同于现在gcc的函数属性说明：void panic(const char *s) __attribute__((noreturn));
volatile void
panic(const char* s)
{
    vprintf(s);
    asm volatile("cli");
    for(;;);
}