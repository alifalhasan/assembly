; input a string and store in another in reverse order

.model small
.stack 100h

.data
    inputPrompt db "Insert input string: $"
    outputPrompt db 0ah, 0dh, "Final string: $"
    strArr db 100 dup(?)
    len dw ?

.code
    main proc

        mov ax, @data
        mov ds, ax

        lea dx, inputPrompt
        mov ah, 9
        int 21h

        xor dx, dx
        mov len, dx

        Input:
            mov ah, 1
            int 21h

            cmp al, 0dh
            je Process

            push ax
            inc len
            jmp Input

        Process:
            lea si, strArr
            mov cx, len

            Copy:
                pop dx
                mov ah, 2
                int 21h

                mov [si], dl
                inc si

                loop Copy

        mov ah, 4ch
        int 21h
    main endp
end main