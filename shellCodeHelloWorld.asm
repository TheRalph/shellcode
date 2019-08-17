; nasm -f elf64 shellCodeHelloWorld.asm -o shellCodeHelloWorld.o
; ld shellCodeHelloWorld.o -o shellCodeHelloWorld

; objcopy -O binary --only-section=.text -I elf64-x86-64 shellCodeHelloWorld OpCodes.bin
; hexdump -v -e '"\\""x" 1/1 "%02x" ""'  OpCodes.bin

SYS_WRITE equ 1
SYS_EXIT equ 60
STD_OUTPUT equ 1
 
section .text
global _start
 
_start:
jmp short MainCode
	msg: db `shellCode: "Hello world!"\n`
	msglen equ $-msg
 
MainCode:
	mov rax, SYS_WRITE
	mov rdi, STD_OUTPUT
	lea rsi, [rel msg]
	mov rdx, msglen
	syscall
 
	mov rax, SYS_EXIT
	mov rdi, 0
	syscall
