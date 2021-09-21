; take a string length 25, print last 10 characters in reverse order

.model small
.stack 100h
.data
    inPrompt db "Enter a string: $"
    outPrompt db 0ah, 0dh, "Output string: $"
.code
    main proc
        mov ax, @data
        mov ds, ax

        lea dx, inPrompt
        mov ah, 9
        int 21h

        mov cx, 25

        Input:
            mov ah, 1
            int 21h
            push ax
            loop Input

        lea dx, outPrompt
        mov ah, 9
        int 21h

        mov cx, 10

        Output:
            pop dx
            mov ah, 2
            int 21h
            loop Output

        mov ah, 4ch
        int 21h

    main endp
end main