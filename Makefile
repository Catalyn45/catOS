all: image.bin

boot.bin: boot/boot.asm boot/print.asm boot/disk.asm boot/switch.asm boot/gdt.asm boot/print_pm.asm
	nasm -o $@ -f bin $<

entry.o: kernel/entry.asm
	nasm $< -f elf -o $@

kernel.o: kernel/kernel.c
	i386-elf-gcc -ffreestanding -o $@ -c $<

kernel.bin: entry.o kernel.o
	i386-elf-ld -o $@ -Ttext 0x1000 --oformat binary $^

image.bin: boot.bin kernel.bin
	cat $^ > $@

run: image.bin
	qemu-system-i386 $<

clean:
	rm kernel.o
	rm kernel.bin
	rm boot.bin
	rm image.bin
