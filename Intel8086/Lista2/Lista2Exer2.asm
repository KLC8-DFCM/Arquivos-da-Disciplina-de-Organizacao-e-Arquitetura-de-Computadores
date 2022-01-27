
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.DATA
     
    T:
        VETOR DB 1,2,4,6,21,89,0,11,12,32
    TAM = $ - T
    
    M1 DB 'ACHOU',0DH
    M2 DB 'NAO ACHOU',0DH
    
    VALOR DB 22

.CODE

    JMP MAIN
    
    

    PROC MAIN
        
            MOV CX, TAM
            LEA BX, VETOR
            MOV DL, VALOR
            
        LP:
           
           CMP [BX], DL 
           JZ  PRINTA_M1
           INC BX
            
           
        LOOP LP
        
        JMP PRINTA_M2
        
        PRINTA_M1:
                LEA BX, M1
                CALL FINAL
                RET
        PRINTA_M2:
                
                LEA BX, M2
                CALL FINAL
                RET
                
    MAIN ENDP


    PROC FINAL 
            
            MOV AH, 0Eh
            
        LP_FINAL:
        
            MOV AL, [BX]
            INC BX
            CMP AL, 0Dh
            INT 10h
            JNE LP_FINAL
        RET 
            
    FINAL ENDP
        




