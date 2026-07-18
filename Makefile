CC = gcc
AS = nasm -f elf64
LD = ld

all:
	$(CC) programa.c -o programa_c
	$(AS) programa.asm -o programa.o
	$(LD) programa.o -o programa_asm
