
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

name "Lista1 exercicio 12" 

org 100h

COMECO:
        MOV CX, SIZE_1
        MOV SI,0
        MOV DI,0
        
LP:
        MOV BL, TEXTO1[SI]
        MOV TEXTO2[DI], BL
        INC DI
        INC SI 
        LOOP LP

FIM:
        
        NOP
        RET
S1:        
        TEXTO1 DB 'Hello world!',0
        SIZE_1 = $ - S1 
S2:        
        TEXTO2 DB 0




