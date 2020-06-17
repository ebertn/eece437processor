org 0x0000
	
	
	ori $1, $0, 0xF0
	ori $20, $0, 5
loop:	
	ori $3, $0, 0xFFFF
	lw $2, 0($1)
	addi $1, $1, 4
	ori $5, $0, 0xFFFF
	lw $4, 0($1)
	ori $7, $0, 0xFFFF
	lw $6, 0($1)
	addi $20, $20, -1
	addi $1, $1, 4
	beq $20, $0, loop
	halt


	
org   0x00F0
	cfw 0xFFFF
	cfw 0xDDDD
	cfw 0xCCCC
	cfw 0xBBBB
  
