prnchar:
    mov ah, 0x0E        ; Teletype CPU mode
    mov bh, 0x00        ; Display page 0
    mov bl, 0x07        ; White on black color mode
    int 0x10            ; Request the BIOS (UEFI) to print with the 0x10 interupt
    ret                 ; Return

prnstr:
.prnlp:
    lodsb               ; Load byte from [DS:SI] into AL, increment SI
    cmp al, 0           ; Check for a null terminator (0)
    je .return          ; Returns if theres is no more text to print
    call prnchar
    jmp .prnlp          ; Continue processing the string

.return:
    ret                 ; Return

