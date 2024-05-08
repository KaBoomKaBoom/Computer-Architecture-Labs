section .data
    ; Messages
    msg1 db 'Enter the first number: ', 0
    lmsg1 equ $ - msg1

    msg2 db 'Enter the second number: ', 0
    lmsg2 equ $ - msg2

    msg3 db 'Result: ', 0
    lmsg3 equ $ - msg3

    nlinea db 10, 0
    lnlinea equ $ - nlinea

section .bss
    num1 resb 20
    num2 resb 20
    result resb 20

section .text
    global _start

_start:
    ; Print message 1
    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, lmsg1
    syscall

    ; Input first number
    mov rax, 0
    mov rdi, 0
    mov rsi, num1
    mov rdx, 20
    syscall

    ; Print message 2
    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, lmsg2
    syscall

    ; Input second number
    mov rax, 0
    mov rdi, 0
    mov rsi, num2
    mov rdx, 20
    syscall

    ; Convert ASCII input to integers
    mov rax, num1
    movzx rax, byte [rax]   ; Zero-extend ASCII character '0'
    sub rax, '0'
    mov [num1], rax

    mov rax, num2
    movzx rax, byte [rax]   ; Zero-extend ASCII character '0'
    sub rax, '0'
    mov [num2], rax

    ; Subtract second number from the first
    mov rax, [num1]
    sub rax, [num2]

    ; Convert result to ASCII
    add rax, '0'
    mov [result], rax

    ; Print message 3
    mov rax, 1
    mov rdi, 1
    mov rsi, msg3
    mov rdx, lmsg3
    syscall

    ; Print result
    mov rax, 1
    mov rdi, 1
    mov rsi, result
    mov rdx, 1
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, nlinea
    mov rdx, lnlinea
    syscall

    ; Exit
    mov rax, 60
    xor rdi, rdi
    syscall
