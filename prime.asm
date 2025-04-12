section .text

global _start

_start:

    movzx eax, byte[number]
    mov ebx, 2
    
    ; In Division
    ; eax is the Quotiant
    ; edx is the Remainder
    
loop_start:
    
;-- Prime can only divide by itself and 1
    cmp ebx, eax         
    jge check_remainder     ; if divisor >= number, end loop
    
;-- Start if statement:
    xor edx, edx
    div ebx                 ; Number (eax) / Divisor (ebx)
                            ; eax = Quotiant
                            ; edx = Remainder
    cmp edx, 0      
    je not_prime            ; if remainder == 0, then not prime
;-- End if statement
    
    add ebx, 1              ; Divisor = divisor +1
    ; movzx eax, byte[number] ; eax is no longer equal to Number
                            ; eax became Quotiant after division
                            ; reset eax to Number
    jmp loop_start

    
check_remainder:
    ; cmp byte[answer], 0
    ; je not_prime
    ; jne prime
    
    cmp edx, 0
    jne prime
    
prime:
    ; mov byte[answer], 1 ; prime = true
    mov eax, 4
    mov ebx, 1
    mov ecx, prime_msg
    mov edx, 16
    int 80h
    jmp exit

not_prime:
    mov byte[answer], 0 ; prime = false
    mov eax, 4
    mov ebx, 1
    mov ecx, not_prime_msg
    mov edx, 20
    int 80h
    jmp exit    
    

exit:
    mov eax, 1
    mov ebx, 0
    int 80h

section .data
    number db 3
    answer db 1     ; 1 means number is prime
                    ; 0 means number is NOT prime
                    ; ASCII 0x0a = LINE FEED (for new line) 
    prime_msg db 'Number is prime', 0x0a
    not_prime_msg db 'Number is NOT prime',0x0a
    