section .bss
    buffer resb 20  ; Reserve 20 bytes for number string

section .text
    global _start

_start:
    mov rax, 1234   ; Store the number to be printed in "rax"
    mov rbx, 10     ; Specify the base we will divide the number by to pluck out the digits
    mov rdi, buffer + 19  ; Move to the end of the buffer, since we'll be plucking digits from right to left, we want to write in buffer from right to left
    mov byte [rdi], 10  ; Store newline character at the end of the buffer
    dec rdi ; Move back one byte to store next character

convert:
    xor rdx, rdx    ; Remainders of division done by "div" op are stored in "rdx", zero it out first // WHY?
    div rbx         ; Divide "rax" by "rbx" (10), this will pluck out the digit into the remainder in "rdx"
    add dl, '0'     ; "dl" represents the lower 8 bits of "rdx", the byte we just plucked by performing "div" on "rax". By adding '0', we move the value into the range of ASCII digits, turning it into a character
    mov [rdi], dl   ; Store the digit in the buffer memory address currently targeted by "rdi"
    dec rdi         ; Move the pointer back one byte to store the next digit
    test rax, rax   ; This sets ZF flag if "rax" is zero, which means we have no more digits to convert
    ;cmp rax, 0     ; This is an alternative to the "test" instruction, this would perform a subtraction without storing the result, setting the flags accordingly, namely the ZF flag (but also the SF, OF, CF flags); this op is slower though...
    jnz convert     ; If ZF flag is not set, the instruction pointer jumps back to the "convert" label to convert the next digit
    
    inc rdi         ; Move the pointer forward one byte to the first printable character

    ; sys_write (Print number)
    mov rax, 1            ; Indicate that we want to use the sys_write syscall
    mov rsi, rdi          ; Move the pointer to the start of the string to print
    mov rdx, buffer + 19  ; Store the address of the end of the buffer
    sub rdx, rdi          ; Subtract the end of the buffer "rdx" from the start of the buffer "rsi" to get the length of the string, the result is stored in "rdx"
    add rdx, 1            ; Add 1 to the length to include the newline character
    mov rdi, 1            ; Specify the file descriptor (stdout)
    syscall               ; Call the kernel to print the number

    ; sys_exit
    mov rax, 60           ; Indicate that we want to use the sys_exit syscall
    xor rdi, rdi          ; Set the exit code to 0
    syscall               ; Call the kernel to exit the program
