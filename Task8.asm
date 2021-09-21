; count vowel and consonant of a word

.MODEL SMALL
.STACK 100h
.DATA
	inputPrint     db "Enter a string: $"
	vowelPrint     db 0ah, 0dh, "Number of vowel: $"
	consonantPrint db 0ah, 0dh, "Number of consonant: $"

.CODE
MAIN PROC

	       mov    ax, @data
	       mov    ds ,ax

	       mov    bl,0                           	;initialize for total count
	       mov    cl,0                           	;initialize for vowel count
      
            lea dx, inputPrint
	       mov    ah,9
	       int    21h

	WhileLoop:

        mov ah, 1
        int 21h
	       cmp    al,0dh                         	;compare wheather this is enter or not
	       je     output
           
	       cmp    al,'a'
	       je     vowel
        
	       cmp    al,'A'
	       je     vowel 
        
	       cmp    al,'e'
	       je     vowel 
        
	       cmp    al,'E'
	       je     vowel
        
	       cmp    al,'i'
	       je     vowel
        
	       cmp    al,'I'
	       je     vowel
        
	       cmp    al,'o'
	       je     vowel
        
	       cmp    al,'O'
	       je     vowel
        
	       cmp    al,'u'
	       je     vowel
        
	       cmp    al,'U'
	       je     vowel
        
       
	total: 
	       inc    bl
	       jmp    WhileLoop
	vowel: 
       
	       inc    cl
	       jmp    total 
        
       
	output:
        lea dx, vowelPrint
        mov ah, 9
        int 21h
          
        mov ah,2
        mov dl,cl
        add dl,30h
        int 21h
        
        lea dx, consonantPrint
        mov ah, 9
        int 21h
        
        sub bl,cl
        
        mov ah,2
        mov dl,bl
        add dl,30h
        int 21h
        
        
        jmp exit
        
        
        exit:
        mov ah,4ch
        int 21h
        main endp
     end main
        
        
    
