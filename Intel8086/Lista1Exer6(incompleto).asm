
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

INICIO:
        MOV AL,0 ; VALORES DA SOMA AQUI
        LEA BX,DADO1 ; END. DE DADO1
        MOV CL,0     ; CONTADOR I
        LEA DX,DADO2 ; END. DE DADO2
        CLC
        
LP:     
        ADD BL,CL ; B[I]
        ADD DL,CL ; D[I]
        ADC AX,[BX] ; VAI DAR MUITO ERRADO POIS VAI
                    ; SOMAR O VALOR DOS DOIS BYTES CONSECUTIVOS

FIM:
        NOP
        RET
        
DADO1 DB 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
DADO2 DB 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
SOMA DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0





