; ============================================================
; Program: ASCII to Hexadecimal Converter
; Description:
;   Repeatedly takes a character input and prints its ASCII value
;   in hexadecimal format (e.g., 'A' → 41h). 
;   Pressing Enter (carriage return) exits the program.
; Environment: 8086 Assembly (MASM/TASM), DOS interrupts (int 21h)
; ============================================================

.MODEL SMALL
.STACK 100H

.DATA     
    inputPrint  DB 'Enter a character : $'                  ; Input prompt
    outputPrint DB 'ASCII code in hexadecimal : $'          ; Output message
    
.CODE
MAIN PROC
    ; --------------------------------------------------------
    ; Initialize data segment
    ; --------------------------------------------------------
    MOV AX, @DATA           
    MOV DS, AX   
    
WHILE1:
    ; --------------------------------------------------------
    ; Display input prompt
    ; --------------------------------------------------------
    LEA DX, inputPrint
    MOV AH, 9
    INT 21H                                      
        
    ; --------------------------------------------------------
    ; Get user input and newline
    ; --------------------------------------------------------
    CALL Input
    CALL NewLine
        
    ; --------------------------------------------------------
    ; Check for Enter (Carriage Return = 0Dh)
    ; --------------------------------------------------------
    CMP BL, 0DH
    JE EXIT
        
    ; --------------------------------------------------------
    ; Display output label
    ; --------------------------------------------------------
    LEA DX, outputPrint
    MOV AH, 9
    INT 21H
        
    ; --------------------------------------------------------
    ; Convert input to hexadecimal
    ; --------------------------------------------------------
    CALL ToHexa

    ; --------------------------------------------------------
    ; Display 'h' to indicate hexadecimal notation
    ; --------------------------------------------------------
    MOV DL, 'h'
    MOV AH, 2
    INT 21H 

    ; --------------------------------------------------------
    ; Print a newline and repeat
    ; --------------------------------------------------------
    CALL NewLine
    JMP WHILE1
    
; ------------------------------------------------------------
; Exit point
; ------------------------------------------------------------
EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP 


; ============================================================
; Subroutine: Input
; Description: Reads a single character into BL
; ============================================================
Input PROC
    MOV AH, 1               ; DOS function: read character
    INT 21H                               
    MOV BL, AL              ; Store input in BL
    RET
Input ENDP
    

; ============================================================
; Subroutine: NewLine
; Description: Prints newline (LF + CR)
; ============================================================
NewLine PROC
    MOV AH, 2
    MOV DL, 0AH             ; Line feed
    INT 21H
    MOV DL, 0DH             ; Carriage return
    INT 21H
    RET
NewLine ENDP    


; ============================================================
; Subroutine: ToHexa
; Description:
;   Converts ASCII code in BL to two hexadecimal digits and 
;   prints them using DOS interrupt.
; ============================================================
ToHexa PROC
    MOV CX, 2               ; Two nibbles (high and low)
FOR1: 
        XOR BH, BH
        SHL BX, 4           ; Move upper nibble into BH
        
        CMP BH, 9 
        JG PRINT2           ; If > 9, it’s A–F
        
PRINT1:
        MOV AH, 2
        ADD BH, 48          ; Convert 0–9 to '0'–'9'
        MOV DL, BH
        INT 21H   
        JMP ITR
            
PRINT2:
        MOV AH, 2
        ADD BH, 55          ; Convert 10–15 to 'A'–'F'
        MOV DL, BH
        INT 21H  
         
ITR:
        LOOP FOR1           ; Process both nibbles
    RET
ToHexa ENDP
END MAIN
