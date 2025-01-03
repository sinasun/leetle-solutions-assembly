# leetle-solutions-assembly

Leetle solutions in assembly

to run you can simply do this (replace the day number):

```bash
nasm -felf32 -g -Fdwarf day1.asm -o day1.o && ld -m elf_i386 day1.o -o day1 && ./day1
```
