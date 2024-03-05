#define CRTPORT 0x3d4
void bootmain() {
    outb(CRTPORT, 15);
    outb(CRTPORT+1, 79);
}