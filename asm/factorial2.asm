main:		addi	$a0, $0, 6			# definir n=6 pour factorial(n)
		jal	factorial			# appel de factorial(n)
		j	end_prog			# sauter a la fin du programmme

factorial:	addi 	$t0, $a0, 0			# initialiser temporaire $t0 = n
		addi	$t1, $t0, -2 			# initialiser compteur for_fact : i = n - 2
		addi	$t3, $0, 1			# initialiser constante 1
		addi	$t5, $t0, 0			# initialiser resultat temporaire a 0
		addi	$t6, $0, 0			# Valeur retournee par par le slt
  
for_fact:	addi 	$t4, $t1, 0			# initialiser compteur mult: j = i
		slt	$t2, $t1, $t3			# j < 1?
		beq	$t2, 1, end_fact		# si oui, on termine en allant a end_fact

mult:		sltu	$t6, $t4, $t3			# $t4 < 1?                    - use sltu
		beq	$t6, $t3, not_first_fact	# si $t6 == $t3: j < 1, aller a not_first_fact
		add	$t0, $t5, $t0			# sinon, on continue la boucle mult	
		addi	$t4, $t4, -1			# Decrementer compteur boucle
		j	mult 	

not_first_fact:	addi	$t5, $t0, 0			# on met a jour la valeur a additionner
		addi	$t1, $t1, -1			# Decrementer le compteur du factoriel
		j	for_fact

end_fact:	addi	$v0, $t0, 0			# valeur de retour dans $v0
		jr	$ra

end_prog:	
		andi 	$t6, $0, 0				# $t6 == 1? $t6 = 1 : $t6 = 0 - use andi
		ori 	$t6, 0 				# $t6 == 1? $t6 = 1 : $t6 = 0 - use ori
		sll	$t6, $t6, 16			# bitshift $t6 de 16          - use sll
		lui	$t7, 1				# $t7 = 0x00010000            - use lui
		beq	$t6, $t7, erratum	# si $t6 == $t7: j < 1, aller a not_first_fact
		sw	$v0, 0x10010010			# sauver le résultat à l'adresse 0x0010
		j the_end
erratum:
		sw	$t6, 0x10010010

the_end:
la	$a0, ($v0)
li  	$v0, 1				# imprimer la reponse
syscall


