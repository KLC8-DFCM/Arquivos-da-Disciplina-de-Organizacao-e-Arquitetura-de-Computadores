
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.DATA
        VALOR DB 11
        P:
            PAR DB 'PAR',0Dh
        TAM_P = $ - P
        I:
            IMPAR DB 'IMPAR',0Dh
        TAM_I = $-I
.CODE

JMP COMECO

EH_PAR:
        MOV CL, TAM_P
        MOV CH, 0
        MOV AH, 0Eh
        LEA BX, PAR
        
        LPP:
                MOV AL, [BX]
                INT 10h
                INC BX
                
        LOOP LPP    
        JMP FIM
         
EH_IMPAR:

        MOV CH, 0
        MOV CL, TAM_I
        MOV AH, 0Eh
        LEA BX, IMPAR
        
        LPI:
                MOV AL,[BX]
                INT 10h
                INC BX
                
        LOOP LPI
        JMP FIM 

COMECO:
        MOV AL, VALOR
        MOV AH, 0
        MOV DL, 2
        DIV DL
        CMP AH, 0
        JZ EH_PAR
        JMP EH_IMPAR
        

FIM:

        NOP
        RET




