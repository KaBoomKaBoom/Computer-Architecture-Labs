; Program to add two numbers
section .text
	global main
main:
	; handles the first input
	mov eax, 4; write
	mov ebx, 1; std_out
	mov ecx, [rel msg1]; what to write
	mov edx, msg1_len
	int 0x80; sys_call
	; perform computations
	mov eax, 3; grab data from keyboard
	mov ebx, 0;
	mov ecx, [rel num1];
	mov edx, 5; remember our 5 bytes
	int 0x80
	; handles the second input
	mov eax, 4; write
	mov ebx, 1; std_out
	mov ecx, [rel msg2]; what to write
	mov edx, msg2_len
	int 0x80
	; perform computations
	mov eax, 3; grab data from keyboard
	mov ebx, 0;
	mov ecx, [rel num2];
	mov edx, 5; remember our 5 bytes
	int 0x80
	mov eax, 4
	mov ebx, 1
	mov ecx, [rel msg]
	mov edx, msg_len
	int 0x80
    ; write final output
    movzx eax, byte [rel num1] ; Load ASCII character of num1 into AL and zero-extend to EAX
    sub eax, '0'           ; Convert ASCII character to integer
    movzx ebx, byte [rel num2] ; Load ASCII character of num2 into BL and zero-extend to EBX
    sub ebx, '0'           ; Convert ASCII character to integer
    add eax, ebx           ; Add the integers
    add eax, '0'           ; Convert integer result back to ASCII character
    mov [rel res], al      ; Store the result
    mov eax, 4
    mov ebx, 1
    mov ecx, [rel res]           ; Write result
    mov edx, 1             ; We only write one byte
    int 80h

exit:
	mov eax, 1
	int 80h

section .data
	msg1 db "Enter num 1: "
	msg1_len equ $ - msg1
	msg2 db "Enter num 2: "
	msg2_len equ $ - msg2
	msg db "The sum is: "
	msg_len equ $ - msg
section .bss
	num1 resb 5 ; res 5 bytes
	num2 resb 5
	res resb 5