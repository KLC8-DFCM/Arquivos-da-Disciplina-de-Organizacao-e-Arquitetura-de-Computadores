
; You may customize this and other start-up templates;
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

NRO equ 100

Inicio:
mov AL,0
Pt1:
cmp AL,NRO
jz Fim
Inc AL
jmp Pt1
Fim:
NOP

ret






