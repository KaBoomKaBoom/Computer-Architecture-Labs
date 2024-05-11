;string to int conversion

section .bss
    input_buffer resb 256     ; Buffer to store user input

section .data
    input_prompt db "Enter the string to convert: ", 0  ; Prompt string
    format_int db "Coverted integer: %ld", 10   ; Format string for printing integer
section .text
    global _start

ex4:

    ; Display prompt message
    mov rax, 1                  ; syscall number for sys_write
    mov rdi, 1                  ; file descriptor 1 (stdout)
    mov rsi, input_prompt             ; pointer to the prompt message
    mov rdx, 30                 ; length of the prompt message
    syscall                     ; invoke the system call

    ; Read user input
    mov rax, 0                 ; sys_read syscall number
    mov rdi, 0                 ; stdin file descriptor
    mov rsi, input_buffer      ; Address of the input buffer
    mov rdx, 256               ; Maximum number of bytes to read
    syscall

    ; Call atoi1 function to convert input string to integer
    mov rdi, input_buffer   ; Pass the address of input string
    call atoi1               ; Call the atoi1 function

    ; Print the converted integer
    mov rsi, rax            ; Pass the integer to be printed
    mov rdi, format_int     ; Pass the format string for printing integer
    xor rax, rax            ; Clear RAX register for syscall number (sys_write)
    call printf             ; Call printf function

ret

section .text
extern printf

global atoi1
global ex4
    
atoi1:
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
