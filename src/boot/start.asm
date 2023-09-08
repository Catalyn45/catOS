[bits 32]
init:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp

    call main

main:
    mov ebx, msg
    call print_string_pm ; Note that this will be written at the top left corner

    call KERNEL

forever:
    hlt
    jmp forever

