#Faça um programa que leia 4 números inteiros (digitados pelo usuário), armazene nos registradores de
#$A0 a $A3 (argumentos da função – valores inteiros de 32 bits). Chamar uma sub-rotina denominada
#“SOMA4” que recebe os 4 valores e calcula a soma retornado o resultado no registrador $V0. A rotina
#SOMA4 deve chamar a rotina CALCSOMA para somar 2 pares de valores e depois somar os 2
#resultados, obtendo a soma dos 4 valores. Atenção para não perder o endereço de retorno da função,
#pois haverá 2 níveis de chamada: chama SOMA4 que chama CALCSOMA. Termine o programa
#exibindo o resultado da soma na console seguido da SYSCALL “Exit”.

.data

.globl main

.text

main:
	jal LerInteiros
	move $a0, $v0 
	
	jal LerInteiros
	move $a1, $v0

	jal LerInteiros
	move $a2, $v0 
	
	jal LerInteiros
	move $a3, $v0
	
	jal Soma4
	
	move $a0, $v0
	jal PrintaInteiro

	li $v0, 10
	syscall 
	
PrintaInteiro:
	li $v0, 1
	syscall
	jr $ra
	
LerInteiros:
	li $v0, 5
	syscall 
	jr $ra

Soma4:
	add $sp, $sp, -4
	sw $ra, ($sp)
	
	jal CalcSoma
	move $v1, $v0
	
	move $a0, $a2
	move $a1, $a3
	jal CalcSoma
	
	move $a0, $v0
	move $a1, $v1
	
	jal CalcSoma
	
	lw $ra, ($sp)
	jr $ra
CalcSoma:
	add $v0, $a0, $a1
	jr $ra