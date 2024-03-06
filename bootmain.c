#include "console.h"
void bootmain() {
    int pos;
    for (pos = 0;pos <2000;pos++)
        vgaputc('A');
    for (pos = 0;pos <100;pos++)
        vgaputc('L');
}