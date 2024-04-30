# Yash Bansal, 2022CS51133

.data
prompt1:	.string "Enter the string :- "
prompt2:	.string "Ans is :- "
instr:		.space 140

.text
	li a7 4
	la a0 prompt1
	ecall
	la a0 instr
	li a7 8
	li a1 140
	ecall
	mv s0 a0	# s0 points to the string containing the instruction
	
	lbu t1 0(s0)	# t1 contains the first character:- a, s, m or d
	addi s0 s0 4
	
atoi:
    	li s1 0    	# to tell negative
    	li s2 0     	# ans
    	li s3 10    	# to multiply by 10
loop:
    	lb s5 0(s0) 	# contains the current character
    	li t6 32
    	beq s5 t6 end	# loop termination
    	li s6, 45    	# '-' ascii
    	beq s5 s6 negative
    	li s7 48    	# zero ascii
    	sub s5 s5 s7
    	mul s2 s2 s3
    	add s2 s2 s5
    	addi s0 s0 1
    	beq zero zero loop

negative:
    	addi s0 s0 1
    	li s1 1
    	beq zero zero loop

end:
    	bne s1 zero make_negative
    	beq zero zero done

make_negative:
    	neg s2 s2

done:
    	mv a5 s2	# a5 contains the first number
    	
atoi1:
    	li s1 0    	# to tell negative
    	li s2 0     	# ans
    	li s3 10    	# to multiply by 10
    	addi s0 s0 1
loop1:
    	lb s5 0(s0) 	# contains the current character
    	li t6 10	
    	beq s5 t6 end1	# loop termination
    	li s6, 45    	# '-' ascii
    	beq s5 s6 negative1
    	li s7 48    	# zero ascii
    	sub s5 s5 s7
    	mul s2 s2 s3
    	add s2 s2 s5
    	addi s0 s0 1
    	beq zero zero loop1

negative1:
    	addi s0 s0 1
    	li s1 1
    	beq zero zero loop1

end1:
    	bne s1 zero make_negative1
    	beq zero zero done1

make_negative1:
    	neg s2 s2

done1:
    	mv a6 s2	# a6 contains the second number
    	
calculate:
	li t6 97
	beq t1 t6 to_add
	li t6 115
	beq t1 t6 to_sub
	li t6 109
	beq t1 t6 to_mul
	li t6 100
	beq t1 t6 to_div
to_add:
	add t6 a5 a6	# t6 contains the final answer
	j exit
to_sub:
	sub t6 a5 a6
	j exit
to_mul:
	mul t6 a5 a6
	j exit
to_div:
	div t6 a5 a6
	j exit

exit:
	li a7 4
	la a0 prompt2
	ecall
	li a7 1
	mv a0 t6
	ecall   
	
# Yash Bansal, 2022CS51133