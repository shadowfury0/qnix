// real time clock
#define     RTC_STAP        0x70
#define     RTC_DATAP       0x71
// select register B
#define     RTC_RA          0x0a
#define     RTC_RB          0x0b
#define     RTC_RC          0x0c
// disable nmi
#define     DIS_NMI         0x80

#define     RTC_TS          0x0     // second
#define     RTC_TMI         0x2     // minute
#define     RTC_TH          0x4     // hour
#define     RTC_TD          0x7     // day
#define     RTC_TMO         0x8     // moth
#define     RTC_TY          0x9     // year
#define     RTC_UMASK       0xf 

// temporary variable  you can set the center centry register in cmos
#define     CURRENT_CENTRY  2000    // century

struct timer {
    uchar   second;
    uchar   minute;
    uchar   hour;
    uchar   day;
    uchar   month;
    ushort  year;
    volatile    uint    tick;
};