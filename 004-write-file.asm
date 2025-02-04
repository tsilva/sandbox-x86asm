section .data
    filename db "output.txt", 0   ; File name (null-terminated)
    msg db "Hello File!", 0xA     ; Message
    len equ $ - msg               ; Message length

section .bss
    buffer resb 128               ; Read buffer (128 bytes)

section .text
    global _start

_start:
    ; sys_open (O_WRONLY | O_CREAT)
    mov rax, 2         ; syscall: sys_open
    mov rdi, filename  ; filename pointer
    mov rsi, 577       ; O_WRONLY | O_CREAT | O_TRUNC (decimal 64 | 1 | 512)
    mov rdx, 0644      ; File permissions (rw-r--r--)
    syscall            

    ; sys_write (Write to file)
    mov rdi, rax       ; sys_open file descriptor returned in rax, file pointer for sys_write in rdi
    mov rax, 1         ; syscall: sys_write
    mov rsi, msg       ; Message pointer
    mov rdx, len       ; Message length
    syscall            

    ; sys_close (Close file)
    mov rax, 3         ; syscall: sys_close
    syscall            

    ; sys_exit
    mov rax, 60
    xor rdi, rdi
    syscall
