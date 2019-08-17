# shellcode

First steps to develop shellcodes on x86 64bits:
```
nasm -f elf64 shellCodeHelloWorld.asm -o shellCodeHelloWorld.o
ld shellCodeHelloWorld.o -o shellCodeHelloWorld

objcopy -O binary --only-section=.text -I elf64-x86-64 shellCodeHelloWorld OpCodes.bin
hexdump -v -e '"\\""x" 1/1 "%02x" ""'  OpCodes.bin
```

All is done into the `buildTest.sh` script which will produce a `.c` file and a `.bin` file from a `.asm`.
The `.c` file is just a launcher of the the shell code, so you can fins the shell code by using `cat` on the `.c` file.
The `.bin` file is just the compiled and linked binary generated from the `.asm`.
```
./buildTest.sh shellCodeHelloWorld.asm
```

