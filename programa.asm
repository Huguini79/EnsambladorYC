section .data
    msg1        db      'Soy el proceso padre!', 0x0A, 0x0D
    msg1_len    equ     $ - msg1

    msg2        db      'Soy el proceso hijo!', 0x0A, 0x0D
    msg2_len    equ     $ - msg2

    msg3        db      'Proceso hijo terminado!', 0x0A, 0x0D
    msg3_len    equ     $ - msg3

    exit_code       db      0

section .text
    global _start
    global child_process
    global father_process


%define SYS_WRITE 1
%define SYS_FORK 57
%define SYS_EXIT 60
%define SYS_WAIT 61

%define STDOUT 1

%define EXIT_SUCCESS 0

_start:
    mov rax, SYS_FORK
    syscall

    cmp eax, 0
        je child_process
    jne father_process

child_process:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, msg2
    mov rdx, msg2_len
    syscall

    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall

father_process:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, msg1
    mov rdx, msg1_len
    syscall

    mov rax, SYS_WAIT
    mov rdi, 0
    mov rsi, exit_code
    mov rdx, 0
    mov r10, 0
    syscall

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, msg3
    mov rdx, msg3_len
    syscall

    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall