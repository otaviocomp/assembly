.data        
       vetor:  .space 40            			 # aloca 40 bytes para armazenar 10 inteiros
       mensagem: .asciiz "digite novo numero:"
       espaco: .asciiz " " 				 # espaço
       mensagemimprimir: .asciiz "vetor digitado foi: " 
       vetorordenado: .asciiz "\nVetor Ordenado: "
       erro: .asciiz "valor invalido! digite novo numero entre -100 e 100 \n"
.text
	main:	
		li $t0, 0      				# zera o registrador t0	
  	inserirvalor:
  		li $v0, 4				# exibe mensagem para digitar um novo número
		la $a0, mensagem
		syscall
  		
  		li $v0, 5 				# usuário entra com um número
		syscall
		
		jal teste 				# chama teste
		
		sw $v0, vetor($t0)			# armazena no vetor
		
		addi $t0, $t0, 4			# passa para a próxima posição do vetor
		bne $t0, 40, inserirvalor		# verifica se já preencheu as 10 posições do vetor
		beq $t0, 40, vetordigitado	
 	teste:	
		bgt $v0, 100, imprimirerro		# testa se o valor digitado é superior a 100
		blt $v0, -100, imprimirerro		# testa se o valor digitado é inferior a 100
		
		jr $ra					# retorna para a subrotina inserirvalor
  	imprimirerro:
		li $v0, 4				# imprime mensagem de erro 
		la $a0, erro
		syscall
		
		j inserirvalor				# retorna para inserirvalor
    	vetordigitado:
    		li $v0, 4				# imprime mensagem
    		la $a0, mensagemimprimir
    		syscall
    		
    		li $t0, 0				# zera t0
    	imprimirvetor:
		lw $t1, vetor($t0)			# carrega o valor contido em uma psição do vetor
			
		li $v0, 1				# imprime elemento
		move $a0, $t1
		syscall
		
		addi $t0, $t0, 4 			# incrementa t0
		
		li $v0, 4				# imprime um espaço
		la $a0, espaco
		syscall
		
		bne  $t0, 40, imprimirvetor		#imprime até que os 10 valores no vetor sejam impressos
		li $t4, 0				# zera valor do registrador t4
		li $t0, 0				# zera valor do registrador t0
		j carregar
	incrementar:
		addi $t4, $t4, 4			# passa para a próxima posição do vetor
		move $t0, $t4				# t0 recebe t4 para percorrer o vetor a partir da posição do elemento vetor($t4)
	carregar:					
		lw $t1, vetor($t4)			# carrega o valor do vetor em t1				
	ordenar:
		addi $t0, $t0, 4			# incrementa t0
		beq $t0, 40, incrementar
		beq $t4, 40, imprimirvetorordenado
		lw $t2, vetor($t0)			# carrega os próximos valores do vetor em t2
		bgt $t1, $t2, trocar			# trocar valores de t1 e t2
		beq $t1, $t2, ordenar			# continuar o algoritmo
		blt $t1, $t2, ordenar			# continuar o algoritmo
	trocar: 
		move $t3, $t1
		move $t1, $t2
		move $t2, $t3
		sw $t1, vetor($t4)			# troca os valores
		sw $t2, vetor($t0)		
		j ordenar
	imprimirvetorordenado:
		li $v0, 4
		la $a0, vetorordenado
		syscall
		li $t0, 0				# zera t0
	imprimirordenado:
		lw $t1, vetor($t0)			# carrega o valor contido em uma psição do vetor
			
		li $v0, 1				# imprime elemento
		move $a0, $t1
		syscall
		
		addi $t0, $t0, 4 			# incrementa t0
		
		li $v0, 4
		la $a0, espaco
		syscall
		
		bne  $t0, 40, imprimirordenado		#imprime até que os 10 valores no vetor sejam impressos
		
		li $v0, 10
		syscall


