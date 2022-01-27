#Faça um programa que leia 5 entradas (números inteiros) digitados pelo usuário e imprima na tela a
#soma dos 5 números digitados. Exibir o resultado da soma na tela da console.

.data 
	InputPrompt: .asciiz "Digite 5 numeros inteiros:\n"
	OutputPrompt: .asciiz "\nSoma = "
.globl main

.text 

main: 
	li $v0,	4
	la $a0, InputPrompt
	syscall 
	
	li $t0, 5
	
LoopIntegerGet:
	li $v0, 5
	syscall
	
	sub $sp, $sp, 4
	sw $v0, ($sp)
	
	subu $t0, $t0, 1
	bne $t0, 0, LoopIntegerGet

	li $t1, 0 #index
	li $t3, 0 #acumulador
LoopSoma:
	lw $t2, ($sp) #valor recuperado
	add $sp, $sp, 4
	add $t3, $t3, $t2
	add $t1, $t1, 1
	bne $t1, 5, LoopSoma

	# Printa prompt de saida
	li $v0,	4
	la $a0, OutputPrompt
	syscall 
	
	#printa o inteiro
	li $v0, 1
	move $a0, $t3
	syscall 
	
	#Sai do programa
	li $v0, 10
	syscall
	