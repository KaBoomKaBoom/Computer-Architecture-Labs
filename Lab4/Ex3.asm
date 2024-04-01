    SYS_EXIT  equ 1
    SYS_READ  equ 3
    SYS_WRITE equ 4
    STDIN     equ 0
    STDOUT    equ 1

segment .data 

    msg db "Enter a digit ", 0xA,0xD 
    len equ $- msg 

segment .bss

    number1 resb 2 
    number2 resb 2 
    result resb 1    

segment .text 

    msg2 db "Enter second digit", 0xA,0xD 
    len2 equ $- msg2 

    msg3 db "The sum is: "
    len3 equ $- msg3

global _start 

 _start: 

    mov eax, SYS_WRITE         
    mov ebx, STDOUT         
    mov ecx, msg         
    mov edx, len 
    int 0x80                

    mov eax, SYS_READ 
    mov ebx, STDIN  
    mov ecx, number1 
    mov edx, 2
    int 0x80            

    mov eax, SYS_WRITE        
    mov ebx, STDOUT         
    mov ecx, msg2          
    mov edx, len2         
    int 0x80

    mov eax, SYS_READ  
    mov ebx, STDIN  
    mov ecx, number2 
    mov edx, 2
    int 0x80        

    mov eax, SYS_WRITE         
    mov ebx, STDOUT         
    mov ecx, msg3          
    mov edx, len3         
    int 0x80

    ; load number1 into eax and subtract '0' to convert from ASCII to decimal
    mov eax, [number1]
    sub eax, '0'
    ; do the same for number2
    mov ebx, [number2]
    sub ebx, '0'

    ; add eax and ebx, storing the result in eax
    add eax, ebx
    ; add '0' to eax to convert the digit from decimal to ASCII
    add eax, '0'

    ; store the result in result
    mov [result], eax

    ; print the result digit
    mov eax, SYS_WRITE        
    mov ebx, STDOUT
    mov ecx, result         
    mov edx, 1        
    int 0x80


exit:    
    mov eax, SYS_EXIT   
    xor ebx, ebx 
    int 0x80
