####################
# file: navigate_menu.s
####################

.section .data
    ind:        .byte 1
    supervisor: .byte 0
    max:        .long 6
    down:       .long 1
    sub:        .byte 0
    

.section .text
    .global navigate_menu

    .type navigate_menu, @function      

navigate_menu:
    movb %ah, ind          # get from %ah the current index
    movb %al, supervisor   # get from %al if is supervisor
    cmpb $1, %al
    je is_supervisor

    call move
    movl %eax, down         # get from %eax 1 if down 0 if up         
    movb %bl, sub           # get from %ecx 1 if is submenu
    cmpb $1, %bl
    jne up_down
    ret

is_supervisor:
    movl $8, max

up_down:
    cmpl $1, %eax
    je increment
    jmp decrement

increment:
    movl ind, %ebx
    movl max, %ecx
    cmpl %ebx, %ecx
    je is_max
    jmp not_max

is_max:
    movb $1, %ah       # returns 1 in %ebx
    ret

not_max:
    addb $1, %ah       # add 1 to current index
    ret

decrement:
    movb ind, %ah
    cmpb $1, %ah
    je is_top
    jmp not_top

is_top:
    movb max, %ah       # returns max (last index)
    ret

not_top:
    subb $1, %ah       # subtract 1 to current index
    ret
