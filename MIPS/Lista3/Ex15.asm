#Faça um programa que ordena um vetor estático de números inteiros e o imprime na tela (ordenado).

.data
	vetorInteiros: .word 12, 13, 0, -1, 345, 15, 2, 23, 5
	PromptIN: .asciiz "Vetor nao ordenado: "
	PromptOUT: .asciiz "Vetor ordenado:  "
	sep: .asciiz ", "
	NewLine: .asciiz "\n"
.globl main

.text

main:
	la $a0, PromptIN
	li $v0, 4
	syscall
	
	li $s1, 36
	jal PrintaVetor
	
	move $s0, $s1  #tamanho do array = 9 elementos de 4 bytes	
	j BubbleSort
fim:
	
	la $a0, PromptOUT
	li $v0, 4
	syscall 
	
	jal PrintaVetor
	
	li $v0, 10
	syscall
	
BubbleSort:
	
LoopExterno:
	
	# j--
	sub $s0, $s0, 4
	
	#j > 0 
	beq $s0, 0, fim
	
	# i = j
	li $t0, 0 #i
	li $t1, 4 # i+1
LoopInterno:

	lw $t2, vetorInteiros($t0)
	lw $t3, vetorInteiros($t1)
	
	bgt $t2, $t3, Trocar
comparacao:	
	add $t0, $t0, 4
	add $t1, $t0, 4
	bne $t0, $s0, LoopInterno
	j LoopExterno
	
Trocar:
	
	sw $t2, vetorInteiros($t1)
	sw $t3, vetorInteiros($t0)
	
	j comparacao
	
PrintaVetor:
	li $t0, 0

LoopPrinta:
	li $v0, 1
	lw $a0, vetorInteiros($t0)
	syscall
	
	li $v0, 4
	la $a0, sep
	syscall
	
	add $t0, $t0, 4
	bne $t0, $s1, LoopPrinta
	
	li $v0, 4
	la $a0, NewLine
	syscall
	
	jr $ra
	
	
