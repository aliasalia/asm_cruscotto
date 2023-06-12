#####################
# filename: move.s
#####################

.section .data
    c:              .ascii "0"
    c_length:       .long . - c
    up:             .ascii "A"
    up_length:      .long . -up
    down:           .ascii "B"
    down_length:    .long . -down
    right:          .ascii "C"
    right_length:   .long . -right

.section .text
    .global _start

    #.type move, @function       # function declaration

_start:
    movl $3, %eax           # scanf first char
    movl $0, %ebx
    leal c, %ecx
    movl c_length, %edx
    int $0x80               # invoke the Linux kernel to perform system call

    movl up, %eax
    cmpl %eax, %ecx
    je is_up
    xor %eax, %eax
    movl down, %eax
    cmpl %eax, %ecx
    je is_down
    xor %eax, %eax
    movl right, %eax
    cmpl %eax, %ecx
    je right

is_up:
    # return -1
    movl $-1, %eax
    jmp end

is_down:
    # return 1
    movl $1, %eax
    jmp end

is_right:
    # return 2
    movl $2, %eax
    jmp end

end:
    # end of function
    #ret
    movl $1, %eax			
	movl $0, %ebx			
	int $0x80	
