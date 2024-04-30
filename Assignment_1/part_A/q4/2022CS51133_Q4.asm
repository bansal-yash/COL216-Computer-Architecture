# Yash Bansal, 2022CS51133

.data
num1 : 		.space 260
num2 : 		.space 260
ans  : 		.space 260
.text
main:
	li a7 5
	ecall
	mv s1 a0
	li a7 ,8
	mv a1 s1
	addi a1 a1 4
	la a0 ,num1
	ecall
	la a0 num2
	ecall
	
	li s2 0 	# s2 contains the current iteration of the loop
	la s3 num1
	add s3 s3 s1
	addi s3 s3 -1	# s3 contains num1 current address
	la s4 num2
	add s4 s4 s1
	addi s4 s4 -1	  # s4 conatins num2 current address
	la s5 ans
	add s5 s5 s1 	# s5 contains ans current address
	li s6 0 	# s6 has carry
loop:
	lb s7 0(s3)
	li t0 '0'
	sub s7 s7 t0
	
	lb s8 0(s4)
	sub s8 s8 t0
	
	xor s9 s7 s8
	xor s9 s9 s6
	
	and a4 s7 s8
	and a5 s7 s6
	and a6 s8 s6
	or s6 a4 a5
	or s6 s6 a6
	
	add s9, s9,t0 
	sb s9 0(s5)
	addi s3 s3 -1
	addi s4 s4 -1
	addi s5 s5 -1
	addi s2 s2 1
	mv t0 s1
	bne s2 t0 loop

	li t0 '0'
	add s6,s6,t0
	sb s6 0(s5)
	
	li a7 4
	mv a0 s5
	ecall