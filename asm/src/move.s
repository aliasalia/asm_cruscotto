#####################
# filename: move.s
#####################

.section .data
    c:              .ascii "0"
    c_length:       .long . - c
    tmp:            .ascii "0"
    tmp_length:     .long . - tmp
    up:             .ascii "A"
    up_length:      .long . - up
    down:           .ascii "B"
    down_length:    .long . - down
    right:          .ascii "C"
    right_length:   .long . - right

.section .text
    .global move

    .type move, @function      

move:
    movl $3, %eax           
    movl $0, %ebx
    leal c, %ecx
    movl c_length, %edx
    int $0x80

    movl $3, %eax           
    movl $0, %ebx
    leal c, %ecx
    movl c_length, %edx
    int $0x80

    movl $3, %eax           
    movl $0, %ebx
    leal c, %ecx
    movl c_length, %edx
    int $0x80

    movl $3, %eax           
    movl $0, %ebx
    leal tmp, %ecx
    movl tmp_length, %edx
    int $0x80

    xorl %ecx, %ecx
    movl c, %ecx

    movl up, %eax
    cmpl %eax, %ecx
    je is_up
    movl down, %eax
    cmpl %eax, %ecx
    je is_down
    movl right, %eax
    cmpl %eax, %ecx
    je is_right

is_up:
    # return 0
    xorl %edx, %edx
    movb $0, %dl
    ret

is_down:
    # return 1
    xorl %edx, %edx
    movb $1, %dl
    ret

is_right:
    # return 1 to navigate in %dl => sub = 1
    xorl %ecx, %ecx
    movb $1, %cl
    ret
