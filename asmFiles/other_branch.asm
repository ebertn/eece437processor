org 0x0000

ori $2, $0, 34
ori $3, $0, 66
add $4, $3, $2
ori $5, $0, 100
beq $5, $4, next

ori $6, $0, 1234
ori $7, $0, 1234

halt
next:
	ori $8, $0, 4321
	ori $9, $0, 1111
	bne $9, $8, next2
	ori $10, $0, 1111
	halt


next2:
	halt
