  #------------------------------------------------------------------
  # Tests control hazards
  #------------------------------------------------------------------

  org   0x0000
testjump:
  j test1_j
  ori $1, $0, 1

test1_j:
  jal test2_j
  ori $2, $0, 2
  j testbranch

test2_j:
  jr $31

testbranch:
  ori $1, $0, 1
  ori $2, $0, 2

  beq $1, $2, test3_b

test1_b:
  bne $1, $2, test2_b
  halt

test2_b:
  ori $3, $0, 10

test3_b:
  halt
