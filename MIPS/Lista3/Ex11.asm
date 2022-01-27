#Faça um programa que recebe uma string como entrada do usuário (digitada pelo usuário) e a imprime
#na tela.

.data
	.eqv MAX_LENGTH_STRING 100
	Buffer: .space MAX_LENGTH_STRING
	Zero: .byte 0
.globl main

.text
	
main:
	# le do teclado: similar a fgets (max length)
	li $v0, 8
	la $a0, Buffer
	li $a1, MAX_LENGTH_STRING
	syscall
	
	# escreve na tela 
	li $v0, 4
	la $a0, Buffer
	syscall
	
	#fim
	li $v0, 10
	syscall
	