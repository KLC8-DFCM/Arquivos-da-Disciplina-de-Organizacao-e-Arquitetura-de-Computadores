#Somar os valores, exibir na tela de console o valor
#total da soma e salvar em uma variável em memória denominada de “soma”. Para exibir na tela
#use a função SYSCALL de exibição de valores inteiros na console, termine o programa com a
#SYSCALL “Exit”.

.data
	dado1: .word 0x01234567
	dado2: .word 0x76543210	
	soma: .word 0x00000000
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
    	
	