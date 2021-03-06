echo Building HackedOS...
nasm bootload.asm
dd if=/dev/zero of=floppya.img bs=512 count=2880
dd if=bootload of=floppya.img bs=512 count=1 conv=notrunc
dd if=map.img of=floppya.img bs=512 count=1 seek=1 conv=notrunc
dd if=dir.img of=floppya.img bs=512 count=1 seek=2 conv=notrunc
#hexdump -C floppya.img
#rm kernel.o
#rm kernel_asm.o
bcc -ansi -c -o kernel.o kernel.c
as86 kernel.asm -o kernel_asm.o
ld86 -o kernel -d kernel.o kernel_asm.o
dd if=kernel of=floppya.img bs=512 conv=notrunc seek=3
#bcc -ansi -c -o fib.o fib.c
#as86 lib.asm -o lib_asm.o
#ld86 -o fib -d fib.o lib_asm.o
#gcc -o loadFile loadFile.c
#./loadFile test2
#./loadFile fib
hexdump -C floppya.img | more
#echo Executing the OS...
#bochs -f osxterm.txt
