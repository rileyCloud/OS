[BITS 16]
[ORG 0x7C00]

start:
    ; 1. Initialize segment registers to 0
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; 2. Print the initial message
    mov si, msg
    call prnstr

    ; 3. Configure and call rdsec to load from Sector 2 to 0x0500
    mov ax, 0x0000
    mov es, ax                  ; Destination Segment ES=0x0000
    mov bx, 0x0500              ; Destination Offset BX=0x0500
    mov dl, 0x00                ; Drive 0 (Floppy)
    mov ch, 0x00                ; Cylinder 0
    mov cl, 0x02                ; Sector 2 <---------------------------------
    mov dh, 0x00                ; Head 0                                     |
    call rdsec                  ; Calls the function to read from the sector |

    ; 4. Print the loaded data (at 0x0500)
    mov si, 0x0500
    call prnstr

    ; 5. Loop forever (halt)
    jmp $

clrscr:
    mov ax, 0x0003              ; "Clear" text mode
    int 0x10                    ; BIOS (UEFI) print interupt
    ret                         ; Return

msg db "IF YOU SEE THIS. WELCOME", 0
%include "print/prn.asm"
%include "disk/dskrd.asm"

; Boot sector padding and signature
times 510-($-$$) db 0           ; Fill the boot sector
dw 0xAA55                       ; Define the magic number (word = AA55)
