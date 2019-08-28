org 0x0000

# Setup stack mem address (at 0x0000)
ori $28, $0, 0xfffc
sw $28, 0($0)

# Inputs
ori $3, $0, 22   # Current day
ori $4, $0, 8    # Current month
ori $5, $0, 2019 # Current year

# Execute days formula

# Days = 0; Days += Current Day
ori $6, $0, 0
addi $6, $3, 0

# 30 * (Current Month - 1)
addi $4, $4, -1
or $2, $0, $4
jal my_push
ori $2, $0, 30
jal my_push
jal mult

# Days += 30 * (Current Month - 1)
add $6, $6, $2

# 365 * (Current Year - 2000)
addi $5, $5, -2000
or $2, $0, $5
jal my_push
ori $2, $0, 365
jal my_push
jal mult

# Days += 365 * (Current Year - 2000)
add $2, $6, $2

# Calculated Days in $2
halt

mult:
  ori $30, $31, 0

  # Pop values from stack
  jal my_pop
  ori $3, $2, 0
  jal my_pop
  ori $4, $2, 0

  # Multiply values
  ori $2, $0, 0
  loop:
    add $2, $2, $3

    addi $4, $4, -1
    bne $4, $0, loop

  jr $30

my_push:
    lw $28, 0($0)
    addi $28, $28, -4
    sw $2, 4($28)
    sw $28, 0($0)
    jr $31

my_pop:
    lw $28, 0($0)
    lw $2, 4($28)
    addi $28, $28, 4
    sw $28, 0($0)
    jr $31
