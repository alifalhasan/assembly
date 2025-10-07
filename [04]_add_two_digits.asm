; ============================================================
; Program: Add Two Digits
; Description:
;   Reads two single-digit numbers from keyboard (input format: a b)
;   and prints their sum in the format "a + b = c".
; Environment: 8086 Assembly (MASM/TASM), DOS interrupts (int 21h)
; ============================================================

.MODEL SMALL
.STACK 100H
.CODE

MAIN PROC   

    ; --------------------------------------------------------
    ; Input first digit (character)
    ; --------------------------------------------------------
    MOV AH, 1                ; DOS function: read character
    INT 21H
    MOV BL, AL               ; Store first digit in BL
    
    ; --------------------------------------------------------
    ; Read and ignore space between digits
    ; --------------------------------------------------------
    MOV AH, 1
    INT 21H
    MOV CL, AL               ; Temporarily store space (not used)
    
    ; --------------------------------------------------------
    ; Input second digit
    ; --------------------------------------------------------
    MOV AH, 1
    INT 21H
    MOV CH, AL               ; Store second digit in CH
    
    ; --------------------------------------------------------
    ; Preserve the first digit (for printing later)
    ; --------------------------------------------------------
    MOV CL, BL               ; Keep a copy of the first digit
    
    ; --------------------------------------------------------
    ; Perform addition: (digit1 + digit2)
    ; ASCII digits need adjustment (subtract '0' = 30h)
    ; --------------------------------------------------------
    ADD BL, CH               ; BL = BL + CH (ASCII addition)
    SUB BL, 30H              ; Adjust for ASCII to get correct digit
    
    ; --------------------------------------------------------
    ; Print result in the format: a + b = c
    ; --------------------------------------------------------
    
    ; Newline
    MOV AH, 2
    MOV DL, 0AH              ; Line Feed
    INT 21H
    MOV DL, 0DH              ; Carriage Return
    INT 21H
    
    ; Print first digit (a)
    MOV DL, CL
    INT 21H               
    
    ; Print space
    MOV DL, 20H
    INT 21H   
    
    ; Print '+'
    MOV DL, 2BH
    INT 21H
    
    ; Print space
    MOV DL, 20H
    INT 21H 
    
    ; Print second digit (b)
    MOV DL, CH
    INT 21H   
    
    ; Print space
    MOV DL, 20H
    INT 21H
    
    ; Print '='
    MOV DL, 3DH
    INT 21H 
    
    ; Print space
    MOV DL, 20H
    INT 21H
    
    ; Print the result (c)
    MOV DL, BL
    INT 21H
    
    ; --------------------------------------------------------
    ; Exit program and return control to DOS
    ; --------------------------------------------------------
EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
