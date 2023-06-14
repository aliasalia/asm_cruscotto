#####################
# filename: index_position_message.s
#####################

.section .data
    set_auto_s:                 .ascii "1. Setting automobile (supervisor): "
    set_auto_s_len:             .long . - set_auto_s
    set_auto:                   .ascii "1. Setting automobile: "
    set_auto_len:               .long . - set_auto
    date:                       .ascii "2. Data: 15/06/2014 "
    date_len:                   .long . - date
    time:                       .ascii "3. Ora: 15:32 "
    time_len:                   .long . - time
    door_lock_on:               .ascii "4. Blocco automatico porte: ON "
    door_lock_on_len:           .long . - door_lock_on
    door_lock_off:              .ascii "4. Blocco automatico porte: OFF "
    door_lock_off_len:          .long . - door_lock_off
    back_home_on:               .ascii "5. Back-home: ON "
    back_home_on_len:           .long . - back_home_on
    back_home_off:              .ascii "5. Back-home: OFF "
    back_home_off_len:          .long . - back_home_off
    check_oil:                  .ascii "6. Check olio "
    check_oil_len:              .long . - check_oil
    blinkers_n:                 .ascii "7. Frecce direzione: "
    blinkers_n_len:             .long . - blinkers_n
    wheels_pressure:            .ascii "8. Reset pressione gomme "
    wheels_pressure_len:        .long . - wheels_pressure
    wheels_pressure_rst:        .ascii "Pressione gomme resettata\n"
    wheels_pressure_rst_len:    .long . - wheels_pressure_rst

    ind:                        .byte 1     # %ah
    supervisor:                 .byte 0     # %al
    door_lock:                  .byte 1     # %cl
    back_home:                  .byte 1     # %bh
    sub:                        .byte 0     # %bl
    blinkers:                   .byte 3     # %ch
    blinkers_len:               .long . - blinkers

    val_print:                  .ascii ""
    val_print_length:           .long - val_print

.section .text
    .global index_position_message

    .type index_position_message, @function       # function declaration

index_position_message:

    #movb %ah, ind
    cmpl $1, %eax
    je is_1
    cmpl $2, %eax
    je is_2
    cmpl $3, %eax
    je is_3
    cmpl $4, %eax
    je is_4
    cmpl $5, %eax
    je is_5
    cmpl $6, %eax
    je is_6
    cmpl $7, %eax
    je is_7
    cmpl $8, %eax
    je is_8


is_1:
    movb %al, supervisor
    cmpl $1, %ebx
    je is_supervisor

    movl set_auto, %eax
    movl %eax, val_print
    movl set_auto_len, %ebx
    movl %ebx, val_print_length
    jmp print
    ret

is_supervisor:
    movl set_auto_s, %eax
    movl %eax, val_print
    movl set_auto_s_len, %ebx
    movl %ebx, val_print_length
    jmp print
    ret
############################################################
is_2:
    movl date, %eax
    movl %eax, val_print
    movl date_len, %ebx
    movl %ebx, val_print_length
    jmp print
    ret
############################################################
is_3:
    movl time, %eax
    movl %eax, val_print
    movl time_len, %ebx
    movl %ebx, val_print_length
    jmp print
    ret
###########################################################
is_4:
    movb %bl, sub
    cmpl $1, %ecx   # %bl has sub
    call move
    cmpl $1, %eax   # return of move up down on %eax
    je change_door_lock
    cmpl $0, %eax
    je change_door_lock

change_door_lock:
    movb %cl, door_lock
    cmpl $1, %edx   # %cl has the current value of door_lock
    je door_lock_set

    movl door_lock_off, %eax
    movl %eax, val_print
    movl door_lock_off_len, %ebx
    movl %ebx, val_print_length
    jmp print
    movb door_lock, %cl
    movb $0, %bl        # sub to 0
    ret

door_lock_set:
    movl door_lock_on, %eax
    movl %eax, val_print
    movl door_lock_on_len, %ebx
    movl %ebx, val_print_length
    jmp print
    movb door_lock, %cl
    movb $0, %bl        # sub to 0
    ret
############################################################
is_5:
    movb %bl, sub
    cmpl $1, %ecx   # %bl has sub
    call move
    cmpl $1, %eax   # return of move up down on %eax
    je change_back_home
    cmpl $0, %eax
    je change_back_home

change_back_home:
    movb %bh, back_home
    cmpl $1, %edx   # %edx has the current value of back_home
    je back_home_set

    movl back_home_off, %eax
    movl %eax, val_print
    movl back_home_off_len, %ebx
    movl %ebx, val_print_length
    jmp print
    movb back_home, %bh
    movb $0, %bl        # sub to 0
    ret

back_home_set:
    movl back_home_on, %eax
    movl %eax, val_print
    movl back_home_on_len, %ebx
    movl %ebx, val_print_length
    jmp print
    movb back_home, %bh
    movb $0, %bl        # sub to 0
    ret
############################################################
is_6:
    movl check_oil, %eax
    movl %eax, val_print
    movl check_oil_len, %ebx
    movl %ebx, val_print_length
    jmp print
    ret
############################################################
is_7:
    movb %bl, sub
    movb %ch, blinkers
    cmpb $1, %bl
    call get_blinkers
    movl blinkers_n, %eax
    movl %eax, val_print
    movl blinkers_n_len, %ebx
    movl %ebx, val_print_length
    jmp print
    movl blinkers, %eax
    movl %eax, val_print
    movl blinkers_len, %ebx
    movl %ebx, val_print_length
    jmp print
    ret

get_blinkers:
    call set_blinkers
    movl %ecx, blinkers
    movb $0, %bl
    movb blinkers, %ch

############################################################
is_8:
    movb %bl, sub
    cmpb $1, %bl
    call reset_pressure
    movl wheels_pressure, %eax
    movl %eax, val_print
    movl wheels_pressure_len, %ebx
    movl %ebx, val_print_length
    jmp print
    movb $0, %bl        # sub to 0
    ret

reset_pressure:
    movl wheels_pressure_rst, %eax
    movl %eax, val_print
    movl wheels_pressure_rst_len, %ebx
    movl %ebx, val_print_length
    movb $0, %bl        # sub to 0
    jmp print

############################################################
print:
    movl $4, %eax
	movl $1, %ebx
	leal val_print, %ecx
	movl val_print_length, %edx
	int $0x80
