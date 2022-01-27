#Faça um programa que leia 2 números inteiros (digitados pelo usuário), armazene nos registradores
#$A0 e $A1 (valores INTEIROS de 32 Bits). Chamar uma sub-rotina (função) denominada de
#“SOMA” que irá somar os 2 valores e exibir na tela de console o valor total da soma, retornando o
#programa principal. Para ler os dados digitados e exibir na tela use as funções SYSCALL de leitura e
#exibição de valores inteiros na console, termine o programa com a SYSCALL “Exit”.
#Ex. SOMA (A,B);

.data 

.globl main 

.text

main:
	jal LerInteiros
	move $a0, $v0 
	
	jal LerInteiros
	move $a1, $v0
	
	jal Soma
	
	li $v0, 10
	syscall 
	
LerInteiros:
	li $v0, 5
	syscall 
	jr $ra

Soma: 
	li $v0, 1
	add $a0, $a1,$a0
	syscall
	jr $ra