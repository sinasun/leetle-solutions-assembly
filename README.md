# leetle-solutions-assembly

**I don't plan to do all days as i dont have time for it, feel free to open a pr if you have done any of days that i am missing. **

# Leetle solutions in assembly

## How to run

to run you can simply do this (replace the day number):

```bash
nasm -felf32 -g -Fdwarf day1.asm -o day1.o && ld -m elf_i386 day1.o -o day1 && ./day1
```
