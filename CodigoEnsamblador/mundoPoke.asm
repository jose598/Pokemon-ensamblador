.data
tip1:      .asciiz "normal"
tip2:      .asciiz "fighting"
tip3:      .asciiz "flying"
tip4:      .asciiz "poison"
tip5:      .asciiz "ground"
tip6:      .asciiz "rock"
tip7:      .asciiz "bug"
tip8:      .asciiz "ghost"
tip9:      .asciiz "steel"
tip10:      .asciiz "fire"
tip11:      .asciiz "water"
tip12:      .asciiz "grass"
tip13:      .asciiz "electric"
tip14:      .asciiz "psychic"
tip15:      .asciiz "ice"
tip16:      .asciiz "dragon"
tip17:      .asciiz "dark"
tip18:      .asciiz "fairy"

Pokeskin: .word tip1,tip2,tip3,tip4,tip5,tip6,tip7,tip8,tip9,tip10,tip11,tip12,tip13,tip14,tip15,tip16,tip17,tip18
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
Ataque1: .float 0
Ataque2: .float 0
indextipo1: .space 4
indextipo2: .space 4
Zero: .float 0.0
base: .float 2
vidap1: .word 5
vidap2: .word 5
alertincomp: .asciiz "\n¡Los pokemons no son compatibles para luchar!\n"
msjganador:    .asciiz "es el ganador!\n"
msjresultado: .asciiz "\n resultado del ataque"
msjvida: .asciiz "Vida:"
msjAtaque: .asciiz "Ataque:"
msjatacaa: .asciiz "ataca a:"
msjcombate: .asciiz "Combatientes:"
msjresult: .asciiz "\nResultado de Ataque:"
msjvs: .asciiz "vs"
spaceline: .asciiz " "
newLine: .asciiz "\n"

.text
.globl MundoPoke

MundoPoke:
	
	jal leearreglo
	jal leematriz
	jal cardato_batalla
	jal calbase
	jal pokeIncompatible #si el ataque de ambos es 0
	jal inibatalla
	jal batalla
	j end
	
leearreglo:
	addi $sp, $sp, -4
    	sw $ra,0($sp)
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
	addi $sp, $sp, -4
    	sw $ra,0($sp)
	add $t0, $zero, 0
	add $t5, $zero, 0

bucle1:
	mul $t1, $t0, $s7
 	add $t6, $zero, 0
bucle2:
	addi $t2, $t1, 0
	add $t2, $t2, $t6
	mul $t2, $t2, longitudDato
	add $t3, $t2, $s0
	beqz $s1,larreglo
	l.s $f3, ($t3)   
	la $t9,indextipo2
	la $s4,indextipo1
	beq $s2,0,fataque
		la $t9,indextipo1
	  	la $s4,indextipo2
	  	j fataque
larreglo:
		
	 	lw $s3, ($t3)
		add $t3, $s3, $zero
		jal compare
		
	continua:
	beq $s2,2,re
	addi $t6, $t6, 1
	blt $t6, $s7, bucle2
	addi $t0, $t0, 1
	blt $t0, $s7, bucle1


compare:
	addi $sp, $sp, -24
    	sw $s6,0($sp)
    	sw $a1,4($sp)
    	sw $ra,8($sp)
    	sw $t0,16($sp)
    	sw $t1,20($sp)
	la $s6,($s3)
	li $v0, 0
	beqz $s2,compoke
	   move $t7,$a2
	   j comcontinua
	compoke:
	 move   $t7,$a0
	comcontinua:
	jal loopc

	lw $s6,0($sp)
    	lw $t7,4($sp)
    	lw $ra,8($sp)
    	lw $t0,16($sp)
    	lw $t1,20($sp)
        addi $sp, $sp, 24
	jr $ra
loopc:
	lb $t0($s6)
	lb $t1($t7)
	add $s6, $s6, 1
	add $t7, $t7, 1
	beqz $t0, lend
	beqz $t1, lend
	bgt $t0, $t1, noigual
	blt $t0, $t1, noigual
	beq $t0, $t1, loopc
noigual:
	
	jr $ra
igual:
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
Guardaindex:
	la $a0,indextipo1
	lb $a0,($a0)
	la $a0,indextipo2
	lb $a0,($a0)
	addi $s2,$s2,1 
	jr $ra

re: 
	lw $ra,0($sp)
        addi $sp, $sp, 4
	jr $ra

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
Guardaataque:	
	la $a0,Ataque1
	la $a0,Ataque2
	 jr $ra
	
cardato_batalla:
	l.s $f0, Ataque1
	l.s $f1, Ataque2
	l.s $f2,base
	la $s4,vidap1
	la $s5,vidap2
	lb $s4,($s4)
	lb $s5,($s5)
	add $t2,$zero,$zero 
	jr $ra

calbase: 
	mul.s $f0,$f2,$f0
	mul.s $f1,$f2,$f1 
	cvt.w.s $f0, $f0
	cvt.w.s $f1, $f1
	mfc1 $s2, $f0 
	mfc1 $s3, $f1 
	jr $ra
	
pokeIncompatible:
	addi $sp, $sp, -4
    	sw $ra,0($sp)
	beqz  $s2,imp1
	beqz  $s3,imp2
	lw $ra,0($sp)
        addi $sp, $sp, 4
	jr $ra
imp1: 	
	 beqz  $s3,escimcop
	 jr $ra
imp2:	
	beqz  $s2,escimcop
	jr $ra
escimcop:	
	li $v0,4
	la $a0,alertincomp
	syscall
	j end

batalla: 
	beqz $s4,endact
	beqz $s5,endef
	add $t4,$s2,$zero #atacante
	add $t6,$s3,$zero #defensa
	move $t5,$s4 #atacante
	move $t3,$s5 #defensa
	move $t7,$a1 #atacante nom
	move $t8,$a3 #defensor nom
	add $t2,$zero,$zero
	jal atacar
	move $s5,$t3
	
	li $v0,4
	la $a0,newLine
	syscall
	
	beqz $s5,endef	
	add $t4,$s3,$zero #atacante
	add $t6,$s2,$zero #defensa
	move $t5,$s5 #atacante
	move $t3,$s4 #defensa
	move $t7,$a3 #defensa nom
	move $t8,$a1 #atacante nom
	li $t2,1
	jal atacar
	move $s4,$t3
	
	li $v0,4
	la $a0,newLine
	syscall
	jal batalla
	
endef:	
	bnez $s5,regreso
	move $t1,$s5
	move $t0,$a1
	jal ganador
endact:
	bnez  $s4,regreso
        move $t1,$s4
        move $t0,$a3
        jal ganador
regreso:
	jr $ra

atacar:
	addi $sp, $sp, -8
    	sw $t0,0($sp)
    	sw $t1,4($sp)
    	sw $ra,8($sp)
	jal preataque
	sub $t3,$t3,$t4 
	addi $t1,$zero,1
	slt $t0,$t3,$t1
	beq $t0,0,exit #vida <1
	   li $t3,0
	   beq $t2,0,resultado #formato
	   jal resultado2
	   lw $t0,0($sp)
	   lw $t1,4($sp)
	   lw $ra,8($sp)
	   addi $sp, $sp, 18
	   jr $ra
	exit:
	beq $t2,0,resultado #formato
	jal resultado2
	regreso2:
	lw $t0,0($sp)
	lw $t1,4($sp)
	lw $ra,8($sp)
	addi $sp, $sp, 8
	jr $ra
preataque:
	addi $sp, $sp, -16
    	sw $t0,0($sp)
    	sw $t1,4($sp)
    	sw $ra,8($sp)
    	sw $t2,16($sp)
	la $t0,($t7)
	add $t1,$t5,$zero
	add $t2,$t4,$zero
	jal formCom
	jal atacaa
	la $t0,($t8)
	add $t1,$t3,$zero
	add $t2,$t6,$zero
	jal formCom
	lw $t0,0($sp)
	lw $t1,4($sp)
	lw $ra,8($sp)
	lw $t2,16($sp)
	addi $sp, $sp, 16
	jr $ra
resultado:
	addi $sp, $sp, -16
    	sw $t0,0($sp)
    	sw $t1,4($sp)
    	sw $ra,8($sp)
    	sw $t2,16($sp)
	li $v0,4
	la $a0,msjresult
	syscall
	
	li $v0,4
	la $a0,newLine
	syscall
	
	la $t0,($t7)
	add $t1,$t5,$zero
	add $t2,$t4,$zero
	jal formCom
	
	li $v0,4
	la $a0,newLine
	syscall
	
	la $t0,($t8)
	add $t1,$t3,$zero
	add $t2,$t6,$zero
	jal formCom
	
	li $v0,4
	la $a0,newLine
	syscall
	
	lw $t0,0($sp)
	lw $t1,4($sp)
	lw $ra,8($sp)
	lw $t2,16($sp)
	addi $sp, $sp, 16
	jal regreso2
resultado2:
	addi $sp, $sp, -16
    	sw $t0,0($sp)
    	sw $t1,4($sp)
    	sw $ra,8($sp)
    	sw $t2,16($sp)
    	
	li $v0,4
	la $a0,msjresult
	syscall
	
	li $v0,4
	la $a0,newLine
	syscall
	 
	la $t0,($t8)
	add $t1,$t3,$zero
	add $t2,$t6,$zero
	jal formCom
	
	li $v0,4
	la $a0,newLine
	syscall
	
	la $t0,($t7)
	add $t1,$t5,$zero
	add $t2,$t4,$zero
	jal formCom
	
	li $v0,4
	la $a0,newLine
	syscall
	lw $t0,0($sp)
	lw $t1,4($sp)
	lw $ra,8($sp)
	lw $t2,16($sp)
	addi $sp, $sp, 16
	jal regreso2
inibatalla:
	li $v0,4
	la $a0,newLine
	syscall
	
	li $v0,4
	la $a0,msjcombate
	syscall
	
	li $v0,4
	la $a0,spaceline
	syscall
	
	li $v0,4
	move $a0,$a1
	syscall
	
	li $v0,4
	la $a0,spaceline
	syscall
	
	li $v0,4
	la $a0,msjvs
	syscall
	
	li $v0,4
	la $a0,spaceline
	syscall
	
	li $v0,4
	move $a0,$a3
	syscall
	
	li $v0,4
	la $a0,newLine
	syscall
	jr $ra
formCom:
	addi $sp, $sp, -16
    	sw $ra,0($sp)
    	sw $t0,4($sp)
    	sw $t1,8($sp)
    	sw $t2,16($sp)
	
	li $v0,4
	move $a0,$t0
	syscall
	
	li $v0,4
	la $a0,spaceline
	syscall
	
	li $v0,4
	la $a0,msjvida
	syscall

	li $v0,1
	move $a0,$t1
	syscall
	
	li $v0,4
	la $a0,spaceline
	syscall
	
        li $v0,4
	la $a0,msjAtaque
	syscall
	
	li $v0,1
	move $a0,$t2
	syscall
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,16($sp)
	addi $sp, $sp, 16
	jr $ra
atacaa:
	
	li $v0,4
	la $a0,spaceline
	syscall
	
	li $v0,4
	la $a0,msjatacaa
	syscall
	
	li $v0,4
	la $a0,spaceline
	syscall
	jr $ra

ganador:
	li $v0, 4        
    	la $a0, newLine
    	syscall
    	
	bnez $t1,end
	li $v0,4
	la $a0,($t0)
	syscall
	
	li $v0, 4        
    	la $a0, spaceline       
    	syscall
    	
	li $v0,4
	la $a0,msjganador
	syscall
	jal end
end:	
	li $v0, 10
	syscall	