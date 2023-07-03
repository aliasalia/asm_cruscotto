####################
# filename: main.s
####################

.section .data
    # -----------main--------------
    supervisor: .byte 0         
    sup_code:   .ascii "2244"
    ind:        .byte 1         
    sub:        .byte 0         
    door_lock:  .byte 1         
    back_home:  .byte 1         
    blinkers:   .byte 3   

    print:      .ascii "0"    

    throw_error:                 .ascii "an error occured"
    throw_error_len:             .long . - throw_error
    # -----------index_position_message------------------
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
    click_up_down:              .ascii "Clicca SU o GIU': "
    click_up_down_len:          .long . - click_up_down
    # --------------navigate_menu-------------
    max:                        .byte 6
    # ------------set_blinkers------------------
    c:                          .ascii "0"
    select_blinkers:            .ascii "Quante volte devono lampeggiare le frecce? "
    select_blinkers_len:        .long . - select_blinkers

.section .text
    .global _start

_start:
    # check if is supervisor
    cmpl $1, (%esp)
    jg maybe_supervisor

first_message:
    # uncomment the following line to test supervisor mode
    #movb $1, %al
    # movb %al, supervisor
    jmp index_position_message

maybe_supervisor:
    movl 8(%esp), %eax
    movl (%eax), %ebx
    movl sup_code, %eax
    cmpl %eax, %ebx
    je is_supervisor

is_supervisor:
    # xorl %eax, %eax
    movl $1, %eax
    movb %al, supervisor
    # xorl %eax, %eax
    movb $8, %al
    movb %al, max
    jmp first_message

loop:
    jmp navigate_menu

end:
    xorl %eax, %eax			# azzero %eax
    inc %eax			    # syscall EXIT (1)
	xorl %ebx, %ebx			# codice di uscita 0
	int $0x80				# eseguo la syscall

# *************************index_position_message*****************************************************

index_position_message:
    movb ind, %bl
    cmpb $1, %bl
    je is_1
    cmpb $2, %bl
    je is_2
    cmpb $3, %bl
    je is_3
    cmpb $4, %bl
    je is_4
    cmpb $5, %bl
    je is_5
    cmpb $6, %bl
    je is_6
    cmpb $7, %bl
    je is_7
    cmpb $8, %bl
    je is_8
    jmp error

#-----------------------------------------------

is_1:
    movb supervisor, %al
    cmpb $1, %al
    je is_supervisor_1
    jmp not_supervisor

is_supervisor_1:
    movl $4, %eax
    movl $1, %ebx
    leal set_auto_s, %ecx
    movl set_auto_s_len, %edx
    int $0x80
    jmp loop

not_supervisor:
    movl $4, %eax
    movl $1, %ebx
    leal set_auto, %ecx
    movl set_auto_len, %edx
    int $0x80
    jmp loop

#-----------------------------------------------

is_2:
    movl $4, %eax
    movl $1, %ebx
    leal date, %ecx
    movl date_len, %edx
    int $0x80
    jmp loop

#-----------------------------------------------

is_3:
    movl $4, %eax
    movl $1, %ebx
    leal time, %ecx
    movl time_len, %edx
    int $0x80
    jmp loop

#-----------------------------------------------

is_4:
    movb sub, %bl
    cmpb $1, %bl
    je is_sub_door
    movb door_lock, %cl
    cmpb $1, %cl
    je print_door_lock_on
    jmp print_door_lock_off

is_sub_door:
    # add print of click_up_down
    movl $4, %eax
    movl $1, %ebx
    leal click_up_down, %ecx
    movl click_up_down_len, %edx
    int $0x80
    # end print of click_up_down
    movb $0, sub
    call move
    cmpb $1, %dl   # return of move up down
    je change_door_lock
    cmpb $0, %dl
    je change_door_lock

change_door_lock:
    movb door_lock, %bl
    cmpb $1, %bl   # %bl has the current value of door_lock
    jne door_lock_set
    movb $0, door_lock
    jmp print_door_lock_off

door_lock_set:
    movb $1, door_lock
    jmp print_door_lock_on

print_door_lock_on:
    movl $4, %eax
    movl $1, %ebx
    leal door_lock_on, %ecx
    movl door_lock_on_len, %edx
    int $0x80
    jmp loop

print_door_lock_off:
    movl $4, %eax
    movl $1, %ebx
    leal door_lock_off, %ecx
    movl door_lock_off_len, %edx
    int $0x80
    jmp loop

#-----------------------------------------------

is_5:
    movb sub, %bl
    cmpb $1, %bl
    je is_sub_home
    movb back_home, %bl
    cmpb $1, %bl
    je print_back_home_on
    jmp print_back_home_off

is_sub_home:
    # add print of click_up_down
    movl $4, %eax
    movl $1, %ebx
    leal click_up_down, %ecx
    movl click_up_down_len, %edx
    int $0x80
    # end print of click_up_down
    movb $0, sub
    call move
    cmpb $1, %dl   # return of move up down on %dh
    je change_back_home
    cmpb $0, %dl
    je change_back_home

change_back_home:
    movb back_home, %bl
    cmpb $1, %bl   # %bl has the current value of back_home
    jne back_home_set
    movb $0, back_home
    jmp print_back_home_off

back_home_set:
    movb $1, back_home
    jmp print_back_home_on

print_back_home_on:
    movl $4, %eax
    movl $1, %ebx
    leal back_home_on, %ecx
    movl back_home_on_len, %edx
    int $0x80
    jmp loop

print_back_home_off:
    movl $4, %eax
    movl $1, %ebx
    leal back_home_off, %ecx
    movl back_home_off_len, %edx
    int $0x80
    jmp loop

#-----------------------------------------------

is_6:
    movl $4, %eax
    movl $1, %ebx
    leal check_oil, %ecx
    movl check_oil_len, %edx
    int $0x80
    jmp loop

#-----------------------------------------------

is_7:
    movb sub, %bl
    cmpb $1, %bl # %bl has sub
    je set_blinkers

    jmp print_blinkers

go_on_blinkers:
    movb $0, sub
    movb %dl, blinkers
    jmp print_blinkers

print_blinkers:
    movl $4, %eax
    movl $1, %ebx
    leal blinkers_n, %ecx
    movl blinkers_n_len, %edx
    int $0x80

    xor %eax, %eax
    movb blinkers, %al
    addl $256, %eax     # to string
    addl $48, %eax
    movl %eax, print

    movl $4, %eax
    movl $1, %ebx
    leal print, %ecx
    movl $1, %edx
    int $0x80
    jmp loop
#-----------------------------------------------

is_8:
    movb sub, %bl
    cmpb $1, %bl
    je reset_pressure
    movl $4, %eax
    movl $1, %ebx
    leal wheels_pressure, %ecx
    movl wheels_pressure_len, %edx
    int $0x80
    jmp loop

reset_pressure:
    movb $0, sub        # sub to 0
    movl $4, %eax
    movl $1, %ebx
    leal wheels_pressure_rst, %ecx
    movl wheels_pressure_rst_len, %edx
    int $0x80
    jmp loop

# ************************************************************

navigate_menu:
    movb supervisor, %al
    cmpb $1, %al
    # je is_supervisor_navigate
    call move      
    movb %cl, sub           # get from %dl 1 if is submenu
    cmpb $1, %cl
    jne up_down
    jmp index_position_message

# is_supervisor_navigate:
#    # xor %eax, %eax
#    # movb $8, %al
#    # movb %al, max
#
#    call move      
#    movb %cl, sub           # get from %dl 1 if is submenu
#    cmpb $1, %cl
#    jne up_down
#    jmp index_position_message

up_down:
    cmpb $1, %dl    # 1 or 0 in dh if up or down
    je increment
    jmp decrement

increment:
    xorl %edx, %edx
    movb max, %dl
    xorl %eax, %eax
    movb ind, %al
    cmpb %dl, %al
    je is_max
    jmp not_max

is_max:
    movb $1, ind    # returns 1 in %al
    jmp index_position_message

not_max:
    incb %al        # add 1 to current index
    movb %al, ind 
    jmp index_position_message

decrement:
    xorl %edx, %edx
    movb ind, %dl
    cmpb $1, %dl
    je is_top
    jmp not_top

is_top:
    movb max, %al
    movb %al, ind    # returns max (last index)
    jmp index_position_message

not_top:
    decb %dl     # subtract 1 to current index
    movb %dl, ind
    jmp index_position_message

# -----------------set_blinkers--------------------
set_blinkers:
    # add print of select_blinkers
    movl $4, %eax
    movl $1, %ebx
    leal select_blinkers, %ecx
    movl select_blinkers_len, %edx
    int $0x80
    # end print of select_blinkers

    movl $3, %eax           
    movl $0, %ebx
    leal c, %ecx
    movl $1, %edx
    int $0x80

    xorl %edx, %edx
    movb c, %dl
    subb $48, %dl

    cmpb $5, %dl
    jg greater_5
    jmp maybe_less_2

greater_5:
    movb $5, %dl
    jmp go_on_blinkers

maybe_less_2:
    cmpb $2, %dl
    jl less_2
    jmp go_on_blinkers     # is between

less_2:
    movb $2, %dl
    jmp go_on_blinkers

# ------------------- error -----------------------
error:
    movl $4, %eax
    movl $1, %ebx
    leal throw_error, %ecx
    movl throw_error_len, %edx
    int $0x80

    xorl %eax, %eax			
    inc %eax			     
	xorl %ebx, %ebx			 
	int $0x80
