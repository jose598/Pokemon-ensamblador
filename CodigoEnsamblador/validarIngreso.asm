.text
.globl validarIngreso

#Funcionalidad: Comprobar que el texto ingresado por el usuario, sea un entero o un string
#Retorno: 0 --- Caso de string 1 --- caso de Numero
validarIngreso:

		addi $sp, $sp, -20
		sw $t0, 0($sp)
		sw $t1, 4($sp)
		sw $t2, 8($sp)
		sw $t3, 12($sp)
		sw $ra, 16($sp)

		la $t0, ($a0)
		li $t2, 0
		li $t3, 1

	validar:

		add $t1, $t2, $t0
		lb $t1, 0($t1)
		beq $t1, 13 , compare 	
		beq $t1, 10 , compare 	
		
		beq $t1, 10 , f 				

		move $a0, $t1
		jal compararNumero
		and $t3, $t3, $v0
		addi $t2, $t2, 1
		j validar

 	compare:
		bne $t2, 0, f
		andi $t3, $t3, 0

	f:
		move $v0, $t3 

		lw $t0, 0($sp)
		lw $t1, 4($sp)
		lw $t2, 8($sp)
		lw $t3, 12($sp)
		lw $ra, 16($sp)
		addi $sp, $sp, 20
		jr $ra
			
	#Funcionalidad: Compara con el codigo de ASCII el caracter correspondiente.
	#Retorno: 0 -- no es un numero 1 -- es un numero
	compararNumero:
		addi $sp, $sp, -8
		sw $ra, 0($sp)
		sw $s0, 4($sp)
			
		li  $s0, '0'
			bltu   $a0 ,$s0, str

			li $s0, '9'
			bltu   $s0 ,$a0, str

			li $v0, 1
			b terminando

		str:
			li $v0, 0
		terminando:
			lw $ra, 0($sp)
			lw $s0, 4($sp)
			addi $sp, $sp, 8
			jr $ra
