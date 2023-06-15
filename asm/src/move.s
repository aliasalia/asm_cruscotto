#####################
# filename: move.s
#####################

.section .data
    c:              .ascii "0"
    c_length:       .long . - c
    up:             .ascii "A"
    up_length:      .long . - up
    down:           .ascii "B"
    down_length:    .long . - down
    right:          .ascii "C"
    right_length:   .long . - right

    supervisor:     .byte 0         # ah
    ind:            .byte 1         # al
    sub:            .byte 0         # bh
    door_lock:      .byte 1         # bl
    back_home:      .byte 1         # ch
    blinkers:       .byte 3         # cl

.section .text
    .global move

    .type move, @function      

move:
    jmp initiate

go_on:
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
    movb $0, %dh
    jmp return

is_down:
    # return 1
    movb $1, %dh
    jmp return

is_right:
    # return 1 to navigate in %dl => sub = 1
    movb $1, %dl
    jmp return

initiate:
    movb %ah, supervisor
    movb %al, ind
    movb %bh, sub
    movb %bl, door_lock
    movb %ch, back_home
    movb %cl, blinkers
    jmp go_on

return:
    movb supervisor,    %ah
    movb ind,           %al
    movb sub,           %bh
    movb door_lock,     %bl
    movb back_home,     %ch
    movb blinkers,      %cl
    ret
