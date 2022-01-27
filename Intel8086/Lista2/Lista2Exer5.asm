
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
        
PRINTA PROC
	
	MOV AH, 0Eh
	MOV CX, SIZE_MSG

        LOOP_PRINTA:
	
	MOV AL, [BX] 
	INC BX	
	INT 10h	

	LOOP LOOP_PRINTA
	
	MOV AL, 0Dh
	INT 10h
	
	RET

PRINTA ENDP        
        
COMECO:
        CALL CESAR
	LEA BX, CRIPT
	CALL PRINTA
	LEA BX, DECRIPT
    CALL INVCESAR
	CALL PRINTA

FIM:

        NOP
        RET

M:        
        MSG DB 'Celso Portiolli nao tem nada a ver com o 11 de setembro',0
        SIZE_MSG = $ - M
        
CRIPT DB SIZE_MSG DUP(0)
DECRIPT DB SIZE_MSG DUP(1)

