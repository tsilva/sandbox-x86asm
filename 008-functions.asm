section .data
    msg db "Sum: %d", 10, 0  ; Format string for printf.  %d for integer, 10 for newline, 0 for null terminator.
    newline db 10, 0

section .bss
    num_buffer resb 12    ; Reserve 12 bytes for the number buffer (large enough for a signed 64-bit integer)

section .text
    global _start

;-----------------------------------------------------------------------------
; Function: add_numbers
; Purpose: Adds two numbers.
; Arguments:
;   - rdi: First number
;   - rsi: Second number
; Returns:
;   - rax: The sum of the two numbers.
;-----------------------------------------------------------------------------
add_numbers:
    mov rax, rdi      ; Move first number into rax (return register).
    add rax, rsi      ; Add the second number to rax.
    ret               ; Return

;-----------------------------------------------------------------------------
; Function: print_number
; Purpose: Prints a number using our own custom function.
; Arguments:
;   - rdi: The number to print.
;-----------------------------------------------------------------------------
print_number:
    push rbp
    mov rbp, rsp

    push rdi            ; Save the number.
    push rsi            ; Save rsi (used in conversion).
    push rdx            ; Save rdx (used in conversion).
    push rcx            ; Save rcx.
    push rax            ; Save rax

    mov rax, rdi        ; Number to convert.
    mov rdi, num_buffer ; Pointer to the buffer.
    call int_to_string ; Convert integer to string.

    mov rdi, num_buffer  ; String to print.
    call print_string     ; Print the string.

    mov rdi, newline ; Print a newline.
    call print_string

    pop rax            ; Restore rax
    pop rcx            ; Restore rcx
    pop rdx            ; Restore rdx
    pop rsi            ; Restore rsi
    pop rdi            ; Restore rdi

    pop rbp
    ret

;-----------------------------------------------------------------------------
; Function: int_to_string
; Purpose: Converts an integer to a string.  Handles negative numbers.
; Arguments:
;   - rax: The integer to convert.
;   - rdi: Pointer to the buffer to store the string.
; Returns:
;   - rdi: Pointer to the buffer.
;-----------------------------------------------------------------------------
int_to_string:
    push rbp
    mov rbp, rsp

    push rbx            ; Save rbx.
    push rcx            ; Save rcx.
    push rdx            ; Save rdx.

    mov rbx, rdi       ; Store the buffer pointer in rbx.
    mov rcx, 0         ; Digit counter.

    ; Handle the negative case.
    test rax, rax
    jge positive_number

    ; Negative number.  Make it positive.
    neg rax
    mov byte [rbx], '-' ; Add the minus sign.
    inc rbx              ; Increment the pointer.

positive_number:

conversion_loop:
    ; Divide by 10.
    xor rdx, rdx        ; Clear rdx for division.
    mov rsi, 10         ; Divisor.
    div rsi             ; rax = rax / rsi, rdx = rax % rsi

    ; Convert remainder to ASCII digit.
    add rdx, '0'        ; Add ASCII '0' to get the digit character.

    ; Store the digit in the buffer (in reverse order).
    push rdx            ; Push the digit onto the stack.
    inc rcx             ; Increment digit counter.

    ; Check if quotient is zero.
    test rax, rax
    jnz conversion_loop   ; If not zero, loop again.

; Store the digits in the buffer (in correct order).
store_digits_loop:
    pop rdx
    mov byte [rbx], dl
    inc rbx
    loop store_digits_loop ; Use loop instruction because rcx is already set up

; Null-terminate the string.
    mov byte [rbx], 0     ; Null terminator.

    mov rdi, rbx        ; return pointer to the last element in string.

    pop rdx
    pop rcx
    pop rbx

    mov rsp, rbp
    pop rbp
    ret

;-----------------------------------------------------------------------------
; Function: print_string
; Purpose: Prints a null-terminated string using the write system call.
; Arguments:
;   - rdi: Pointer to the string.
;-----------------------------------------------------------------------------
print_string:
    push rbp
    mov rbp, rsp

    push rbx
    push rcx
    push rdx

    ; Calculate the string length.
    mov rbx, rdi       ; Store the string pointer.
    mov rcx, 0         ; Initialize length counter.
string_length_loop:
    mov al, byte [rbx + rcx] ; Load a byte from the string.
    test al, al          ; Check if it's the null terminator.
    jz string_length_done  ; If null terminator, we're done.
    inc rcx              ; Increment the counter.
    jmp string_length_loop ; Loop again.
string_length_done:

    ; Now perform the write syscall.
    mov rax, 1          ; System call number for write.
    mov rdi, 1          ; File descriptor 1 (stdout).
    mov rsi, rbx        ; Pointer to the string.
    mov rdx, rcx        ; Number of bytes to write.
    syscall             ; Make the system call.

    pop rdx
    pop rcx
    pop rbx

    mov rsp, rbp
    pop rbp
    ret

_start:
    ; Initialize loop counter.
    mov rcx, 10         ; Loop 10 times.

loop_start:
    ; Calculate the numbers to add (using the loop counter).
    mov rdi, rcx        ; First number is the loop counter.
    mov rsi, rcx        ; Second number is the loop counter.
    add rsi, 5         ; Add 5 to the second number to make it different each time.

    ; Call add_numbers.
    call add_numbers      ; Call the custom add_numbers function.  Result in rax.

    ; Print the result.
    mov rdi, rax        ; Move the sum to rdi to pass to print_number.
    call print_number     ; Call the custom print_number function.

    ; Decrement loop counter.
    loop loop_start       ; Decrement rcx and jump back to loop_start if rcx is not zero.

    ; Exit the program.
    mov rax, 60         ; System call number for exit.
    xor rdi, rdi        ; Exit code 0.
    syscall             ; Make the system call.