<div align="center">
  <img src="logo.png" alt="sandbox-x86asm" width="512"/>

  # sandbox-x86asm

  **Learn x86 assembly programming through hands-on examples with NASM syntax**

  [Quick Start](#quick-start) · [Examples](#examples) · [Architecture Reference](#architecture-reference)
</div>

## Overview

A playground for learning x86 assembly programming with practical examples covering both 32-bit and 64-bit architectures. Each program demonstrates a specific concept with detailed comments explaining syscalls, registers, and assembly patterns.

## Features

- **Dual Architecture Support** - Examples for both x86 (32-bit) and x64 (64-bit)
- **Commented Source Code** - Every line explained for learning
- **Progressive Complexity** - From "Hello World" to functions and loops
- **Single Build Script** - Compile and run any example with one command

## Quick Start

```bash
# Clone the repository
git clone https://github.com/tsilva/sandbox-x86asm.git
cd sandbox-x86asm

# Run a 32-bit example
bash ./run.sh 001-hello_x86.asm x86

# Run a 64-bit example
bash ./run.sh 002-hello_x64.asm x64
```

## Examples

| # | Program | Architecture | Concepts |
|---|---------|--------------|----------|
| 001 | `hello_x86.asm` | x86 | `sys_write`, `sys_exit`, `int 0x80` |
| 002 | `hello_x64.asm` | x64 | `sys_write`, `sys_exit`, `syscall` |
| 003 | `input.asm` | x64 | `sys_read`, stdin, buffers |
| 004 | `write-file.asm` | x64 | `sys_open`, `sys_write`, `sys_close`, file I/O |
| 006 | `execute-cmd.asm` | x64 | `sys_execve`, program execution |
| 007 | `print-integer.asm` | x64 | Integer to string conversion, `div`, `test` |
| 008 | `functions.asm` | x64 | Functions, stack frames, `call`/`ret`, loops |

## Architecture Reference

### x86 (32-bit)

| Register | Purpose |
|----------|---------|
| `eax` | Syscall number / return value |
| `ebx` | First argument |
| `ecx` | Second argument |
| `edx` | Third argument |

```nasm
mov eax, 4          ; sys_write
mov ebx, 1          ; stdout
mov ecx, msg        ; buffer
mov edx, len        ; length
int 0x80            ; call kernel
```

### x64 (64-bit)

| Register | Purpose |
|----------|---------|
| `rax` | Syscall number / return value |
| `rdi` | First argument |
| `rsi` | Second argument |
| `rdx` | Third argument |

```nasm
mov rax, 1          ; sys_write
mov rdi, 1          ; stdout
mov rsi, msg        ; buffer
mov rdx, len        ; length
syscall             ; call kernel
```

### Common Syscalls

| Syscall | x86 Number | x64 Number |
|---------|------------|------------|
| `sys_read` | 3 | 0 |
| `sys_write` | 4 | 1 |
| `sys_open` | 5 | 2 |
| `sys_close` | 6 | 3 |
| `sys_exit` | 1 | 60 |
| `sys_execve` | 11 | 59 |

## Requirements

- **NASM** - Netwide Assembler
- **ld** - GNU linker
- **Linux** - For syscall compatibility

```bash
# Install on Debian/Ubuntu
sudo apt install nasm

# Install on Arch
sudo pacman -S nasm
```

## License

MIT
