#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

if [ $# -ne 2 ]; then
    echo "Usage: $0 <asm_file> <arch (x86 or x64)>"
    exit 1
fi

ASM_FILE="$1"
ARCH="$2"
BASE_NAME="${ASM_FILE%.*}"
OBJ_FILE="${BASE_NAME}.o"
BIN_FILE="${BASE_NAME}.bin"

# Validate ARCH
if [[ "$ARCH" != "x86" && "$ARCH" != "x64" ]]; then
  echo "Error: Architecture must be 'x86' or 'x64'"
  exit 1
fi


if [ "$ARCH" == "x64" ]; then
    echo "Building x64 assembly"
    nasm -f elf64 -o "$OBJ_FILE" "$ASM_FILE"
    ld -o "$BIN_FILE" "$OBJ_FILE"
    chmod +x "$BIN_FILE"
elif [ "$ARCH" == "x86" ]; then
    echo "Building x86 assembly"
    nasm -f elf32 -o "$OBJ_FILE" "$ASM_FILE"
    ld -m elf_i386 -o "$BIN_FILE" "$OBJ_FILE"
    chmod +x "$BIN_FILE"
fi

if [ -f "$BIN_FILE" ]; then
    echo "Executing $BIN_FILE:"
    ./"$BIN_FILE"
else
    echo "Build failed"
    exit 1
fi