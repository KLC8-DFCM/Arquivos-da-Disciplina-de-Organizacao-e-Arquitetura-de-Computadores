#Faça um programa que calcule o fatorial de um número informado pelo usuário (digitado pelo
#usuário). O programa deve calcular o fatorial por multiplicações sucessivas, sem usar recursividade ou
#chamadas de funções (sub-rotinas). Exibir na console o resultado do cálculo do fatorial.

.data
	PromptIN: .asciiz "Digite um natural: "
	PromptOUT: .asciiz "\nO fatorial do seu numero e: "
.globl main

.text

main:
	la $a0, PromptIN
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0
	
	la $a0, PromptOUT
	li $v0, 4
	syscall
	
	li $s1, 1
	
LoopFatorial:
	
	mul $s1, $s1, $s0
	sub $s0, $s0, 1
	bne $s0, 0, LoopFatorial

 	li $v0, 1
 	move $a0, $s1
 	syscall
 	
 	li $v0, 10
 	syscall			
			