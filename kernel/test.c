#include "types.h"
#include "io.h"
#include "dev/ide.h"

// test file
void
test(void)
{
    fat_init();
    // 初始化fat代码
    fat_alloc(1);

    for(;;) {
        // stihlt();
        // printdate();
    }
}