; string to lowecase

section .data
    input_string resb 255 ; Input string to be converted to lowercase
    output_string resb 255 ; Reserve space for the output string
    format db "Lower case: ", 0 ; Format string for printing integer (newline added)
    prompt_msg db 'Enter string: ', 0 ; Prompt message for user input
section .text
    global _start
    extern printf

_start:

    ; Prompt user to enter string
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_msg
    mov rdx, 16
    syscall

    ; Read input string
    mov rax, 0            ; syscall number for sys_read
    mov rdi, 0            ; file descriptor 0 (stdin)
    mov rsi, input_string ; buffer to read into
    mov rdx, 255          ; number of bytes to read
    syscall

    ; Call the function to convert the string to lowercase
    mov rdi, input_string
    mov rsi, output_string
    call to_lowercase

    ; Print formatted message
    mov rdi, format
    call printf

    ; Print the lowercase string
    mov rdi, output_string
    call printf

    ; Exit the program
    mov rax, 60         ; syscall number for exit
    xor rdi, rdi        ; exit code 0
    syscall

to_lowercase:
    ; Loop through each character of the string until null terminator
    .tolower_loop:
        mov al, byte [rdi]     ; Load the current character
        test al, al            ; Check for null terminator
        jz .tolower_done       ; If null terminator, exit loop

        ; Convert uppercase letters to lowercase
        cmp al, 'A'
        jb .tolower_continue
        cmp al, 'Z'
        ja .tolower_continue
        add al, 32             ; 'A'-'a' = 32
    .tolower_continue:
        mov byte [rsi], al     ; Store the lowercase character
        inc rdi                ; Move to the next character in input string
        inc rsi                ; Move to the next character in output string
        jmp .tolower_loop      ; Repeat for the next character
    .tolower_done:
        ret
