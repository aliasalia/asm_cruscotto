#####################
# filename: move.s
#####################

.section .data
    format_char: .string "%c"   # format string for reading a single character

.section .text
    .global move

    .type move, @function       # function declaration

move:
    # function prologue ??
    pushl %ebp
    mov %esp, %ebp

    # variable declarations
    sub $8, %esp                
    mov %esp, %edx              # c
    mov %edx, %eax              # tmp ????

    # read the first character
    lea format_char, %eax
    pushl %edx                  # push the address of 'c'
    pushl %eax                  # push the address of the format string
    call scanf                  # call scanf
    add $8, %esp                # clean up the stack

    # check for escape character '\033'
    cmpb $27, (%edx)
    jne .not_escape

    # read char (should be '[')
    pushl %edx                  # push the address of 'c'
    pushl %eax                  # push the address of the format string
    call scanf                  # call scanf function
    add $8, %esp                # clean up the stack

    # check if true
    cmpb $'[', (%edx)
    jne .not_escape

    # read letter (es. A)
    pushl %edx                  
    pushl %eax                  
    call scanf                                  

    # reading the tmp part ??? maybe in the next part compare the tmp instead of the c
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
    mov $-1, %eax
    jmp .end

.down:
    # return 1
    mov $1, %eax
    jmp .end

.right:
    # return 2
    mov $2, %eax
    jmp .end

.end:
    # end of function
    mov %ebp, %esp
    popl %ebp
    ret
