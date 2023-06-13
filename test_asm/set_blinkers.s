###########################
# filename: set_blinkers.s
###########################

.section .data
    c:              .ascii "0"
    c_length:       .long . - c

.section .text
    .global _start
    
    #.type set_blinkers, @function      

_start:
    movl $3, %eax           
    movl $0, %ebx
    leal c, %ecx
    movl c_length, %edx
    int $0x80               

    xorl %ecx, %ecx
    movl c, %ecx
    subl $48, %ecx

    cmp $5, %cl
    jg  greater_5
    jmp maybe_less_2

greater_5:
    movl $5, %ecx
    addl $256, %ecx
    jmp end

maybe_less_2:
    cmp $2, %cl
    jl  less_2
    jmp between

less_2:
    movl $2, %ecx
    addl $256, %ecx
    jmp end

between:
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
    movl $1, %eax			
	movl $0, %ebx			
	int $0x80				
    