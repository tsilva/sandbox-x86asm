# sandbox-x86asm

A playground for x86 assembly programming.

## Usage

Use the run.sh script to compile and execute assembly programs:

```bash
bash ./run.sh 001-hello_x86.asm x86     # run 32-bit program
bash ./run.sh 001-hello_x64.asm x64     # run 64-bit program
```

The script will:
1. Compile and link the program for the specified architecture
2. Execute the resulting binary
3. Clean up temporary files
