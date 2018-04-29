main:		addi $v0,$0,360		# intialiser $t0 a 720
		sll $v0,$v0,1
#		add $t0,$v0,$0
#		andi $t0,720
#		ori $t0,720
#		addi $t1,$0,32
#		slt $t2,$t1,$t0
#		sll $t1,$t1,2
#		sltu $t2,$t1,$t0
#		jal jal_l
#		addi $t2,$t2,4
#		j the_end
#jal_l:		addi $t2,$t2,4
#		jr $ra
the_end:	sw $v0,0x10010010	# sauver a l'adresse 0x0010
