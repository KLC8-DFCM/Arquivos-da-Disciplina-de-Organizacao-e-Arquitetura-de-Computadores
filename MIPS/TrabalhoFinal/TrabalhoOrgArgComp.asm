#Trabalho de Arquitetura e Organização de Computadores
#Diego Fleury Corrêa de Moraes 
#nusp: 11800584
#data: 28/12/2021

#Definição dos valores usados muitas vezes na impressao de chars
	.eqv Format1 40
	.eqv Format2 58
	.eqv Format3 41
	.eqv Format4 32
	.eqv NL 10

#Definição de valores usados como atalhos para os tamanhos de campos relevantes
	.eqv IMG_SIZE 10000
	.eqv HDR_SIZE 38
	.eqv HIS_SIZE 256
	
.globl main
	
	#Vale ressaltar que uma das maiores dificuldades deste trabalho fora o fato de que a diretiva .space
	#no Mars não necessariamente 'aloca' espaço respeitando outras áreas de memória. Como exemplo vem o erro
	#que ocorre se as diretivas .asciiz da data section forem colocadas anteriormente às diretivas .space
	#NÃO implica que entre o COMEÇO de PromptLimiar e o FINAL do espaço do histograma (pois é little endian)
	#teremos HIS_SIZE bytes zerados, na verdade apenas implica que entre o começo da secção de dados em si e o final 
	#do espaço 'alocado' para Histograma teremos HIS_SIZE zeros. Fica claro o problema se for feito o teste.
	
	#Em suma: diretivas .space (por alguma razão) devem ser declaradas anteriormente à diretivas que efetivamente ocupam
	#memória pois o MARS não efetivamente reserva memória em .space.

.data 	

	Histograma: .space HIS_SIZE
	Cabecalho: .space HDR_SIZE
	Imagem: .space IMG_SIZE
	
	Filename: .asciiz "/home/diego-fleury/imagem.pgm"
	FilenameProc: .asciiz "/home/diego-fleury/imgproc.pgm"  
	PromptLimiar: .asciiz "Por favor digite um valor entre 0 e 255 para o limiar: "
.text

main:

	#Abrir arquivo para leitura
	la   $a0, Filename  
	li   $a1, 0                    
	jal AbreArquivo
	
	#Descritor de arquivo esta agora em $v0, salvar em $s0
	move $s0, $v0
	
	#Armazena o cabecalho
	#Passagem de parametros
	move $a0, $s0  
	la $a1, Cabecalho
	li $a2, HDR_SIZE
	jal ArmazenaDados
	
	#Armazena a imagem
	#Passagem de parametros
	move $a0, $s0  
	la $a1, Imagem
	li $a2, IMG_SIZE
	jal ArmazenaDados
	
	#Fecha o arquivo
	move $a0, $s0
	jal FechaArquivo

	#Gerar o histograma acessando cada elemento na area de memoria da imagem
	li $a0, IMG_SIZE
	jal GeraHistograma

	#Mostrar histograma na saída padrão
	li $a0, HIS_SIZE
	jal MostraHistograma
	
	#Solicita do usuario a threshold
	jal SolicitaThreshold
	
	#Salva o valor
	move $s1, $v0
	
	#Binarizacao da imagem
	move $a0, $s1
	li $a1, IMG_SIZE
	jal  BinarizaImagem
	
	#Abrir arquivo para escrita
	la   $a0, FilenameProc
	li   $a1, 1                    
	jal AbreArquivo
	
	#Descritor de arquivo esta agora em $v0, salvar 
	move $s0, $v0

	#Escreve cabecalho
	#Passagem de parametros
	move $a0, $s0  
	la $a1, Cabecalho
	li $a2, HDR_SIZE
	jal EscreveArquivo
	
	#Escreve imagem processada
	#Passagem de parametros
	move $a0, $s0  
	la $a1, Imagem
	li $a2, IMG_SIZE
	jal EscreveArquivo
	
	#Fecha o arquivo
	move $a0, $s0
	jal FechaArquivo
	
	#Sai do programa	
	li $v0, 10
	syscall 
	
#Recebe como argumentos:
# $a0: endereco da string com o nome
# $a1: modo 
AbreArquivo:

	li   $v0, 13                  
	li   $a2, 0	
	syscall            

	jr $ra

#Recebe como argumento:
# $a0: descritor de arquivo a ser fechado
FechaArquivo:

	li $v0, 16
	syscall
	
	jr $ra
	
#Recebe como argumentos:
# $a0: o descritor de arquivo sobre o qual deve ler
# $a1: o endereco em que o dado deve ser armazenado em memoria 
# $a2: a quantidade de bytes que devem ser escritos na memoria
ArmazenaDados:
	
	li   $v0, 14      
	syscall           
	
	jr $ra

#Recebe como argumentos:
# $a0: o descritor de arquivo sobre o qual deve escrever
# $a1: o endereco em que o dado deve ser lido da memoria 
# $a2: a quantidade de bytes que deve ser escrita para o arquivo
EscreveArquivo:

	li   $v0, 15     
	syscall     
	
	jr $ra

#Recebe como argumentos:
# $a0: qtd de dados a serem lidos da imagem
GeraHistograma:

	#Index da imagem
	li $t0, 0
	
LoopLeitura:
	
	#Index do histograma
	lb $t1, Imagem($t0)
	
	#Captura valor atual armazenado
	lb $t2, Histograma($t1)
	
	#Soma mais um pois temos uma nova ocorrencia
	addu $t2, $t2, 1
	
	#Armazena valor novo em memoria
	sb $t2, Histograma($t1)
	
	#Proxima Leitura
	add $t0, $t0, 1
	bne $t0, $a0, LoopLeitura
	
	jr $ra

#Recebe como argumentos:
# $a0: tamanho do histograma
MostraHistograma:
	
	#Index do histograma
	li $t0, 0
	
	#Salva valor do tamanho do histograma
	move $t1, $a0

LoopHistograma:
	
	# '('
	li $v0, 11
	li $a0, Format1
	syscall
	
	#index do histograma
	li $v0, 1
	move $a0, $t0
	syscall
	
	# ':'
	li $v0, 11
	li $a0, Format2
	syscall

	#contagem do histograma
	li $v0, 1
	lb $a0, Histograma($t0)
	syscall
		
	# ')'
	li $v0, 11
	li $a0, Format3
	syscall
	
	# ' '
	li $v0, 11
	li $a0, Format4
	syscall
	
	add $t0, $t0, 1
	bne $t1, $t0, LoopHistograma
	
	# Nova linha
	li $v0, 11
	li $a0, NL
	syscall
	
	jr $ra

#Retorna:
# $v0: threshold escolhida
SolicitaThreshold:

	li $v0, 4
	la $a0, PromptLimiar
	syscall
	
	#Recupera o valor do usuario
	li $v0, 5
	syscall
	
	jr $ra

#Recebe como parametros:
# $a0: Threshold
# $a1: Tamanho da Imagem
BinarizaImagem:

	li $t0, 0
	
LoopBinarizacao:
	
	#Recupera pixel
	lb $t1, Imagem($t0)
	
	#Valor a ser passado inicializado como 0
	li $t2, 0
	
	blt $t1, $a0, SalvaValor
	
	#Valor novo caso maior igual que o threshold
	li $t2, 255
	
SalvaValor:
	
	#Salva valor novo
	sb $t2, Imagem($t0)
	
	add $t0, $t0, 1
	blt $t0, $a1, LoopBinarizacao 
	
	jr $ra	

