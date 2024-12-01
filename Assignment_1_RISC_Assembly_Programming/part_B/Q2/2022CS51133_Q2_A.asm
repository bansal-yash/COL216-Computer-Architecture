# Yash Bansal, 2022CS51133
# Recursive solution
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
	jal ra sum
	j exit
sum:
	addi sp sp -32
	sw ra 0(sp)
	sw s2 4(sp)
	beq s2 zero return
	
	addi s2 s2 -1
	jal ra sum
	
	lw s2 4(sp)
	lw ra 0(sp)
	add s3 s3 s2
	addi sp sp 32
	ret
return:
	addi sp sp 32
	ret
exit:
	li a7 4
	la a0 prompt2
	ecall
	li a7 1
	mv a0 s3
	ecall	
# Yash Bansal, 2022CS51133