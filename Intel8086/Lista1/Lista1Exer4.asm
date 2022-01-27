
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

INICIO:
        MOV AX,0 ;ACUMULADOR DO VALOR EM SI
        LEA BX,SOMATORIO ;ENDERECO DE SOMATORIO
        MOV CX,BX ; INDEXADOR
        ADD CX,10 
LP:
        ADD AL,[BX] 
        ;ANTES ERA AX AO INVES DE AL MAS 
        ;COMO RESULTADO FINAL TEM QUE SER
        ;16 BITS, COMO USAR DE MANEIRA
        ;NATURAL O FATO QUE QUEREMOS ACESSAR
        ;SOH O 1o BYTE DE BX EM [BX]?
        INC BX
        CMP BX,CX
        JZ FIM
        JMP LP
FIM:
        MOV RESULTADO,AX
        NOP 
        RET
RESULTADO DW 0
SOMATORIO DB 1,2,3,4,5,6,7,8,9,10



