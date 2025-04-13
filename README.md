# nasm-prime-number
Comp 228: Prime Number using Nasm Intel x86

## Install NASM
```$ sudo apt update``` <br> 
```$ sudo apt install nasm``` <br> 
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

- Set Intel Syntax <br> 
    ```(gdb) set disassembly-flavor intel```

- Set a breakpoint <br> 
    ```(gdb) break _start```

- Run the program <br> 
    ```(gdb) run```

- View Assembly and Registers <br> 
    ```(gdb) layout asm (or a)```
    ```(gdb) layout regs```

- Perform next step <br> 
    ```(gdb) stepi (or nexti)```

- Quit the program and debugger <br> 
    ```(gdb) q```

- How to view data in register <br>
    Ex: ```print $al```

- How to view data in *number* and *answer* memory location <br> 
    Ex: ```x/1xb &answer```

## Registers being used

```AX```: 16-bits register <br>
- ```AL```: first 8 bits, works as the Quotient when performing division
- ```AH```: last 8 bits, works as the Remainder when performing division

```BX```: 16-bits register <br>
- ```BL```: first 8 bits, works as the Dividor in this program


# Useful Information

## Code to exit program
```
mov eax, 1                          ; set syscall number for sys_exit 
mov ebx, 0                          ; set exit code to 0
int 0x80                            ; call kernel
```
## Code to print out a message on the terminal
```
mov eax, 4                          ; set syscall number for sys_write
mov ebx, 1                          ; set file descriptor to stdout
mov ecx, prime_msg                  ; load address of message to print 
mov edx, 16                         ; set length of message 
int 80h
```
## Check if Number = 1
```
cmp byte [number] , 1               ; if Number = 1, then it's NOT prime
je not_prime_print
```
Since 1 is not divisible by anything other than itself, then it is neither a Prime number or a Composite number. In this case, it is NOT a Prime number.

## Specifying to use bytes
In the section .data, when declaring the variables, we specified the program to use byte-size (db) variables. This means the range of number that can be used are from 0 to 255:
```
    number db 7                     ; 8-bits: 0000 0111 
    answer db 1                     ; 8-bits: 0000 0001
```
When comparing, you need to remind the program to compare using byte-sized variables by specifying that they are bytes:
```
    cmp byte [number] , 1
```

## Division
We are Moving the ```Number = 0000 0111``` into ```AX```, which is a 16 bit sized register, so ```AX = 0000 0000 0000 0111```
```
    movzx ax, [number]
```
We are doing the same with ```BL``` and ```BX```. ```BL``` is set to 2  ```mov bl, 2```, but to compare the data in ```BL```  with ```AX```, both need to be the same size of bites, which is why we set ```BX``` with the same data as ```BL```.
```
    movzx bx, bl
    cmp bx, ax
```

When performing the division, the program will always divide ```AL``` by ```BL```, since we specified the ```Number``` variable to have a 8 bits.
Why? The highest value ```Number``` can have is ```1111 1111```, meaning ```AX``` would be equal to ````0000 0000 1111 1111```, where ```AH = 0000 0000``` and ```AL = 1111 1111```.
```
    div bl
```
It is important to reset ```AX``` to its original value after performing the division. In divisions, the Quotient will go into ```AL``` and the Remainder goes into ```AH```.
```
Ex:
    7 / 2 = 3 with remainder 1
```
where,
```
AL = 3 = 0000 0011
AH = 1 = 0000 0001
```
This means that ```AX = 0000 0001 0000 0011 = 259``` u"\u2260" ```Number = 7```
