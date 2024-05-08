section .bss
    str1 resb 256    ; Allocate space for string 1
    str2 resb 256    ; Allocate space for string 2

section .data
    equal_msg db 'Strings are equal', 0
    not_equal_msg db 'Strings are not equal', 0
    prompt_msg db 'Enter string: ', 0

section .text
    global _start

_start:
    ; Prompt user to enter string 1
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_msg
    mov rdx, 16
    syscall

    ; Read string 1 from user
    mov rax, 0       ; syscall number for sys_read
    mov rdi, 0       ; file descriptor 0 (stdin)
    mov rsi, str1    ; buffer to store string
    mov rdx, 256     ; maximum number of bytes to read
    syscall

    ; Prompt user to enter string 2
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_msg
    mov rdx, 16
    syscall

    ; Read string 2 from user
    mov rax, 0       ; syscall number for sys_read
    mov rdi, 0       ; file descriptor 0 (stdin)
    mov rsi, str2    ; buffer to store string
    mov rdx, 256     ; maximum number of bytes to read
    syscall

    ; Compare strings
    mov rsi, str1    ; Address of first string
    mov rdi, str2    ; Address of second string
    call compare_strings

    ; Exit program
    mov eax, 60         ; syscall number for sys_exit
    xor edi, edi        ; Exit code 0
    syscall

compare_strings:
    compare_loop:
        ; Load bytes from each string
        mov al, byte [rsi]    ; Load byte from str1 into AL
        mov bl, byte [rdi]    ; Load byte from str2 into BL

        ; Compare the bytes
        cmp al, bl
        jne not_equal        ; If not equal, jump to not_equal label

        ; Check if we've reached the end of the string (null terminator)
        cmp al, 0
        je strings_equal    ; If both strings are null-terminated, they are equal

        ; Move to the next character in the strings
        inc rsi
        inc rdi
        jmp compare_loop    ; Continue comparing

    strings_equal:
        mov rax, 1      ; syscall number for sys_write
        mov rdi, 1      ; file descriptor 1 (stdout)
        mov rsi, equal_msg  ; pointer to the string
        mov rdx, 30     ; length of the string
        syscall         ; invoke the system call
        ret

    not_equal:
        mov rax, 1      ; syscall number for sys_write
        mov rdi, 1      ; file descriptor 1 (stdout)
        mov rsi, not_equal_msg  ; pointer to the string
        mov rdx, 30    ; length of the string
        syscall         ; invoke the system call
        ret
