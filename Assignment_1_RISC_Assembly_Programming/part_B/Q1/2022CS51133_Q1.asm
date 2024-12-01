# Yash Bansal, 2022CS51133

.data
prompt1:	.asciz "Enter the values of n :- "
prompt2:	.asciz "Enter the value of r :- "
prompt3:	.asciz "n C r value is :- "
prompt4:	.asciz "Invalid input"

.text
main:
	li a7 4
	la a0 prompt1
	ecall
	li a7 5
	ecall
	mv s2 a0 	# s2 contains the value of n
	li a7 4
	la a0 prompt2
	ecall
	li a7 5
	ecall
	mv s3 a0	# s3 contains the value of r
	
	bgt s3 s2 invalid
	blt s3 zero invalid
	
	mv s4 s2 	# s4 contains the value of which the current factorial would be calculated
	li s5 1		# s5 contains the answer of factorial of s4
	jal ra factorial
	mv t3 s5	# t3 contains n factorial
	
	mv s4 s3
	li s5 1
	jal ra factorial
	mv t4 s5	# t4 contains r factorial
	
	sub s4 s2 s3
	li s5 1
	jal ra factorial
	mv t5 s5	# t5 contains n-r factorial
	
	mul t6 t4 t5
	div s2 t3 t6	# s2 has the final answer
	
	beq zero zero exit
	
	
factorial:
	li s6 0		# s6 contains the current iteration of the loop
	beq s4 zero return
	loop:
		addi s6 s6 1
		mul s5 s5 s6
		bne s6 s4 loop
	return:
		ret
exit:
	li a7 4
	la a0 prompt3
	ecall
	li a7 1
	mv a0 s2
	ecall
	beq zero zero terminate
	
invalid:
	li a7 4
	la a0 prompt4
	ecall
	beq zero zero terminate

terminate:

# Yash Bansal, 2022CS51133