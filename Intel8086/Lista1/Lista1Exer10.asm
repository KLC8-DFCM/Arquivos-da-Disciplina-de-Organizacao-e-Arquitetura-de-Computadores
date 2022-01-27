
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

COMECO:
        MOV AX, A
        SHL AX, 2
        MOV X4, AX

FIM:
        NOP
        RET

A DW 1000
X4 DW ?




