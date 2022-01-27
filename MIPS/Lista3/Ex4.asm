#Faça um programa com um contador que conte de 1 até o número definido por uma constante.
#Inicialmente você pode contar até 100. Laço de contagem de 1 até o NRO definido (100). Exibir a
#contagem na tela da console com o respectivo syscall.

.data
	.eqv NRO 100
	NewLine: .asciiz "\n"
	
.globl main
.text 
main:
	li $s0, 1
	la $s1, NewLine 
Laco:
	move $t0, $s0
	addu  $s0, $s0, 1
	
	move $a0, $t0 
	li $v0, 1
	syscall
	
	move $a0, $s1
	li $v0, 4
	syscall
	
	bne $t0,NRO, Laco
	
	li $v0, 10
	syscall
	
	
