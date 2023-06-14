####################
# filename: main.s
####################

.section .data
supervisor: .byte 0
sup_code:   .ascii "2244"
ind:        .byte 1
sub:        .byte 0
door_lock:  .byte 1
back_home:  .byte 1
blinkers:   .byte 3

.section .text
    .global _start

_start:
    # check if is supervisor
    movl %esp, %eax
    cmp $1, %eax
    jg maybe_supervisor

    movb ind, %eax
    movb supervisor, %ebx
    call index_position_message
    jmp loop

maybe_supervisor:
    movl 8(%esp), %eax
    movl (%eax), %ebx
    movl sup_code, %eax
    cmp %eax, %ebx
    je is_supervisor

loop:
    movb ind, %ah
    movb supervisor, %al
    movb door_lock, %cl
    movb back_home, %bh
    movb sub, %bl
    movb blinkers, %ch

    call navigate_menu

    movb %ah, ind
    movb %al, supervisor
    movb %cl, door_lock
    movb %bh, back_home
    movb %bl, sub
    movb %ch, blinkers
    jmp loop

is_supervisor:
    movb $1, %al
    movb %al, supervisor

end:
    movl $1, %eax			# syscall EXIT
	movl $0, %ebx			# codice di uscita 0
	int $0x80				# eseguo la syscall
