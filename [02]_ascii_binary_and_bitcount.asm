; ============================================================
; Program: ASCII to Binary and Bit Counter
; Description:
;   Reads a single character input.
;   - Displays its ASCII code in 8-bit binary form.
;   - Counts and prints the number of '1' bits in that ASCII value.
; Environment: 8086 Assembly (MASM/TASM), DOS interrupts (int 21h)
; ============================================================

.MODEL SMALL
.STACK 100H

.DATA
   PROMPT_1  DB  'Enter the character : $\'                    ; Input prompt
   PROMPT_2  DB  0DH,0AH,'The ASCII code of the given number in binary form is : $\' ; Message before binary output
   PROMPT_3  DB  0DH,0AH,'The number of 1 bits in ASCII code are : $\'              ; Message before bit count output

.CODE
MAIN PROC
     ; ------------------------------------------------------------
     ; Initialize data segment
     ; ------------------------------------------------------------
     MOV AX, @DATA
     MOV DS, AX

     ; ------------------------------------------------------------
     ; Display prompt to enter a character
     ; ------------------------------------------------------------
     LEA DX, PROMPT_1
     MOV AH, 9
     INT 21H

     ; ------------------------------------------------------------
     ; Read a single character from keyboard (AL = input)
     ; ------------------------------------------------------------
     MOV AH, 1
     INT 21H

     ; Store input character in BL
     XOR BX, BX
     MOV BL, AL

     ; ------------------------------------------------------------
     ; Display message for binary output
     ; ------------------------------------------------------------
     LEA DX, PROMPT_2
     MOV AH, 9
     INT 21H

     ; ------------------------------------------------------------
     ; Prepare for bit extraction
     ; ------------------------------------------------------------
     XOR BH, BH          ; Clear BH (used for counting 1s)
     MOV CX, 8           ; Loop counter = 8 bits
     MOV AH, 2           ; DOS function to display character

@OUTPUT:
       ; --------------------------------------------------------
       ; Shift BL left by 1 bit (MSB to Carry flag)
       ; --------------------------------------------------------
       SHL BL, 1

       ; --------------------------------------------------------
       ; If carry flag = 1, output '1' and increment bit count
       ; Otherwise, output '0'
       ; --------------------------------------------------------
       JNC @ZERO          ; Jump if Carry = 0
       INC BH             ; Increment bit counter
       MOV DL, 31H        ; ASCII '1'
       JMP @DISPLAY

@ZERO:
       MOV DL, 30H        ; ASCII '0'

@DISPLAY:
       INT 21H            ; Display current bit
     LOOP @OUTPUT          ; Repeat for all 8 bits

     ; ------------------------------------------------------------
     ; Display message for number of 1 bits
     ; ------------------------------------------------------------
     LEA DX, PROMPT_3
     MOV AH, 9
     INT 21H

     ; ------------------------------------------------------------
     ; Convert count in BH to ASCII and display
     ; ------------------------------------------------------------
     OR BH, 30H           ; Convert to ASCII ('0' + value)
     MOV AH, 2
     MOV DL, BH
     INT 21H

     ; ------------------------------------------------------------
     ; Exit program and return control to DOS
     ; ------------------------------------------------------------
     MOV AH, 4CH
     INT 21H

MAIN ENDP
END MAIN
