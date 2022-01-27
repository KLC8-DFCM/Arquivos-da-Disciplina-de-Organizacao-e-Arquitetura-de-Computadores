
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

COMECO:
        MOV CX, QTDE
        LEA SI, ORIGEM
        LEA DI, DESTINO
        
LP:
        MOV AL, [SI]
        MOV [DI], AL
        INC SI
        INC DI
        
        LOOP LP

FIM:
        NOP
        RET

QTDE EQU 50        
ORIGEM DB 100 DUP(0)
DESTINO DB 200 DUP(1)    
