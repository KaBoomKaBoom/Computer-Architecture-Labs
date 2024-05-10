;invert string

section .data
    msg times 64 db 0 
    max equ 64
    prompt_msg db 'Enter string: ', 0
    

section .text
    global _start

_start:
    ; Prompt user to enter string 1
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_msg
    mov rdx, 16
    syscall

    ; Read
    mov rdx,max
    mov rsi,msg
    mov rdi,0
    mov rax,0
    syscall

    mov rcx,rax     ; Copy the string for later
    mov rdi,msg     ; Set RDI and RSI to point at message
    mov rsi,msg     ;
    add rdi,rax     ; RDI should point at last character in message
    dec rdi         ;
    shr rax,1       ; Divide length by 2

    .loop           ; Begin loop:
    mov bl,[rsi]    ; Swap the characters using 8 bit registers
    mov bh,[rdi]    ; 
    mov [rsi],bh    ; 
    mov [rdi],bl    ; 
    inc rsi         ; Increment rsi (which is a pointer)
    dec rdi         ; Decrement rdi (also a pointer)
    dec rax         ; Decrement our counter
    jnz .loop       ; If our counter isn't zero, keep looping

    ; Write
    .write
    mov rdx,rcx ; nbytes
    mov rsi,msg ; *msg
    mov rdi,1 ; stream
    mov rax,1 ; syscall
    syscall

    ; Exit
    mov rdi,0 ; exit code
    mov rax,60 ; syscall
    syscall