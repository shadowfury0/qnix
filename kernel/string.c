#include "types.h"

int
strncmp(const char *p, const char *q, uint n)
{
    while(n > 0 && *p && *p == *q)
        n--, p++, q++;
    if(n == 0)
        return 0;
    return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
{
    char *os;
    os = s;
    while(n-- > 0 && (*s++ = *t++) != 0);
    while(n-- > 0)
        *s++ = 0;
    return os;
}

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    char *os;
    os = s;
    if(n <= 0)
        return os;
    while(--n > 0 && (*s++ = *t++) != 0);
    *s = 0;
    return os;
}

int
strlen(const char *s)
{
    int n;
    for(n = 0; s[n]; n++);
    return n;
}

void
strupper(char *s) {
    while (*s) {
        if ('a' <= *s && *s <= 'z') {
            *s = *s - ('a' - 'A');
        }
        s++;
    }
}