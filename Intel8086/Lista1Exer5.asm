
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

INICIO:
        MOV AX,0
        LEA BX,VETOR
        ADD BL, VETINI ; --> END. INICIAL
        MOV CX,BX
        ADD CL,TOTVAL  ; --> END. FINAL
LP:
        ADD AX,[BX]
        INC BX
        INC BX
        CMP BX,CX
        JZ FIM
        JMP LP

FIM:
        NOP
        RET
VETOR DW 1,10,100,10,1,10,100,10,1
VETINI DB 4 ; POSICAO 2
TOTVAL DB 8 ; 4*2 --> 4 VALORES LOGO 100+10+1+10=121=79h 



