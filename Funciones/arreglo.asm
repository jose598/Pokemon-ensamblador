.data
tipo1:      .asciiz "fire"
tipo2:      .asciiz "water"
matrizA: .word tipo1,tipo2
	#matrizA: .word 2,3,3,2
	nroColumnas: .word 2
	.eqv longitudDato 16
	
espacio: .asciiz " "
salto: .asciiz "\n"
.text


principal:
	la $s0, matrizA
	lw $s7, nroColumnas
	add $t0, $zero, 0
bucle1:
	mul $t1, $t0, $s7
	add $t6, $zero, 0
bucle2:
	addi $t2, $t1, 0
	add $t2, $t2, $t6
	mul $t2, $t2, longitudDato
	add $t3, $t2, $s0
	lw $s3, ($t3)
	add $t3, $s3, $zero
	move $a0, $t3
	li $v0, 4
	syscall

	li $v0, 4
	la $a0, espacio
	syscall
	
	addi $t6, $t6, 1
	blt $t6, $s7, bucle2
	
	li $v0, 4
	la $a0, salto
	syscall

	addi $t0, $t0, 1
#	blt $t0, $s7, bucle1
