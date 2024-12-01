# Yash Bansal, 2022CS51133

.data
prompt1:	.string "ans is :- "
prompt2:	.string "Enter the number :- "
.text 	
main:
	li a7 4
	la a0 prompt2
	ecall
	li a7 5		# for reading from the console
	ecall
	mv s5 a0	# s5 contains the number n
	li s2 0		
	li s3 1
	li s4 1 	# gives the current iteration of the loop
		
	beq s5 s3 exit
loop:
	add s6 s3 s2
	mv s2 s3
	mv s3 s6
	addi s4 s4 1
	bne s5 s4 loop	
exit:
	li a7 4		# for output to the console
	la a0 prompt1
	ecall
	li a7 1
	mv a0 s3	# moving the sum to the required register for output
	ecall		# output to the console