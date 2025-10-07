;-------------------------------------------------------------
; Program: Reverse String Storage
; Description:
;   This program takes a string input from the user and stores
;   it in reverse order in a separate array. The reversed string
;   is then displayed.
;
;   Uses stack to reverse string characters.
;
; Author: Alif Al Hasan
; Assembler: MASM/TASM compatible
;-------------------------------------------------------------

.model small
.stack 100h

.data
    inputPrompt  db "Insert input string: $"      ; Prompt for string input
    outputPrompt db 0ah, 0dh, "Final string: $"  ; Output label with newline
    strArr       db 100 dup(?)                    ; Array to store reversed string
    len          dw ?                             ; Stores length of input string

.code
main proc

    ;--------------------------------------------------------
    ; Step 1: Initialize data segment
    ;--------------------------------------------------------
    mov ax, @data
    mov ds, ax

    ;--------------------------------------------------------
    ; Step 2: Display input prompt
    ;--------------------------------------------------------
    lea dx, inputPrompt
    mov ah, 9
    int 21h

    ;--------------------------------------------------------
    ; Step 3: Initialize length counter
    ;--------------------------------------------------------
    xor dx, dx
    mov len, dx            ; Set len = 0 initially

    ;--------------------------------------------------------
    ; Step 4: Read characters and push onto stack
    ;--------------------------------------------------------
Input:
    mov ah, 1              ; DOS read character
    int 21h

    cmp al, 0dh           ; Check for Enter key
    je Process            ; End input if Enter pressed

    push ax               ; Push character to stack
    inc len               ; Increment length counter
    jmp Input

    ;--------------------------------------------------------
    ; Step 5: Process stack to store reversed string
    ;--------------------------------------------------------
Process:
    lea si, strArr       ; Load address of strArr
    mov cx, len          ; Set counter to length of string

Copy:
    pop dx               ; Pop character from stack (reverse order)
    mov ah, 2            ; DOS display character
    int 21h

    mov [si], dl        ; Store popped character in array
    inc si               ; Move to next array position

    loop Copy            ; Repeat until all characters are processed

    ;--------------------------------------------------------
    ; Step 6: Exit program
    ;--------------------------------------------------------
    mov ah, 4ch
    int 21h

main endp
end main
