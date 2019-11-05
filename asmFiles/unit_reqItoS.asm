#------------------------------------------------------------------
  # Tests Req I -> S and Responder M -> S
  #------------------------------------------------------------------

#CORE 0
org 0x0000

ori $1, $0, 0xF000
ori $2, $0, 0x6666

lw $3, 0($1) # CPU 0 goes I -> S

loop1:
  ori $5, $zero, 0x200
  addi $5, $5, -1
  beq $5, $zero, loop1

loop3:
  ori $5, $zero, 0x200
  addi $5, $5, -1
  beq $5, $zero, loop3

lw $3, 0($1) # CPU1 M -> S CPU0 I-S

halt

#CORE 1
org 0x0200
ori $1, $0, 0xF000
ori $2, $0, 0x6666

loop2:
  ori $1, $zero, 0x200
  addi $1, $1, -1
  beq $1, $zero, loop2

sw $2 0($1)   # CPU1 S -> M  CPU0 S-I


halt

org 0xF000
cfw		0x1111
