disk_read:
    push bp
    mov bp, sp

    push dx

    mov bx, [bp + 6] ; where to place the data in memory
    mov al, [bp + 4] ; sectors to read
    mov ah, 0x02     ; 0x02 = 'read'
    mov cl, 0x02     ; where to start ( second sector )
    mov ch, 0x00     ; cylinder
    mov dh, 0x00     ; head number

    int 0x13 ; call read routine

    pop dx

disk_end:
    leave

    ret
