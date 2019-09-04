org 0x0000

ori $28, $0, 0xfffc
ori $27, $0, 0xf000
sw $28, 0($27)

ori $2, $0, 4
jal my_push
ori $2, $0, 5
jal my_push
ori $2, $0, 6
jal my_push
ori $2, $0, 7
jal my_push

jal mult_procedure

halt

mult_procedure:
  ori $30, $31, 0

  # Pop values from stack
  jal my_pop
  ori $3, $2, 0

  pop_loop:
    jal my_pop
    ori $4, $2, 0

    # Multiply values
    ori $5, $0, 0
    loop:
      add $5, $5, $3

      addi $4, $4, -1
      bne $4, $0, loop

    add $3, $0, $5

    ori $26, $0, 0xfffc
    ori $27, $0, 0xf000
    lw $28, 0($27)

    bne $28, $26, pop_loop

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
