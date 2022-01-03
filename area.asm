; System calls
SYS_WRITE		equ		1

; File descriptors
FD_STDOUT		equ		1

; External symbols
extern libPuhfessorP_printSignedInteger64
extern libPuhfessorP_inputSignedInteger64


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Begin the data section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section	.data
; Strings
msg1 		db 	"This area function is fondly brought to you by Sasan Ejbari.",13,10
msg1_len	equ	$-msg1
msg2 		db 	"Pleae enter the radius of a circle in whole number of meters: "
msg2_len	equ	$-msg2
msg3 		db 	"The number "
msg3_len	equ	$-msg3
msg4 		db 	" was received.",13,10
msg4_len	equ	$-msg4
msg5 		db 	"The area of a circle with this radius is "
msg5_len	equ	$-msg5
msg6 		db 	" and "
msg6_len	equ	$-msg6
msg7 		db 	"/"
msg7_len	equ	$-msg7
msg8 		db 	" square meters. ", 13, 10
msg8_len	equ	$-msg8
msg9 		db 	"The integer part of the area will be returned to the main program. Please enjoy your circles.", 13, 10, 13, 10
msg9_len	equ	$-msg9

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Begin the text section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section	.text

global area
area:
	; Save registers
	push rbx
	
	; Print out welcome message with a system call
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg1				; Provide the memory location to start reading our characters to print
	mov rdx, msg1_len			; Provide the number of characters print
	syscall
	
	; Print out the message asking for the radius
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg2				; Provide the memory location to start reading our characters to print
	mov rdx, msg2_len			; Provide the number of characters print
	syscall
	
	; Read integer as input from user
	call libPuhfessorP_inputSignedInteger64
	mov rbx, rax				; save the radius in rbx
	
	; Print out the received radius 
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg3				; Provide the memory location to start reading our characters to print
	mov rdx, msg3_len			; Provide the number of characters print
	syscall
	
	mov rdi, rbx
	call libPuhfessorP_printSignedInteger64

	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg4				; Provide the memory location to start reading our characters to print
	mov rdx, msg4_len			; Provide the number of characters print
	syscall
	
	; Calculate the area of the circle
	mov rax, rbx				; rax = radius
	mul rax						; rdx:rax = radius*radius
	mov rcx, 22				
	mul rcx						; rdx:rax = radius*radius*22
	mov rcx, 7
	div rcx						; rax = radius*radius*22/7
	mov rbx, rax
	push rdx					; save quotient of the division
	push rax					; save remainder of the division 
		
	; Print out the calculated area
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg5				; Provide the memory location to start reading our characters to print
	mov rdx, msg5_len			; Provide the number of characters print
	syscall
	
	pop rdi
	call libPuhfessorP_printSignedInteger64
	
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg6				; Provide the memory location to start reading our characters to print
	mov rdx, msg6_len			; Provide the number of characters print
	syscall
	
	pop rdi
	call libPuhfessorP_printSignedInteger64
	
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg7				; Provide the memory location to start reading our characters to print
	mov rdx, msg7_len			; Provide the number of characters print
	syscall
	
	mov rdi, 7
	call libPuhfessorP_printSignedInteger64
	
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg8				; Provide the memory location to start reading our characters to print
	mov rdx, msg8_len			; Provide the number of characters print
	syscall
	
	; Print the bye message
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg9				; Provide the memory location to start reading our characters to print
	mov rdx, msg9_len			; Provide the number of characters print
	syscall
	
	; Return
	mov rax, rbx
	pop rbx
	ret

