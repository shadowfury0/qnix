// tty io cache
#define TTY_QB_SIZE  32  // must be 2^n

// cache queue
struct tty_queue {
    ulong   h;                  // head
    ulong   t;                  // tail
    uchar   buf[TTY_QB_SIZE];
};

// tty queue function
#define TTY_INC(v) ((++v) & (TTY_QB_SIZE-1))
#define TTY_DEC(v) ((--v) & (TTY_QB_SIZE-1))
#define TTY_Q_LEFT(q) (((q).t-(q).h-1)&(TTY_QB_SIZE-1))
#define TTY_Q_FULL(q) (!TTY_Q_LEFT(q))
#define TTY_Q_EMPTY(q) ((q).h == (q).t)
#define TTY_Q_GET(q,r) ({(r)=(q).buf[(q).t];TTY_INC(q.t);})
#define TTY_Q_PUT(q,v) ({(q).buf[(q).h]=(v);TTY_INC(q.h);})
#define TTY_Q_INIT(q) ({(q).h=0;(q).t=0;})