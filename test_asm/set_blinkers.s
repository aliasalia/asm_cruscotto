###########################
# filename: set§_blinkers.s
###########################

.section .data
    format_char: .string "%c"   # format string for reading a single character
    format_int: .string "%d"    # format string for reading an int val

.section .text
    .global set_blinkers
    
    .type set_blinkers, @function       # function declaration

set_blinkers:
    sub $8, %esp
    mov %esp, %edx      # n
    mov %edx, %eax      # tmp

    lea format_int, %eax
    pushl %edx                  # push the address of 'c'
    pushl %eax                  # push the address of the format string
    call scanf                  # call scanf
    add $8, %esp                # clean up the stack

    cmp $5, (%edx)
    jg  .greater_5
    jl  .lower_2
    jmp .else

    # end of function
    mov %ebp, %esp
    popl %ebp
    ret

.greater_5
    # movl $5, blinkers

.less_2
    # movl $2, blinkers

.else:    
    # movl (%edx), blinkers

    