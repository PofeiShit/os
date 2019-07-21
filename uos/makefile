src=hellos.s
obj=hellos.o
elf=hellos.elf
boot=hellos.bin

$(boot):$(hellos)
	gcc -c $(src) -m32 -o $(obj)
	ld $(obj) -e start -Ttext 0x7c00 -o $(elf)
	objcopy -S -O binary -j .text $(elf) $(boot)

writeusb:
	dd if=hellos.bin of=\\.\Volume{19572513-924e-11e8-afeb-806e6f6e6963} bs=512 count=1