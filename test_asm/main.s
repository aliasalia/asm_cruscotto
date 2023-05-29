####################
# filename: main.s
####################

.section .text
    .global _start

_start:
call  move              # chiamata alla funzione _move


# syscall EXIT
xorl %eax, %eax         # azzera eax
inc %eax                # incr. eax di 1 (1 e' il codice della exit)          
xorl %ebx, %ebx         # azzera ebx (alla exit viene passato 0)           
int $0x80               # invoca la funzione exit
