gdt_start:
    dd 0x00
    dd 0x00

gdt_code:
    dw 0xffff    ; segment length
    dw 0x0000    ; segment base
    db 0x00      ; segment base
    db 10011010b ; flags
    db 11001111b ; flags
    db 0x00      ; segment base

gdt_data:
    dw 0xffff    ; segment length
    dw 0x0000    ; segment base
    db 0x00      ; segment base
    db 10010010b ; flags
    db 11001111b ; flags
    db 0x00      ; segment base

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

