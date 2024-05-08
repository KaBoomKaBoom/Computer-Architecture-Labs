section .data
    fmt_input db "%d", 0             ; Format string for input of the first long long integer
    fmt_input2 db "%d", 0            ; Format string for input of the second long long integer
    fmt db "%d", 0                    ; Format string for printing a long long integer
    divide_by_zero_error db "Error: Division by zero", 0
    conversion_error_msg db "Error: Conversion failed", 0

section .bss
    num1 resq 1                         ; Reserve space for the first integer
    num2 resq 1                         ; Reserve space for the second integer
    input1 resb 20                      ; Reserve space for input string 1
    input2 resb 20                      ; Reserve space for input string 2

section .text
    extern printf, scanf, atoi, exit    ; Declare external C functions

global _start
_start:
    ; Prompt for input of the first integer
    mov     rdi, fmt_input
    mov     rsi, input1                 ; Address of input string 1
    call    scanf                       ; Call scanf to read the first integer from stdin

    ; Check for conversion errors
    mov     rdi, input1
    call    atoi
    test    rax, rax                    ; Check if conversion was successful
    js      conversion_error            ; Jump to conversion error if sign flag is set
    ; Print the first converted number
    mov     rdi, fmt
    mov     rsi, rax                 ; Load the converted number from memory
    call    printf                      ; Print the converted number
    mov     [num1], rax                 ; Store the converted integer back


    ; Prompt for input of the second integer
    mov     rdi, fmt_input2
    mov     rsi, input2                 ; Address of input string 2
    call    scanf                       ; Call scanf to read the second integer from stdin

    ; Check for conversion errors
    mov     rdi, input2
    call    atoi
    test    rax, rax                    ; Check if conversion was successful
    js      conversion_error            ; Jump to conversion error if sign flag is set
    mov     [num2], rax                 ; Store the converted integer back

    ; Print the second converted number
    mov     rdi, fmt
    mov     rsi, [num2]                 ; Load the converted number from memory
    call    printf                      ; Print the converted number

    ; Check for division by zero
    cmp     qword [num2], 0             ; Compare num2 with zero
    je      division_error              ; If zero, jump to division error

    ; Divide num1 by num2
    mov     rax, [num1]
    mov     rbx, [num2]
    cqo
    div     rbx

    ; Print the result of division
    mov     rdi, fmt
    mov     rsi, rax
    call    printf                      ; Print the result of division

    ; Exit the program
    mov     eax, 0                      ; System call number for exit
    call    exit                        ; Invoke exit to terminate the program

division_error:
    ; Print division by zero error message
    mov     rdi, divide_by_zero_error
    call    printf

    ; Exit the program with error
    mov     eax, 1                      ; System call number for exit
    call    exit                        ; Invoke exit to terminate the program

conversion_error:
    ; Print conversion error message
    mov     rdi, conversion_error_msg
    call    printf

    ; Exit the program with error
    mov     eax, 1                      ; System call number for exit
    call    exit                        ; Invoke exit to terminate the program
