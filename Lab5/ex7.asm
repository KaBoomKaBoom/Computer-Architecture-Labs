;decimal to hexadecimal

section .data
    ; Messages
    msg1 db 'Enter a number to convert to hexadecimal: ', 0
    lmsg1 equ $ - msg1

    msg2 db 'Hexadecimal representation: ', 0
    lmsg2 equ $ - msg2

    nlinea db 10, 0
    lnlinea equ $ - nlinea

    format_str db "Hexadecimal representation: %s", 10   ; Format string for printing string

section .bss
    num resb 8
    result resb 20
    input resb 256     ; Buffer to store user input

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
    mov rsi, input             ; Address of the input buffer
    mov rdx, 256               ; Maximum number of bytes to read
    syscall

    ; Call atoi function to convert input string to integer
    mov rdi, input             ; Pass the address of input string
    call atoi                  ; Call the atoi function
    mov [num], rax             ; Store the result in num

    ; Convert integer to hexadecimal
    mov rdi, [num]             ; Pass the integer to be converted
    mov rsi, result            ; Pass the address of the result buffer
    call itoa                  ; Call the itoa function

    ; Reverse the string
    mov rdi, result            ; Pass the address of the result buffer
    call reverse_string       ; Call the reverse_string function

    mov rsi, result            ; Pass the result to be printed
    mov rdi, format_str        ; Pass the format string for printing string
    xor rax, rax               ; Clear RAX register for syscall number (sys_write)
    call printf                ; Call printf function

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

section .text
extern printf
global atoi
global itoa
global reverse_string

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

itoa:
    ; Function to convert integer to ASCII string in hexadecimal format
    ; Input: rdi - Integer to convert
    ;        rsi - Address of the buffer to store the result
    ; Output: rsi - Address of the resulting ASCII string
    xor rcx, rcx            ; Clear the counter
    mov rax, rdi            ; Copy the integer to RAX
    mov rbx, 16             ; Set the base to 16 (hexadecimal)
.hex_loop:
    xor rdx, rdx            ; Clear the remainder
    div rbx                 ; Divide RDX:RAX by the base
    add dl, '0'             ; Convert remainder to ASCII
    cmp dl, '9'             ; Check if its a digit
    jbe .store_digit        ; If yes, store it directly
    add dl, 7               ; If not, adjust to get 'A' - 'F'
.store_digit:
    mov byte [rsi+rcx], dl ; Store the digit in the buffer
    inc rcx                 ; Move to the next position in the buffer
    test rax, rax           ; Check if quotient is zero
    jnz .hex_loop           ; If not, continue
    mov byte [rsi+rcx], 0  ; Null-terminate the string
    ret                     ; Return

reverse_string:
    ; Function to reverse a null-terminated string in place
    ; Input: rdi - Address of the string
    mov rsi, rdi            ; Copy address of the string to RSI
    xor rcx, rcx            ; Clear the counter
.find_end:
    inc rcx                 ; Increment the counter
    cmp byte [rsi+rcx], 0  ; Check if the current character is null
    jnz .find_end           ; If not, continue searching
    dec rcx                 ; Decrement the counter to point to the last character
    mov rdx, rcx            ; Copy the counter to RDX (number of characters)
    shr rdx, 1              ; Divide RDX by 2 to get the number of iterations
    xor rcx, rcx            ; Reset RCX to the beginning of the string
.reverse_loop:
    cmp rcx, rdx            ; Check if we've reached the middle of the string
    jae .done               ; If yes, we are done
    mov al, [rdi+rcx]       ; Swap characters
    mov r8, rdx             ; Use R8 as a temporary register
    sub r8, rcx
    mov dl, [rdi+r8]
    mov [rdi+r8], al
    mov [rdi+rcx], dl
    inc rcx                 ; Move to the next character from the beginning
    jmp .reverse_loop       ; Continue reversing
.done:
    ret                     ; Return
