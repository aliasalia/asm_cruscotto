####################
# file: navigate_menu.s
####################

.section .data
    max:        .byte 6    

.section .text
    .global navigate_menu

    .type navigate_menu, @function      

navigate_menu:

    cmpb $1, %ah
    je is_supervisor

go_on:
    call move     
    movb %dl, %bh           # get from %dl 1 if is submenu
    cmpb $1, %dl
    jne up_down
    ret

is_supervisor:
    movb $8, max
    jmp go_on

up_down:
    cmpb $1, %dh
    je increment
    jmp decrement

increment:
    movb max, %dl
    cmpb %dl, %al
    je is_max
    jmp not_max

is_max:
    movb $1, %al    # returns 1 in %al
    ret

not_max:
    incb %al        # add 1 to current index
    ret

decrement:
    cmpb $1, %al
    je is_top
    jmp not_top

is_top:
    movb max, %al    # returns max (last index)
    ret

not_top:
    dec %al     # subtract 1 to current index
    ret
