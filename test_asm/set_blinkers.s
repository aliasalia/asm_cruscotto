###########################
# filename: set§_blinkers.s
###########################

.section .data
    c:              .long 0
    c_length:       .long . - c
    tmp:            .ascii "0"
    tmp_length:     .long . - tmp

.section .text
    .global set_blinkers
    
    .type set_blinkers, @function       # function declaration

set_blinkers:
    movl $3, %eax           # scanf number
    movl $0, %ebx
    leal c, %ecx
    movl c_length, %edx
    int $0x80               # Invoke the Linux kernel to perform system call

    movl $3, %eax           # scanf blank char (end of string)
    movl $0, %ebx
    leal tmp, %ecx
    movl tmp_length, %edx
    int $0x80               # Invoke the Linux kernel to perform system call

    cmpl $5, (%ecx)
    jg  .greater_5
    cmpl $2, (%ecx)
    jl  .less_2
    jmp .end

    # end of function
    mov %ebp, %esp
    popl %ebp
    ret

.greater_5:
    # movl $5, %ecx
    jmp .end

.less_2:
    # movl $2, %ecx
    jmp .end

.end:
    ret

    