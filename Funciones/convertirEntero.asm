
.text
.globl convertirEntero

convertirEntero:
		addi $sp, $sp, -52
		sw $t0, ($sp)
		sw $t1, 4($sp)
		sw $t2, 8($sp)
		sw $s0, 12($sp)
		sw $s1, 16($sp)
		sw $a0, 20($sp)
		sw $a1, 24($sp)
		sw $ra, 28($sp)
		sw $s7, 32($sp)
		sw $t3, 36($sp)
		sw $s2, 40($sp)
		sw $s3, 44($sp)
		sw $t9, 48($sp)
		
		move $s0,$a0 # numeroString
		b tomarLongitud
	continuar:
		li $t0,0
		li $t9, 0
		#move $s1, $s7
		sub $s7,$s7,1
	loop:
		sle $t2, $t0, $s7
		bne $t2, 1, validacionTerminada
		add $t2, $s0, $t0
		lb $s3, ($t2)		
		addi $s3, $s3, -48  #a0
		sub $s2, $s7, $t0 #a1
		
		move $a0,$s3
		move $a1,$s2   
		#esrooo
		jal multiplicacion
		add $t9, $t9, $v0
		addi $t0, $t0, 1
		j loop
	
	tomarLongitud:
		li $t0,0
	while:
		add $t1, $s0, $t0
		lb $t2, ($t1)
		la $t3,10
		bne $t2,$t3,sumar1
		move $s7, $t0
		b continuar
	sumar1:	
		addi $t0, $t0, 1
		j while
		
			
	validacionTerminada:
		move $v0, $t9		
		lw $t0, ($sp)
		lw $t1, 4($sp)
		lw $t2, 8($sp)
		lw $s0, 12($sp)
		lw $s1, 16($sp)
		lw $a0, 20($sp)
		lw $a1, 24($sp)
		lw $ra, 28($sp)
		lw $s7, 32($sp)
		lw $t3, 36($sp)
		lw $s2, 40($sp)
		lw $s3, 44($sp)
		lw $t9, 48($sp)
		addi $sp, $sp, 52
		jr $ra
		
		
		
		
		
	multiplicacion:
		addi $sp,$sp,-28
		sw $ra,($sp)
		sw $t7,4($sp)
		sw $t6,8($sp)
		sw $t5,12($sp)
		sw $t4,16($sp)	
		sw $s4,20($sp)
		sw $s5,24($sp)
		
		move $s4,$a1 # esotooo...
		move $s5,$a0
		li $t7,10
		li $t6,0
		li $t5,1
		
	looping:
		slt $t4, $t6, $s4
		bne $t4,1, finalizar
		mul $t5, $t5, $t7
		addi $t6, $t6, 1
		j looping
	
	finalizar:
		mul $t5, $s5, $t5
		move $v0, $t5
		
		lw $ra,($sp)
		lw $t7,4($sp)
		lw $t6,8($sp)
		lw $t5,12($sp)
		lw $t4,16($sp)
		lw $s4,20($sp)
		lw $s5,24($sp)
		addi $sp,$sp, 28
		jr $ra

		
		