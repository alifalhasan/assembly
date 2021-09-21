; Take a character and convert to opposite case

.model small
.stack 100h
.data
    inputDialogue db "Enter a character : $"
    lower db 0ah, 0dh, "The lowercase is : $"
    upper db 0ah, 0dh, "The uppercase is : $"
    invalid db 0ah, 0dh, "Not a valid input.$"


.code
main proc

    mov ax, @data
    mov ds, ax

    lea dx, inputDialogue
    mov ah, 9  ;printing inputDialogue
    int 21h

    mov ah, 1  ;taking input
    int 21h

    mov bl, al  ;
    
    cmp bl, 97
    jge ConvertToUpper
    
    cmp bl, 65
    jl PrintInvalid
    
    CovertToLower: 
    
    cmp bl, 91
    jge PrintInvalid

    lea dx, lower
    mov ah, 9
    int 21h

    add bl, 32  ;up to lower
    mov dl, bl
    mov ah, 2  
    int 21h
    jmp Exit
    
    
    ConvertToUpper:
    
    cmp bl, 123
    jge PrintInvalid
    
    lea dx, upper
    mov ah, 9
    int 21h

    sub bl, 32  ;down to upper
    mov dl, bl
    mov ah, 2
    int 21h
    jmp exit 
    
    
    PrintInvalid:
    
    lea dx, invalid
    mov ah, 9
    int 21h
    jmp exit
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main