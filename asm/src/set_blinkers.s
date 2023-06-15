###########################
# filename: set_blinkers.s
###########################

.section .data
    c:          .ascii "0"
    c_length:   .long . - c

    supervisor: .byte 0         # ah
    ind:        .byte 1         # al
    sub:        .byte 0         # bh
    door_lock:  .byte 1         # bl
    back_home:  .byte 1         # ch
    blinkers:   .byte 3         # cl

.section .text
    .global set_blinkers
    
    .type set_blinkers, @function      

set_blinkers:
    jmp initiate

go_on:
    movl $3, %eax           
    movl $0, %ebx
    leal c, %edx
    movl c_length, %edx
    int $0x80               

    xorl %edx, %edx
    movl c, %edx
    subl $48, %edx

    cmpb $5, %dl
    jg  greater_5
    jmp maybe_less_2

greater_5:
    movb $5, %dl  ## maybe error
    jmp return

maybe_less_2:
    cmp $2, %dl
    jl  less_2
    jmp return     # is between

less_2:
    movb $2, %dl ## maybe error
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
