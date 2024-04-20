// Identification space
#define     ATA_IDENT_DEVICETYPE        0
#define     ATA_IDENT_CYLINDERS         2
#define     ATA_IDENT_HEADS             6
#define     ATA_IDENT_SECTORS           12
#define     ATA_IDENT_SERIAL            20
#define     ATA_IDENT_MODEL             54
#define     ATA_IDENT_CAPABILITIES      98
#define     ATA_IDENT_FIELDVALID        106
#define     ATA_IDENT_MAX_LBA           120
#define     ATA_IDENT_COMMANDSETS       164
#define     ATA_IDENT_MAX_LBA_EXT       200

// Status
#define     ATA_SR_BSY                  0x80    // Busy
#define     ATA_SR_DRDY                 0x40    // Drive ready
#define     ATA_SR_DF                   0x20    // Drive write fault
#define     ATA_SR_DSC                  0x10    // Drive seek complete
#define     ATA_SR_DRQ                  0x08    // Data request ready
#define     ATA_SR_CORR                 0x04    // Corrected data
#define     ATA_SR_IDX                  0x02    // Index
#define     ATA_SR_ERR                  0x01    // Error
                
// Errors               
#define     ATA_ER_BBK                  0x80    // Bad block
#define     ATA_ER_UNC                  0x40    // Uncorrectable data
#define     ATA_ER_MC                   0x20    // Media changed
#define     ATA_ER_IDNF                 0x10    // ID mark not found
#define     ATA_ER_MCR                  0x08    // Media change request
#define     ATA_ER_ABRT                 0x04    // Command aborted
#define     ATA_ER_TK0NF                0x02    // Track 0 not found
#define     ATA_ER_AMNF                 0x01    // No address mark

// Commands
#define     ATA_CMD_READ_PIO            0x20
#define     ATA_CMD_READ_PIO_EXT        0x24
#define     ATA_CMD_READ_DMA            0xc8
#define     ATA_CMD_READ_DMA_EXT        0x25
#define     ATA_CMD_WRITE_PIO           0x30
#define     ATA_CMD_WRITE_PIO_EXT       0x34
#define     ATA_CMD_WRITE_DMA           0xca
#define     ATA_CMD_WRITE_DMA_EXT       0x35
#define     ATA_CMD_CACHE_FLUSH         0xe7
#define     ATA_CMD_CACHE_FLUSH_EXT     0xea
#define     ATA_CMD_PACKET              0xa0
#define     ATA_CMD_IDENTIFY_PACKET     0xa1
#define     ATA_CMD_IDENTIFY            0xec

// Register
#define     ATA_REG_DATA                0x00
#define     ATA_REG_ERROR               0x01
#define     ATA_REG_FEATURES            0x01
#define     ATA_REG_SECCOUNT            0x02
#define     ATA_REG_LBA0                0x03
#define     ATA_REG_LBA1                0x04
#define     ATA_REG_LBA2                0x05
#define     ATA_REG_HDDEVSEL            0x06
#define     ATA_REG_COMMAND             0x07
#define     ATA_REG_STATUS              0x07
#define     ATA_REG_SECCOUNT1           0x08
#define     ATA_REG_LBA3                0x09
#define     ATA_REG_LBA4                0x0a
#define     ATA_REG_LBA5                0x0b
#define     ATA_REG_CONTROL             0x0c
#define     ATA_REG_ALTSTATUS           0x0c
#define     ATA_REG_DEVADDRESS          0x0d

#define     IDE_ATA                     0x00
#define     IDE_ATAPI                   0x01

// Channels:
#define     IDE_ATA                     0x00
// slave
#define     IDE_ATAPI                   0x01
 
 // -------------------------
// bus
#define     ATA_PRIMARY                 0x00
#define     ATA_SECONDARY               0x01
// drive
#define     ATA_MASTER                  0x00
#define     ATA_SLAVE                   0x01
// port
#define     PRIMARY_PORT                0x1f0
#define     SECONDARY_PORT              0x170

#define     IDE_DEV_SIZE                4
#define     SECTSIZE                    512


struct ide_device {
    uchar  exist;       // 0 (Empty) or 1 (This Drive really exists).
    uchar  channel;     // 0 (Primary Channel) or 1 (Secondary Channel).
    uchar  drive;       // 0 (Master Drive) or 1 (Slave Drive).
    // uchar  type;        // 0: ATA, 1:ATAPI
    ushort signature;   // Drive Signature
    ushort capabilities;// Features.
    uint   commandSets; // Command Sets Supported.
    uint   size;        // Size
};