#####################
# filename: index_position_message.s
#####################

.section .data
    format_char: .string "%c"   # format string for reading a single character

.section .text
    .global index_position_message

    .type index_position_message, @function       # function declaration

index_position_message:


jTable    dc.l case0,case1,case2,case3,case4,case5,case6,case7

va   dc.l $0

vb   dc.l $12345678

vc:  dc.l $11223344

vp:  dc.l $3

start
    move.l #jTable, a0

    move.l vp, d0

    add.l d0, d0

    add.l d0, d0

    adda.l d0, a0

    movea.l (a0), a0

    jmp (a0)

case0

    move.l vb, d0

    add.l vc, d0

    move.l d0, va

    bra after

case1

    move.l vb, d0

    sub.l vc, d0

    move.l d0, va

    bra after

case3

    move.l vb, d0

    move.l d0, va

    bra after

case2

case4

case5

case6

case7

    move.l vc, d0

    move.l d0, va

    bra after



    clr.l va

after
    
.right:
    # return 2
    mov $2, %eax
    jmp .end

.end:
    # end of function
    mov %ebp, %esp
    popl %ebp
    ret
