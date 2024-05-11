section .data
    choice_prompt db "Select a process from 1 to 10, or enter 0 to exit:", 10
    menu db "1. Compare strings", 10
         db "2. Inverting a string", 10
         db "3. Substraction of 2 numbers", 10
         db "4. String to int conversion", 10
         db "5. Division of 2 numbers", 10
         db "6. Factorial of a given number", 10
         db "7. String to lower case", 10
         db "8. Larger of 2 numbers", 10
         db "9. Arithmetic mean of 2 integer/real numbers", 10
         db "10. Generate a random string", 10
         db "0. Exit", 10
    invalid_choice db "Invalid choice. Please try again.", 10
    choice db 0, 0, 0, 0, 0 ; 4 bytes for input and 1 byte for null-terminator
    num dq 0

    format_int db "Result: %ld", 10, 0   ; Format string for printing integer
    format_float db "Result: %f", 10   ; Format string for printing floating point number

section .text
    global main
    extern ex1, ex2, ex3, ex4, ex5, ex6, ex7, ex8, ex9, ex10, atoi,printf

main:
    ; display menu
    mov rax, 1           ; syscall number for sys_write
    mov rdi, 1           ; file descriptor 1 (stdout)
    mov rsi, choice_prompt
    mov rdx, 334      ; message length
    syscall

    ; read choice from user
    mov rax, 0           ; syscall number for sys_read
    mov rdi, 0           ; file descriptor 0 (stdin)
    mov rsi, choice
    mov rdx, 4           ; number of bytes to read
    syscall

    ; null-terminate the string
    mov byte [rsi+rdx], 0

    ; Call atoi function to convert input string to integer
    mov rdi, choice   ; Pass the address of input string
    call atoi               ; Call the atoi function
    mov [num], rax        ; Store the result in num

    ; perform the chosen process
    cmp qword [num], 0
    je exit_program
    cmp qword [num], 1
    je call_ex1
    cmp qword [num], 2
    je call_ex2
    cmp qword [num], 3
    je call_ex3
    cmp qword [num], 4
    je call_ex4
    cmp qword [num], 5
    je call_ex5
    cmp qword [num], 6
    je call_ex6
    cmp qword [num], 7
    je call_ex7
    cmp qword [num], 8
    je call_ex8
    cmp qword [num], 9
    je call_ex9
    cmp qword [num], 10
    je call_ex10

    ; invalid choice
    mov rax, 1           ; syscall number for sys_write
    mov rdi, 1           ; file descriptor 1 (stdout)
    mov rsi, invalid_choice
    mov rdx, 32          ; message length
    syscall
    jmp main

exit_program:
    ; exit program
    mov rax, 60          ; syscall number for sys_exit
    xor rdi, rdi         ; exit code 0
    syscall

call_ex1:
    call ex1
    jmp main

call_ex2:
    call ex2
    jmp main

call_ex3:
    call ex3
    ; Print the converted integer
    mov rdi, format_int     ; Pass the format string for printing integer
    mov rsi, rax            ; Pass the integer to be printed
    xor rax, rax            ; Clear RAX register for syscall number (sys_write)
    call printf             ; Call printf function
    jmp main 

call_ex4:
    call ex4
        ; Print the converted integer
    mov rdi, format_int     ; Pass the format string for printing integer
    mov rsi, rax            ; Pass the integer to be printed
    xor rax, rax            ; Clear RAX register for syscall number (sys_write)
    call printf             ; Call printf function
    jmp main

call_ex5:
    call ex5
    mov rdi, format_int        ; Pass the format string for printing integer
    mov rsi, rax            ; Pass the integer to be printed
    xor rax, rax               ; Clear RAX register for syscall number (sys_write)
    call printf                ; Call printf function

    jmp main

call_ex6:
    call ex6
    mov rdi, format_int        ; Pass the format string for printing integer
    mov rsi, rax            ; Pass the integer to be printed
    xor rax, rax               ; Clear RAX register for syscall number (sys_write)
    call printf                ; Call printf function
    jmp main

call_ex7:
    call ex7
    jmp main

call_ex8:
    call ex8
    mov rdi, format_int     ; Pass the format string for printing integer
    xor rax, rax            ; Clear RAX register for syscall number (sys_write)
    call printf             ; Call printf function
    jmp main

call_ex9:
    call ex9
        ; Print the result
    mov rdi, format_float
    mov rax, 1
    call printf
    jmp main

call_ex10:
    call ex10
    jmp main