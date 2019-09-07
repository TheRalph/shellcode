; Simple code to display the contents of a file using open/read/write
 
section .text
global _start
 
_start:
jmp PathFileToRead ; jump to get the path of the file to read

;;;;;;;;;;;;;;
_openFile:
  pop rdi          ; the path to read is now at the address stored by rdi
  push 2
  pop rax          ; SYS_OPEN
  xor rsi, rsi     ; set O_RDONLY flag
  syscall

;;;;;;;;;;;;;;
_readFile:
  push rax
  pop rdi          ; put the fd which is the open result into rdi
  xor al, al       ; SYS_READ
  add sp, -0x30    ; allocate 30 bytes on stack
  push rsp
  pop rsi          ; set rsi with the stack address (allocated buffer)
  push 0x30
  pop rdx          ; set the size to read (30)
  syscall

;;;;;;;;;;;;;;
_writeFile:
  push rax
  pop rdx          ; put the read size to rdx
  mov al, 1        ; SYS_WRITE
  mov dil, 1       ; STD_OUTPUT
  syscall

;;;;;;;;;;;;;;
; Exit the code
_exit:
	xor  al, al
  add al, 60       ; SYS_EXIT
	xor dil, dil
	syscall

;;;;;;;;;;;;;;
PathFileToRead:
  call _openFile
  db "./fileToRead", 0


