#Faça um programa com um contador que conte de “inicio” até o valor “final” definidos por variáveis
#em memória. Faça o contador avançar com um passo, definido na variável “incr”. Exibir a contagem
#na tela da console com o respectivo syscall

.data 
	inicio: .word 10 
	incr: .word 2
	final: .word 100
	NewLine: .asciiz "\n"
	
.globl main

.text
	lw $s0, inicio
	lw $s1, final
	lw $s2, incr
	la $s3, NewLine
	
	move $t0, $s0
main:
	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 4
	move $a0, $s3
	syscall
	
	addu $t0, $t0, $s2
	
	bne $t0, $s1, main

FIM:	
	li $v0, 10
	syscall
	