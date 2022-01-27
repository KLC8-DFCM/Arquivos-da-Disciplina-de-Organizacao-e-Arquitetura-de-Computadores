
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

name "L1Ex7"

org 100h

comeco: 
        MOV CH, 0H
        MOV CL, VAL2
        MOV AX, 0
        CLC
        
repeticao:
        ADD AL, VAL1
        ADC AH, 0  
        
        LOOP repeticao
final:  
        MOV RESMULT,AX
        NOP
        RET

        
        VAL1 DB 13
        VAL2 DB 5
        RESMULT DW 0


