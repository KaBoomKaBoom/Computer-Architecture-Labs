global _start       ; make the label _start visible externally
 
extern WriteFile        ; include the WriteFile function
extern GetStdHandle     ; include the GetStdHandle function
 
section .data   ; data section
message: db "Hello! This is my first program!",10  ; string to output to console
 
section .text       ; code section declaration
_start:             ; _start label - entry point of the program
    sub  rsp, 40   ; Allocate space on the stack for function parameters (40 bytes)
    mov  rcx, -11  ; Set the argument for GetStdHandle to STD_OUTPUT (-11)
    call GetStdHandle ; Call the GetStdHandle function to obtain a handle to the standard output
    mov  rcx, rax     ; Set the file descriptor (handle) for WriteFile to the handle obtained from GetStdHandle
    mov  rdx, message    ; Set the pointer to the message to be written to the console
    mov  r8d, 35      ; Set the length of the message string to be written
    xor  r9, r9       ; Initialize the parameter for WriteFile (used to store the number of bytes written)
    mov  qword [rsp + 32], 0  ; Initialize the fifth parameter for WriteFile (used to store the number of bytes written)
    call WriteFile ; Call the WriteFile function to write the message to the console
    add  rsp, 40 ; Deallocate the space allocated on the stack for function parameters
    ret             ; exit the program





