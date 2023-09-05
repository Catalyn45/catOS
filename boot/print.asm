print_char:
    push bp
    mov bp, sp

    mov ah, 0x0e
    mov al, [bp + 4]
    int 0x10

    jmp print_end

print:
    push bp
    mov bp, sp

    mov bx, [bp + 4] ; get string

    mov ah, 0x0e

print_loop:
    mov al, [bx]

    cmp al, 0
    je print_end

    int 0x10

    inc bx
    jmp print_loop

print_end:
    leave

    ret

