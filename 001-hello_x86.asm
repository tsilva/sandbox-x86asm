section .data
    msg db 'Hello, World!', 0xa  ; String with newline
    len equ $ - msg              ; Length of string

section .text
    global _start

_start:
    ; write syscall
    mov eax, 4          ; syscall number (sys_write)
    mov ebx, 1          ; file descriptor (stdout)
    mov ecx, msg        ; message to write
    mov edx, len        ; message length
    int 0x80            ; call kernel

    ; exit syscall
    mov eax, 1          ; syscall number (sys_exit)
    mov ebx, 0          ; exit code 0
    int 0x80            ; call kernel
