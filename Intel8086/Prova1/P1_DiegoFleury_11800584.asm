; NOME: DIEGO FLEURY CORREA DE MORAES
; EMAIL: diegofleurycm@usp.br
; NUSP: 11800584


org 100h

JMP MAIN

; SI--> MSG , DI --> CRIPTO, BP --> CHAVE
CRIPT_CHAVEADO PROC
        
        ; TRANSFERENCIA DA MENSAGEM DE DS:SI PARA ES:DI
        MOV CX, SIZE_MSG
        REP MOVSB             
        
        
    ; CRIPTOGRAFIA
        
        ;VARIAVEIS DE CONTROLE DE STRING ARMAZENADA EM CRIPTO
        MOV DX, SIZE_MSG
        LEA BX, CRIPTO
        
    LP_EXTERNO:
            
            ; REINICIA ESSA VARIAVEIS A TODO COMECO DE LOOP INTERNO
            ; POIS CHAVE CICLICA
            MOV CX, 5
            LEA BP, CHAVE 
        
        LP_INTERNO:
            
            MOV AL, [BP]
            ADD [BX], AL    ; AQUILO DENTRO DE CRIPTO RECEBE VALOR DENTRO DE CHAVE
            
            INC BX          ; PROXIMA LETRA
            INC BP          ; PROXIMO VALOR DE CHAVE
            
            DEC DX          ; CONTROLE DE SE PROXIMO DO FINAL DE CRIPTO
            CMP DX,0
            JE SAIDA         
            
        LOOP LP_INTERNO ; CONTROLADO POR CX
        
        
       
    JMP LP_EXTERNO
        
        SAIDA:
        
        RET    
    
CRIPT_CHAVEADO ENDP   


PRINTA_TELA PROC
        
        ; INICIALIZACAO DO LOOP
        MOV CX, SIZE_MSG
        
        ; MODO DE EXIBICAO DA TELA PARA INT 21h
        MOV AH,02h
        
        ; CONTROLE DE ENDERECO DE CRIPTO
        LEA BX, CRIPTO
        
    LOOP_PRINT:
        
        ; PASSA VALOR
        MOV DL, [BX] 
        
        ; CHAMA INTERRUPCAO
        INT 21h
        
        ; PROXIMA LETRA
        INC BX 
    
    LOOP LOOP_PRINT
       
        RET
        
PRINTA_TELA ENDP    

        
MAIN PROC
        
        ; PASSAGEM DE PARAMETROS
        LEA SI, MSG
        LEA DI, CRIPTO
        LEA BP, CHAVE
       
        
        ; CHAMADA DE PROCEDIMENTO 
        CALL CRIPT_CHAVEADO
        
        ; APOS ESTE PONTO TEMOS QUE MSG ESTA ENCRIPTADO EM CRIPTO
        ; LOGO SO RESTA A CHAMADA DE PRINT
        CALL PRINTA_TELA 
    
    ; AGUARDA PRESSIONAMENTO DE TECLA
    AGUARDA:
        MOV AH, 01h
        INT 16h
    JZ AGUARDA
    
        ; FINAL DO PROGRAMA, RETORNA CONTROLE AO SO
        NOP
        RET
            
MAIN ENDP


; AREA DE DADOS
CHAVE DB 3,1,6,7,2
M:
    MSG DB 'ABCDEFGHIJKLMNOPQ',00h
SIZE_MSG = $ - M - 1
 
CRIPTO DB ?