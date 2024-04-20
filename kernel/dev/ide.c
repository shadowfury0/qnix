#include "types.h"
#include "io.h"
#include "ide.h"

struct ide_device ide_devices[IDE_DEV_SIZE];

static uchar ide_buf[SECTSIZE] = {0};

uint
idewait(uint d)
{
	// wait until is ready
	while(!(inb(d + ATA_REG_STATUS) & ATA_SR_DRQ));
    return inb(d + ATA_REG_STATUS) & ATA_SR_ERR;
}

// i dont know why do that in ata
void 
ide_400ns_delay(uint io)
{
    uint i;
	for(i = 0;i < 4; i++)
		inb(io + ATA_REG_ALTSTATUS);
}

uint
select_channel(uint bus)
{
    return bus == ATA_PRIMARY ? PRIMARY_PORT : SECONDARY_PORT; 
}

uint
ide_identify(uint bus,uint drive)
{
    if (bus == ATA_PRIMARY) 
    {
        if (drive == ATA_MASTER) outb(PRIMARY_PORT + ATA_REG_HDDEVSEL,0xa0);
        else outb(PRIMARY_PORT + ATA_REG_HDDEVSEL,0xb0);
        return PRIMARY_PORT;
    }
    else 
    {
        if (drive == ATA_MASTER) outb(SECONDARY_PORT + ATA_REG_HDDEVSEL,0xa0);
        else outb(SECONDARY_PORT + ATA_REG_HDDEVSEL,0xb0);
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
    if (status) {
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
    int i,j;
    uint count = 0;
    for (i=0;i<2;i++)
        for (j=0;j<2;j++,count++) {
            if(check_drive(i,j)) continue;
            
            // Delay 400 nanosecond for select to complete:
            ide_400ns_delay(select_channel(i));
            // Read Identification Space of the Device
            ide_space(select_channel(i));

            ide_devices[count].exist = 1;
            ide_devices[count].channel = i;
            ide_devices[count].drive = j;
            ide_devices[count].signature = *((ushort*)(ide_buf+ATA_IDENT_DEVICETYPE));
            ide_devices[count].capabilities = *((ushort*)(ide_buf+ATA_IDENT_CAPABILITIES));
            ide_devices[count].commandSets = *((uint*)(ide_buf+ATA_IDENT_COMMANDSETS));

            // usually mater drive is the same as slave dirve size
            if (ide_devices[count].commandSets & (1 << 26))
                // Device uses 48-Bit Addressing:
                ide_devices[count].size   = *((uint *)(ide_buf + ATA_IDENT_MAX_LBA_EXT));
            else
                // Device uses CHS or 28-bit Addressing:
                ide_devices[count].size   = *((uint *)(ide_buf + ATA_IDENT_MAX_LBA));
        }

    for (i = 0; i < 4; i++)
        if (ide_devices[i].exist) {
            vprintf("Channel %d,Drive %d, Maximum space is %d\n",
            // (const char *[]){"ATA", "ATAPI"}[ide_devices[i].Type],         /* Type */
            ide_devices[i].channel,ide_devices[i].drive,
            ide_devices[i].size / 2);
        }
}

void
readsect(void *dst, uint offset,uint p,uint d)
{
    outb(p + ATA_REG_SECCOUNT, 1);   // count = 1
    outb(p + ATA_REG_LBA0, offset);
    outb(p + ATA_REG_LBA1, offset >> 8);
    outb(p + ATA_REG_LBA2, offset >> 16);
    outb(p + ATA_REG_HDDEVSEL, (offset >> 24) | 0xE0 | (d<<4));
    outb(p + ATA_REG_COMMAND, 0x20);  // cmd 0x20 - read sectors
    idewait(p);
    // Read 512 B data.
    insl(p + ATA_REG_DATA, dst, 128);
}

void
writesect(void* dst,uint offset,uint p,uint d) {
    outb(p + ATA_REG_SECCOUNT, 1);   // count = 1
    outb(p + ATA_REG_LBA0, offset);
    outb(p + ATA_REG_LBA1, offset >> 8);
    outb(p + ATA_REG_LBA2, offset >> 16);
    outb(p + ATA_REG_HDDEVSEL, (offset >> 24) | 0xE0 | (d<<4));
    outb(p + ATA_REG_COMMAND, 0x30);  // cmd 0x30 - write sectors
    idewait(p);
    // Write 512 B data.
    outsl(p + ATA_REG_DATA, dst, SECTSIZE/4);
}

void
ideread(void* dst,uint offset,uint dev)
{
    if (dev >= sizeof(IDE_DEV_SIZE))
    {
        vprintf("device is not found\n");
        return;
    }
    // read a sector from device
    readsect(dst,offset,select_channel(dev>>1),dev%2);
}

void
idewrite(void* dst,uint offset,uint dev)
{
    if (dev >= sizeof(IDE_DEV_SIZE))
    {
        vprintf("device is not found\n");
        return;
    }
    // write a sector from device
    writesect(dst,offset,select_channel((dev & 1)? ATA_SECONDARY : ATA_PRIMARY),dev%2);
}

void
ide_init(void)
{
    uint i=0;
    for (i=0;i<NELEM(ide_devices);i++)
    {
        ide_devices[i].exist = 0;
    }
    //check all drive
    check_drives();
}

void
do_ide(void)
{
	piceoi();
}