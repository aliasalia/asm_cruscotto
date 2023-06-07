#####################
# filename: move.s
#####################

.section .data
    c:              .ascii ""
    c_length:       .long . - c
    tmp:            .ascii ""
    tmp_length:     .long . - tmp

.section .text
    .global _move

    #.type move, @function       # function declaration

_move:
    movl $3, %eax           # scanf first char
    movl $0, %ebx
    leal c, %ecx
    movl c_length, %edx
    int $0x80               # invoke the Linux kernel to perform system call

    movl (%ecx), %eax        # move the character to %eax

    cmpl $27, %eax           # cmp '\033' to %eax
    jne .end

    movl $3, %eax           # scanf second char
    movl $0, %ebx
    leal c, %ecx
    movl c_length, %edx
    int $0x80               # invoke the Linux kernel to perform system call

    movl (%ecx), %eax        # move the character to %eax

    cmpl $'[', %eax          # cmp '[' to %eax
    jne .end

    movl $3, %eax           # scanf third char (A B or C)
    movl $0, %ebx
    leal c, %ecx
    movl c_length, %edx
    int $0x80               # Invoke the Linux kernel to perform system call

    movl $3, %eax           # scanf last blank char (end of string)
    movl $0, %ebx
    leal tmp, %ecx
    movl tmp_length, %edx
    int $0x80               # Invoke the Linux kernel to perform system call

    # check wich key has been pressed
    cmpl $'A', (%ecx)
    je .up
    cmpl $'B', (%ecx)
    je .down
    cmpl $'C', (%ecx)
    je .right

.up:
    # return -1
    movl $-1, %eax
    jmp .end

.down:
    # return 1
    movl $1, %eax
    jmp .end

.right:
    # return 2
    movl $2, %eax
    jmp .end

.end:
    # end of function
    ret
