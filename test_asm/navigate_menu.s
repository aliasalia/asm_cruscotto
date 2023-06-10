####################
# file: navigate_menu.s
####################

.section .data
    ind:        .long 1
    supervisor: .long 0
    max:        .long 6
    down:       .long 1
    sub:        .long 0
    

.section .text
    .global navigate_menu

navigate_menu:
    movl %eax, ind
    movl %ebx, supervisor
    cmp $1, %ebx
    je is_supervisor

    call move
    movl %eax, down
    movl %ecx, sub
    cmp $2, %ecx
    jne up_down

is_supervisor:
    movl $8, max

up_down:
    cmp $1, %eax
    je increment
    jmp decrement

increment:
    movl ind, %ebx
    movl max, %ecx
    cmp %ebx, %ecx
    je is_max
    jmp not_max

is_max:
    movl $1, %ebx       # returns 1 in %ebx
    ret

not_max:
    addl $1, %ebx       # add 1 to current index
    ret

decrement:
    movl ind, %ebx
    cmp $1, %ebx
    je is_top
    jmp not_top

is_top:
    movl max, %ebx       # returns max (last index)
    ret

not_top:
    subl $1, %ebx       # subtract 1 to current index
    ret
