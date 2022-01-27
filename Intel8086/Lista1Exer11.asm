
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

COMECO:
        MOV AX, A
        SHR AX,1
        MOV DIV2, AX
FIM:
        NOP
        RET
        
A DW 5112
DIV2 DW 0




