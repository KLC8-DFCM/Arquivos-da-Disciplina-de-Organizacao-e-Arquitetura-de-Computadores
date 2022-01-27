

org 100h

.DATA
     
    T:
        VETOR DB 1,2,4,6,21,89,0,11,12,32
    TAM = $ - T
    
    M1 DB 'A',0F0h,'C',0F0h,'H',0F0h,'O',0F0h,'U',0F0h,0DH, 0F0h
    M2 DB 'N',0F0h,'A',0F0h,'O',0F0h,' ',0F0h,'A',0F0h,'C',0F0h,'H',0F0h,'O',0F0h,'U',0F0h,0DH, 0F0h
    
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
        
        ; set video mode
	MOV AX, 3
	INT 10h        

; BX TEM O ENDERECO DA MENSAGEM
        PUSH BX
        
	; cancel blinking and enable all 16 colors:
        MOV AX, 1003h
        MOV BX, 0
        INT 10h
        
        POP BX
; RECUPERAR
        
	; set segment register
	
        MOV AX, 0B800h
        MOV DS, AX             ; PROBLEMA ESTA AQUI, COMO MUDA-SE O LOCAL DE DS
                               ; BX GUARDA UM OFFSET ANTIGO, COMO CORRIGIR?
	MOV DI, 02h
	
LP_FINAL:
	
	MOV DL, [BX]
     MOV [DI], DL
	ADD BX, 2  
	CMP [DI], 0Dh
	ADD DI, 2
JNZ LP_FINAL        
        RET 
            
    FINAL ENDP
        





