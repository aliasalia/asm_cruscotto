#####################
# filename: move.s
#####################

.section .data
    c:              .ascii "0"
    c_length:       .long . - c
    up:             .ascii "A"
    up_length:      .long . - up
    down:           .ascii "B"
    down_length:    .long . - down
    right:          .ascii "C"
    right_length:   .long . - right

.section .text
    .global move

    .type move, @function      

move:
    movl $3, %eax           
    movl $0, %ebx
    leal c, %ecx
    movl c_length, %edx
    int $0x80  

    movl $3, %eax           
    movl $0, %ebx
    leal c, %ecx
    movl c_length, %edx
    int $0x80         

    movl $3, %eax           
    movl $0, %ebx
    leal c, %ecx
    movl c_length, %edx
    int $0x80             

    xorl %ecx, %ecx
    movl c, %ecx

    movl up, %eax
    cmpl %eax, %ecx
    je is_up
    movl down, %eax
    cmpl %eax, %ecx
    je is_down
    movl right, %eax
    cmpl %eax, %ecx
    je is_right

is_up:
    # return 0
    movl $0, %eax
    jmp end

is_down:
    # return 1
    movl $1, %eax
    jmp end

is_right:
    # return 1 to navigate in %ecx => sub = 1
    movl $1, %ecx
    jmp end

end:
    #addl $256, %eax
    #addl $48, %eax
    #movl %eax, c

    #movl $4, %eax
	#movl $1, %ebx
	#leal c, %ecx
	#movl c_length, %edx
	#int $0x80

    # end of function
    ret
    #movl $1, %eax			
	#movl $0, %ebx			
	#int $0x80	
