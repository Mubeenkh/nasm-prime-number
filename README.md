# nasm-prime-number
Comp 228: Prime Number using Nasm Intel x86

## Install NASM
```$ sudo apt update```
```$ sudo apt install nasm```
```$ nasm --version```

## Install GDB (GNU Debugger)
```$ sudo apt install gdb```

## How to Assemble the program on Linux
- Use a text editor to write your program <br>
        E.g., **nano or vim**

- Save it under **<program_name>.asm** <br>
    ```$ nano helloWorld.asm```
 
- Use nasm to create the object file (<program_name>.obj) <br>
    ```$ nasm -f elf32 -g helloWorld.asm –o helloWorld.o```

- Create an executable file: <br>
    ```$ ld –m elf_i386 -g helloWorld.o -o helloWorld```

- Run the executable file: <br>
    ```$ ./helloWorld```

## How to Debug



- Load the program in the debugger: <br> 
    ```gdb ./helloWorld```

- Set Intel Syntax
    ```(gdb) set disassembly-flavor intel```

- Set a breakpoint
    ```(gdb) break _start```

- Run the program
    ```(gdb) run```

- View Assembly and Registers
    ```(gdb) layout asm (or a)```
    ```(gdb) layout regs```

- Perform next step
    ```(gdb) stepi (or nexti)```

- Quit the program and debugger
    ```(gdb) q```

