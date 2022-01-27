# P2 Diego Fleury 
# nusp: 11800584

.data
	NewLine: .asciiz "\n"
	promptInicial: .asciiz "\nAdivinhe um numero entre 0.0 e 999.999 (com 3 casas antes e depois da virgula)\n"
	promptEntradaInteira: .asciiz "Digite a parte inteira do numero: "	
	promptEntradaDecimal: .asciiz "Digite a parte decimal do numero: "
	promptSaidaInteira: .asciiz "A parte inteira do numero oculto eh "
	promptSaidaDecimal: .asciiz "A parte decimal do numero oculto eh "
	maior: .asciiz "MAIOR!\n" 
	menor: .asciiz "MENOR!\n"
	certa: .asciiz "CERTA!\n"
	promptCorreto: .asciiz "\nVoce ACERTOU! Parabens!\n"
	saida1: .asciiz "Numero Oculto: "
	saida2: .asciiz "Numero Tentativa: "
	saida3: .asciiz "Total de Tentativas:"
	NOCULTOI: .word 100
	NOCULTOD: .word 100
	Ponto: .ascii "."
.globl main

.text 

#inicializa contador
	li $s4, 1
main:
	
	#mostra a string inicial
	li $v0, 4
	la $a0, promptInicial
	syscall
	
	#linha em branco
	li $v0, 4
	la $a0, NewLine
	syscall
	
	#recupera a entrada inteira
	la $a0, promptEntradaInteira
	jal PromptInput
	move $s0, $v0
	
	#recupera a entrada decimal
	la $a0, promptEntradaDecimal
	jal PromptInput
	move $s1, $v0
	
	#passagem de parametros para TestaNumero 
	move $a0, $s0
	move $a1, $s1
	
	#poderia ser feito apenas uma vez, porem para claridade feito a cada iteracao
	lw $a2, NOCULTOI
	lw $a3, NOCULTOD
	
	jal TestaNumero
	
	# contador
	bne $v0, $zero, Final
	add $s4, $s4, 1
	j main
	
Final: #printa tudo e sai
	
	# Cabecalho de saida
	la $a0, promptCorreto
	jal PromptFinalString
	
	#numero oculto
	la $a0, saida1
	jal PromptFinalString
	
	lw $a0, NOCULTOI
	jal PromptFinalInt
	
	la $a0, Ponto
	jal PromptFinalString

	lw $a0, NOCULTOD
	jal PromptFinalInt

	la $a0, NewLine
	jal PromptFinalString
	
	#numero tentativa
	la $a0, saida2
	jal PromptFinalString
		
	lw $a0, NOCULTOI
	jal PromptFinalInt
	
	la $a0, Ponto
	jal PromptFinalString

	lw $a0, NOCULTOD
	jal PromptFinalInt

	la $a0, NewLine
	jal PromptFinalString
	
	#total de tentativas
	la $a0, saida3
	jal PromptFinalString

	move $a0, $s4
	jal PromptFinalInt

	la $a0, NewLine
	jal PromptFinalString

	#sai do programa
	li $v0, 10
	syscall
	
#no caso ira testar os dois numeros
# parte inteira testada: a0
# parte decimal testada: a1
# parte inteira oculta: a2
# parte decimal oculta: a3

#retorna em v0: 1-> acertou, 0-> errou
TestaNumero:
	
	#salva endereco de retorno
	add $sp, $sp, -4
	sw $ra, ($sp)
	
	#passagem de parametros para a parte inteira de ComparaNumero
	move $t0, $a1
	move $a1, $a2
	
	#Compara numero parte inteira
	jal ComparaNumero
	
	#salva se acertou ou nao inteiro
	move $s2, $v1
	
	#passagem de parametros para promptDica
	la $a0, promptSaidaInteira
	move $a1, $v0
	
	#prompt parte inteira
	jal PromptDica
	
	#recuperacao/passagem de parametros para a parte decimal
	move $a0, $t0
	move $a1, $a3
	
	#Compara numero parte decimal
	jal ComparaNumero
	
	#salva se acertou ou nao decimal
	move $s3, $v1
	
	#passagem de parametros para promptDica
	la $a0, promptSaidaDecimal
	move $a1, $v0
	
	#prompt parte decimal
	jal PromptDica
	
	#valor de retorno
	beq $s2, $s3, RetornoIgual
	b RetornoPadrao
	
RetornoIgual:
	beq $s2, $zero, RetornoPadrao
	li $v0, 1 #acertou!
	b Retorno
	
RetornoPadrao:
	move $v0, $zero
	
Retorno:
	
	#recupera endereco de retorno
	lw $ra, ($sp)
	add $sp, $sp, 4
	
	jr $ra

#recebe os numeros. Testado em a0, oculto em a1
#retorna a string de se é maior, menor ou igual ($v0)
#retorna se é igual ($v1)
ComparaNumero:
	
	beq $a0, $a1, Igual
	
	li $v1, 0
	
	blt $a0, $a1, Maior
	b Menor
Igual:
	la $v0, certa
	li $v1, 1
	jr $ra

Maior:
	la $v0, maior
	jr $ra
Menor:
	la $v0, menor
	jr $ra

#assume-se argumento de string em a0, retorna em v0 o inteiro
PromptInput: 
	
	#printa string de prompt
	li $v0,4
	syscall
	
	#pega inteiro (armazenado em v0)
	li $v0, 5
	syscall
	
	#salva inteiro
	move $t0, $v0
	
	#nova linha
	li $v0,4
	la $a0, NewLine
	syscall
	
	move $v0, $t0
	
	jr $ra

# assume-se que endereco da string de prompt em a0 e de dica em a1
PromptDica:
	
	#printa string de prompt
	li $v0, 4
	syscall
	
	move $a0, $a1
	
	#printa string de dica
	li $v0, 4
	syscall
	
	jr $ra

#assume-se string em a0
PromptFinalString:
	li $v0, 4
	syscall
	jr $ra

#assume-se int em a0
PromptFinalInt:
	li $v0, 1
	syscall
	jr $ra

	
	
	