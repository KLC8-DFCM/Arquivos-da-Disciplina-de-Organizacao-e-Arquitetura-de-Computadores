
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

Inicio:
        mov ax, VALOR
Lp:
        CMP AX,0
        JZ Fim
        DEC AX
        JMP Lp
Fim:
        nop
        ret
        VALOR DW 1000



