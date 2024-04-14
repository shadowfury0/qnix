#include "types.h"
#include "io.h"
#include "ide.h"

struct ide_device {
    uchar  exist;       // 0 (Empty) or 1 (This Drive really exists).
    uchar  channel;     // 0 (Primary Channel) or 1 (Secondary Channel).
    uchar  drive;       // 0 (Master Drive) or 1 (Slave Drive).
    // uchar  type;        // 0: ATA, 1:ATAPI
    ushort signature;   // Drive Signature
    ushort capabilities;// Features.
    uint   commandSets; // Command Sets Supported.
    uint   size;        // Size
}   ide_devices[4];

static uchar ide_buf[512] = {0};

uint
idewait(uint port)
{
	// wait until is ready
	while(!(inb(port + ATA_REG_STATUS) & ATA_SR_DRQ));
    return inb(port + ATA_REG_STATUS) & ATA_SR_ERR;
}

uint
select_drive_port(uint bus)
{
    return bus == ATA_PRIMARY ? PRIMARY_PORT : SECONDARY_PORT; 
}

uint
ide_identify(uint bus,uint drive)
{
    if (bus == ATA_PRIMARY) 
    {
        if (drive == ATA_MASTER) outb(ATA_PRIMARY + ATA_REG_HDDEVSEL,0xa0);
        else outb(ATA_PRIMARY + ATA_REG_HDDEVSEL,0xb0);
        return PRIMARY_PORT;
    }
    else 
    {
        if (drive == ATA_MASTER) outb(ATA_SECONDARY + ATA_REG_HDDEVSEL,0xa0);
        else outb(ATA_SECONDARY + ATA_REG_HDDEVSEL,0xb0);
        return SECONDARY_PORT;
    }
}

uint
check_drive(uint bus,uint io)
{
    uint drive = ide_identify(bus,io);
    outb(drive + ATA_REG_SECCOUNT,0);
    outb(drive + ATA_REG_LBA0,0);
    outb(drive + ATA_REG_LBA1,0);
    outb(drive + ATA_REG_LBA2,0);
    // send identify
    outb(drive + ATA_REG_COMMAND,ATA_CMD_IDENTIFY);

    uint status = inb(drive + ATA_REG_STATUS);

    // data must ready
    if (status & ATA_SR_DRQ) {
		if(idewait(drive)) 
            //If Err, Device is not ATA Disk
            return 2;
        return 0;
    }
    else
        //drive not found
        return 1;
}

// Read Identification Space of the Device
void
ide_space(uint drive)
{
    // send identify
    outb(drive + ATA_REG_COMMAND,ATA_CMD_IDENTIFY_PACKET);
    // save in ide_buf
    insl(drive + ATA_REG_DATA, ide_buf, SECTSIZE/4);
}

// check all drives usually is four
void
check_drives(void)
{
    int i,j,count;
    for (j=0;j<2;j++)
        for (i=1;i >= 0;--i) {
            // access the slave channel first and then the master channel
            // or you will get the same information for master and slave in simulator
            if(check_drive(j,i)) continue;

            // Read Identification Space of the Device
            ide_space(select_drive_port(j));

            ide_devices[count].exist = 1;
            ide_devices[count].channel = i;
            ide_devices[count].drive = j;
            ide_devices[count].signature = *((ushort*)(ide_buf+ATA_IDENT_DEVICETYPE));
            ide_devices[count].capabilities = *((ushort*)(ide_buf+ATA_IDENT_CAPABILITIES));
            ide_devices[count].commandSets = *((uint*)(ide_buf+ATA_IDENT_COMMANDSETS));

            if (ide_devices[count].commandSets & (1 << 26))
                // Device uses 48-Bit Addressing:
                ide_devices[count].size   = *((uint *)(ide_buf + ATA_IDENT_MAX_LBA_EXT));
            else
                // Device uses CHS or 28-bit Addressing:
                ide_devices[count].size   = *((uint *)(ide_buf + ATA_IDENT_MAX_LBA));
            count++;
        }

    for (i = 0; i < 4; i++)
        if (ide_devices[i].exist) {
            vprintf("Channel %d,Drive %d, Maximum space is %d\n",
            // (const char *[]){"ATA", "ATAPI"}[ide_devices[i].Type],         /* Type */
            ide_devices[i].channel,ide_devices[i].drive,
            ide_devices[i].size);
        }
}

void
ide_init(void)
{

    check_drives();

    // int* p = kalloc();
    // readsect(p,0);
}

void
readsect(void *dst, uint offset)
{
    // outb(0x176, (offset >> 24) | 0xE0);
    // outb(0x172, 1);   // count = 1
    // outb(0x173, offset);
    // outb(0x174, offset >> 8);
    // outb(0x175, offset >> 16);
    // outb(0x177, 0x20);  // cmd 0x20 - read sectors

    // // Read data.
    // while((inb(0x177) & 0x88) != 8);
    
    // insl(0x170, dst, 128);

    outb(0x1F2, 0);   // count = 1
    outb(0x1F3, offset);
    outb(0x1F4, offset >> 8);
    outb(0x1F5, offset >> 16);
    outb(0x1F6, (offset >> 24) | 0xA0);
    outb(0x1F7, 0x20);  // cmd 0x20 - read sectors

    // Read data.
    // waitdisk();
    idewait(0);
    insl(0x1F0, dst, 128);
}

// void
// writesect(void* dst,uint offset) {
//     outb(0x1F2, 1);   // count = 1
//     outb(0x1F3, offset);
//     outb(0x1F4, offset >> 8);
//     outb(0x1F5, offset >> 16);
//     outb(0x1F6, (offset >> 24) | 0xE0);
//     outb(0x1F7, 0x30);  // cmd 0x30 - write sectors
//     // Write data.
//     waitdisk();
//     outsl(0x1F0, dst, SECTSIZE/4);
// }

void
do_ide(void)
{
	piceoi();
}