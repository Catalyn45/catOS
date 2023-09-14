global port_byte_in
global port_byte_out
global port_word_in
global port_word_out

port_byte_in:
    push ebp
    mov ebp, esp

    mov edx, [ebp + 8]
    in al, dx

    leave
    ret

port_byte_out:
    push ebp
    mov ebp, esp

    mov edx, [ebp + 8]
    mov eax, [ebp + 12]

    out dx, al

    leave
    ret

port_word_in:
    push ebp
    mov ebp, esp

    mov edx, [ebp + 8]
    in ax, dx

    leave
    ret

port_word_out:
    push ebp
    mov ebp, esp

    mov edx, [ebp + 8]
    mov eax, [ebp + 12]

    out dx, ax

    leave
    ret

