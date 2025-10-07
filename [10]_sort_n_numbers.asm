;-------------------------------------------------------------
; Program: Sort N Numbers
; Description:
;   This program takes 'n' numbers as input from the user,
;   sorts them in ascending order, and displays the sorted array.
;
;   The input numbers are entered one by one as characters.
;   The program uses bubble sort-like logic for sorting.
;
; Author: Alif Al Hasan
; Assembler: MASM/TASM compatible
;-------------------------------------------------------------

.model small
.stack 100h
.data
    n            db ?                                 ; Stores number of elements
    arr          db 50 dup(?)                         ; Array to store input numbers
    newLine      db 0ah, 0dh, "$"                     ; New line for output formatting
    prompt1      db "Enter num of elements: $"       ; Prompt for number of elements
    prompt2      db 0ah, 0dh, "Sorted Array: $"      ; Prompt for output of sorted array

.code
main proc
    ;--------------------------------------------------------
    ; Step 1: Initialize data segment
    ;--------------------------------------------------------
    mov ax, @data
    mov ds, ax

    ; Print extra newlines for cleaner output
    lea dx, newLine
    mov ah, 9
    int 21h
    lea dx, newLine
    mov ah, 9
    int 21h

    ;--------------------------------------------------------
    ; Step 2: Prompt for number of elements
    ;--------------------------------------------------------
    lea dx, prompt1
    mov ah, 9
    int 21h

    ;--------------------------------------------------------
    ; Step 3: Input number of elements
    ;--------------------------------------------------------
    xor cx, cx              ; Clear CX (number of elements)
    xor dx, dx

NumOfElements:
    mov ah, 1               ; Read a character
    int 21h
    cmp al, 0dh            ; Check Enter key
    je InputArray
    sub al, 48             ; Convert ASCII digit to number
    mov dh, al
    mov ax, cx
    mov dl, 10
    mul dl                 ; Multiply current count by 10
    xor dl, dl
    xchg dh, dl
    add ax, dx
    mov cx, ax
    jmp NumOfElements

InputArray:
    mov n, cl
    xor ch, ch
    lea si, arr

    ;--------------------------------------------------------
    ; Step 4: Input array elements
    ;--------------------------------------------------------
TakeAnElement:
    xor bx, bx
    xor dx, dx

TakeChar:
    mov ah, 1
    int 21h
    cmp al, 0dh
    je ContinueInput
    sub al, 48
    mov dh, al
    mov ax, bx
    mov dl, 10
    mul dl
    xor dl, dl
    xchg dh, dl
    add ax, dx
    mov bx, ax
    jmp TakeChar

ContinueInput:
    mov [si], bl           ; Store element
    inc si
    loop TakeAnElement

    ;--------------------------------------------------------
    ; Step 5: Sorting process
    ;--------------------------------------------------------
    mov cl, n
    xor ch, ch

SortArray:
    mov ah, 0
    mov al, 0              ; Flag to prevent -1 index
    lea si, arr

Iterate:
    cmp al, 0
    je ToggleFlag
    mov bl, [si]
    dec si
    mov bh, [si]
    inc si
    cmp bh, bl
    jle ToggleFlag         ; If already sorted, skip
    xchg bh, bl            ; Swap elements
    mov [si], bl
    dec si
    mov [si], bh
    inc si

ToggleFlag:
    mov al, 1
    inc si
    inc ah
    cmp ah, n
    jl Iterate
    loop SortArray

    ;--------------------------------------------------------
    ; Step 6: Output sorted array
    ;--------------------------------------------------------
    lea dx, prompt2
    mov ah, 9
    int 21h

    mov bl, 10
    xor ch, ch
    lea si, arr

PrintArray:
    mov al, [si]
    xor cl, cl

Calculate:
    cmp al, 0
    je PrintNumber
    xor ah, ah
    div bl
    mov dl, ah
    push dx
    inc cl
    jmp Calculate

PrintNumber:
    cmp cl, 0
    jg NonZero
    mov dl, '0'            ; Print zero if value is zero
    mov ah, 2
    int 21h
    jmp RemainingWork

NonZero:
    pop dx
    add dl, 48             ; Convert to ASCII
    mov ah, 2
    int 21h
    dec cl
    cmp cl, 0
    je RemainingWork
    jmp NonZero

RemainingWork:
    mov dl, ' '
    mov ah, 2
    int 21h

    inc si
    inc ch
    cmp ch, n
    jl PrintArray

    ;--------------------------------------------------------
    ; Step 7: Exit program
    ;--------------------------------------------------------
    lea dx, newLine
    mov ah, 9
    int 21h
    lea dx, newLine
    mov ah, 9
    int 21h

    mov ah, 4ch
    int 21h

main endp
end main
