  #------------------------------------------------------------------
  # Tests hazards that can be solved by forwarding
  #------------------------------------------------------------------

  org   0x0000
  ori $1, $0, 0x0002
  add $1, $1, $1
  sub $2, $1, $1
  halt
