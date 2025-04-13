# nasm-prime-number
Comp 228: Prime Number using Nasm Intel x86

## How to Assemble the program

- Use a text editor to write your program
        E.g., nano or vim

- Save it under <program_name>.asm
    ```$ nano helloWorld.asm```
 
- Use nasmto create the object file (<program_name>.obj)
    ```$ nasm -f elf32 -g helloWorld.asm –o helloWorld.o```

- Create an executable file: 
    ```$ ld –m elf_i386 -g helloWorld.o -o helloWorld```

- Run the executable file:
    ```$ ./helloWorld```