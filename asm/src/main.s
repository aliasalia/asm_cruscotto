####################
# filename: main.s
####################

.section .data
    supervisor: .byte 0         # ah
    sup_code:   .ascii "2244"
    ind:        .byte 1         # al
    sub:        .byte 0         # bh
    door_lock:  .byte 1         # bl
    back_home:  .byte 1         # ch
    blinkers:   .byte 3         # cl

.section .text
    .global _start

_start:
    # check if is supervisor
    cmpl $1, %esp
    jg maybe_supervisor

    movb supervisor,    %ah
    movb ind,           %al
    movb sub,           %bh
    movb door_lock,     %bl
    movb back_home,     %ch
    movb blinkers,      %cl

    call index_position_message

    jmp loop

maybe_supervisor:
    movl 8(%esp), %eax
    movl (%eax), %ebx
    movl sup_code, %eax
    cmp %eax, %ebx
    je is_supervisor

is_supervisor:
    movb $1, %ah
    movb %ah, supervisor

loop:
    call navigate_menu

    jmp loop

end:
    xorl %eax, %eax			# azzero %eax
    inc %eax			    # syscall EXIT (1)
	xorl %ebx, %ebx			# codice di uscita 0
	int $0x80				# eseguo la syscall
