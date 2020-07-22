#Funcion valOpcion
.data
        .globl valOpcion
		.text

# La etiqueta main representa el punto de partida		
 valOpcion:
 	addi $sp,$sp,-20
 	sw $ra,0($sp)
 	sw $s0,4($sp)
 	sw $t0,8($sp)
 	sw $t1,12($sp)
 	sw $t2,16($sp)
 	#la $t0,($a0)
  	add $s0,$zero,$a0  #valor a validar
	addi $t0,$zero,0 
	addi $t1,$zero,1
	addi $t2,$zero,12 
	
	beq $s0,11,salir
	bge $s0,$t2,noValido
	bge $s0,$t1,Valido 
	ble $s0,$t0,noValido
	
	noValido:
		li $t0,0
		la $v0,($t0)
		b exit
	Valido:
		li $t1,1
		la $v0,($t1)
		b exit
	salir:
		li $t1,2
		la $v0,($t1)
	exit: 	
 		lw $ra,0($sp)
 		lw $s0,4($sp)
 		lw $t0,8($sp)
 		lw $t1,12($sp)
 		lw $t1,16($sp)
		addi $sp,$sp,20
		jr $ra
