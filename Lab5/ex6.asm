; factorial of a number

section .data
    ; Messages
    msg1 db 'Enter a number to calculate its factorial: ', 0
    lmsg1 equ $ - msg1

    msg2 db 'Result: ', 0
    lmsg2 equ $ - msg2

    nlinea db 10, 0
    lnlinea equ $ - nlinea

    format_int db "Result: %ld", 10   ; Format string for printing integer

section .bss
    num resb 8
    result resb 64
    input resb 256     ; Buffer to store user input

section .text
    global ex6

ex6:
    ; Print message 1
    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, lmsg1
    syscall

    ; Read user input
    mov rax, 0                 ; sys_read syscall number
    mov rdi, 0                 ; stdin file descriptor
    mov rsi, input             ; Address of the input buffer
    mov rdx, 256               ; Maximum number of bytes to read
    syscall

    ; Call atoi3 function to convert input string to integer
    mov rdi, input             ; Pass the address of input string
    call atoi3                  ; Call the atoi3 function
    mov [num], rax             ; Store the result in num

    ; Calculate factorial
    mov rax, 1                 ; Initialize result to 1
    mov rcx, [num]             ; Load the input number

.factorial_loop:
    imul rax, rcx              ; Multiply result by current number
    dec rcx                    ; Decrement current number
    jnz .factorial_loop        ; Repeat until current number is zero

mov rsi, rax               ; Pass the result to be printed
ret

section .text
extern printf
global atoi3
    
atoi3:
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
