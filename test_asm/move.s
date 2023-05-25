#####################
# filename: move.s
#####################

.section .data
    format_char db "%c", 0     ; Format string for reading a single character

.section .text
global _move

_move:
    ; Function prologue
    push ebp
    mov ebp, esp

    ; Variable declarations
    sub esp, 8                 ; Allocate space for 'c' and 'tmp'
    mov edx, esp               ; Address of 'c'
    mov eax, edx               ; Address of 'tmp'

    ; Read the first character
    lea eax, [format_char]
    push eax                   ; Push the address of the format string
    push edx                   ; Push the address of 'c'
    call scanf                 ; Call scanf function
    add esp, 8                 ; Clean up the stack

    ; Check for escape character '\033'
    cmp byte [edx], 27
    jne .not_escape

    ; Read the second character
    push eax                   ; Preserve the result of the first scanf
    push edx                   ; Push the address of 'c'
    call scanf                 ; Call scanf function
    add esp, 8                 ; Clean up the stack

    ; Check for '[' character
    cmp byte [edx], '['
    jne .not_escape

    ; Read the third and fourth characters
    push eax                   ; Preserve the result of the second scanf
    push edx                   ; Push the address of 'c'
    call scanf                 ; Call scanf function
    add esp, 8                 ; Clean up the stack

    push eax                   ; Preserve the result of the third scanf
    push edx                   ; Push the address of 'tmp'
    call scanf                 ; Call scanf function
    add esp, 8                 ; Clean up the stack

    ; Check for different movement keys
    cmp byte [edx], 'A'
    je .up
    cmp byte [edx], 'B'
    je .down
    cmp byte [edx], 'C'
    je .right

.not_escape:
    ; Return 0
    xor eax, eax
    jmp .end

.up:
    ; Return -1
    mov eax, -1
    jmp .end

.down:
    ; Return 1
    mov eax, 1
    jmp .end

.right:
    ; Return 2
    mov eax, 2
    jmp .end

.end:
    ; Function epilogue
    mov esp, ebp
    pop ebp
    ret