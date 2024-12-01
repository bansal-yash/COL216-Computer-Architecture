# Yash Bansal, 2022CS51133

.data
prompt1:	.string "YashBansal"
prompt2:	.string "Enter the alphanumeric string :- "
instr:		.space 12
result: 	.space 16
.text
main:
	li a7 4
	la a0 prompt2
	ecall
	la a0 instr
	li a7 8
	li a1 12
	ecall 
	mv s0 a0
	la s1 prompt1
	la s2 result
	li t0 0
	li t1 10
	li t2 11
loop1:
	lb t3 0(s0)
	lb t4 0(s1)	
	sb t4 0(s2)
	addi s2 s2 1
	sb t3 0(s2)
	addi s0 s0 1
	addi s1 s1 1
	addi s2 s2 1
	addi t0 t0 1
	bne t0 t1 loop1	
loop2:
	lb t3 0(s0)
	sb t3 0(s2)
	addi s2 s2 1
	addi s0 s0 1
	addi t0 t0 1
	bne t0 t2 loop2
	la a0 result
	li a7 4
	ecall