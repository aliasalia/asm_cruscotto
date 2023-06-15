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

    supervisor:                 .byte 0         # ah
    ind:                        .byte 1         # al
    sub:                        .byte 0         # bh
    door_lock:                  .byte 1         # bl
    back_home:                  .byte 1         # ch
    blinkers:                   .byte 3         # cl
    blinkers_len:               .long . - blinkers

    val_print:                  .ascii ""
    val_print_length:           .long - val_print

#-----------------------------------------------

.section .text
    .global index_position_message

    .type index_position_message, @function       # function declaration

index_position_message:
    jmp initiate

go_on:
    cmpb $1, %al
    je is_1
    cmpb $2, %al
    je is_2
    cmpb $3, %al
    je is_3
    cmpb $4, %al
    je is_4
    cmpb $5, %al
    je is_5
    cmpb $6, %al
    je is_6
    cmpb $7, %al
    je is_7
    cmpb $8, %al
    je is_8

#-----------------------------------------------

is_1:
    cmpb $1, %ah
    je is_supervisor
    jmp not_supervisor

is_supervisor:
    movl set_auto_s, %eax
    movl %eax, val_print
    movl set_auto_s_len, %ebx
    movl %ebx, val_print_length
    movl $4, %eax
    movl $1, %ebx
    leal val_print, %ecx
    movl val_print_length, %edx
    int $0x80
    jmp return

not_supervisor:
    movl set_auto, %eax
    movl %eax, val_print
    movl set_auto_len, %ebx
    movl %ebx, val_print_length
    movl $4, %eax
    movl $1, %ebx
    leal val_print, %ecx
    movl val_print_length, %edx
    int $0x80
    jmp return

#-----------------------------------------------

is_2:
    movl date, %eax
    movl %eax, val_print
    movl date_len, %ebx
    movl %ebx, val_print_length
    movl $4, %eax
    movl $1, %ebx
    leal val_print, %ecx
    movl val_print_length, %edx
    int $0x80
    jmp return

#-----------------------------------------------

is_3:
    movl time, %eax
    movl %eax, val_print
    movl time_len, %ebx
    movl %ebx, val_print_length
    movl $4, %eax
    movl $1, %ebx
    leal val_print, %ecx
    movl val_print_length, %edx
    int $0x80
    jmp return

#-----------------------------------------------

is_4:
    cmpb $1, %bh
    je is_sub_door
    cmpb $1, door_lock
    je print_door_lock_on
    jmp print_door_lock_off

is_sub_door:
    movb $0, sub
    call move
    cmpb $1, %dh   # return of move up down on %dh
    je change_door_lock
    cmpb $0, %dh
    je change_door_lock

change_door_lock:
    cmpb $1, %bl   # %bl has the current value of door_lock
    jne door_lock_set
    movb $0, door_lock
    jmp print_door_lock_off

door_lock_set:
    movb $1, door_lock
    jmp print_door_lock_on

print_door_lock_on:
    movl door_lock_on, %eax
    movl %eax, val_print
    movl door_lock_on_len, %ebx
    movl %ebx, val_print_length
    movl $4, %eax
    movl $1, %ebx
    leal val_print, %ecx
    movl val_print_length, %edx
    int $0x80
    jmp return

print_door_lock_off:
    movl door_lock_off, %eax
    movl %eax, val_print
    movl door_lock_off_len, %ebx
    movl %ebx, val_print_length
    movl $4, %eax
    movl $1, %ebx
    leal val_print, %ecx
    movl val_print_length, %edx
    int $0x80
    jmp return

#-----------------------------------------------

is_5:
    cmpb $1, %ch
    je is_sub_home
    cmpb $1, back_home
    je print_back_home_on
    jmp print_back_home_off

is_sub_home:
    movb $0, sub
    call move
    cmpb $1, %dh   # return of move up down on %dh
    je change_back_home
    cmpb $0, %dh
    je change_back_home

change_back_home:
    cmpb $1, %ch   # %bl has the current value of back_home
    jne back_home_set
    movl $0, back_home
    jmp print_back_home_off

back_home_set:
    movb $1, back_home
    jmp print_back_home_on

print_back_home_on:
    movl back_home_on, %eax
    movl %eax, val_print
    movl back_home_on_len, %ebx
    movl %ebx, val_print_length
    movl $4, %eax
    movl $1, %ebx
    leal val_print, %ecx
    movl val_print_length, %edx
    int $0x80
    jmp return

print_back_home_off:
    movl back_home_off, %eax
    movl %eax, val_print
    movl back_home_off_len, %ebx
    movl %ebx, val_print_length
    movl $4, %eax
    movl $1, %ebx
    leal val_print, %ecx
    movl val_print_length, %edx
    int $0x80
    jmp return

#-----------------------------------------------

is_6:
    movl check_oil, %eax
    movl %eax, val_print
    movl check_oil_len, %ebx
    movl %ebx, val_print_length
    movl $4, %eax
    movl $1, %ebx
    leal val_print, %ecx
    movl val_print_length, %edx
    int $0x80
    jmp return

#-----------------------------------------------

is_7:
    cmpb $1, %bh # %bh has sub
    je get_blinkers

    movl blinkers_n, %eax
    movl %eax, val_print
    movl blinkers_n_len, %ebx
    movl %ebx, val_print_length
    movl $4, %eax
    movl $1, %ebx
    leal val_print, %ecx
    movl val_print_length, %edx
    int $0x80

    
    movl blinkers, %eax
    addl $256, %eax     # to string
    addl $48, %eax
    movl %eax, val_print
    movl blinkers_len, %ebx  ## maybe error
    movl %ebx, val_print_length
    movl $4, %eax
    movl $1, %ebx
    leal val_print, %ecx
    movl val_print_length, %edx
    int $0x80
    jmp return

get_blinkers:
    call set_blinkers
    movb %dl, blinkers ##maybe error
    movb $0, sub
#-----------------------------------------------

is_8:
    cmpb $1, %bh
    je reset_pressure
    movl wheels_pressure, %eax
    movl %eax, val_print
    movl wheels_pressure_len, %ebx
    movl %ebx, val_print_length
    movl $4, %eax
    movl $1, %ebx
    leal val_print, %ecx
    movl val_print_length, %edx
    int $0x80
    movb $0, sub        # sub to 0
    jmp return

reset_pressure:
    movl wheels_pressure_rst, %eax
    movl %eax, val_print
    movl wheels_pressure_rst_len, %ebx
    movl %ebx, val_print_length
    movb $0, %bl        # sub to 0
    movl $4, %eax
    movl $1, %ebx
    leal val_print, %ecx
    movl val_print_length, %edx
    int $0x80

#-----------------------------------------------

initiate:
    movb %ah, supervisor
    movb %al, ind
    movb %bh, sub
    movb %bl, door_lock
    movb %ch, back_home
    movb %cl, blinkers
    jmp go_on

#-----------------------------------------------

return:
    movb supervisor,    %ah
    movb ind,           %al
    movb sub,           %bh
    movb door_lock,     %bl
    movb back_home,     %ch
    movb blinkers,      %cl
    ret
