%define ORG 0x7c00
%define STACK 0x9000
%define KERNEL 0x1000

[bits 16]

[org ORG]

mov bp, STACK ; setup stack
mov sp, bp

load_kernel:
    push kernel_loading
    call print

    push KERNEL
    push 1
    call disk_read ; read 2 sectors

    push kernel_loaded
    call print

    call switch

    jmp $

[bits 32]
main:
    mov ebx, msg
    call print_string_pm ; Note that this will be written at the top left corner

    call KERNEL

forever:
    hlt
    jmp forever

[bits 16]
%include "boot/print.asm"
%include "boot/disk.asm"
%include "boot/gdt.asm"

%include "boot/switch.asm"
%include "boot/print_pm.asm"

[bits 16]
kernel_loaded: db "kernel loaded", 0
kernel_loading: db "loading kernel", 0
msg: db "32bit entered", 0

times 510-($-$$) db 0
db 0x55, 0xaa

