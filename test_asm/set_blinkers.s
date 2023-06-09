###########################
# filename: set_blinkers.s
###########################

.section .data
    c:              .ascii "0"
    c_length:       .long . - c

.section .text
    .global _start
    
    #.type set_blinkers, @function       # function declaration

_start:
    movl $3, %eax           # scanf number
    movl $0, %ebx
    leal c, %ecx
    movl c_length, %edx
    int $0x80               # Invoke the Linux kernel to perform system call 

    xorl %ecx, %ecx
    movl c, %ecx
    subl $48, %ecx

    cmp $5, %cl
    jg  greater_5
    cmp $2, %cl
    jl  less_2
    jmp end

greater_5:
    movl $5, %ecx
    jmp end

less_2:
    movl $2, %ecx
    jmp end

end:
    addl $48, %ecx
    movl %ecx, c

    movl $4, %eax
	movl $1, %ebx
	leal c, %ecx
	movl c_length, %edx
	int $0x80

    #ret
    movl $1, %eax			# syscall EXIT
	movl $0, %ebx			# codice di uscita 0
	int $0x80				# eseguo la syscall
    