  #------------------------------------------------------------------
  # Tests Req I -> M and Responder M -> I
  #------------------------------------------------------------------

#CORE 0
org 0x0000
  ori   $1, $zero, 0xF0
  ori   $2, $zero, 0xACAC

  # Test Req: I -> M
  sw    $2, 0($1) # CPU0 will go I -> M

  # Wait some time (aka count to 0x500)
loop0:
  ori $1, $zero, 0x500
  addi $1, $1, -1
  beq $1, $zero, loop0

  halt

#CORE 1
org 0x0200

  # Wait some time (aka count to 0x200)
loop1:
  ori $1, $zero, 0x200
  addi $1, $1, -1
  beq $1, $zero, loop1

  ori   $1, $zero, 0xF0
  ori   $2, $zero, 0xBDBD

  # Test Req: I -> M
  sw    $2, 0($1) # CPU1 will go I -> M and CPU0 will go M -> I

  halt