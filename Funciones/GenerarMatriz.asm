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
poke1:  .asciiz "normal" #quemado
poke2:  .asciiz "ghost" #quemado
Ataque1: .float 0
Ataque2: .float 0
indextipo1: .space 4
indextipo2: .space 4
Zero: .float 0.0
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

<<<<<<< HEAD:Funciones/GenerarMatriz.asm
mainG:	
#j leematriz
j leearreglo
j end
leematriz:
	addi $s1,$zero,1 #1 lee matriz
	la $s0, PokeAttack
	j principal
=======
>>>>>>> 6d43970cb1915984d3cf12b6b91fc64d46a7b627:Funciones/GenerarMatriz
leearreglo:
	addi $s1,$zero,0 #1 lee matriz
	add $s2,$zero,$zero
	la $s0, Pokeskin
	j principal
leematriz:
	addi $s1,$zero,1 #1 lee matriz
	la $s0, PokeAttack
	add $s2,$zero,$zero
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
	   l.s $f3, ($t3)   
          # l.s $f1,Zero
	  # add.s $f12,$f3,$f1
	   #li $v0, 2
	   #syscall   
	
	  beq $t5, $t4, end
	  la $t9,indextipo2
	  la $s4,indextipo1
	  beq $s2,0,fataque
	        la $t9,indextipo1
	  	la $s4,indextipo2
	  	j fataque
	
	larreglo:#lee arreglo
		
	 	lw $s3, ($t3)
		add $t3, $s3, $zero
		jal compare
		beq $t5, $s7, end
		
	continua:
	addi $t6, $t6, 1
	blt $t6, $s7, bucle2
	la $a0,salto
	li $v0, 4
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
	bgt $t0, $t1, noigual
	blt $t0, $t1, noigual
	beq $t0, $t1, loopc
noigual:
	j i

igual:
	#addi $t6,$t6,1 #indice de tipo
	beq $s2,1,guarda
	la $t8,indextipo1
	sb $t6,($t8)
	addi $s2,$zero,1 
	j principal
guarda:
	la $t8,indextipo2
	sb $t6,($t8)
	j Guardaindex
lend:
	beq $t0, $t1, igual
	beqz $t0, noigual
	beqz $t1, noigual
fataque:
	  lb $t9,($t9)
	  bne $t6,$t9,continua
	 	lb $s4,($s4)
	 	bne $t0,$s4,continua
		   beq $s2,1,salto1
		       la $s5, Ataque1
			swc1 $f3, ($s5) 
		        addi $s2,$zero,1
		       
		       j principal
		    salto1:
		       la $t9, Ataque2
			swc1 $f3, ($t9)
			
		       j Guardaataque   		  
Guardaindex:
	la $a0,indextipo1
<<<<<<< HEAD:Funciones/GenerarMatriz.asm
	
	
	la $a0,indextipo2
=======
	lb $a0,($a0)
	
	la $a0,indextipo2
	lb $a0,($a0)

	j leematriz
Guardaataque:	
	la $a0,Ataque1
	l.s $f12,($a0)
	li $v0, 2
	syscall
	
	la $a0,Ataque2
	l.s $f12,($a0)
	li $v0, 2
	syscall
	j end
end:	
>>>>>>> 6d43970cb1915984d3cf12b6b91fc64d46a7b627:Funciones/GenerarMatriz
	
	li $v0, 10
	syscall	
