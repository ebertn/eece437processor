org 0x0000


	ori $1, $0, 0xF0
	lw $2,0($1)
	lw $3,4($1)

halt


org   0x00F0
	cfw 0xFFFF
	cfw 0xDDDD
	cfw 0xCCCC
	cfw 0xBBBB
  
