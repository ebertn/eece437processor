org 0x0000

ori $28, $0, 0xfffc
sw $28, 0($0)

ori $2, $0, 4
jal my_push
ori $2, $0, 5
jal my_push

jal mult

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
