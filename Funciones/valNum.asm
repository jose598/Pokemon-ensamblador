.data
text: .asciiz "h"
num: .space 4

	.globl mainV
	.text

mainV:
    la $s0,text
    #li $s0,4
while:
    lbu $t0,0($s0)
   # add $t0,$s0,4
    li $t1, 48
    li $t2, 57 
    ble $t0, $t2, condition2
    j aumento
return1:  
    li $v0, 1 
aumento:
    addiu $s0,$s0,1
    beqz $t0,return
    j while
condition2:
    bge $t0, $t1, return1
    li $v0, 0
    j aumento
return: 
	syscall
    