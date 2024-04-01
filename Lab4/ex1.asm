section .data
    hello db 'Hello, World!', 10  ; String to be printed, with newline character (10)

section .text
    global _start   ; Entry point for the program

_start:
    ; System call to write to standard output (file descriptor 1)
    mov rax, 1      ; syscall number for sys_write
    mov rdi, 1      ; file descriptor 1 (stdout)
    mov rsi, hello  ; pointer to the string
    mov rdx, 13     ; length of the string
    syscall         ; invoke the system call

    ; System call to exit the program
    mov rax, 60     ; syscall number for sys_exit
    xor rdi, rdi    ; exit code 0
    syscall         ; invoke the system call