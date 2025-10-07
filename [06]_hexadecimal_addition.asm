;-------------------------------------------------------------
; Program: Add Two Hexadecimal Numbers
; Description: This program reads two hexadecimal numbers from
;              the user, adds them, and displays the binary
;              representation of their sum.
; 
; Author: Alif Al Hasan
; Assembler: MASM/TASM compatible
;-------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA 
   nLine DB 0DH,0AH,"$"       ; For printing a new line (Carriage Return + Line Feed)

.CODE
   MAIN PROC
      MOV AX, @DATA            ; Initialize the Data Segment
      MOV DS, AX
      
      XOR BX, BX               ; Clear BX register (will store first number)
      MOV CL, 4                ; Set shift count for nibble (4 bits)
      
      ;-----------------------------------------------
      ; Input First Hexadecimal Number
      ;-----------------------------------------------
      MOV AH, 1                ; Function to read a single character
      INT 21h                  ; DOS interrupt to read input
      
   INPUT1:
      CMP AL, 0DH              ; Check if ENTER key is pressed (carriage return)
      JE LINE1                 ; If yes, stop taking first input
      
      CMP AL, 39h              ; Check if input > '9' (i.e., a letter A-F)
      JG LETTER1               ; If greater, go to letter handler
      
      AND AL, 0FH              ; Convert ASCII '0'-'9' to actual value (0-9)
      JMP SHIFT1
      
   LETTER1:                    ; Handle input 'A'-'F' or 'a'-'f'
      SUB AL, 37H              ; Convert ASCII letter to numerical hex (A=10, B=11, etc.)
       
   SHIFT1:
      SHL BX, CL               ; Shift BX left by 4 bits to make room for next nibble
      OR  BL, AL               ; Combine the new digit with BX
      
      INT 21h                  ; Read next character
      JMP INPUT1

   LINE1:                      ; When ENTER is pressed after first input
      LEA DX, nLine            ; Print a newline
      MOV AH, 9
      INT 21h
          
      XOR DX, DX               ; Clear DX (will store second number)
      
      ;-----------------------------------------------
      ; Input Second Hexadecimal Number
      ;-----------------------------------------------
      MOV AH, 1
      INT 21h
      
   INPUT2:
      CMP AL, 0DH              ; Check if ENTER pressed
      JE LINE2
         
      CMP AL, 39h              ; Check if input > '9'
      JG LETTER2               ; If so, process as letter
      
      AND AL, 0FH              ; Convert ASCII to numeric for digits
      JMP SHIFT2
          
   LETTER2:
      SUB AL, 37H              ; Convert ASCII to numeric for letters (A-F)
       
   SHIFT2:
      SHL DX, CL               ; Shift DX left 4 bits
      OR  DL, AL               ; Combine current nibble with DX
      
      INT 21h                  ; Read next character
      JMP INPUT2

   LINE2:                      ; End of second number input
      MOV CX, DX               ; Copy DX (second number) into CX
      
      LEA DX, nLine            ; Print a newline
      MOV AH, 9
      INT 21h
          
      MOV DH, 16               ; Set bit count for displaying 16-bit sum
      
      ;-----------------------------------------------
      ; Add the Two Hexadecimal Numbers
      ;-----------------------------------------------
   SUM:
      ADD BX, CX               ; BX = BX + CX (add two hexadecimal numbers)
      JC PC1                   ; If carry, handle overflow by printing an extra 1
      
      ;-----------------------------------------------
      ; Display Result in Binary Form
      ;-----------------------------------------------
   OUTPUT:
      CMP DH, 0                ; Check if all bits printed
      JE EXIT
           
      SHL BX, 1                ; Shift left to bring next bit into Carry flag
      JC P1                    ; If carry = 1, print '1'
      JNC P0                   ; If carry = 0, print '0'
      
   P1:
      MOV DL, '1'              ; Print character '1'
      MOV AH, 2
      INT 21h
      SUB DH, 1
      JMP OUTPUT
      
   P0:
      MOV DL, '0'              ; Print character '0'
      MOV AH, 2
      INT 21h
      SUB DH, 1
      JMP OUTPUT
      
   ;-----------------------------------------------
   ; Handle Overflow (Extra Carry)
   ;-----------------------------------------------
   PC1:
      MOV DL, '1'
      MOV AH, 2
      INT 21h
      JMP OUTPUT
        
   ;-----------------------------------------------
   ; Program Exit
   ;-----------------------------------------------
   EXIT:
      RET
        
   MAIN ENDP
   END MAIN
