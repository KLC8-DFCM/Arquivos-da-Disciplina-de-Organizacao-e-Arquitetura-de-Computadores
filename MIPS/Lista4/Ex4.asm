#Faça um programa que leia um número inteiro e calcule o fatorial de um número de forma recursiva, ou
#seja, deve empilhar e desempilhar adequadamente os parâmetros (entrada), valor de retorno (saída) e
#endereço de retorno de cada chama (Usar um “frame” na pilha para armazenar os dados da função).
#Termine o programa exibindo o resultado do fatorial na console seguido da SYSCALL “Exit”.

.data

.globl main

.text
main:
	li $v0, 5
	syscall 
	
	move $a0, $v0
	
	jal Fatorial
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
#passar por $a0
Fatorial:

	add $sp, $sp, -8
	sw $ra, ($sp)
	sw $s0, 4($sp)
	
	li $v0, 1
	beq $a0, 0, RecuperaStack
	
	move $s0, $a0
	sub $a0, $a0, 1
	jal Fatorial #quando voltar jr volta AQUI, direto pra parte que multiplica
	
	mul $v0, $s0, $v0 #repara no truque : jal nao tem necessariamente apenas a funcao de guardar o endereco
	                  # mas indiretamente controla a quantidade de vezes que temos de "voltar" na recursao

RecuperaStack: #é chamado diretamente uma vez apenas, nas outras é consequencia do fato de "continuar" da parte de cima

	lw $ra, ($sp)
	lw $s0, 4($sp)
	add $sp, $sp, 8
	jr $ra
