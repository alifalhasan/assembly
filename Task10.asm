; take n numbers and sort them

.model small
.stack 100h
.data
    n db ?
    arr db 50 dup(?)
    newLine db 0ah, 0dh, "$"
    prompt1 db "Enter num of elements: $"

.code
    main proc
        mov ax, @data
        mov ds, ax

        lea dx, newLine ;printing two extra lines for clearing output
        mov ah, 9
        int 21h
        lea dx, newLine
        mov ah, 9
        int 21h

        lea dx, prompt1
        mov ah, 9
        int 21h








        ;Input part starts

        xor cx, cx ;cx stores number of elements
        xor dx, dx
        NumOfElements: ;taking number of elements as input
            mov ah, 1
            int 21h
            cmp al, 0dh
            je InputArray
            sub al, 48
            mov dh, al
            mov ax, cx
            mov dl, 10
            mul dl
            xor dl, dl
            xchg dh, dl
            add ax, dx
            mov cx, ax
            jmp NumOfElements

        InputArray:
            mov n, cl
            xor ch, ch
            lea si, arr
            TakeAnElement:
                xor bx, bx ;Here bx contains the number
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
                    mov [si], bl
                    inc si;
                loop TakeAnElement


        ;Input part completed








        ;Sorting part starts

        mov cl, n
        xor ch, ch

        SortArray:
            mov ah, 0
            mov al, 0 ;flag to prevent -1 index access
            lea si, arr
            Iterate:
                cmp al, 0
                je ToggleFlag
                mov bl, [si]
                dec si
                mov bh, [si]
                inc si
                cmp bh, bl
                jle ToggleFlag
                xchg bh, bl ;if arr[i] < arr[i-1] then swapping
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


        ;Sorting part completed









        ;Print part starts

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
                mov dl, '0'; if the number is 0 then printing here
                mov ah, 2
                int 21h
                jmp RemainingWork
                NonZero: ;if non-zero then printing here
                    pop dx
                    add dl, 48
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

        ;Print part completed
            
        lea dx, newLine ;printing two extra lines for clearing output
        mov ah, 9
        int 21h
        lea dx, newLine
        mov ah, 9
        int 21h

        mov ah, 4ch
        int 21h
    main endp
end main