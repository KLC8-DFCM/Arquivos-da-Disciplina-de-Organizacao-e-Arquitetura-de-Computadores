#Faça um programa que leia dois números inteiros (digitados pelo usuário) e calcule a multiplicação
#destes 2 números. Exibir na console o resultado da multiplicação.

.data
	PromptIN: .asciiz "Escolha dois numeros inteiros\n"
	PromptOUT: .asciiz "Estes numeros multiplicados resultam em: "
.globl main

.text 

main:
	la $a0, PromptIN
	jal PrintaPrompt
	
	jal PegaInteiro
	move $s0, $v0
	
	jal PegaInteiro
	move $s1, $v0
	
	la $a0, PromptOUT
	jal PrintaPrompt
	
	#multiplicacao em si
	mul $a0, $s0, $s1
	li $v0, 1
	syscall
	
	#sai do programa
	li $v0, 10
	syscall
	
#recebe de entrada endereco da string na registradora $a0
PrintaPrompt:
	 li $v0, 4
	 syscall 
	 jr $ra

#retorna na registradora $v0
PegaInteiro:
	li $v0, 5
	syscall 
	jr $ra