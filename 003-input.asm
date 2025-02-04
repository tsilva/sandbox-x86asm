section .bss
    buffer resb 128    ; Reserve 128 bytes for input

section .text
    global _start

_start:
    ; sys_read (0 = stdin)
    mov rax, 0        ; syscall: sys_read
    mov rdi, 0        ; file descriptor: stdin
    mov rsi, buffer   ; buffer to store input
    mov rdx, 128      ; max bytes to read
    syscall           ; Call kernel

    ; sys_write (print user input back)
    mov rax, 1        ; syscall: sys_write
    mov rdi, 1        ; file descriptor: stdout
    mov rsi, buffer   ; message (user input)
    mov rdx, 128      ; length (same as input)
    syscall           ; Call kernel

    ; sys_exit (60 = exit)
    mov rax, 60       
    xor rdi, rdi    ; exit code 0, could be "mov rdi, 0" but that would take more bytes, require moving a value to the register and prevent out-of-order execution (xor rdi, rdi can be executed without waiting because its result is always zero)
    syscall
