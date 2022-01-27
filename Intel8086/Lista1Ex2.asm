
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

Inicio:
        mov al,1
LP:
        cmp al,VALMAX
        jz Fim 
        inc al
        jmp LP
Fim:
        nop      
        ret
        
VALMAX DB 100



