;-------------------------------------------------------------
; Program: Reverse Last 10 Characters of a String
; Description:
;   This program takes a 25-character string input from the user
;   (one character at a time) and prints the last 10 characters
;   of that string in reverse order.
;
;   The program uses the stack to temporarily store all 25
;   characters, then pops the last 10 entries for reverse output.
;
; Author: Alif Al Hasan
; Assembler: MASM/TASM compatible
;-------------------------------------------------------------

.model small
.stack 100h
.data
    inPrompt  db "Enter a string: $"          ; Prompt message for input
    outPrompt db 0ah, 0dh, "Output string: $" ; Output label with newline

.code
    main proc
        ;-----------------------------------------------
        ; Step 1: Initialize data segment
        ;-----------------------------------------------
        mov ax, @data
        mov ds, ax

        ;-----------------------------------------------
        ; Step 2: Display input prompt
        ;-----------------------------------------------
        lea dx, inPrompt
        mov ah, 9
        int 21h

        ;-----------------------------------------------
        ; Step 3: Read 25 characters and push each onto stack
        ;-----------------------------------------------
        mov cx, 25                 ; Set counter = 25 (string length)

    Input:
        mov ah, 1                  ; DOS interrupt to read a single character
        int 21h                    ; Waits for user to type one character
        push ax                    ; Push the character (in AX) onto the stack
        loop Input                 ; Repeat 25 times

        ;-----------------------------------------------
        ; Step 4: Display output prompt
        ;-----------------------------------------------
        lea dx, outPrompt
        mov ah, 9
        int 21h

        ;-----------------------------------------------
        ; Step 5: Pop and print last 10 characters (reverse order)
        ;-----------------------------------------------
        mov cx, 10                 ; Set counter = 10 (last 10 characters)

    Output:
        pop dx                     ; Pop character from stack (LIFO order)
        mov ah, 2                  ; Function to display a single character
        int 21h
        loop Output                ; Repeat 10 times to print last 10 chars reversed

        ;-----------------------------------------------
        ; Step 6: Exit program
        ;-----------------------------------------------
        mov ah, 4ch                ; DOS terminate program
        int 21h

    main endp
end main
