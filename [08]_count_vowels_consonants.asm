;-------------------------------------------------------------
; Program: Count Vowels and Consonants
; Description:
;   This program takes a word (string) as input from the user
;   and counts the number of vowels and consonants in it.
;
;   The program treats both uppercase and lowercase vowels equally.
;   It uses DOS interrupts to handle input and output.
;
; Author: Alif Al Hasan
; Assembler: MASM/TASM compatible
;-------------------------------------------------------------

.MODEL SMALL
.STACK 100h
.DATA
	inputPrint     db "Enter a string: $"                  ; Prompt for input
	vowelPrint     db 0ah, 0dh, "Number of vowels: $"      ; Output label for vowels
	consonantPrint db 0ah, 0dh, "Number of consonants: $"  ; Output label for consonants

.CODE
MAIN PROC

	;--------------------------------------------------------
	; Step 1: Initialize data segment and counters
	;--------------------------------------------------------
	mov    ax, @data
	mov    ds ,ax

	mov    bl,0             ; Total letter count (will be updated)
	mov    cl,0             ; Vowel count

	;--------------------------------------------------------
	; Step 2: Display input prompt
	;--------------------------------------------------------
	lea dx, inputPrint
	mov ah,9
	int 21h

	;--------------------------------------------------------
	; Step 3: Read characters and count vowels/consonants
	;--------------------------------------------------------
WhileLoop:
	mov ah, 1                ; DOS function: read character
	int 21h

	cmp    al,0dh            ; Check if Enter key is pressed
	je     output            ; End input if Enter pressed

	; Check if character is vowel (both lowercase and uppercase)
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

	;--------------------------------------------------------
	; Non-vowel: count as consonant
	;--------------------------------------------------------
total:
	inc    bl               ; Increase consonant counter
	jmp    WhileLoop

	;--------------------------------------------------------
	; Vowel found
	;--------------------------------------------------------
vowel:
	inc    cl               ; Increase vowel counter
	jmp    total            ; Continue loop

	;--------------------------------------------------------
	; Step 4: Output results
	;--------------------------------------------------------
output:
	; Print vowel count
	lea dx, vowelPrint
	mov ah, 9
	int 21h

	mov ah, 2
	mov dl, cl
	add dl, 30h             ; Convert to ASCII
	int 21h

	; Print consonant count
	lea dx, consonantPrint
	mov ah, 9
	int 21h

	sub bl, cl              ; Calculate consonants = total - vowels

	mov ah, 2
	mov dl, bl
	add dl, 30h             ; Convert to ASCII
	int 21h

	;--------------------------------------------------------
	; Step 5: Exit program
	;--------------------------------------------------------
	jmp exit

exit:
	mov ah,4ch
	int 21h

MAIN endp
end main
