.data
formato: .asciiz ". "
mSalir: .asciiz "Salir"
newline: .asciiz "\n"

.text
.globl imprimirResultado

#Funcionalidad: Imprimir cada uno de los pokemones en el main prinicipal, 10 pokemones
#Retorno: No hay retorno, solo imprime.
imprimirResultado:
		
		addi $sp,$sp,-20
		sw $ra,($sp)
		sw $s0,4($sp)
		sw $t0,8($sp)
		sw $t1,12($sp)
		sw $s1,16($sp)	
		
		li $t0, 1
		li $s0,0
		move $s1,$a0
		opciones10:
			slti $t1, $t0, 11
			beq $t1, $zero, opcion11
			la $a0, ($t0)
			li $v0, 1
			syscall
			la $a0, formato
			li $v0, 4
			syscall
			add $t1, $s1, $s0
			li $v0, 4
			lw $a0, 0($t1)
			syscall
			la $a0, newline
			li $v0, 4
			syscall
			addi $s0, $s0, 4
			addi $t0, $t0, 1
			j opciones10
	
		opcion11:
			la $a0, ($t0)
			li $v0, 1
			syscall
		
			la $a0, formato
			li $v0, 4
			syscall
		
			la $a0, mSalir
			li $v0, 4
			syscall
			
			la $a0, newline
			li $v0, 4
			syscall
			
		ending:
		lw $ra,($sp)
		lw $s0,4($sp)
		lw $t0,8($sp)
		lw $t1,12($sp)
		lw $s1,16($sp)
		addi $sp,$sp,20
		jr $ra
