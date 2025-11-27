clean:
	rm boot.bin

qemu:
	qemu-system-i386 -boot a -fda boot.bin

bin:
	nasm -f bin boot/boot.asm -o boot.bin

all:
	rm boot.bin
	nasm -f bin boot/boot.asm -o boot.bin
	qemu-system-i386 -boot a -fda boot.bin
	clear