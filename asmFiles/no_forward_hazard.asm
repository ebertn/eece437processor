
  #------------------------------------------------------------------
  # Tests hazards that cannot be solved by forwarding
  #------------------------------------------------------------------

  org   0x0000
  ori   $1, $zero, 0x0F00
  lw    $2, 0($1)
  addi  $3, $2, 1
  halt

  org   0x0F00
  cfw   0x7337