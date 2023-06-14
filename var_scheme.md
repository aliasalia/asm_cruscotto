# Registers - Variables associations

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
