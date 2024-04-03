.globl  switch
switch:
    movl    4(%esp),%eax
#    movl    8(%esp),%ebx
    leal    1,8(%esp)
    jmp     *%eax
1:
    ret