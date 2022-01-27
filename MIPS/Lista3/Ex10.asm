#. Faça um programa que procura por um caractere ‘c’ em uma string estática e imprime na tela se
#encontrou ou não este caractere na string (Mensagens: “achou” / “nao achou”), e indicando em qual
#posição encontrou o referido caractere (contador inteiro).

.data
	StringSemC: .asciiz "Eu sou uma string sem a letra"
	StringComC: .asciiz "Eu sou uma string com a letra"
	PromptAchou: .asciiz "achou na posicao:"
	PromptNaoAchou: .asciiz "nao achou"
.globl main

.text

	j main
Printa:
	li $v0, 4
	syscall
	jr $ra
printaAchou:
	la $a0, PromptAchou
	jal Printa
	
	sub $s0, $s0, $s1
	li $v0, 1
	move $a0, $s0
	syscall
	
	j fim 
printaNaoAchou:
	la $a0, PromptNaoAchou
	jal Printa
	j fim
main:	
	# carrega endereco da string estatica
	la $s0, StringComC
	move $s1, $s0
	
LoopCheca:
	# a cada iteracao 
	lb $t0, ($s0)			#carrega um char da memoria em t0
        beq $t0, 0, printaNaoAchou      # se caracter 0: fim (pois null terminated)
	add $s0, $s0, 1 	 	# aumenta em um o endereco (proximo char)
	beq $t0,'c', printaAchou	# se caracter == 'c': fim (achou)
	j LoopCheca
fim:	
	li $v0, 10
	syscall