####################
# filename: main.s
####################

.section .data
supervisor: .long 0
sup_length: .long . - supervisor
sup_code:   .ascii "2244"
supc_length: .long . - sup_code
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
    movl 8(%esp), %eax
    movl (%eax), %ebx
    movl sup_code, %eax
    cmp %eax, %ebx
    je is_supervisor
    movl %ebx, supervisor
    jmp continue

continue:
    movl $4, %eax
	movl $1, %ebx
	leal supervisor, %ecx
	movl sup_length, %edx
	int $0x80
    jmp end

is_supervisor:
    movl $1, %eax
    addl $256, %eax
    addl $48, %eax
    movl %eax, supervisor
    jmp continue

# call index_position_message

loop:
    movl ind, %eax
    movl supervisor, %ebx
    #call navigate_menu
    jmp loop

end:
    movl $1, %eax			# syscall EXIT
	movl $0, %ebx			# codice di uscita 0
	int $0x80				# eseguo la syscall
