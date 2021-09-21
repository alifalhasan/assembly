; program to add to binary nubers

.MODEL SMALL
.STACK 100h
.DATA
	i            DB 8                                 	;variable declaration
	j            DB 8
	k            DB 16
	s            DW ?

	firstInput   db "Enter First Number:$"
	secondInput  db 0ah , 0dh, "Enter Second Number:$"
	firstOutput  db 0ah , 0dh, "First Number:$"
	secondOutput db 0ah , 0dh, "Second Number:$"
	sumoutput    db 0ah , 0dh, "Sum:$"

.CODE
MAIN PROC
	        MOV AX,@DATA
	        MOV DS,AX
        
	        LEA DX, firstInput
	        MOV AH, 9
	        INT 21h
        
	        XOR BX,BX           	;set initially bx register's value to 'zero'
	        XOR CX,CX           	;set initially bx register's value to 'zero'

        
        
	        MOV AH,1            	;for taking user input
	        INT 21h
        
	NUM1:                       	;level for taking first input
	        CMP AL,0DH          	;pressing 'enter' will end the fisrt number
	        JE  SECOND
            
	        AND AL,0FH          	;this is for masking.it will give you the original value from ascii value
	        SHL BL,1            	;left shift current value for next storing
	        OR  BL,AL           	;store the value in 'BL' register
            
	        INT 21h
	        JMP NUM1
      
	SECOND: 
      
	        LEA DX, secondInput
	        MOV AH, 9
	        INT 21h
        
	NUM2:                       	;level for taking second input

	        MOV AH,1
	        INT 21h
	        CMP AL,0DH
	        JE  SUM
            
	        AND AL,0FH
	        SHL CL,1
	        OR  CL,AL
            
	        JMP NUM2
         
	SUM:                        	;now two inputs are in bx and cx register
      
	        ADD s,BX            	;add bx with s and keep it in s
	        ADD s,CX            	;add cx with s and keep it in s.so out sum is in 's'

       
	        LEA DX, firstOutput
	        MOV AH, 9
	        INT 21h
             
	NUMBER1:                    	;level for print first input
	        CMP i,0
	        JE  OUTPUT1
            
	        SHL BL,1            	;it is not possible to print a whole number at once in assembly language.we should shift one bit in left and the value will be store in carry flag.thus we will print the total number
	        JC  P1              	;check if the carry flag value is equal to 1
	        JNC P0              	;check if the carry flag value is equal to 0

	P1:                         	;level for print 1
	        MOV DL,'1'
	        MOV AH,2
	        INT 21h
	        SUB i,1
	        JMP NUMBER1
	P0:                         	;level for print 0
	        MOV DL,'0'
	        MOV AH,2
	        INT 21h
	        SUB i,1
	        JMP NUMBER1
       
	OUTPUT1:
	        LEA DX, secondOutput
	        MOV AH, 9
	        INT 21h
         
	NUMBER2:                    	;level for print second input
	        CMP j,0
	        JE  OUTPUT2
            
	        SHL CL,1
	        JC  Q1
	        JNC Q0
	Q1:                         	;kevel for print 1
	        MOV DL,'1'
	        MOV AH,2
	        INT 21h
	        SUB j,1
	        JMP NUMBER2
	Q0:                         	;level for print 0
	        MOV DL,'0'
	        MOV AH,2
	        INT 21h
	        SUB j,1
	        JMP NUMBER2
    
	OUTPUT2:
	        LEA DX, sumoutput
	        MOV AH, 9
	        INT 21h
	SHOW:                       	;now we should print their sum in the same way
	        CMP k,0
	        JE  EXIT
           
	        SHL s,1
	        JC  R1
	        JNC R0
	R1:                         	;level for print 1
	        MOV DL,'1'
	        MOV AH,2
	        INT 21h
	        SUB k,1
	        JMP SHOW
	R0:                         	;level for print 0
	        MOV DL,'0'
	        MOV AH,2
	        INT 21h
	        SUB k,1
	        JMP SHOW
	EXIT:                       	;terminate programme
	        ret
         
       MAIN ENDP
  END MAIN