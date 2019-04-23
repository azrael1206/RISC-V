#!/bin/sh

export CC=riscv32-unknown-linux-gnu-gcc
export LD=riscv32-unknown-linux-gnu-gcc
export OBJCOPY=riscv32-unknown-linux-gnu-objcopy

export CFLAGS="-std=c99 -ffreestanding -fno-stack-protector -fno-delete-null-pointer-checks -fconserve-stack -fno-strict-aliasing -fno-common -march=rv32i -mabi=ilp32 -msmall-data-limit=0 -mcmodel=medany"
export LDFLAGS="-Wl,-melf32lriscv -nostdlib -mabi=ilp32 "

$CC $CFLAGS -c -o main.o main.c
$CC $CFLAGS -c -o start.o start.S
$LD $LDFLAGS -o test.elf -T test.ld main.o start.o -lgcc
$OBJCOPY -j .text -j .rodata -j .data -Obinary test.elf program.bin
