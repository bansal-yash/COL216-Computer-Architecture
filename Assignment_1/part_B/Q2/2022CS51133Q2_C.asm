# Yash Bansal, 2022CS51133
# Iterative solution

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
	li s4 0		# s4 contains the current iteration of the loop
	
loop:
	beq s4 s2 exit
	addi s4 s4 1
	add s3 s3 s4
	j loop
	
exit:
	li a7 4
	la a0 prompt2
	ecall
	li a7 1
	mv a0 s3
	ecall	
	
# Yash Bansal, 2022CS51133