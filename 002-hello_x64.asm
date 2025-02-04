section .data
    msg db 'Hello, World!', 0xa  ; String with newline
    len equ $ - msg              ; Length of string

section .text
    global _start

_start:
    ; write syscall
    mov rax, 1          ; syscall number (sys_write)
    mov rdi, 1          ; file descriptor (stdout)
    mov rsi, msg        ; message to write
    mov rdx, len        ; message length
    syscall             ; call kernel

    ; exit syscall
    mov rax, 60         ; syscall number (sys_exit)
    mov rdi, 0          ; exit code 0
    syscall             ; call kernel
