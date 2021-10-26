.eqv N 32

.data
#Vetor:  .word 9,2,5,1,8,2,4,3,6,7,10,2,32,54,2,12,-6,3,1,78,54,23,1,54,2,65,3,6,55,31,4,-4
Vetor: .space 1

.text	
MAIN:   jal ra, INICIALIZA

	la a0,Vetor
	li a1,N
	jal ra, SHOW2

	la a0,Vetor
	li a1,N
	jal ra,SORT

	la a0,Vetor
	li a1,N
	jal ra,SHOW2

FINAL:	jal zero, FINAL

SWAP:	slli t1,a1,2
	add t1,a0,t1
	lw t0,0(t1)
	lw t2,4(t1)
	sw t2,0(t1)
	sw t0,4(t1)
	ret

SORT:	addi sp,sp,-20
	sw ra,16(sp)
	sw s3,12(sp)
	sw s2,8(sp)
	sw s1,4(sp)
	sw s0,0(sp)	# guarda 5 registradores
	
	mv s2,a0
	mv s3,a1
	mv s0,zero
for1:	bge s0,s3,exit1
	addi s1,s0,-1
for2:	blt s1,zero,exit2
	slli t1,s1,2
	add t2,s2,t1
	lw t3,0(t2)
	lw t4,4(t2)
	bge t4,t3,exit2
	mv a0,s2
	mv a1,s1
	jal ra, SWAP
	addi s1,s1,-1
	jal zero, for2
exit2:	addi s0,s0,1
	jal zero, for1
	
exit1: 	lw s0,0(sp)	# recupera os registradores e retorna
	lw s1,4(sp)
	lw s2,8(sp)
	lw s3,12(sp)
	lw ra,16(sp)
	addi sp,sp,20
	ret

SHOW:	mv t0,a0
	mv t1,a1
	mv t2,zero

loop1: 	beq t2,t1,fim1
	li a7,1
	lw a0,0(t0)
	ecall
	li a7,11
	li a0,9
	ecall
	addi t0,t0,4
	addi t2,t2,1
	j loop1

fim1:	li a7,11
	li a0,10
	ecall
	ret

#	t0 = endereco do vetor
#	t1 = tamanho do vetor
# Esse procedimento mostra todos os elementos do vetor, um por um no registrador a0
# para que possamos mostrar ele no Deeds. Ele também mostra o endereco no registrador a1.
SHOW2:	mv t0,a0
	mv t1,a1
	mv t2,zero

loop12: beq t2,t1,fim12
	lw a0,0(t0)		# mostra elemento do vetor em a0
	addi t0,t0,4
	addi t2,t2,1
	mv a1,t2		# mostra a posição do elemento em a1
	jal zero, loop12
fim12:	ret	
	


INICIALIZA:       # Inicializa a RAM de dados com o vetor a partir do endereço 0x10010000
#Vetor:  .word 9,2,5,1,8,2,4,3,6,7,10,2,32,54,2,12,-6,3,1,78,54,23,1,54,2,65,3,6,55,31,4,-4
	li t0,0x10010000
	li a0,9
	sw a0,0(t0)
	li a0,2
	sw a0,4(t0)	
	li a0,5
	sw a0,8(t0)
	li a0,1
	sw a0,12(t0)	
	li a0,8
	sw a0,16(t0)
	li a0,2
	sw a0,20(t0)	
	li a0,4
	sw a0,24(t0)
	li a0,3
	sw a0,28(t0)	
	li a0,6
	sw a0,32(t0)
	li a0,7
	sw a0,36(t0)	
	li a0,10
	sw a0,40(t0)
	li a0,2
	sw a0,44(t0)	
	li a0,32
	sw a0,48(t0)
	li a0,54
	sw a0,52(t0)	
	li a0,2
	sw a0,56(t0)
	li a0,12
	sw a0,60(t0)	
	li a0,-6
	sw a0,64(t0)
	li a0,3
	sw a0,68(t0)	
	li a0,1
	sw a0,72(t0)
	li a0,78
	sw a0,76(t0)	
	li a0,54
	sw a0,80(t0)
	li a0,23
	sw a0,84(t0)	
	li a0,1
	sw a0,88(t0)
	li a0,54
	sw a0,92(t0)	
	li a0,2
	sw a0,96(t0)
	li a0,65
	sw a0,100(t0)	
	li a0,3
	sw a0,104(t0)
	li a0,6
	sw a0,108(t0)	
	li a0,55
	sw a0,112(t0)
	li a0,31
	sw a0,116(t0)	
	li a0,4
	sw a0,120(t0)
	li a0,-4
	sw a0,124(t0)	

	jalr zero, ra, 0	# ret
