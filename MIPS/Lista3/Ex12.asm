#Faça um programa que concatena (une) duas strings (sequências de caracteres), pré-definidas no
#código e previamente armazenadas em memória, resultando em uma só nova string (como o comando
#strcat da linguagem “C”). Exibir na tela da console a string nova resultante da concatenação.

.data
	String1: .ascii "Eu sou a primeira string e "
	String2: .asciiz "essa e a segunda string\n"
	StringConcatenada: .space 53 #28 + 25
.globl main 

.text

main:
	# enderecos
	la $s0, String1 
	la $s1, String2
	la $s2, StringConcatenada
	
	#tamanhos
	sub $s3, $s1, $s0
	sub $s4, $s2, $s1
	
	#index 1
	li $t0, 0
Loop1:
	lb $t1, String1($t0)
	sb $t1, StringConcatenada($t0)
	add $t0 , $t0 , 1
	blt $t0, $s3, Loop1

	#index 2
	li $t2, 0
Loop2:
	lb $t1, String2($t2)
	sb $t1, StringConcatenada($t0)
	add $t0 , $t0 , 1
	add $t2 , $t2 , 1
	bne $t2, $s4, Loop2

	#printa na tela
	li $v0, 4
	move $a0, $s2
	syscall
	
	#sai do programa
	li $v0, 10
	syscall
	
		
	