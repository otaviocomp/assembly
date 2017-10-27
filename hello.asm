section.text
global_start

_start:
	mov edx, len					;message len
	mov ecx, msg					;message to write 
	mov ebx, 1						;file descriptor(stdout)
	mov eax, 4						;system call number (sys_write)
	int 0x80						;call kernel

	mov eax, 1						;system call number(sys_exit)
	int 0x80						;call kernel

section.data
	msg db 'Hello Wolrld!', 0xa		;string to be printed
	len equ $ -msg					;length of the string
