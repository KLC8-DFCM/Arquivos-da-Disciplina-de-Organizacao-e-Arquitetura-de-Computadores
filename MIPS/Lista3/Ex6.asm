#Faça um programa com uma contagem regressiva até Zero, que conte de um valor definido em uma
#variável “inicio” e com um laço de contagem de “inicio” até 0. Exibir a contagem na tela da console
#com o respectivo syscall.

.data
	inicio: .word 100
	NewLine: .asciiz "\n"
.globl main

.text
	la $s0, NewLine
	lw $s1, inicio
main:
	
	move $a0, $s1
	li $v0, 1
	syscall
	
	move $a0, $s0
	li $v0, 4
	syscall
	
	subu $s1, $s1,1
	
	bge $s1, 0, main

	li $v0, 10
	syscall