# Yash Bansal, 2022CS51133
# Tail recursive solution
.data
prompt1:	.asciz "Enter the values of n :- "
prompt2:	.asciz "Ans is :- "
.text
main:
	li a7 4
	la a0 prompt1
	ecall
	li a7 5
	ecall
	mv s2 a0 	# s2 contains the value of n	
	li s3 0		# s3 contains the value of acc	
sum:
	beq s2 zero exit
	add s3 s3 s2
	addi s2 s2 -1
	j sum
exit:
	li a7 4
	la a0 prompt2
	ecall
	li a7 1
	mv a0 s3
	ecall	
# Yash Bansal, 2022CS51133