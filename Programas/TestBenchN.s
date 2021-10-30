		# Teste microRISCV Processor

		jal x11, OK0				# testa o jal
		nop
		addi x11, x11, -4		      	# endereco do possivel erro no jal

ERRO:
   		lui x10, 0xEEEEE
    		li x12, 0xEEE
    		nop
    		nop
    		nop
    		add x10, x10, x12			# se algo deu errado, coloca 0xEEEEEEEE em x10 e o endereco do erro em x11

FIM:		jal x0, FIM				# loop infinito
		nop

OK0:
		# andi
		addi x3, x0, 0xF			# 1111
		nop
    		nop
    		nop
		andi x4, x3, 5		      		# 0101
		addi x5, x0, 5		      		# resultado esperado
		nop
    		nop
    		nop
		jal x11, T1				# salva endereco do possivel erro no andi
		nop
		nop
T1:	
   		beq x4, x5, OK1		      		# verifica se deu certo
   		nop
		addi x11, x11, -12	      		# endereco que deu erro
		jal x0, ERRO
		nop
		nop

OK1:
    		# ori
    		addi x3, x0, 0xA	      		# 1010
    		nop
    		nop
    		nop
		ori x4, x3, 0x5		      		# 0101
		addi x5, x0, 0xF		    	# resultado esperado
		jal x11, T2		          	# salva endereco do possivel erro no andi
		nop
		nop
    
T2:
    		beq x4, x5, OK2		      		# verifica se deu certo
    		nop
		addi x11, x11, -12	     	 	# endereco que deu erro
		jal x0, ERRO
		nop
		nop

OK2:
    		# xori
		addi x3, x0, 10 	      		# 1010
		nop
    		nop
    		nop
		xori x4, x3, 5		      		# 0101
		addi x5, x0, 15		      		# 1111
		jal x11, T3		          	# salva endereco do possivel erro no xori
		nop
		nop

T3:
    		beq x4, x5, OK3		      		# verifica se deu certo
    		nop
		addi x11, x11, -12	      		# endereco que deu erro
		jal x0, ERRO
		nop
		nop

OK3:
    		# slti
    		addi x31, x0, -1        		# x31 = -1
    		nop
    		nop
    		nop
    		slti x30, x31, 0
    		addi x29, x0, 1
    		jal x11, T4             		# salva endereco do possivel erro slti
    		nop
    		nop

T4:
    		beq x29, x30, OK4
    		nop
    		addi x11, x11, -12
    		jal x0, ERRO
    		nop
OK4:
    		# sltiu
    		addi x3, x0, -1	        		# 0xffff
    		nop
    		nop
    		nop
		sltiu x4, x3, 1		      		# 0x1
		jal x11, T5		          	# salva endereco do possivel erro no andi
		nop
		nop
    
T5:
   	 	beq x4, x0, OK5		      		# verifica se deu certo
   	 	nop
		addi x11, x11, -8	      		# endereco que deu erro
		jal x0, ERRO
		nop
    

OK5:
    		# slli
		addi x3, x0, 1	        		# 1
		nop
    		nop
    		nop
		slli x4, x3, 2		      		# 2
		addi x5, x0, 4		      		# 4
		jal x11, T6		          	# salva endereco do possivel erro no slli
		nop
		nop

T6:
    		beq x4, x5, OK6		      		# verifica se deu certo
    		nop
		addi x11, x11, -12	      		# endereco que deu erro
		jal x0, ERRO
		nop
		
OK6:
    		# lui
    		addi x28, x0, 0x100     		# 0x100
    		nop
    		nop
    		nop
    		slli x28, x28, 4        		# 0x1000
    		nop
    		nop
    		nop
    		addi x28, x28, 1        		# 0x1001
    		nop
    		nop
    		nop
    		slli x28, x28, 16	      		# resultado esperado
		lui x27, 0x10010  	    		# 0x10010000
		jal x11, T7		          	# salva endereco do possivel erro no lui
		nop
		nop

T7:
    		beq x27, x28, OK7		   	# verifica se deu certo
    		nop
		addi x11, x11, -8 	      		# endereco que deu erro
		jal x0, ERRO
		nop

OK7:
    		# auipc
    		auipc x10, 0				# x10 = PC (com auipc)
    		addi x9, x11, 12			# x9 = PC
    		jal x11, T8
    		nop
    		nop

T8:
    		beq x9, x10, OK8			# verifica se deu certo
    		nop    		
    		addi x11, x11, -12			# valor do endereco do possivel erro no auipc 
    		jal x0, ERRO
    		nop

OK8:
    		# jalr
    		lui x24, 0x00400
    		nop
    		nop
    		nop
    		addi x24, x24, 0x104			# x24 = 0x00400104 (PC atual)
    		jalr x11, x24, 0x8			# pula pra duas instrucoes depois
    		nop
    		nop

OK9:
    		# lw e sw
    		addi x3, x0, 0
    		lui x3, 0x10010   	# x3 = 0x10010000
    		addi x4, x0, 10   	# x4 = 10	
    		nop
    		nop
    		nop
		sw x4, 0(x3)      	# salva x4 na memoria
    		lw x5, 0(x3)      	# carrega valor da memoria em x5
    		jal x11, T10
    		nop
    		nop

T10:
    		beq x4, x5, OK10  	# verifica se deu certo
    		nop
    		jal x0, ERRO      	# o x1 ja ta com o endereco certo
    		nop

OK10:
    		# bne
		addi x3, x0, 777		# 777
		nop
    		nop
    		nop
		addi x4, x3, 666		# 666
		jal x11, T11		# salva endereco do possivel erro no bne
		nop
		nop

T11:
    		bne x3, x4, OK11
    		nop
    		jal x0, ERRO
    		nop

OK11:
    		# blt
		addi x3, x0, -1	    	# -1
		nop
    		nop
    		nop
		addi x4, x3, 1		# 1
		jal x11, T12		# salva endereco do possivel erro no blt
		nop
		nop

T12:
    		blt x3, x4, OK12
    		nop
    		jal x0, ERRO
    		nop

OK12:
    		# bge
    		addi x26, x0, 2  		# 2
		addi x25, x0, 0		# -1
		jal x11, T13	    	# salva endereco do possivel erro no bge
		nop
		nop

T13:
    		bge x26, x25, OK13
    		nop
    		jal x0, ERRO
    		nop

OK13:
    		# bltu
		addi x24, x0, 1	    	# 1
		addi x23, x0, -1		# -1
		jal x11, T14		# salva endereco do possivel erro no bltu
		nop
		nop

T14:
    		bltu x24, x23, OK14
    		nop
    		jal x0, ERRO
    		nop

OK14:
    		# bgeu
    		addi x26, x0, 2  		# 0
		addi x25, x0, 0		# -1
		jal x11, T15     		# salva endereco do possivel erro no bgeu
		nop
		nop
T15:
    		bgeu x26, x25, OK15
    		nop
    		jal x0, ERRO
    		nop
OK15:
    		# add
		addi x24, x0, 69    	# 69
		addi x23, x0, 1     	# 1
		nop
    		nop
    		nop
    		add x21, x23, x24
		addi x22, x0, 70    	# 70 resultado esperado
		jal x11, T16		# salva endereco do possivel erro no slli
		nop
		nop

T16:
    		beq x21, x22, OK16
    		nop
    		addi x11, x11, -12
    		jal x0, ERRO
    		nop

OK16:
    		# sub
    		addi x20, x0, -1
    		nop
    		nop
    		nop
    		sub x19, x20, x20
    		jal x11, T17
    		nop
    		nop

T17:
    		beq x19, x0, OK17
    		nop
    		addi x11, x11, -8
    		jal x0, ERRO
    		nop

OK17:
    		# and
    		addi x19, x0, 13  # 1101
    		addi x18, x0, 6   # 0110
    		addi x16, x0, 4   # 0100
    		nop
    		nop
    		and x17, x18, x19
    		jal x11, T18
    		nop
    		nop

T18:
    		beq x17, x16, OK18
    		nop
    		addi x11, x11, -8
    		jal x0, ERRO
    		nop

OK18:
    		# or
    		addi x15, x0, 10  # 1010
    		addi x14, x0, 4   # 0100
    		nop
    		nop
    		nop
    		or x13, x15, x14
    		addi x12, x0, 14  # 1110 resultado esperado
    		jal x11, T19
    		nop
    		nop
    
T19:
    		beq x13, x12, OK19
    		nop
    		addi x11, x11, -12
    		jal x0, ERRO
    		nop

OK19:
    		# xor
    		addi x12, x0, 17  # 10001 vitu eh muito legal :)
    		addi x10, x0, 14  # 01110
    		addi x9, x0, 31   # 11111
    		xor x8, x12, x10
    		jal x11, T20
    		nop
    		nop

T20:    		
    		beq x8, x9, OK20
    		nop
    		addi x11, x11, -8
    		jal x0, ERRO
    		nop

OK20:
    		# slt
    		addi x6, x0, -1   # -1
    		nop
    		nop
    		nop
    		slt x5, x6, x0    
    		addi x4, x0, 1    # 1 valor esperado
    		jal x11, T21       # salva endereco do possivel erro slti
    		nop
    		nop
    
T21:
    		beq x4, x5, OK21
    		nop
    		addi x11, x11, -12
    		jal x0, ERRO
    		nop

OK21:
    		# sltu
    		addi x3, x0, -1   # -1
    		nop
    		nop
    		nop
    		sltu x2, x0, x3    
    		addi x1, x0, 1    # 1 valor esperado
    		jal x11, T22       # salva endereco do possivel erro sltu
    		nop
    		nop

T22:
    		beq x1, x2, OK22
    		nop
    		addi x11, x11, -12
    		jal x0, ERRO
    		nop

OK22:
    		# sll
    		addi x3, x0, 333  # 333
    		addi x2, x0, 1    # 1
    		nop
    		nop
    		nop
    		sll x3, x3, x2
    		jal x11, T23
    		nop

T23:
    		addi x1, x0, 0x666  # 666
    		nop
    		nop
    		nop
    		beq x3, x1, CORRETO
    		nop
    		addi x11, x11, -8
    		jal x0, ERRO
    		nop

CORRETO:
    		lui x10, 0xCCCCC
		li x12, 0xCCC
		nop
    		nop
    		nop
		add x10, x10, x12	# se tudo deu certo, coloca CCCCCCCC em x10
    		jal FIM
    		nop
