section .data
    charset db 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,;.+-="', 0

    ; Messages
    msg1 db 'Enter length: ', 0
    lmsg1 equ $ - msg1

    str_len equ 64   ; Maximum length of the generated string
    str: times str_len db 0
    nlinea db 10, 0
    lnlinea equ $ - nlinea

section .bss
    len resb 4
    input resb 256     ; Buffer to store user input

section .text
    global ex10

ex10:
    ; Print message 1
    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, lmsg1
    syscall

    ; Read user input
    mov rax, 0                  ; sys_read syscall number
    mov rdi, 0                  ; stdin file descriptor
    mov rsi, input              ; Address of the input buffer
    mov rdx, 256                ; Maximum number of bytes to read
    syscall

    ; Convert input string to integer
    mov rdi, input              ; Address of the input buffer
    call atoi                   ; Call the atoi function
    mov [len], eax             ; Store the result in len

    ; Generate random string
    mov ecx, eax                ; Set loop counter to the length entered by the user
    lea rdi, [str]

generate_string:
    rdtsc                       ; Get timestamp for random seed
    and eax, 94                 ; Limit to size of charset
    lea rsi, [charset]
    movzx eax, byte [rsi+rax]   ; Get a random character from charset
    stosb                       ; Store character in str
    loop generate_string        ; Repeat until the desired length is reached

    ; Print the string
    mov eax, 1
    mov edi, eax
    lea rsi, [str]
    mov edx, [len]              ; Print only the specified length
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, nlinea
    mov rdx, lnlinea
    syscall

ret

atoi:
    xor rax, rax                ; Set initial total to 0

convert:
    movzx rsi, byte [rdi]       ; Get the current character
    test rsi, rsi               ; Check for \0
    je done

    cmp rsi, 48                 ; Anything less than '0' is invalid
    jl done

    cmp rsi, 57                 ; Anything greater than '9' is invalid
    jg done

    sub rsi, 48                 ; Convert from ASCII to decimal
    imul rax, 10                ; Multiply total by 10
    add rax, rsi                ; Add current digit to total

    inc rdi                     ; Get the address of the next character
    jmp convert

done:
    ret                         ; Return total
