#Faça um programa similar ao exercício anterior, que leia 2 números inteiros (digitados pelo usuário),
#armazene nos registradores $A0 e $A1 (valores INTEIROS de 32 Bits). Chamar uma sub-rotina
#(função) denominada de “CALCSOMA” que irá somar os 2 valores, porém ao invés da sub-rotina
#exibir o resultado na tela, ela deve retornar o valor total da soma, retornando este valor para o
#programa principal (que chamou a função). Use o registrador correto para retornar um valor de uma
#função (registrador de retorno - $V0). Para ler os dados digitados e exibir na tela use as funções
#SYSCALL de leitura e exibição de valores inteiros na console, termine o programa exibindo o
#resultado da soma na console seguido da SYSCALL “Exit”.
#Ex. V = CALCSOMA (A, B);

.data

.globl main

.text

main:
	jal LerInteiros
	move $a0, $v0 
	
	jal LerInteiros
	move $a1, $v0
	
	jal CalcSoma
	
	move $a0, $v0
	jal PrintaInteiro
	
	li $v0, 10
	syscall 
	
LerInteiros:
	li $v0, 5
	syscall 
	jr $ra

CalcSoma:
	add $v0, $a0, $a1
	jr $ra

PrintaInteiro:
	li $v0, 1
	syscall
	jr $ra
	