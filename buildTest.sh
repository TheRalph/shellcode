#!/bin/bash

if test $# -eq 0
then
     echo "Synthax: $0 shellcode.asm"
     exit 0
fi

if test ! -f $1
then
     echo "'$1' is not found"
     exit 0
fi

SHELL_CODE_SRC=${1%%.*}

BUILD_FOLDER=buildFolder

rm -rf $BUILD_FOLDER
mkdir -p $BUILD_FOLDER

cd $BUILD_FOLDER
cp ../$1 .

echo "Compiling ..."
nasm -f elf64 "$SHELL_CODE_SRC".asm -o "$SHELL_CODE_SRC".o

echo "Linking ..."
ld "$SHELL_CODE_SRC".o -o "$SHELL_CODE_SRC.bin"

objcopy -O binary --only-section=.text -I elf64-x86-64 "$SHELL_CODE_SRC.bin" OpCodes.bin
SHELL_CODE=$(hexdump -v -e '"\\""x" 1/1 "%02x" ""'  OpCodes.bin)

echo "void _start(){" > "$SHELL_CODE_SRC.c"
echo "   char ShellCode[] =\\" >> "$SHELL_CODE_SRC.c"
echo "\"$SHELL_CODE\";" >> "$SHELL_CODE_SRC.c"
echo "   (*(void(*)())ShellCode)();" >> "$SHELL_CODE_SRC.c"
echo "}" >> "$SHELL_CODE_SRC.c"

gcc "$SHELL_CODE_SRC.c" -o "$SHELL_CODE_SRC" -nostdlib -nostartfiles -fno-stack-protector -z execstack

cp "$SHELL_CODE_SRC.c" "$SHELL_CODE_SRC" "$SHELL_CODE_SRC.bin" ..

cd ..
rm -rf "$BUILD_FOLDER"
