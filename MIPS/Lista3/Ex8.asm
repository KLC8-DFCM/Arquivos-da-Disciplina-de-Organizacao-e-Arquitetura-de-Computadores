#Faça o mesmo do exercício acima (exercício 7), porém o valor agora deverá ser lido do teclado e o
#triângulo deve ser apresentado na console de forma invertida (diminuindo o nro. de asteriscos).
#Lembre-se de usar a devida SYSCALL para ler um número inteiro que representa o número máximo
#de asteriscos do desenho do triângulo. Exemplo: se o usuário digitar 5, seu programa deverá imprimir

#mudar, mas é algo do tipo
.data
	Asterisco: .asciiz "*"
	NewLine: .asciiz "\n"
.globl main

.text
	# inicializacao do newLine
	la $s0, NewLine
	la $s1, Asterisco
	
	# pegar int do usuario
	li $v0, 5
	syscall
	
	# quantidade esta em t0
	move $t0, $v0
	addu $t0, $t0, 1
	
main:
        subu $t0, $t0, 1
        ble  $t0, 0, fim
	j PrintCaracter
fim:	
	li $v0, 10
	syscall
	
PrintCaracter:
	li $t1, 1
	move $a0, $s1
	li $v0, 4
Laco:
	syscall # printa o caracter *
	addu $t1, $t1, 1
	ble $t1, $t0, Laco
	
	move $a0, $s0
	syscall
	
	j main
	
