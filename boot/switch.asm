[bits 16]
switch:
    cli ; stop interupts
    lgdt [gdt_descriptor] ; load gdt descriptor
    mov eax, cr0
    or eax, 0x1 ; set 32bit mode
    mov cr0, eax
    jmp CODE_SEG:init ; far jump

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
