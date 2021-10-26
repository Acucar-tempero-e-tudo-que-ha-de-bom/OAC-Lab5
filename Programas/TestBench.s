		# Teste microRISCV Processor

		jal x11, OK0				# testa o jal
		addi x11, x11, -4		      	# endereco do possivel erro no jal

ERRO:
   		lui x10, 0xEEEEE
    		li x12, 0xEEE
    		add x10, x10, x12			# se algo deu errado, coloca 0xEEEEEEEE em x10 e o endereco do erro em x11

FIM:		jal x0, FIM				# loop infinito

OK0:
		# andi
		addi x3, x0, 0xF			# 1111
		andi x4, x3, 5		      		# 0101
		addi x5, x0, 5		      		# resultado esperado
		jal x11, T1				# salva endereco do possivel erro no andi
T1:	
   		beq x4, x5, OK1		      		# verifica se deu certo
		addi x11, x11, -12	      		# endereco que deu erro
		jal x0, ERRO

OK1:
    		# ori
    		addi x3, x0, 0xA	      		# 1010
		ori x4, x3, 0x5		      		# 0101
		addi x5, x0, 0xF		    	# resultado esperado
		jal x11, T2		          	# salva endereco do possivel erro no andi
    
T2:
    		beq x4, x5, OK2		      		# verifica se deu certo
		addi x11, x11, -12	     	 	# endereco que deu erro
		jal x0, ERRO

OK2:
    		# xori
		addi x3, x0, 10 	      		# 1010
		xori x4, x3, 5		      		# 0101
		addi x5, x0, 15		      		# 1111
		jal x11, T3		          	# salva endereco do possivel erro no xori

T3:
    		beq x4, x5, OK3		      		# verifica se deu certo
		addi x11, x11, -12	      		# endereco que deu erro
		jal x0, ERRO

OK3:
    		# slti
    		addi x31, x0, -1        		# x31 = -1
    		slti x30, x31, 0
    		addi x29, x0, 1
    		jal x11, T4             		# salva endereco do possivel erro slti

T4:
    		beq x29, x30, OK4
    		addi x11, x11, -12
    		jal x0, ERRO
    
OK4:
    		# sltiu
    		addi x3, x0, -1	        		# 0xffff
		sltiu x4, x3, 1		      		# 0x1
		jal x11, T5		          	# salva endereco do possivel erro no andi
    
T5:
   	 	beq x4, x0, OK5		      		# verifica se deu certo
		addi x11, x11, -8	      		# endereco que deu erro
		jal x0, ERRO
    

OK5:
    		# slli
		addi x3, x0, 1	        		# 1
		slli x4, x3, 2		      		# 2
		addi x5, x0, 4		      		# 4
		jal x11, T6		          	# salva endereco do possivel erro no slli

T6:
    		beq x4, x5, OK6		      		# verifica se deu certo
		addi x11, x11, -12	      		# endereco que deu erro
		jal x0, ERRO
OK6:
    		# lui
    		addi x28, x0, 0x100     		# 0x100
    		slli x28, x28, 4        		# 0x1000
    		addi x28, x28, 1        		# 0x1001
    		slli x28, x28, 16	      		# resultado esperado
		lui x27, 0x10010  	    		# 0x10010000
		jal x11, T7		          	# salva endereco do possivel erro no lui

T7:
    		beq x27, x28, OK7		   	# verifica se deu certo
		addi x11, x11, -8 	      		# endereco que deu erro
		jal x0, ERRO

OK7:
    		# auipc
    		auipc x10, 0				# x10 = PC (com auipc)
    		addi x9, x11, 12			# x9 = PC
    		jal x11, T8

T8:
    		beq x9, x10, OK8			# verifica se deu certo
    		addi x11, x11, -12			# valor do endereco do possivel erro no auipc 
    		jal x0, ERRO

OK8:
    		# jalr
    		lui x24, 0x00400
    		addi x24, x24, 0x104			# x24 = 0x00400104 (PC atual)
    		jalr x11, x24, 0x8			# pula pra duas instrucoes depois

OK9:
    		# lw e sw
    		addi x3, x0, 0
    		lui x3, 0x10010   	# x3 = 0x10010000
    		addi x4, x0, 10   	# x4 = 10	
		sw x4, 0(x3)      	# salva x4 na memoria
    		lw x5, 0(x3)      	# carrega valor da memoria em x5
    		jal x11, T10

T10:
    		beq x4, x5, OK10  	# verifica se deu certo
    		jal x0, ERRO      	# o x1 ja ta com o endereco certo

OK10:
    		# bne
		addi x3, x0, 777		# 777
		addi x4, x3, 666		# 666
		jal x11, T11		# salva endereco do possivel erro no bne

T11:
    		bne x3, x4, OK11
    		jal x0, ERRO    

OK11:
    		# blt
		addi x3, x0, -1	    	# -1
		addi x4, x3, 1		# 1
		jal x11, T12		# salva endereco do possivel erro no blt

T12:
    		blt x3, x4, OK12
    		jal x0, ERRO

OK12:
    		# bge
    		addi x26, x0, 2  		# 2
		addi x25, x0, 0		# -1
		jal x11, T13	    	# salva endereco do possivel erro no bge

T13:
    		bge x26, x25, OK13
    		jal x0, ERRO

OK13:
    		# bltu
		addi x24, x0, 1	    	# 1
		addi x23, x0, -1		# -1
		jal x11, T14		# salva endereco do possivel erro no bltu

T14:
    		bltu x24, x23, OK14
    		jal x0, ERRO

OK14:
    		# bgeu
    		addi x26, x0, 2  		# 0
		addi x25, x0, 0		# -1
		jal x11, T15     		# salva endereco do possivel erro no bgeu
T15:
    		bgeu x26, x25, OK15
    		jal x0, ERRO
OK15:
    		# add
		addi x24, x0, 69    	# 69
		addi x23, x0, 1     	# 1
    		add x21, x23, x24
		addi x22, x0, 70    	# 70 resultado esperado
		jal x11, T16		# salva endereco do possivel erro no slli

T16:
    		beq x21, x22, OK16
    		addi x11, x11, -12
    		jal x0, ERRO

OK16:
    		# sub
    		addi x20, x0, -1
    		sub x19, x20, x20
    		jal x11, T17

T17:
    		beq x19, x0, OK17
    		addi x11, x11, -8
    		jal x0, ERRO

OK17:
    		# and
    		addi x19, x0, 13  # 1101
    		addi x18, x0, 6   # 0110
    		addi x16, x0, 4   # 0100
    		and x17, x18, x19
    		jal x11, T18

T18:
    		beq x17, x16, OK18
    		addi x11, x11, -8
    		jal x0, ERRO

OK18:
    		# or
    		addi x15, x0, 10  # 1010
    		addi x14, x0, 4   # 0100
    		or x13, x15, x14
    		addi x12, x0, 14  # 1110 resultado esperado
    		jal x11, T19
    
T19:
    		beq x13, x12, OK19
    		addi x11, x11, -12
    		jal x0, ERRO

OK19:
    		# xor
    		addi x12, x0, 17  # 10001 vitu eh muito legal :)
    		addi x10, x0, 14  # 01110
    		addi x9, x0, 31   # 11111
    		xor x8, x12, x10
    		jal x11, T20

T20:    		
    		beq x8, x9, OK20
    		addi x11, x11, -8
    		jal x0, ERRO

OK20:
    		# slt
    		addi x6, x0, -1   # -1
    		slt x5, x6, x0    
    		addi x4, x0, 1    # 1 valor esperado
    		jal x11, T21       # salva endereco do possivel erro slti
    
T21:
    		beq x4, x5, OK21
    		addi x11, x11, -12
    		jal x0, ERRO

OK21:
    		# sltu
    		addi x3, x0, -1   # -1
    		sltu x2, x0, x3    
    		addi x1, x0, 1    # 1 valor esperado
    		jal x11, T22       # salva endereco do possivel erro sltu

T22:
    		beq x1, x2, OK22
    		addi x11, x11, -12
    		jal x0, ERRO

OK22:
    		# sll
    		addi x3, x0, 333  # 333
    		addi x2, x0, 1    # 1
    		sll x3, x3, x2
    		jal x11, T23

T23:
    		addi x1, x0, 666  # 666
    		beq x3, x1, CORRETO
    		addi x11, x11, -8
    		jal x0, ERRO

CORRETO:
    		lui x10, 0xCCCCC
		li x12, 0xCCC
		add x10, x10, x12	# se tudo deu certo, coloca CCCCCCCC em x10
    		jal FIM
