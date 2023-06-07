#####################
# filename: move.s
#####################

.section .data
    format_char:    .string "%c"   # format string for reading a single character
    c:              .ascii
    tmp:            .ascii     

.section .text
    .global move

    .type move, @function       # function declaration

move:
    movl c, %ecx

    movl $3, %eax
    movl $0, %ebx
    leal c, %ecx
    movl $1, %edx

    # give space on the stack
    pushl %ebp
    movl %esp, %ebp

    # variable declarations
    sub $8, %esp                
    movl %esp, %edx              # c
    movl %edx, %eax              # tmp

    # read the first character
    leal format_char, %eax
    pushl %edx                  # push the address of 'c'
    pushl %eax                  # push the address of the format string
    call scanf                  # call scanf
    add $8, %esp                # clean up the stack

    # check for escape character '\033'
    cmpb $27, (%edx)
    jne .not_escape

    # read second char
    pushl %edx                  # push the address of 'c'
    pushl %eax                  # push the address of the format string
    call scanf                  # call scanf function
    add $8, %esp                # clean up the stack

    # check if id '['
    cmpb $'[', (%edx)
    jne .not_escape

    # read letter (es. A)
    pushl %edx                  
    pushl %eax                  
    call scanf                                  

    # reading the tmp part
    pushl %edx                  
    pushl %eax                  
    call scanf                  
    add $8, %esp                

    # check wich key has been pressed
    cmpb $'A', (%edx)
    je .up
    cmpb $'B', (%edx)
    je .down
    cmpb $'C', (%edx)
    je .right

.not_escape:
    # return 0
    xor %eax, %eax
    jmp .end

.up:
    # return -1
    movl $-1, %eax
    jmp .end

.down:
    # return 1
    movl $1, %eax
    jmp .end

.right:
    # return 2
    movl $2, %eax
    jmp .end

.end:
    # end of function
    movl %ebp, %esp
    popl %ebp
    ret
