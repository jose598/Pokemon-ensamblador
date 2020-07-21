.data
tipo1:      .asciiz "normal"
tipo2:      .asciiz "fighting"
tipo3:      .asciiz "flying"
tipo4:      .asciiz "poison"
tipo5:      .asciiz "ground"
tipo6:      .asciiz "rock"
tipo7:      .asciiz "bug"
tipo8:      .asciiz "ghost"
tipo9:      .asciiz "steel"
tipo10:      .asciiz "fire"
tipo11:      .asciiz "water"
tipo12:      .asciiz "grass"
tipo13:      .asciiz "electric"
tipo14:      .asciiz "psychic"
tipo15:      .asciiz "ice"
tipo16:      .asciiz "dragon"
tipo17:      .asciiz "dark"
tipo18:      .asciiz "fairy"
poke1:  .asciiz "fire" #quemado
poke2:  .asciiz "water" #quemado
indextipo1: .space 4
indextipo2: .space 4
Pokeskin: .word tipo1,tipo2,tipo3,tipo4,tipo5,tipo6,tipo7,tipo8,tipo9,tipo10,tipo11,tipo12,tipo13,tipo14,tipo15,tipo16,tipo17,tipo18
PokeAttack: 	.float	1,1,1,1,1,0.5,1,0,0.5,1,1,1,1,1,1,1,1,1
	   	.float	2,1,0.5,0.5,1,2,0.5,0,2,1,1,1,1,0.5,2,1,2,0.5
	  	.float	1,2,1,1,1,0.5,2,1,0.5,1,1,2,0.5,1,1,1,1,1
	   	.float	1,1,1,0.5,0.5,0.5,1,0.5,0,1,1,2,1,1,1,1,1,2
		.float	1,1,0,2,1,2,0.5,1,2,2,1,0.5,2,1,1,1,1,1
		.float	1,0.5,2,1,0.5,1,2,1,0.5,2,1,1,1,1,2,1,1,1
		.float	1,0.5,0.5,0.5,1,1,1,0.5,0.5,0.5,1,2,1,2,1,1,2,0.5
		.float	0,1,1,1,1,1,1,2,1,1,1,1,1,2,1,1,0.5,1
		.float	1,1,1,1,1,2,1,1,0.5,0.5,0.5,1,0.5,1,2,1,1,2
		.float	1,1,1,1,1,0.5,2,1,2,0.5,0.5,2,1,1,2,0.5,1,1
		.float	1,1,1,1,2,2,1,1,1,2,0.5,0.5,1,1,1,0.5,1,1
		.float	1,1,0.5,0.5,2,2,0.5,1,0.5,0.5,2,0.5,1,1,1,0.5,1,1
		.float	1,1,2,1,0,1,1,1,1,1,2,0.5,0.5,1,1,0.5,1,1
		.float	1,2,1,2,1,1,1,1,0.5,1,1,1,1,0.5,1,1,0,1
		.float	1,1,2,1,2,1,1,1,0.5,0.5,0.5,2,1,1,0.5,2,1,1
		.float	1,1,1,1,1,1,1,1,0.5,1,1,1,1,1,1,2,1,0
		.float	1,0.5,1,1,1,1,1,2,1,1,1,1,1,2,1,1,0.5,0.5
		.float	1,2,1,0.5,1,1,1,1,0.5,0.5,1,1,1,1,1,2,2,1
nroColumnas: .word 18
.eqv longitudDato 4
espacio: .asciiz " "
salto: .asciiz "\n"

.text

mainG:	
#j leematriz
j leearreglo
j end
leematriz:
	addi $s1,$zero,1 #1 lee matriz
	la $s0, PokeAttack
	j principal
leearreglo:
	addi $s1,$zero,0 #1 lee matriz
	add $s2,$zero,$zero
	la $s0, Pokeskin
	j principal
principal:
	lw $s7, nroColumnas
	mul $t4,$s7,$s7
	add $t0, $zero, 0
	add $t5, $zero, 0 #contador global
bucle1:
	mul $t1, $t0, $s7 #cant de elementos
 	add $t6, $zero, 0
bucle2:
	addi $t2, $t1, 0
	add $t2, $t2, $t6
	mul $t2, $t2, longitudDato
	add $t3, $t2, $s0
	addi $t5, $t5, 1 #pare
	beqz $s1,larreglo#leematriz
	  l.s $f12 ($t3)      
	  li $v0, 2
	  syscall
	  beq $t5, $t4, end
	  j continua
	larreglo:#lee arreglo
		
	 	lw $s3, ($t3)
		add $t3, $s3, $zero

		jal compare
		beq $t5, $s7, end
		
	continua:
	addi $t6, $t6, 1
	blt $t6, $s7, bucle2
	li $v0, 4
	la $a0, salto
	syscall

	addi $t0, $t0, 1
	blt $t0, $s7, bucle1
	
compare:
	addi $sp, $sp, -20
    	sw $a0,0($sp)
    	sw $a1,4($sp)
    	sw $ra,8($sp)
    	sw $t0,16($sp)
    	sw $t1,20($sp)
	la $a0,($s3)
	
	li $v0, 0
	beqz $s2,compoke
	   la $a1,poke2#pokemon a comparar
	   j comcontinua
	compoke:
	   la $a1,poke1 #pokemon a comparar
	comcontinua:
	j loopc
i:
	lw $a0,0($sp)
    	lw $a1,4($sp)
    	lw $ra,8($sp)
    	lw $t0,16($sp)
    	lw $t1,20($sp)
        addi $sp, $sp, 20
	jr $ra
loopc:
	lb $t0($a0)
	lb $t1($a1)
	add $a0, $a0, 1
	add $a1, $a1, 1
	beqz $t0, lend
	beqz $t1, lend
	bgt $t0, $t1, mayor
	blt $t0, $t1, menor
	beq $t0, $t1, loopc
mayor:
#	li $v0, 1
	j i
menor:
#	li $v0, -1
	j i
igual:
	
	addi $t6,$t6,1 #indice de tipo
	
	beq $s2,1,guarda
	la $t8,indextipo1
	sb $t6,($t8)
	addi $s2,$zero,1 
	j principal
guarda:
	la $t8,indextipo2
	sb $t6,($t8)
	j end
lend:
	beq $t0, $t1, igual
	beqz $t0, menor
	beqz $t1, mayor

end:	
	la $a0,indextipo1
	
	
	la $a0,indextipo2
	
	li $v0, 10
	syscall	