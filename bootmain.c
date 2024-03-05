#include "boot.h"
#include "io.h"

//boot main start 
void bootmain() {
    //do nothing
    outb(CRTPORT,15);
    outb(CRTPORT+1,79);
}