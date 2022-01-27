#Faça um programa similar ao do exercício 1, porém definindo os valores de dado1 e dado2 como 2
#valores inteiros em Decimal, dado1 deve valer 01234567 (inteiro em notação decimal de 32 bits) e
#dado2 deve valer 76543210 (inteiro em notação decimal de 32 bits). Somar, salvar o resultado em
#“soma”, exibir o resultado e terminar com “exit”.

.data #NAO deu certo quando escrevi começando com 0 (01234567) --> achou que era octal, pois padrão de octal é começar com 0
	dado1: .word 1234567
	dado2: .word 76543210	
	soma: .word 00000000
.text 
	.globl main
main:
	lw $s0, dado1
	lw $s1, dado2
	add $s2, $s1, $s0
	sw $s2, soma
	
#impressao inteira na tela
    	lw $a0,soma
    	li $v0,1
    	syscall
    	
#sair do programa
    	li $v0,10
    	syscall
    	
	