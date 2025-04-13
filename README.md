# nasm-prime-number
Comp 228: Prime Number using Nasm Intel x86

## How to Assemble the program

- Use a text editor to write your program <br>
        E.g., **nano or vim**

- Save it under **<program_name>.asm** <br>
    ```$ nano helloWorld.asm```
 
- Use nasmto create the object file (<program_name>.obj) <br>
    ```$ nasm -f elf32 -g helloWorld.asm –o helloWorld.o```

- Create an executable file: <br>
    ```$ ld –m elf_i386 -g helloWorld.o -o helloWorld```

- Run the executable file: <br>
    ```$ ./helloWorld```