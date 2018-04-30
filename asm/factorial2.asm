main:		addi	$a0, $0, 6			# definir n=6 pour factorial(n)
		jal	factorial			# appel de factorial(n)
		j	end_prog			# sauter a la fin du programmme

factorial:	addi 	$t0, $a0, 0			# initialiser temporaire $t0 = n
		addi	$t1, $t0, -2 			# initialiser compteur outer_loop : i = n - 2
		addi	$t3, $0, 1			# initialiser constante = 1
		addi	$t5, $t0, 0			# initialiser somme intermediaire a n

outer_loop:	addi 	$t4, $t1, 0			# initialiser compteur inner_loop: j = i
		slt	$t2, $t1, $t3			# i < 1?
		beq	$t2, 1, end_fact		# si oui, sauter end_fact

inner_loop:	sltu	$t6, $t4, $t3			# j < 1?
		beq	$t6, $t3, not_first_fact	# si oui sauter a not_first_fact
		add	$t0, $t5, $t0			# sommer les termes intermediaires j fois	
		addi	$t4, $t4, -1			# j -= 1
		j	inner_loop 			# loop over j

not_first_fact:	addi	$t5, $t0, 0			# reinitialiser la somme intermediaire
		addi	$t1, $t1, -1			# i -= 1
		j	outer_loop			# loop over i

end_fact:	addi	$v0, $t0, 0			# sauver le resultat dans $v0
		jr	$ra				# retour

end_prog:	andi 	$t6, $t6, 1			# - use andi : $t6 = 1
		ori 	$t6, $t6, 0 			# - use ori  : $t6 = 1
		sll	$t6, $t6, 16			# - use sll  : $t6 = 0x10000
		lui	$t7, 2				# - use lui  : $t7 = 0x20000
		beq	$t6, $t7, erratum		# erreur si $t6 == $t7, sauter a erratum
		sw	$v0, 0x10010010			# sauver fact(6) a l'adresse 0x0010
		j the_end				# sauter a la fin
		
erratum:	sw	$t6, 0x10010010			# sauver $t6 a l'adresse 0x0010

the_end:
lw	$a0, 0x10010010
li  	$v0, 1				# imprimer la reponse
syscall


