switch:
    cli ; stop interupts
    lgdt [gdt_descriptor] ; load gdt descriptor
    mov eax, cr0
    or eax, 0x1 ; set 32bit mode
    mov cr0, eax
    jmp CODE_SEG:init ; far jump

