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

    ret

#   put cur eip into first argument
fork:
#   esp
    pushl   %esp
#   eip
    pushl   4(%esp)

    call    fork1
# clean the stack
    addl    $8,%esp
    ret

wait:
    pushl   %esp
    pushl   4(%esp)
    pushl   %eax
    call    wait1
    addl    $0x10,%esp
    jmp     schedule
yield:
    pushl   %esp
    pushl   4(%esp)
    pushl   %eax
    call    yield1
    addl    $0x10,%esp
    jmp     schedule