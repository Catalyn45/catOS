%define ORG 0x7c00
%define STACK 0x9000
%define KERNEL 0x1000

[org ORG]

mov bp, STACK ; setup stack
mov sp, bp

load_kernel:
    push kernel_loading
    call print

    push KERNEL
    push 2
    call disk_read ; read 2 sectors

    push kernel_loaded
    call print

    call switch

    jmp $

kernel_loaded: db "kernel loaded", 0
kernel_loading: db "loading kernel", 0
msg: db "32bit entered", 0

%include "src/boot/print.asm"
%include "src/boot/disk.asm"
%include "src/boot/gdt.asm"
%include "src/boot/switch.asm"

%include "src/boot/start.asm"
%include "src/boot/print_pm.asm"

times 510-($-$$) db 0
db 0x55, 0xaa

