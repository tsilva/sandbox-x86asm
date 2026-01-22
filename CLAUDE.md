# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a playground for x86 assembly programming, containing example programs that demonstrate various assembly concepts using NASM (Netwide Assembler) syntax.

## Build and Execution

Use the `run.sh` script to compile and execute assembly programs:

```bash
bash ./run.sh <asm_file> <arch>
```

Where `<arch>` is either `x86` (32-bit) or `x64` (64-bit).

Examples:
```bash
bash ./run.sh 001-hello_x86.asm x86
bash ./run.sh 002-hello_x64.asm x64
```

The script automatically:
- Assembles the `.asm` file with NASM (`nasm -f elf32` for x86 or `nasm -f elf64` for x64)
- Links the object file with `ld` (using `-m elf_i386` for x86)
- Executes the resulting binary
- Does not clean up intermediate files (`.o` and `.bin` files remain)

## Architecture Notes

**x86 (32-bit)**:
- Uses registers: `eax`, `ebx`, `ecx`, `edx`
- Syscalls via `int 0x80`
- Syscall numbers: `sys_write = 4`, `sys_exit = 1`
- Linking requires `-m elf_i386` flag

**x64 (64-bit)**:
- Uses registers: `rax`, `rdi`, `rsi`, `rdx`
- Syscalls via `syscall` instruction
- Syscall numbers: `sys_write = 1`, `sys_exit = 60`
- Standard ELF64 linking

## Program Naming Convention

Programs are numbered sequentially (e.g., `001-hello_x86.asm`, `002-hello_x64.asm`). When creating new programs, continue this numbering scheme.

## README Maintenance

README.md must be kept up to date with any significant project changes, including new program additions or architectural modifications.
