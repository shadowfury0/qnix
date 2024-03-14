const char* welcome = "\
*************\n\
 ***********\n\
  *********\n\
   *******\n\
    *****\n\
     ***\n\
      *\n\
";
void 
init() {
    init_idt();
    vprintf("welcome to qnix");
    vgaputc('\n');
    vprintf(welcome);
    vprintf("loading...");
}
