
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

JMP COMECO
    
    
    
MULT PROC ; RECEBE CX, DX AX
    
        MUL CX
        RET        
    
MULT ENDP
    
    
    
COMECO:
        
        MOV CL, NRO
        MOV CH, 0
        MOV DX, 0
        MOV AX, 1                                
        
LP1:    
        CMP CX, 1
        JL FIM

        CALL MULT                 ; A PARTIR DAQUI, (DX AX) = (00 AX) = AX * CX
         
        DEC CX
        JMP LP1

FIM:
        MOV [FAT], AX
        NOP
        RET
        
NRO DB 8 ; NUMERO MAXIMO TAL QUE FAT SEJA 16 BITS E SUPORTE O NUMERO INTEIRO
FAT DW ? 



