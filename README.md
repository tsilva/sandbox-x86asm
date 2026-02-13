<div align="center">
  <img src="logo.png" alt="sandbox-x86asm" width="512"/>

  **🔧 Playground for x86 and x64 assembly programming with NASM 💻**

</div>

## Overview

A playground for x86 assembly programming with example programs demonstrating various assembly concepts using NASM (Netwide Assembler) syntax. Includes both 32-bit (x86) and 64-bit (x64) examples.

## Features

- **Dual architecture** - Examples for both x86 and x64
- **Progressive learning** - Numbered programs from basic to advanced
- **Build script** - Simple `run.sh` for compilation and execution
- **NASM syntax** - Industry-standard assembler

## Quick Start

```bash
# Clone the repository
git clone https://github.com/tsilva/sandbox-x86asm.git
cd sandbox-x86asm

# Run 32-bit example
bash ./run.sh 001-hello_x86.asm x86

# Run 64-bit example
bash ./run.sh 002-hello_x64.asm x64
```

## Examples

| File | Description |
|------|-------------|
| `001-hello_x86.asm` | Hello World (32-bit) |
| `002-hello_x64.asm` | Hello World (64-bit) |
| `003-input.asm` | User input handling |
| `004-write-file.asm` | File operations |
| `006-execute-cmd.asm` | Command execution |
| `007-print-integer.asm` | Integer to string conversion |
| `008-functions.asm` | Function calls |

## Architecture Reference

| | x86 (32-bit) | x64 (64-bit) |
|---|---|---|
| Registers | `eax`, `ebx`, `ecx`, `edx` | `rax`, `rdi`, `rsi`, `rdx` |
| Syscall | `int 0x80` | `syscall` |
| sys_write | 4 | 1 |
| sys_exit | 1 | 60 |

## Requirements

- NASM
- GNU ld
- Linux (for syscalls)

## License

MIT
