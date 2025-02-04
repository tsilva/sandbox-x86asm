section .data
    path db "/bin/ls", 0  ; Program to execute
    null dq 0             ; NULL for argv/envp

section .text
    global _start

_start:
    mov rax, 59         ; syscall: sys_execve
    mov rdi, path       ; Path to program
    mov rsi, null       ; argv[] = NULL
    mov rdx, null       ; envp[] = NULL
    syscall

    ; sys_exit (if execve fails)
    mov rax, 60
    xor rdi, rdi
    syscall
