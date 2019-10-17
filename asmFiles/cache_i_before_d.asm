org 0x0000
	
	ori $1, $0, 0xF0
	lw $2, 0($1)
	ori $3, $0, 0xFFFF
	lw $4, 4($1)
	ori $5, $0, 0xFFFF
	lw $6, 8($1)
	ori $7, $0, 0xFFFF
	
	
	halt

	
org   0x00F0
	cfw 0xFFFF
	cfw 0xDDDD
	cfw 0xCCCC
	cfw 0xBBBB
  
