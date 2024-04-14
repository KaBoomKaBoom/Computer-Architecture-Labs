section .data
    num_randoms equ 10
    range equ 55
    format db "%d", 10, 0  ; Adding newline character (10) after each number

section .text
    global _start

_start:
    ; Initialize random seed
    mov     rdi, 0       ; Null pointer for time
    call    time
    mov     rdi, rax     ; Set seed for srand
    call    srand

    ; Initialize loop counter
    mov     rcx, num_randoms  ; Load the loop counter with the number of random numbers to generate

generate_loop:
    
    ; Call rand to get a random number
    call    rand
    xor     rdx, rdx           ; Clear upper bits of rdx
    mov     rdi, range         ; Load the upper limit for the random number
    dec     rdi                ; Decrement range to make it between 0 and range-1
    call    mod                ; Ensure the number is in the range [0, range-1]
    inc     rax                ; Increment to make it between 1 and range

    ; Print the random number
    mov     rsi, rax           ; Load the random number to rsi for printing
    mov     rdi, format        ; Load the format string
    xor     rax, rax           ; Clear rax for syscall write
    call    printf

    ; Print newline character
    mov     rsi, newline       ; Load the newline character to rsi
    mov     rdi, 1             ; File descriptor 1 (stdout)
    mov     rdx, 1             ; Length of the string (1 byte for newline character)
    mov     rax, 1             ; syscall number for write
    syscall
    
    dec rcx
    jnz    generate_loop      ; Jump to generate_loop if ecx is not zero


exit_program:
    ; Exit the program
    mov     eax, 60      ; syscall number for exit
    xor     edi, edi     ; Exit status 0
    syscall

; C library functions
extern srand, rand, printf
extern time

section .text
mod:
    ; Calculate rax % rdi and return both the quotient and the remainder
    push    rdx             ; Save rdx on the stack
    mov     rdx, 0          ; Clear rdx
    div     rdi             ; rax = rax / rdi, rdx = rax % rdi
    mov     rax, rdx        ; Return the remainder in rax
    pop     rdx             ; Restore rdx from the stack
    ret

section .data
    newline db 10        ; Newline character