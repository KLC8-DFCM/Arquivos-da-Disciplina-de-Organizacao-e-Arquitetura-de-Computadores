#Faça um programa em assembly MIPS que imprima na tela triângulos desenhados com o caractere de
#estrela/asterisco (*) de acordo com um valor pré-definido no código. Exemplo: se o valor for 4, seu
#programa deverá imprimir na tela da console: “um triângulo, começando com 1, depois 2, depois 3 e
#por fim 4 asteriscos formando o desenho triangular na tela”. Use a devida função SYSCALL para a
#exibição dos asteriscos na tela.

.data
	h: .word 5
	asterisco: .asciiz "*"
	NewLine: .asciiz "\n"
.globl main

.text
	la $s0, NewLine
	la $s1, asterisco
	lw $s2, h
	li $t0, 0
main:
        addu $t0, $t0, 1
        bgt  $t0, $s2, fim
	j PrintAsterisco
fim:	
	li $v0, 10
	syscall
	
PrintAsterisco:
	li $t1, 1
	move $a0, $s1
	li $v0, 4
Laco:
	syscall
	addu $t1, $t1, 1
	ble $t1, $t0, Laco
	
	move $a0, $s0
	syscall
	
	j main
	
