
.data

<<<<<<< HEAD
file:   .asciiz "C:\\Users\\Francisco\\Desktop\\Ensamblador\\pokeTypes.txt"      # ruta Absoluta..
=======
#file:   .asciiz "C:\\Users\\Francisco\\Desktop\\Ensamblador\\pokeTypes.txt"      # ruta Absoluta..
file:   .asciiz "C:\\Users\\TASHZ\\Desktop\\mars\\Pokemon-ensamblador\\pokeTypes.txt" 
>>>>>>> ae8c9906596bdaf06c509def7377ae15dabc22db
poke1:    .space 50
poke2: .space 50
tipo1:    .space 50
tipo2: .space 50
poke3:    .space 50
poke4: .space 50
tipo3:    .space 50
tipo4: .space 50
poke5:    .space 50
poke6: .space 50
tipo5:    .space 50
tipo6: .space 50
poke7:    .space 50
poke8: .space 50
tipo7:    .space 50
tipo8: .space 50
poke9:    .space 50
poke10: .space 50
tipo9:    .space 50
tipo10: .space 50


buffer: .space 1730

linea1: .space 100
linea2: .space 100
linea3: .space 100
linea4: .space 100
linea5: .space 100
linea6: .space 100
linea7: .space 100
linea8: .space 100
linea9: .space 100
linea10: .space 100

matrizPokemon: .word poke1, poke2, poke3, poke4, poke5, poke6, poke7, poke8, poke9, poke10

matrizTipos: .word tipo1,tipo2, tipo3, tipo4, tipo5, tipo6, tipo7, tipo8, tipo9, tipo10


.text
	.globl mainSecundario


# Funcionalidad: Trabaja en similitud a un main secundario para este archivo. 
#Retorno: No retorna nada. 
mainSecundario:
	
	addi $sp,$sp,-8
	sw $ra,($sp)
	sw $s0,4($sp)
	
	jal random
  	move $s0,$v0
	jal open
	move $a1, $v0 
 	move $a0,$s0
 	jal read
 	jal close
 	jal separarLinea
 	
 	la $v0, matrizPokemon
	la $v1, matrizTipos
	
  	lw $ra,($sp)
	lw $s0,4($sp)
  	addi $sp,$sp,8
	jr $ra
	
  	# Funcionalidad: Abre el archivo
  	# Retorno: devuelve el file descriptor
  	 open:
 		addi $sp,$sp,-12
 		sw $ra,($sp)
 		sw $a0,4($sp)
 		sw $a1,8($sp)
 		
 		la $a0, file
		li $v0, 13    
 		li $a1, 0       
 		syscall 
 		
 		lw $ra,($sp)
 		lw $a0,4($sp)
 		lw $a1,8($sp)
 		addi $sp,$sp,12
 		jr $ra 
 	#Funcionalidad: Lee el archivo correspondiente 
 	#Retorno: No retorna nada. 
 	read:
 		addi $sp,$sp,-36
 		sw $ra,($sp)
 		sw $s7,4($sp)
 		sw $s5,8($sp)
 		sw $s0,12($sp)
 		sw $s1,16($sp)	
 		sw $s3,20($sp)
 		sw $t1,24($sp)
 		sw $s6,28($sp)
 		sw $t3,32($sp)
 		
 		move $t1,$a1  
 		add $s5,$zero, $a0
 		sub $s5,$s5,1
 		li $s7,0 		
 		addi $s6,$s5,11		
 		addi $s4,$zero,0  	
 		addi $s2,$zero,-1
 		
 		leer:
 			li $v0, 14     
 			la $a1, buffer 
 			li $a2, 1
 			move $a0, $t1  	
 			syscall 
 			
 			la $a3,buffer
 			slt $t0,$s4,$s5
 			beq $t0,0,imprimir
 		chequeo:
 			lb $t3,($a3)
 			la $t0,10
 			beq $t3,$t0,salto
 			la $t0,13
 			beq $t3,$t0,regresar
 			b leer
 		regresar:
 			b leer
 		salto:
 			addi $s4,$s4,1
			slt $t0,$s4,$s5      
 			beq $t0,1,leer
 			slt $t0,$s4,$s6
 			beq $t0,0,leer
 		
 		imprimir:
 			slt $t0,$s4,$s6
 			beq $t0,$0,regreso
 			la $t0,10
 			lb $t3,($a3)
 			bne $t3,$t0,seguir  #\n
 				addi $s4,$s4,1
 				addi $s2,$s2,1
 				li $s7,0
 				b leer
 			seguir:
 				la $t0,13  # \r
 				beq $t3,$t0,return
 				la $t0,9 #\t
 				beq $t3,$t0,return
 				
 				move $a0,$s2
 				move $a1,$s7 
 				move $a3,$t3 
 				jal guardacionOutput
 				addi $s7,$s7,1
 				b leer
 			return: 
 				b leer
 		regreso:
 			lw $ra,($sp)
 			lw $s7,4($sp)
 			lw $s5,8($sp)
 			lw $s0,12($sp)
 			lw $s1,16($sp)	
 			lw $s3,20($sp)
 			lw $t1,24($sp)
 			lw $s6,28($sp)
 			lw $t3,32($sp)
 			addi $sp,$sp,36
 			jr $ra  
 			
 			
 			
 			
 	#Funcionalidad: Establece la linea en donde guardar el caracter en el espacio de la linea correspondiente.
 	# Resultado: No retorna, solo guarda en la linea correspondiente.
 	guardacionOutput:
 			addi $sp,$sp, -20
 			sw $ra,($sp)
 			sw $s2,4($sp)
 			sw $s3,12($sp)
 			sw $t1,16($sp)
 			
 			
 			move $t1,$a0
 			la $s3,($a3)
 			add $s2,$zero,$t1
 			beq $s2,0,primero
 			beq $s2,1,segundo
 			beq $s2,2,tercero
 			beq $s2,3,cuarto
 			beq $s2,4,quinto
 			beq $s2,5,sexto
 			beq $s2,6,septimo
 			beq $s2,7,octavo
 			beq $s2,8,noveno
 			beq $s2,9,decimo
 			beqz $s2,else
 			
 			segundo:
 				move $a0,$a1 
 				move $a1, $s3
 				la $a2, linea2 
 				jal guardarPrueba
 				b else
 			primero:
 				li $a0,0
 				add $a0,$zero,$a1 
 				move $a1, $s3
 				la $a2, linea1 
 				jal guardarPrueba
 				b else
 			tercero:
 				li $a0,0
 				add $a0,$zero,$a1
 				move $a1, $s3
 				la $a2, linea3 
 				jal guardarPrueba
 				b else
 			cuarto:
 				li $a0,0
 				add $a0,$zero,$a1
 				move $a1, $s3
 				la $a2, linea4
 				jal guardarPrueba
 				b else
 			quinto:
 				li $a0,0
 				add $a0,$zero,$a1 
 				move $a1, $s3
 				la $a2, linea5 
 				jal guardarPrueba
 				b else
 			sexto:
 				li $a0,0
 				add $a0,$zero,$a1 
 				move $a1, $s3
 				la $a2, linea6 
 				jal guardarPrueba
 				b else
 			septimo:
 				li $a0,0
 				add $a0,$zero,$a1 
 				move $a1, $s3 
 				la $a2, linea7
 				jal guardarPrueba
 				b else
 			octavo:
 				li $a0,0
 				add $a0,$zero,$a1 
 				move $a1, $s3 
 				la $a2, linea8 
 				jal guardarPrueba
 				b else
 			noveno:
 				li $a0,0
 				add $a0,$zero,$a1 
 				move $a1, $s3
 				la $a2, linea9 
 				jal guardarPrueba
 				b else
 			decimo:
 				li $a0,0
 				add $a0,$zero,$a1 
 				move $a1, $s3 
 				la $a2, linea10 
 				jal guardarPrueba
 				b else
 			else:
 				lw $ra,($sp)
 				lw $s2,4($sp)
 				lw $s3,12($sp)
 				lw $t1,16($sp)
 				addi $sp,$sp,20
 				jr $ra
 				
 	#Guarda el caracter en la linea correspondiente.
 	#Retorno: Ninguno.		
 	guardarPrueba:
 		addi $sp,$sp,-24
 		sw $ra,($sp)
 		sw $s7,4($sp)
 		sw $t3,8($sp)
 		sw $t1,12($sp)
 		sw $s0,16($sp)
 		sw $s3,20($sp)
 		
 		
 		la $s7,($a0)
 		add $t1,$zero,$s7
 		move $s0,$a1 
 		move $s3,$a2
 		
 		
 		addu $t2,$s3,$s7
 		sb $s0,0($t2)
 		beqz $s0,fi
 		
   		fi:
   		lw $ra,($sp)
   		lw $s7,4($sp)
   		lw $t3,8($sp)
   		lw $t1,12($sp)
   		lw $s0,16($sp)
   		lw $s3,20($sp)
 		addi $sp,$sp,24
 		jr $ra
 	
 	#Funcionalidad: Separa la linea que antes se guardo en dos partes, en las cuales son guardadas en el arreglo Tipos y Pokemons
 	#Retorno: Nignuno, solo hace de referencia.	
 	separarLinea:
 		addi $sp, $sp, -4
 		sw $ra, ($sp)
 		
 		la $a0,poke1
 		la $a1,tipo1
 		la $a2,linea1
 		jal separar
 		
 		la $a0,poke2
 		la $a1,tipo2
 		la $a2,linea2
 		jal separar	
 		
 		la $a0,poke3
 		la $a1,tipo3
 		la $a2,linea3
 		jal separar	
 		
 		la $a0,poke4
 		la $a1,tipo4
 		la $a2,linea4
 		jal separar
 		
 		la $a0,poke5
 		la $a1,tipo5
 		la $a2,linea5
 		jal separar
 		
 		la $a0,poke6
 		la $a1,tipo6
 		la $a2,linea6
 		jal separar				
 		
 		la $a0,poke7
 		la $a1,tipo7
 		la $a2,linea7
 		jal separar
 		
 		la $a0,poke8
 		la $a1,tipo8
 		la $a2,linea8
 		jal separar	
 		
 		la $a0,poke9
 		la $a1,tipo9
 		la $a2,linea9
 		jal separar
 		
 		la $a0,poke10
 		la $a1,tipo10
 		la $a2,linea10
 		jal separar
 					
 		lw $ra, ($sp)
 		addi $sp, $sp, 4			
 	
 	#Funcionalidad: Separacion y retorno en cada uno de el .space pre indentificado
 	#Retorno: Dos palabras almacenadas en Tipos y Pokemons
 	separar:
 		addi $sp,$sp,-32
 		sw $ra,($sp)
 		sw $s0,4($sp)
 		sw $t5,8($sp)
 		sw $t6,12($sp)
 		sw $t0,16($sp)
 		sw $t3,20($sp)
 		sw $t2,24($sp)
 		sw $t1,28($sp)
 		
 		move $t5, $a0
 		move $t6, $a1
 		move $t0,$a2 
   		li $t1, 0    
   		la $t3, 44   
 	countChr:  
 		lb $t2, 0($t0)  
   		 beqz $t2, final  
   		 beq $t2, $t3, suma
   		 sb      $t2,0($t5)             
   		 addi    $t5,$t5,1   
   		 
   		 add $t0, $t0,1     
    		 add $t1, $t1, 1 
   		 b countChr
	suma:
    		add $t0, $t0,1 
	proceed:
    		lb $t2, 0($t0) 
   		beqz $t2, final 
    		sb      $t2,0($t6)     
    		addi    $t6,$t6,1          	

    	        add $t0, $t0,1    
    		add $t1, $t1, 1
    		b proceed

 	final:  
    		 
 		lw $ra,($sp)
 		lw $s0,4($sp)
 		lw $t5,8($sp)
 		lw $t6,12($sp)
 		lw $t0,16($sp)
 		lw $t3,20($sp)
 		lw $t2,24($sp)
 		lw $t1,28($sp)
    		addi $sp,$sp,32
    		jr $ra	
 			
 	#Funcionalidad: Cierra el archivo
 	#Retorno: Devuelve el fd
 	close:
 		addi $sp,$sp,-4
 		sw $ra,($sp)
 		
 		li $v0,16
  		move $a0,$t1
 		syscall
 		
 		lw $ra,($sp)
 		addi $sp,$sp,4
 		jr $ra
 		
 		
   	
   	random:
   		  addi $sp,$sp,-8
   		  sw $ra,($sp)
   		  sw $a1,4($sp)
    		  li $a1, 99 
   	 	  li $v0, 42
  		  syscall
		  move $v0, $a0
		  lw $ra, ($sp)
		  lw $a1, 4($sp)
		  addi $sp,$sp,8
		  jr $ra
		  
		  
	
	
		
		  
	
	
	
		
