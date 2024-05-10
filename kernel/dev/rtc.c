#include "types.h"
#include "io.h"
#include "rtc.h"

static struct timer t_clock;

void
rtc_dump(void)
{
    //  is important is that if register C is not read after an IRQ 8, 
    //  then the interrupt will not happen again
    outb(RTC_STAP, RTC_RC);	    // select register C
    inb(RTC_DATAP);		        // just throw away contents
}

void
rtc_init(void)
{
    t_clock.tick = 0;
    // 1024 Hz
    outb(RTC_STAP, DIS_NMI|RTC_RB);		// select register B, and disable NMI
    uchar p = inb(RTC_DATAP);	        // read the current value of register B
    outb(RTC_DATAP, p | 0x40);          // set the index again (a read will reset the index to register D)

    // outb(RTC_STAP, DIS_NMI|RTC_RB);		
    outb(RTC_DATAP, 0x12);

    rtc_dump();
    
    rtc_date();
}

static inline uchar 
rtc_ready(void) {
    outb(RTC_STAP,DIS_NMI|RTC_RA);
    return inb(RTC_DATAP) & 0x80;
}

static inline uchar
rtc_get(uchar reg)
{
    outb(RTC_STAP,reg);
    return inb(RTC_DATAP);
}

void
rtc_date(void)
{
    t_clock.second  = rtc_get(RTC_TS);
    t_clock.minute  = rtc_get(RTC_TMI);
    t_clock.hour    = rtc_get(RTC_TH);
    t_clock.day     = rtc_get(RTC_TD);
    t_clock.month   = rtc_get(RTC_TMO);
    t_clock.year    = rtc_get(RTC_TY);

    // register B
    uchar rB;
    rB = rtc_get(0x0B);

    if (!(rB & 0x04)) {
        t_clock.second  = (t_clock.second & RTC_UMASK) + ((t_clock.second / 16) * 10);
        t_clock.minute  = (t_clock.minute & RTC_UMASK) + ((t_clock.minute / 16) * 10);
        // t_clock.hour    = ( (t_clock.hour & RTC_UMASK) + (((t_clock.hour & 0x70) / 16) * 10) ) | (t_clock.hour & 0x80);
        // t_clock.hour    = (t_clock.hour & 0x0f) + ((t_clock.hour  / 16) * 10);
        t_clock.hour    = (t_clock.hour + 17) % 24 + 1;
        t_clock.day     = (t_clock.day & RTC_UMASK) + ((t_clock.day / 16) * 10);
        t_clock.month   = (t_clock.month & RTC_UMASK) + ((t_clock.month / 16) * 10);
        t_clock.year    = (t_clock.year & RTC_UMASK) + ((t_clock.year / 16) * 10);
        t_clock.year    += CURRENT_CENTRY;
    }

    // Convert 12 hour clock to 24 hour clock if necessary
    // if (!(rB & 0x02) && (t_clock.hour & 0x80)) {
        // t_clock.hour = ((t_clock.hour & 0x7F) + 12) % 24;
    // }
}

void
rtctrap(void)
{
    cli();
    // check uip
    while(rtc_ready());
    t_clock.tick++;

    rtc_date();
    rtc_dump();
    piceoi();

    yield();
}

volatile void
sleep(uint t)
{
    uint l = t_clock.tick;
    while ((t + l) > t_clock.tick);
}

void
printdate(void)
{
    vprintf("%d-%d-%d  %d:%d:%d \n",t_clock.year,t_clock.month,t_clock.day,t_clock.hour,t_clock.minute,t_clock.second);
}

uchar
rtc_get_second(void)
{
    return t_clock.second;
}

uchar
rtc_get_minute(void)
{
    return t_clock.minute;
}

uchar
rtc_get_hour(void)
{
    return t_clock.hour;
}

uchar
rtc_get_day(void)
{
    return t_clock.day;
}

uchar
rtc_get_month(void)
{
    return t_clock.month;
}

ushort
rtc_get_year(void)
{
    return t_clock.year;
}

int
sys_time(void)
{
    printdate();
    return  0;
}

int
sys_sleep(uint i)
{
    sti();
    sleep(i);
    return 0;
}