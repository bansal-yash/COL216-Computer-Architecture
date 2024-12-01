# Yash Bansal, 2022CS51133

.data
name:	.asciz  "Yash Bansal\n"
entry:  .asciz "2022CS511133"

.text
main:
	li a7 4
	la a0 name
	ecall
	la a0 entry
	ecall