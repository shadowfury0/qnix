// This function is used to display significant 
// error messages in the kernel, run the file system synchronization function, and then enter
// Dead cycle - crash
volatile void
panic(const char* s)
{
    vprintf(s);
    asm volatile("cli");
    for(;;);
}