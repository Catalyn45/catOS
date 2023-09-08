CC  = /usr/local/i386elfgcc/bin/i386-elf-gcc
CFLAGS = -g

ASM = nasm

LD  = /usr/local/i386elfgcc/bin/i386-elf-ld
GDB = /usr/local/i386elfgcc/bin/i386-elf-gdb

C =$(shell find ./src -name "*.c")
OBJ=$(patsubst %,obj/%.o,$(basename $(C)))

default: image.bin

boot.bin: $(wildcard src/boot/*.asm)
	$(ASM) -o $@ -f bin $<

obj/src/kernel/entry.o: src/kernel/entry.asm
	$(ASM) $< -f elf -o $@

obj/./src/%.o: src/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -ffreestanding -o $@ -c $<

kernel.bin: obj/src/kernel/entry.o $(OBJ)
	$(LD) -s -o $@ -Ttext 0x1000 --oformat binary $^

kernel.elf: obj/src/kernel/entry.o $(OBJ)
	$(LD) -o $@ -Ttext 0x1000 $^

image.bin: boot.bin kernel.bin
	cat $^ > $@

run: image.bin
	qemu-system-i386 -drive file=$(<),format=raw

debug: image.bin kernel.elf
	qemu-system-i386 -s -S -drive file=image.bin,format=raw&
	$(GDB) -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

clean:
	rm *.bin *.elf
	rm obj/src/kernel/entry.o
	rm $(OBJ)

