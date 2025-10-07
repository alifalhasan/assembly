; ============================================================
; Program: Case Converter (Uppercase ↔ Lowercase)
; Description:
;   Takes a single character input from the user.
;   - If input is lowercase (a–z), converts it to uppercase.
;   - If input is uppercase (A–Z), converts it to lowercase.
;   - Otherwise, prints an invalid input message.
; Environment: 8086 Assembly (MASM/TASM), DOS interrupts (int 21h)
;
; Author: Alif Al Hasan
; Assembler: MASM/TASM compatible
; ============================================================

.model small
.stack 100h

.data
    inputDialogue db "Enter a character : $"            ; Prompt message
    lower db 0ah, 0dh, "The lowercase is : $"           ; Message before lowercase output
    upper db 0ah, 0dh, "The uppercase is : $"           ; Message before uppercase output
    invalid db 0ah, 0dh, "Not a valid input.$"          ; Invalid input message

.code
main proc

    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    ; Display input prompt
    lea dx, inputDialogue
    mov ah, 9                   ; DOS function: print string
    int 21h

    ; Read a single character from keyboard
    mov ah, 1                   ; DOS function: read character (AL = input)
    int 21h
    mov bl, al                  ; Store input in BL for processing
    
    ; Check if input is lowercase (a–z)
    cmp bl, 97                  ; Compare with 'a' (ASCII 97)
    jge ConvertToUpper          ; If >= 'a', may be lowercase
    
    ; Otherwise, check if it’s uppercase (A–Z)
    cmp bl, 65                  ; Compare with 'A' (ASCII 65)
    jl PrintInvalid             ; If < 'A', invalid input

CovertToLower:
    cmp bl, 91                  ; Compare with '[' (ASCII 91)
    jge PrintInvalid            ; If >= '[', invalid (not A–Z)

    ; Display "lowercase" label
    lea dx, lower
    mov ah, 9
    int 21h

    ; Convert uppercase → lowercase
    add bl, 32                  ; Add 32 to ASCII (A→a)
    mov dl, bl
    mov ah, 2                   ; DOS function: print character
    int 21h
    jmp Exit

ConvertToUpper:
    cmp bl, 123                 ; Compare with '{' (ASCII 123)
    jge PrintInvalid            ; If >= '{', invalid (not a–z)
    
    ; Display "uppercase" label
    lea dx, upper
    mov ah, 9
    int 21h

    ; Convert lowercase → uppercase
    sub bl, 32                  ; Subtract 32 to ASCII (a→A)
    mov dl, bl
    mov ah, 2                   ; Print the converted character
    int 21h
    jmp Exit 

PrintInvalid:
    ; Display invalid input message
    lea dx, invalid
    mov ah, 9
    int 21h
    jmp Exit

Exit:
    ; Terminate program
    mov ah, 4Ch                 ; DOS terminate function
    int 21h

main endp
end main
