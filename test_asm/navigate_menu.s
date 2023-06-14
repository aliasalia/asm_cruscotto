####################
# file: navigate_menu.s
####################

.section .data
    ind:        .long 1
    ind_length: .long . - ind
    supervisor: .long 0
    max:        .long 6
    down:       .long 1
    sub:        .long 0
    

.section .text
    .global _start

_start:
    movl %eax, ind          # get from %eax the current index
    movl %ebx, supervisor   # get from %ebx if is supervisor
    cmp $1, %ebx
    je is_supervisor

    call move
    movl %eax, down         # get from %eax 1 if down 0 if up         
    movl %ecx, sub          # get from %ecx 1 if is submenu
    cmp $1, %ecx
    jne up_down
    jmp end

is_supervisor:
    movl $8, max

up_down:
    cmp $1, %eax
    je increment
    jmp decrement

increment:
    movl ind, %ebx
    movl max, %ecx
    cmp %ebx, %ecx
    je is_max
    jmp not_max

is_max:
    movl $1, %ebx       # returns 1 in %ebx
    #ret
    jmp end

not_max:
    addl $1, %ebx       # add 1 to current index
    #ret
    jmp end

decrement:
    movl ind, %ebx
    cmp $1, %ebx
    je is_top
    jmp not_top

is_top:
    movl max, %ebx       # returns max (last index)
    #ret
    jmp end

not_top:
    subl $1, %ebx       # subtract 1 to current index
    #ret
    jmp end

end:
    ret
    #addl $256, %ebx
    #addl $48, %ebx
    #movl %ebx, ind

    #movl $4, %eax
	#movl $1, %ebx
	#leal ind, %ecx
	#movl ind_length, %edx
	#int $0x80

    # end of function
    #movl $1, %eax			
	#movl $0, %ebx			
	#int $0x80	
