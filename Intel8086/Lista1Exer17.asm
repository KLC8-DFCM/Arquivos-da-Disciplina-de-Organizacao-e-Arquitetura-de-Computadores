
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

JMP COMECO


CESAR PROC
        
        MOV CX, SIZE_MSG
        LEA SI, MSG
        LEA DI, CRIPT
        
    LP1:
        MOV AL, [SI]
        INC AL
        MOV [DI], AL
        INC DI
        INC SI
        LOOP LP1
        RET
            
CESAR ENDP
        
        
        
INVCESAR PROC
        
        MOV CX, SIZE_MSG
        LEA SI, CRIPT
        LEA DI, DECRIPT
        
    LP2:
        MOV AL, [SI]
        DEC AL
        MOV [DI], AL
        INC DI
        INC SI
        LOOP LP2
        RET        
        
INVCESAR ENDP
        
        
        
COMECO:
        CALL CESAR
        CALL INVCESAR

FIM:

        NOP
        RET

M:        
        MSG DB 'Celso Portiolli nao tem nada a ver com o 11 de setembro',0
        SIZE_MSG = $ - M
        
CRIPT DB SIZE_MSG DUP(0)
DECRIPT DB SIZE_MSG DUP(1)



