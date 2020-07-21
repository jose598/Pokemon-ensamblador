.data
Ataque1: .float	
Ataque2: .float	
PokeAttack: 	.float	1,2,3
Zero: 	.float	0.0
.eqv longitudDato 4
.text
main:
la $s0, PokeAttack
addi $t2, $t1, 0
#add $t2, $t2, $t6
#mul $t2, $t2, longitudDato
add $t3, $t2, $s0
l.s $f3, 0($t3) 
#la $t9,Ataque1
#mfc1 $t9,$f3
la $t9, Ataque1
swc1 $f3, ($t9) 
l.s $f2,Ataque1
add.s $f12,$f2,$f1
li $v0, 2
syscall

addi $t2,$t2,1
mul $t2, $t2, longitudDato
add $t3, $t2, $s0
l.s $f3, ($t3) 
#la $t8,Ataque2
#mfc1 $t8,$f3
la $t9, Ataque2
swc1 $f3, ($t9) 
#l.s $f1,Zero


#la $t1, Ataque2
#lwc1 $f12, 0($t1) 
l.s $f2,Ataque2
add.s $f12,$f2,$f1
li $v0, 2
syscall

li $v0, 10
syscall


		   