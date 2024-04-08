.globl swtch,fork,wait,yield

# switch the eip register with the first address
swtch:
    movl    (%esp), %eax
    movl    4(%esp),%edx
    addl    $8,%esp
# esp
    movl    0x38(%edx),%esp
# eip
    pushl   0x20(%edx)
    movl    %eax,0x20(%edx)
# eax
    movl    0x28(%edx),%eax
# ecx
    movl    0x2c(%edx),%ecx
# ebx
    movl    0x34(%edx),%ebx
# ebp
    movl    0x3c(%edx),%ebp
# esi
    movl    0x40(%edx),%edi
# edi 
    movl    0x44(%edx),%esi
# edx
    xchgl   0x30(%edx),%edx

    ret

#   put cur eip into first argument
fork:
#   esp
    pushl   %esp
#   eip
    pushl   4(%esp)
    pushl   %ecx
    pushl   %edx
    pushl   %ebx
    pushl   %ebp
    pushl   %esi
    pushl   %edi

    call    fork1
# clean the stack

    popl    %edi
    popl    %esi
    popl    %ebp
    popl    %ebx
    popl    %edx
    popl    %ecx

    addl    $4,%esp
    popl    %esp

    ret

wait:
    pushl   %esp
    pushl   4(%esp)
    pushl   %eax
    pushl   %ecx
    pushl   %edx
    pushl   %ebx
    pushl   %ebp
    pushl   %esi
    pushl   %edi
    call    wait1
    addl    $0x28,%esp
    jmp     schedule
yield:
    pushl   %esp
    pushl   4(%esp)
    pushl   %eax
    pushl   %ecx
    pushl   %edx
    pushl   %ebx
    pushl   %ebp
    pushl   %esi
    pushl   %edi

    call    yield1
    addl    $0x28,%esp
    jmp     schedule
