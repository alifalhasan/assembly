; Enter a character, print the ascii in hexadecimal 

.MODEL SMALL
.STACK 100H

.DATA     
    inputPrint DB 'Enter a character : $'
    outputPrint DB 'ASCII code in hexadecimal : $'
    
.CODE
MAIN PROC
    MOV AX, @DATA           ; Initiate the data section
    MOV DS, AX   
    
    WHILE1:
        LEA DX, inputPrint           ; instruction message
        MOV AH, 9
        INT 21H                                      
        
        CALL Input
        CALL NewLine
        
        CMP BL, 0DH
        JE EXIT
        
        LEA DX, outputPrint           
        MOV AH, 9
        INT 21H
        
        CALL ToHexa

        mov dl, 'h'
        mov ah, 2
        int 21H 

        CALL NewLine
        JMP WHILE1
    
    
    EXIT:
        MOV AH, 4CH
        INT 21H
        MAIN ENDP 


Input PROC
    MOV AH, 1               ; input a char
    INT 21H                               
    MOV BL, AL                            
    
    ret
    Input ENDP
    
NewLine PROC                     ; New Line function
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    RET
    NewLine endp    
    
ToHexa PROC                ; print the Hexadecimal value of BL  
    MOV CX, 2
    FOR1: 
        XOR BH, BH
        SHL BX, 4
        
        CMP BH, 9 
        JG PRINT2
        
        PRINT1:
            MOV AH, 2
            ADD BH, 48
            MOV DL, BH
            INT 21H   
            
            JMP ITR
            
        PRINT2:
            MOV AH, 2
            ADD BH, 55
            MOV DL, BH
            INT 21H  
             
        
        ITR:
            LOOP FOR1     
            
    RET
    ToHexa endp
END MAIN