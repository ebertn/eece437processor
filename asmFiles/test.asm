org 0x0000

ori $8, $0, 0
ori $6, $0, 20
ori $4, $0, 0x0F00
ori $5, $0, buffer_size
ori $7, $0, consumer_index
lw $2, 0($5)

loop:
  lw $1, 0($7)  #consumer index
  sw $8, 0($4)
  addi $1,$1, 1
  addi $4, $4, 4
  addi $8, $8, 1
  bne $1, $2, second_part
  ori $1, $0, 0
  ori $4, $0, 0x0F00
second_part:
  sw $1, 0($7)
  bne $8, $6, loop




ori $4, $0, 0x0F00

lw $5, 0($4)
lw $6, 4($4)
lw $7, 8($4)
lw $8, 12($4)
lw $9, 16($4)
lw $10, 20($4)
lw $11, 24($4)
lw $12, 28($4)
lw $13, 32($4)
lw $14, 36($4)

ori $1, $0, consumer_index
lw $15, 0($1)

halt



org 0x0F00
array:
  cfw 0x0000
  cfw 0x0000
  cfw 0x0000
  cfw 0x0000
  cfw 0x0000
  cfw 0x0000
  cfw 0x0000
  cfw 0x0000
  cfw 0x0000
  cfw 0x0000

buffer_size:
  cfw 0x000A
consumer_index:
  cfw 0x0000

