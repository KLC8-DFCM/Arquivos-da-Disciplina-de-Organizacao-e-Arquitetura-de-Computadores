
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

COMECO:
        MOV AX, A
        MOV DX, B
        MUL DX
        MOV MULT[2],DX            ; TEM QUE SER ASSIM POIS LITTLE ENDIAN (MENOR BIT ANTES)
        MOV MULT[0],AX

FIM:

        NOP
        RET
        
A DW 5
B DW 59
MULT DW 0h, 1h




