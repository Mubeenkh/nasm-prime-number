; Group Members
; Rachelle Badua ID 40313723
; Mubeen Khan ID 40313724
; Mert Salvador ID 40316307
; Jericho Nieva ID #########

section .data

    ; db = 8-bits
    ; so range of possible 'number' is from 0-255
    number db 7
    answer db 1                         ; 1 means number is prime
                                        ; 0 means number is NOT prime

    prime_msg db 'Number is prime', 0x0a; ASCII 0x0a = LINE FEED (for new line)
    not_prime_msg db 'Number is NOT prime',0x0a

section .text

global _start

_start:
    mov bl, 2                           ; set bl (8-bits) to 2

    cmp byte [number] , 1               ; if Number = 1, then it's NOT prime
    je not_prime_print

loop_start:

    movzx ax, [number]                  ; set and reset ax (16-bits) to Number

    movzx bx, bl                        ; move bl (8-bits) to bx (16-bits) since ax is a 16-bits value
    cmp bx, ax                          ; compare bx with ax
    je prime_print                      ; if bx (Divisor) = ax (Number), END LOOP

                                        ;------ Start if statement ------
    div bl                              ; Divide ax (Number) by bl (Divisor)
                                        ; Quotient is stored in al (8-bits)
                                        ; Remainder is stored in ah (8-bits)

    cmp ah, 0                           ; compare ah (Remainder) with 0
    je not_prime_print                  ; if ah (Remainder) == 0, then NOT PRIME
                                        ;------ End if statement ------

    add bl, 1                           ; bl (Divisor) = bl (Divisor) + 1
    jmp loop_start                      ; RESET LOOP

prime_print:
    call prime

not_prime_print:
    call not_prime

; Subroutine 1
prime:
    mov eax, 4                          ; set syscall number for sys_write
    mov ebx, 1                          ; set file descriptor to stdout
    mov ecx, prime_msg                  ; load address of message to print 
    mov edx, 16                         ; set length of message 
    int 80h
    jmp exit

; Subroutine 2
not_prime:
    mov byte [answer], 0                ; prime = false
    mov eax, 4
    mov ebx, 1
    mov ecx, not_prime_msg
    mov edx, 20
    int 80h
    jmp exit

exit:
    mov eax, 1                          ; set syscall number for sys_exit
    mov ebx, 0                          ; set exit code to 0
    int 0x80                            ; call kernel