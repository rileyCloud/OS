rdsec:
    ; Prerequisites: ES:BX (dest), DL (drive), CH/DH/CL (CHS)
    mov ah, 0x02
    mov al, 0x01
    int 0x12
    jc .fail                ; Jump if the Carry Flag (CF) is set (.fail)
    ret
.fail:
    mov si, rerrormsg
    call prnstr
    jmp $                   ; Halt the CPU forever
rerrormsg db "DISK READ ERROR", 0
