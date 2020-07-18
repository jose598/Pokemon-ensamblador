.data
alertincomp: .asciiz "\n¡Los pokemons no son compatibles para luchar!\n"
msjganador:    .asciiz "es el ganador!\n"
msjresultado: .asciiz "\n resultado del ataque"
msjvida: .asciiz "Vida:"
msjAtaque: .asciiz "Ataque:"
msjatacaa: .asciiz "ataca a:"
msjcombate: .asciiz "Combatientes:"
msjresult: .asciiz "\nResultado de Ataque:"
msjvs: .asciiz "vs"
poke1:  .asciiz "Seviper"
poke2:  .asciiz "Metagross"
tipo1:  .word 4 #poison	
tipo2:  .word 9 #steel	
index1: .word 1#Seviper
index2: .word 2#Metagross
base: .word 2
ataquep1: .word 1#Seviper
ataquep2: .word 2#Metagross
spaceline: .asciiz " "
newLine: .asciiz "\n"
vidap1: .word 5
vidap2: .word 5

.text
    
.globl main

main:
#
	la $s1,base 
	la $s2,ataquep1
	la $s3,ataquep2
	la $s4,vidap1
	la $s5,vidap2
	lb $s1,($s1)
	lb $s2,($s2)
	lb $s3,($s3)
	lb $s4,($s4)
	lb $s5,($s5)
	add $t2,$zero,$zero #formato
	jal calbase
	jal pokeIncompatible #si el ataque de ambos es 0
	#batalla
	jal inibatalla
	jal batalla
	jal end

calbase: 
	mul $s2,$s1,$s2
	mul $s3,$s1,$s3
	 	
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
	jal end
batalla: 
	beqz $s4,endact
	beqz $s5,endef
	
	
	add $t4,$s2,$zero #atacante
	add $t6,$s3,$zero #defensa
	move $t5,$s4 #atacante
	move $t3,$s5 #defensa
	la $t7,poke1 #atacante nom
	la $t8,poke2 #defensor nom
	add $t2,$zero,$zero
	jal atacar
	move $s5,$t3
	#salto
	li $v0,4
	la $a0,newLine
	syscall
	
	beqz $s5,endef	
	add $t4,$s3,$zero #atacante
	add $t6,$s2,$zero #defensa
	move $t5,$s5 #atacante
	move $t3,$s4 #defensa
	la $t7,poke2 #defensa nom
	la $t8,poke1 #atacante nom
	li $t2,1
	jal atacar
	move $s4,$t3
	#salto
	li $v0,4
	la $a0,newLine
	syscall
	jal batalla
	
endef:	
	bnez $s5,regreso
	move $t1,$s5
	la $t0,poke1
	jal ganador
endact:
	bnez  $s4,regreso
        move $t1,$s4
        la $t0,poke2
        jal ganador
regreso:
	jr $ra

atacar:
	addi $sp, $sp, -8
    	sw $t0,0($sp)
    	sw $t1,4($sp)
    	sw $ra,8($sp)
    	#sw $t2,16($sp)
#t7 nombre atacante
#t5 vidadefesa 
#t4 ataqueAtacante
#t3 vidadefesa 
#t6 ataquedefensa
#t8 nombre defensa
	jal preataque
	sub $t3,$t3,$t4  #vidaD=vidaD-ataqueA

	addi $t1,$zero,1
	slt $t0,$t3,$t1
	beq $t0,0,exit #vida <1
	   li $t3,0
	   beq $t2,0,resultado #formato
	   jal resultado2
	  #jal resultado
	   lw $t0,0($sp)
	   lw $t1,4($sp)
	   lw $ra,8($sp)
	 #  lw $t2,16($sp)
	   addi $sp, $sp, 18
	   jr $ra
	exit:
	beq $t2,0,resultado #formato
	jal resultado2
	#jal resultado
	regreso2:
	lw $t0,0($sp)
	lw $t1,4($sp)
	lw $ra,8($sp)
	#lw $t2,16($sp)
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
	#resultado
	li $v0,4
	la $a0,msjresult
	syscall
	#salto
	li $v0,4
	la $a0,newLine
	syscall
	la $t0,($t7)
	add $t1,$t5,$zero
	add $t2,$t4,$zero
	jal formCom
	#salto
	li $v0,4
	la $a0,newLine
	syscall
	la $t0,($t8)
	add $t1,$t3,$zero
	add $t2,$t6,$zero
	jal formCom
	#salto
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
	#resultado
	li $v0,4
	la $a0,msjresult
	syscall
	#salto
	li $v0,4
	la $a0,newLine
	syscall
	 
	la $t0,($t8)
	add $t1,$t3,$zero
	add $t2,$t6,$zero
	jal formCom
	#salto
	li $v0,4
	la $a0,newLine
	syscall
	
	la $t0,($t7)
	add $t1,$t5,$zero
	add $t2,$t4,$zero
	jal formCom
	#salto
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
	#combatientes
	li $v0,4
	la $a0,msjcombate
	syscall
	#espacio
	li $v0,4
	la $a0,spaceline
	syscall
	#poke1
	li $v0,4
	la $a0,poke1
	syscall
	#espacio
	li $v0,4
	la $a0,spaceline
	syscall
	#vs
	li $v0,4
	la $a0,msjvs
	syscall
	#espacio
	li $v0,4
	la $a0,spaceline
	syscall
	#poke2
	li $v0,4
	la $a0,poke2
	syscall
	#salto
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
	#nombre atacante
	li $v0,4
	move $a0,$t0
	syscall
	#espacio
	li $v0,4
	la $a0,spaceline
	syscall
	#vida atacante
	li $v0,4
	la $a0,msjvida
	syscall
	#respuesta vida atacante
	li $v0,1
	move $a0,$t1
	syscall
	#espacio
	li $v0,4
	la $a0,spaceline
	syscall
	#ataque atacante
        li $v0,4
	la $a0,msjAtaque
	syscall
	#respuesta ataque atacante
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
	#espacio
	li $v0,4
	la $a0,spaceline
	syscall
	#ataca a 
	li $v0,4
	la $a0,msjatacaa
	syscall
	#espacio
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