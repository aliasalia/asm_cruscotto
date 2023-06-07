####################
# filename: main.s
####################

.section .data
supervisor: .long 0
ind:        .long 1
sub:        .long 0
door_lock:  .long 1
back_home:  .long 1
blinkers:   .long 3

.section .text
    .global _start

    .type _start, @function

_start:
# check if is supervisor TODO

#.loop
#    call navigate_menu
#    jmp .loop

call  move              # chiamata alla funzione _move


# syscall EXIT
xorl %eax, %eax         # azzera eax
inc %eax                # incr. eax di 1 (1 e' il codice della exit)          
xorl %ebx, %ebx         # azzera ebx (alla exit viene passato 0)           
int $0x80               # invoca la funzione exit
