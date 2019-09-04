org 0x0000

ori $28, $0, 0xfffc
ori $27, $0, 0xf000
sw $28, 0($27)

ori $2, $0, 4
jal my_push
ori $2, $0, 4
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
    ori $27, $0, 0xf000
    lw $28, 0($27)
    addi $28, $28, -4
    sw $2, 4($28)
    sw $28, 0($27)
    jr $31

my_pop:
    ori $27, $0, 0xf000
    lw $28, 0($27)
    lw $2, 4($28)
    addi $28, $28, 4
    sw $28, 0($27)
    jr $31
