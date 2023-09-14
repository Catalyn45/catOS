set pagination off

target remote localhost:1234
symbol-file kernel.elf

tui en
b main
c

