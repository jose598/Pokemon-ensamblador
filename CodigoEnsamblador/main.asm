
.data 
text1: .asciiz "Bienvenido al sistema de combates Pok�mon "
poke1:  .asciiz "\nIngrese el numero del primer Pokemon para el combate: "
poke2:  .asciiz "\nIngrese el numero del segundo Pokemon para el combate: "
newLine: .asciiz "\n"
file:   .asciiz "C:\\Users\\Francisco\\Desktop\\Ensamblador\\pokeTypes.txt"      # ruta Absoluta..
#file:   .asciiz "C:\\Users\\TASHZ\\Desktop\\Pokemon-ensamblador\\pokeTypes.txt" 
buffer: .space 1024
	.eqv len 10
texto: .space len

	.text
.globl main

main:
	li $v0, 4
	la $a0, text1
	syscall
	li $v0, 4
	la $a0, newLine
	syscall 
	
	jal mainSecundario  
	la $s1,($v1) #matrizTipos
	la $s0,($v0) #matrizPokemon\
	
	move $a0,$s0
        jal imprimirResultado 
        
        la $a2, poke1
        jal opcionesEntradas 
        bne $v0,1,end
        
        move $s7,$v1  #indice primer Pokemon
        move $a0,$s7
        move $a1,$s1   # matrizTipo
	jal tomarTiposoPokemon
	move $s5, $v0 #Tipo 1
	
	move $s7,$v1  #indice primero Pokemon
        move $a0,$s7
        move $a1,$s0   # matrizPokemon
	jal tomarTiposoPokemon
	move $s6, $v0 #pokemon 1
		 
        la $a2,poke2
        jal opcionesEntradas
        bne $v0,1,end
        
        move $s7,$v1  #indice segundo Pokemon
        move $a0,$s7
        move $a1,$s1   # matrizTipo
	jal tomarTiposoPokemon
	move $s4, $v0 #tipo 2
	
	move $s7,$v1  #indice segundo Pokemon
        move $a0,$s7
        move $a1,$s0   # matrizPokemon
	jal tomarTiposoPokemon
	move $s3, $v0 #pokemon 2
	
	
	
	#move $a0,$s5
	#move $a1,$s6
	#move $a2,$s4
	#move $a3, $s3
	jal MundoPoke
	j end
	
	
opcionesEntradas:
	addi $sp,$sp,-12
	sw $ra, ($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	entrada:
	
		la $s0,($a2)
        	li $v0, 4
        	move $a0, $s0
        	syscall
        	
		li $v0,8
		la $a0, texto
		li $a1, len
		syscall
		
		la $a0, texto
        	jal validarIngreso
        	beq $v0,0,salirI
        	la $a0, texto
        	jal convertirEntero
        	move $t0,$v0
  		move $a0, $t0
        	jal valOpcion
        	move $s0,$v0
        	bne $s0,0,salir
        	b entrada
        salirI:
        	b  entrada
        	
        salir:
        	move $v0,$s0	#bandera
        	move $v1,$t0   #indice
        	lw $ra, ($sp)
		lw $s0,4($sp)
		lw $t0,8($sp)
		addi $sp,$sp,12
       	 	jr $ra
       	 	
       	 	
tomarTiposoPokemon:
	addi $sp,$sp,-12
	sw $ra, ($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	move $s0, $a1 # tipos
	sub $t0,$a0,1 #eleccion
	mul $t0,$t0,4
	add $t1, $s0, $t0
	lw $a0, 0($t1)
	move $v0,$a0
	lw $ra, ($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	addi $sp,$sp,12
       	 jr $ra
	

 end:
 	
 	li $v0,10
 	syscall 