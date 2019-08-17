; Simple code to display the contents of a file using 'cat'

SYS_EXECVE equ 59  ; 0x3B
SYS_EXIT   equ 60  ; 0x3C
 
section .text
global _start
 
_start:
; jmp short MainCode
MainCode:

; SYS_EXECVE needs to use 3 registers:
; rdi : const char *filename
; rsi : const char *const argv[]
; rdx : const char *const envp[]

; rdi : const char *filename
	xor  rax, rax
	mov  rbx, '/bin/cat'
	push rax
	push rbx
	mov  rdi, rsp           ; set rdi with cmd

; rsi : const char *const argv[]
  mov  rbx, rsp ; cmd

	push rax
	mov  rcx, 'leToRead'
  push rcx
	mov  rcx, './////fi'
  push rcx
  mov  rcx, rsp ; param 

	push rax
  push rcx
  push rbx

	mov  rsi, rsp           ; set rsi with array   

; rdx : const char *const envp[]
  xor  rdx, rdx           ; no envp

; rax : sys_execve
  xor  rax, rax
  mov  al, SYS_EXECVE     ; rax = sys_execve

  syscall

; Exit the code
	mov  rax, SYS_EXIT
	mov  rdi, 0
	syscall
