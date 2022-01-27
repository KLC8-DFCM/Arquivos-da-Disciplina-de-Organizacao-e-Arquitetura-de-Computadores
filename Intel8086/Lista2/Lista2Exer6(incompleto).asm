
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

JMP COMECO


CESAR PROC
        
        MOV CH, 0
        MOV CL, [SIZE_TEXTO]
        LEA SI, TEXTO
        LEA DI, CRIPT
        
    LP1:
        MOV AL, [SI]
        INC AL
        MOV [DI], AL
        INC DI
        INC SI
        LOOP LP1
        RET
            
CESAR ENDP
        
        
        
INVCESAR PROC
        
        MOV CH, 0
        MOV CL, [SIZE_TEXTO]
        LEA SI, CRIPT
        LEA DI, DECRIPT
        
    LP2:
        MOV AL, [SI]
        DEC AL
        MOV [DI], AL
        INC DI
        INC SI
        LOOP LP2
        RET        
        
INVCESAR ENDP
        
PRINTA PROC
	
	MOV AH, 0Eh
	MOV CH, 0
	MOV CL, [SIZE_TEXTO]

        LOOP_PRINTA:
	
	MOV AL, [BX] 
	INC BX	
	INT 10h	

	LOOP LOOP_PRINTA
	
	MOV AL, 0Dh
	INT 10h
	
	RET

PRINTA ENDP

LER_TECLADO PROC
        
        ; SET VIDEO MODE
        
        MOV AX, 0
        INT 10h
        
        ; PRIMEIRA PAGINA DE VIDEO
        
        MOV AH, 05H
        MOV AL, 0
        INT 10h
        
        ; ESCOLHE PAGINA DE VIDEO ATIVA COMO 0
        MOV AH,08h
        MOV BH, 0
        
        ; SETA POSICAO INICIAL DO CURSOR EM 0,0
        MOV DX, 0
        MOV AH, 2
        MOV BH, 0
        INT 10h
        
        ; AQUI INICIALIZA-SE A CONTAGEM DE CARACTERES ESCRITOS
        MOV CX, 0
        
        ; PREPARA LOCAL DE MEMORIA PARA SER ESCRITO
        MOV BP, OFFSET TEXTO
        
    LP_TECLADO: ; READ --> SET CURSOR + 1 --> REPEAT
    
    
        
        ; LE CARACTER (E ATRIBUTO) NA POSICAO DO CURSOR
        ; AL <- CHAR , AH <- ATR       
        MOV AH, 08h
        MOV BH,0       
        INT 10h                     
        
        ; DA UPDATE NA QTD DE CARACTERES LIDOS
        INC CX
        
        ; ARMAZENA EM LOCAL DE MEMORIA 
        MOV [BP], AL
        
        ; DA UPDATE NA POSICAO DO CURSOR
        INC DX
        
        CMP AL, 0Dh
        JNE LP_TECLADO
        
        ;ESCREVE AO FINAL O VALOR EM SIZE_TEXTO
        MOV BP, OFFSET SIZE_TEXTO
        MOV [BP], CL
        
        RET        
LER_TECLADO ENDP
    
    
        
COMECO:
    
    CALL LER_TECLADO
    CALL CESAR
	LEA BX, CRIPT
	CALL PRINTA
	LEA BX, DECRIPT
    CALL INVCESAR
	CALL PRINTA

FIM:

        NOP
        RET
        
        SIZE_TEXTO DB ?     
        TEXTO DB ?
        
        
        
CRIPT DB 50 DUP(0)
DECRIPT DB 50 DUP(1)

