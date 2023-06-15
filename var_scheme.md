# Registers - Variables associations

## Variabili che vengono passate da un file all'altro:

1. main -> index_position_message: supervisor
2. main -> navigate_menu: supervisor
3. navigate_menu -> index_position_message: supervisor
4. 

supervisor: .byte 0         # ah
sup_code:   .ascii "2244"
ind:        .byte 1         # al
sub:        .byte 0         # bh
door_lock:  .byte 1         # bl
back_home:  .byte 1         # ch
blinkers:   .byte 3         # cl

is_up or is_down			# dh
is_right					# dl

## move

| return var    | registers     |
| -----------   | -----------   |
| sub           | %bl           | needed in index_position_message
| down          | %eax          | needed in index_position_message and navigate_menu

## set_blinkers

| return var    | registers     |
| -----------   | -----------   |
| blinkers      | %ecx          |

## index_position_message

| get var       | registers     |
| -----------   | -----------   |
| ind           | %ah           |
| supervisor    | %al           |
| door_lock     | %cl           |
| back_home     | %bh           |
| sub           | %bl           |
| blinkers      | %ch           |

| return var    | registers     |
| -----------   | -----------   |
| ind           | %ebx          |

## navigate_menu

| get var       | registers     |
| -----------   | -----------   |
| ind           | %ah          |
| supervisor    | %al          |

| return var    | registers     |
| -----------   | -----------   |
| ind           | %ah          |
| sub           | %bl           |

## main

| get var       | registers     |
| -----------   | -----------   |
| ind           | %eax          |
| supervisor    | %ebx          |
| door_lock     | %cl           |
| back_home     | %bh           |
| sub           | %ecx          |
| blinkers      | %ch           |

| return var    | registers     |
| -----------   | -----------   |
| ind           | %ah           |
| supervisor    | %al           |
| door_lock     | %cl           |
| back_home     | %bh           |
| sub           | %bl           |
| blinkers      | %ch           |
