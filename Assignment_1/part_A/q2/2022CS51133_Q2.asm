# Yash Bansal, 2022CS51133

.data 
prompt1:	.string "Sum is :- "
prompt2:	.string "Enter the array :- \n"
.text 
	
main:
	li a7 4
	la a0 prompt2
	ecall
	addi sp sp -44  # initialize the stack pointer to store the array
	li s2 0  	# s2 contains my final sum
	li a7 5  	# for reading from the console
	li s3 10 	# for the loop to go over 10 times
	li s4 0  	# gives the current iteration of the loop
	mv s5 sp 	# gives the array pointer	
loop :
	ecall
	sw a0 0(s5)	# store the input to the array
	add s2 a0 s2	# add the array value to the answer register
	addi s5 s5 4	# increment the array pointer
	addi s4 s4 1	# increment the current iteration of the loop
	bne s3 s4 loop	# loop around if the condition is not met

	sw s2 0(s5) 	# store the sum to the memory
	li a7 4		# for output to the console
	la a0 prompt1
	ecall
	li a7 1
	mv a0 s2	# moving the sum to the required register for output
	addi sp sp 64	# restoring the stack pointer
	ecall		# output to the console