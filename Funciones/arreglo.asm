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
matrizA: .word tipo1,tipo2,tipo3,tipo4,tipo5,tipo6,tipo7,tipo8,tipo9,tipo10,tipo11,tipo12,tipo13,tipo14,tipo15,tipo16,tipo17,tipo18
	#matrizA: .word 2,3,3,2
	nroColumnas: .word 18
	.eqv longitudDato 4
	
espacio: .asciiz " "
salto: .asciiz "\n"
poke:  .asciiz "fire"
sigual:  .asciiz "son iguales"
noigual:  .asciiz "no iguales"
.text

main:	
jal principal
j end

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
	jal compare
	li $v0, 4
	la $a0, espacio
	syscall
	
	addi $t6, $t6, 1
	blt $t6, $s7, bucle2
	
	li $v0, 4
	la $a0, salto
	syscall

	addi $t0, $t0, 1
	jal end
#	blt $t0, $s7, bucle1
compare:
	addi $sp, $sp, -20
    	sw $a0,0($sp)
    	sw $a1,4($sp)
    	sw $ra,8($sp)
    	sw $t0,16($sp)
    	sw $t1,20($sp)
	la $a0,($s3)
	la $a1,poke#pokemon a comparar
	li $v0, 0
	jal loopc
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
	li $v0, 0
	li $v0, 1
	addi $t6,$t6,1 #indice de tipo
	la $a0, ($t6)
	syscall	
	j end
lend:
	beq $t0, $t1, igual
	beqz $t0, menor
	beqz $t1, mayor

end:	
	li $v0, 10
	syscall	
