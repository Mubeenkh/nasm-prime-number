section .text

global _start

_start:

    mov bl, 2                           ; set bl to 2 (8-bits)

loop_start:
    
    movzx ax, byte[number]              ; set and reset ax to Number ( 16-bits)
    
    movzx bx, bl                        ; move bl (8-bits) to bx(16-bits) since ax is a 16-bits value
    cmp bx, ax                          ; compare bx (16-bits) with ax (16-bits)
    jge prime_print                     ; if bx (16-bits Divisor) >= ax (16-bits Number), END LOOP

    
                                        ;------ Start if statement:
    div bl                              
    cmp ah, 0      
    je not_prime_print                  ; if ah (8-bits Remainder) == 0, then NOT PRIME
                                        ;------ End if statement
    
    add bl, 1                           ; bl (8-bits Divisor) = bl (8-bits Divisor) + 1
    jmp loop_start                      ; RESET LOOP


; Subroutine 1
prime_print:
    call prime 

; Subroutine 2
not_prime_print:
    call not_prime
    
prime:
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
    int 0x80

section .data

    ; db = 8-bits 
    ; so range of possible numbers are from 0-254
    number db 254
    answer db 1     ; 1 means number is prime
                    ; 0 means number is NOT prime
                    ; ASCII 0x0a = LINE FEED (for new line) 
    prime_msg db 'Number is prime', 0x0a
    not_prime_msg db 'Number is NOT prime',0x0a
    