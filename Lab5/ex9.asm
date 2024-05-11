; arithmetic mean of two numbers (integers or real numbers)

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

    format_float db "Result: %f", 10   ; Format string for printing floating point number

    two dq 2.0
section .bss
    num1 resb 8
    num2 resb 8
    result resb 16
    input1 resb 256     ; Buffer to store user input
    input2 resb 256     ; Buffer to store user input

section .text
    global ex9

ex9:
    ; Print message 1
    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, lmsg1
    syscall

    ; Read user input
    mov rax, 0                 ; sys_read syscall number
    mov rdi, 0                 ; stdin file descriptor
    mov rsi, input1      ; Address of the input buffer
    mov rdx, 256               ; Maximum number of bytes to read
    syscall

    ; Print message 2
    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, lmsg2
    syscall

    ; Read user input
    mov rax, 0                 ; sys_read syscall number
    mov rdi, 0                 ; stdin file descriptor
    mov rsi, input2      ; Address of the input buffer
    mov rdx, 256               ; Maximum number of bytes to read
    syscall

    ; Call atof function to convert input string to floating point number
    mov rdi, input1   ; Pass the address of input string
    call atof               ; Call the atof function
    movsd [num1], xmm0       ; Store the result in num1

    ; Call atof function to convert input string to floating point number
    mov rdi, input2   ; Pass the address of input string
    call atof               ; Call the atof function
    movsd [num2], xmm0        ; Store the result in num2

    ; Calculate arithmetic mean
    movsd xmm0, [num1]
    addsd xmm0, [num2]      ; Add both numbers
    divsd xmm0, [two]       ; Divide by 2 to find the mean
    movsd [result], xmm0    ; Store the result

    ; Print the result
    mov rdi, format_float
    mov rax, 1
    call printf

ret

section .text
extern printf

section .text
extern atof

