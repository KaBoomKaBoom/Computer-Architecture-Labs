;larger number between 2 numbers

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

    format_int db "Larger number: %ld", 10   ; Format string for printing integer
section .bss
    num1 resb 8
    num2 resb 8
    result resb 16
    input1 resb 256     ; Buffer to store user input
    input2 resb 256     ; Buffer to store user input

section .text
    global _start

_start:
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

    ; Call atoi function to convert input string to integer
    mov rdi, input1   ; Pass the address of input string
    call atoi               ; Call the atoi function
    mov [num1], rax        ; Store the result in num1

    ; Call atoi function to convert input string to integer
    mov rdi, input2   ; Pass the address of input string
    call atoi               ; Call the atoi function
    mov [num2], rax        ; Store the result in num1

    ; Compare the numbers
    mov rax, [num1]
    cmp rax, [num2]
    jge num1_is_greater
    mov rax, [num2]   ; If num2 is greater, load it into rax
    jmp print_result

num1_is_greater:
    mov rax, [num1]   ; If num1 is greater, load it into rax

print_result:
    ; Print the larger number
    mov [result], rax

    ; Print the converted integer
    mov rsi, [result]            ; Pass the integer to be printed
    mov rdi, format_int     ; Pass the format string for printing integer
    xor rax, rax            ; Clear RAX register for syscall number (sys_write)
    call printf             ; Call printf function

    ; Exit
    mov rax, 60
    xor rdi, rdi
    syscall

section .text
extern printf
global atoi
    
atoi:
    mov rax, 0              ; Set initial total to 0
     
convert:
    movzx rsi, byte [rdi]   ; Get the current character
    test rsi, rsi           ; Check for \0
    je done
    
    cmp rsi, 48             ; Anything less than 0 is invalid
    jl done
    
    cmp rsi, 57             ; Anything greater than 9 is invalid
    jg done
     
    sub rsi, 48             ; Convert from ASCII to decimal 
    imul rax, 10            ; Multiply total by 10
    add rax, rsi            ; Add current digit to total
    
    inc rdi                 ; Get the address of the next character
    jmp convert

done:
    ret                     ; Return total
