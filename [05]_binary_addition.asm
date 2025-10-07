; ============================================================
; Program: Binary Addition
; Description:
;   Reads two binary numbers (entered as 0s and 1s, separated by Enter),
;   adds them, and displays both numbers and their binary sum.
; Environment: 8086 Assembly (MASM/TASM), DOS interrupts (int 21h)
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
	i            DB 8                                  ; Counter for first number bits
	j            DB 8                                  ; Counter for second number bits
	k            DB 16                                 ; Counter for sum bits
	s            DW ?                                  ; Variable to store the sum (16 bits)

	firstInput   db "Enter First Number:$"
	secondInput  db 0ah, 0dh, "Enter Second Number:$"
	firstOutput  db 0ah, 0dh, "First Number:$"
	secondOutput db 0ah, 0dh, "Second Number:$"
	sumoutput    db 0ah, 0dh, "Sum:$"

.CODE
MAIN PROC
	; --------------------------------------------------------
	; Initialize data segment
	; --------------------------------------------------------
	MOV AX, @DATA
	MOV DS, AX
        
	; --------------------------------------------------------
	; Prompt user for first binary number
	; --------------------------------------------------------
	LEA DX, firstInput
	MOV AH, 9
	INT 21h
        
	XOR BX, BX                ; Clear BX for first input storage
	XOR CX, CX                ; Clear CX for second input (later use)

	; --------------------------------------------------------
	; Take first binary number input (as characters 0/1)
	; Ends when user presses Enter (carriage return)
	; --------------------------------------------------------
	MOV AH, 1
	INT 21h
        
NUM1:
	CMP AL, 0DH               ; If Enter pressed → go to second input
	JE  SECOND
            
	AND AL, 0FH               ; Convert ASCII '0'/'1' → binary 0/1
	SHL BL, 1                 ; Shift BL left to make room for next bit
	OR  BL, AL                ; Insert the current bit
            
	INT 21h                   ; Take next character
	JMP NUM1
      
; ------------------------------------------------------------
; Read second binary number
; ------------------------------------------------------------
SECOND: 
	LEA DX, secondInput
	MOV AH, 9
	INT 21h
        
NUM2:
	MOV AH, 1
	INT 21h
	CMP AL, 0DH               ; Stop if Enter pressed
	JE  SUM
            
	AND AL, 0FH               ; Convert ASCII '0'/'1' → binary 0/1
	SHL CL, 1
	OR  CL, AL
	JMP NUM2
         
; ------------------------------------------------------------
; Perform binary addition: s = BX + CX
; ------------------------------------------------------------
SUM:
	ADD s, BX                 ; Add first number
	ADD s, CX                 ; Add second number (sum in s)

	; --------------------------------------------------------
	; Display "First Number"
	; --------------------------------------------------------
	LEA DX, firstOutput
	MOV AH, 9
	INT 21h
             
NUMBER1:
	CMP i, 0
	JE  OUTPUT1               ; If done printing, go to next output
            
	SHL BL, 1                 ; Shift MSB into Carry flag
	JC  P1                    ; If Carry=1 → print '1'
	JNC P0                    ; If Carry=0 → print '0'

P1:                          ; Print '1'
	MOV DL, '1'
	MOV AH, 2
	INT 21h
	SUB i, 1
	JMP NUMBER1

P0:                          ; Print '0'
	MOV DL, '0'
	MOV AH, 2
	INT 21h
	SUB i, 1
	JMP NUMBER1
       
; ------------------------------------------------------------
; Display "Second Number"
; ------------------------------------------------------------
OUTPUT1:
	LEA DX, secondOutput
	MOV AH, 9
	INT 21h
         
NUMBER2:
	CMP j, 0
	JE  OUTPUT2
            
	SHL CL, 1
	JC  Q1
	JNC Q0

Q1:                          ; Print '1'
	MOV DL, '1'
	MOV AH, 2
	INT 21h
	SUB j, 1
	JMP NUMBER2

Q0:                          ; Print '0'
	MOV DL, '0'
	MOV AH, 2
	INT 21h
	SUB j, 1
	JMP NUMBER2
    
; ------------------------------------------------------------
; Display "Sum"
; ------------------------------------------------------------
OUTPUT2:
	LEA DX, sumoutput
	MOV AH, 9
	INT 21h

SHOW:
	CMP k, 0
	JE  EXIT                  ; End printing when all bits done
           
	SHL s, 1                  ; Shift sum left to get bit into Carry
	JC  R1
	JNC R0

R1:                          ; Print '1'
	MOV DL, '1'
	MOV AH, 2
	INT 21h
	SUB k, 1
	JMP SHOW

R0:                          ; Print '0'
	MOV DL, '0'
	MOV AH, 2
	INT 21h
	SUB k, 1
	JMP SHOW

; ------------------------------------------------------------
; Program termination
; ------------------------------------------------------------
EXIT:
	ret                       ; Return to DOS
         
MAIN ENDP
END MAIN
