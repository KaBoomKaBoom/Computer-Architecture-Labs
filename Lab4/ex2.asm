section .data
    prompt db 'Enter your name: ', 0    ; Prompt message
    greeting db 'Hello, ', 0             ; Greeting message prefix
    newline db 10, 0                     ; Newline character for printing

section .bss
    name resb 32                         ; Buffer to store user's name (up to 31 characters)

section .text
    global _start

_start:
    ; Display prompt message
    mov rax, 1                  ; syscall number for sys_write
    mov rdi, 1                  ; file descriptor 1 (stdout)
    mov rsi, prompt             ; pointer to the prompt message
    mov rdx, 17                 ; length of the prompt message
    syscall                     ; invoke the system call

    ; Read user input
    mov rax, 0                  ; syscall number for sys_read
    mov rdi, 0                  ; file descriptor 0 (stdin)
    mov rsi, name               ; pointer to the buffer
    mov rdx, 32                 ; maximum number of bytes to read
    syscall                     ; invoke the system call

    ; Print greeting
    mov rax, 1                  ; syscall number for sys_write
    mov rdi, 1                  ; file descriptor 1 (stdout)
    mov rsi, greeting           ; pointer to the greeting prefix
    mov rdx, 7                  ; length of the greeting prefix
    syscall                     ; invoke the system call

    ; Print the user's name
    mov rax, 1                  ; syscall number for sys_write
    mov rdi, 1                  ; file descriptor 1 (stdout)
    mov rsi, name               ; pointer to the user's name
    syscall                     ; invoke the system call

    ; Print newline character
    mov rax, 1                  ; syscall number for sys_write
    mov rdi, 1                  ; file descriptor 1 (stdout)
    mov rsi, newline            ; pointer to the newline character
    mov rdx, 1                  ; length of the newline character
    syscall                     ; invoke the system call

    ; Exit the program
    mov rax, 60                 ; syscall number for sys_exit
    xor rdi, rdi                ; exit code 0
    syscall                     ; invoke the system call
