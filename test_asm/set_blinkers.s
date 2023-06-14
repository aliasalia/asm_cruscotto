###########################
# filename: set_blinkers.s
###########################

.section .data
    c:              .ascii "0"
    c_length:       .long . - c

.section .text
    .global set_blinkers
    
    .type set_blinkers, @function      

set_blinkers:
    movl $3, %eax           
    movl $0, %ebx
    leal c, %ecx
    movl c_length, %edx
    int $0x80               

    xorl %ecx, %ecx
    movl c, %ecx
    subl $48, %ecx

    cmp $5, %cl
    jg  greater_5
    jmp maybe_less_2

greater_5:
    movl $5, %ecx
    addl $256, %ecx
    ret

maybe_less_2:
    cmp $2, %cl
    jl  less_2
    ret     # is between

less_2:
    movl $2, %ecx
    addl $256, %ecx
    ret
