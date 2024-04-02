; Define system call numbers
SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

section .data 
    ; Define message to prompt user to enter a digit
    msg db "Enter a digit ", 0xA,0xD   ; Newline and carriage return characters
    len equ $- msg                      ; Calculate length of message

section .bss
    ; Reserve space for variables
    number1 resb 2                      ; Reserve space for the first number
    number2 resb 2                      ; Reserve space for the second number
    result resb 1                       ; Reserve space for the result

section .text 
    ; Define another message to prompt user to enter second digit
    msg2 db "Enter second digit", 0xA,0xD 
    len2 equ $- msg2 

    ; Define message for displaying the sum
    msg3 db "The sum is: "
    len3 equ $- msg3

global _start 

_start: 
    ; Prompt user to enter the first digit
    mov eax, SYS_WRITE         ; System call to write
    mov ebx, STDOUT            ; File descriptor for standard output
    mov ecx, msg               ; Address of the message
    mov edx, len               ; Length of the message
    int 0x80                   ; Invoke the system call

    ; Read the first digit entered by the user
    mov eax, SYS_READ          ; System call to read
    mov ebx, STDIN             ; File descriptor for standard input
    mov ecx, number1           ; Address to store the input
    mov edx, 2                 ; Number of bytes to read
    int 0x80                   ; Invoke the system call

    ; Prompt user to enter the second digit
    mov eax, SYS_WRITE         ; System call to write
    mov ebx, STDOUT            ; File descriptor for standard output
    mov ecx, msg2              ; Address of the message
    mov edx, len2              ; Length of the message
    int 0x80                   ; Invoke the system call

    ; Read the second digit entered by the user
    mov eax, SYS_READ          ; System call to read
    mov ebx, STDIN             ; File descriptor for standard input
    mov ecx, number2           ; Address to store the input
    mov edx, 2                 ; Number of bytes to read
    int 0x80                   ; Invoke the system call

    ; Display message indicating sum calculation
    mov eax, SYS_WRITE         ; System call to write
    mov ebx, STDOUT            ; File descriptor for standard output
    mov ecx, msg3              ; Address of the message
    mov edx, len3              ; Length of the message
    int 0x80                   ; Invoke the system call

    ; Load number1 into eax and subtract '0' to convert from ASCII to decimal
    mov eax, [number1]
    sub eax, '0'
    ; Do the same for number2
    mov ebx, [number2]
    sub ebx, '0'

    ; Add eax and ebx, storing the result in eax
    add eax, ebx
    ; Add '0' to eax to convert the digit from decimal to ASCII
    add eax, '0'

    ; Store the result in result
    mov [result], eax

    ; Print the result digit
    mov eax, SYS_WRITE         ; System call to write
    mov ebx, STDOUT            ; File descriptor for standard output
    mov ecx, result            ; Address of the result
    mov edx, 1                 ; Length of the result
    int 0x80                   ; Invoke the system call

exit:    
    ; Exit the program
    mov eax, SYS_EXIT          ; System call to exit
    xor ebx, ebx               ; Exit code 0
    int 0x80                   ; Invoke the system call
