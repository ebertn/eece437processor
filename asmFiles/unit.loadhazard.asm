# For when the instruction immediately after a LW depends on the LW

org 0x0000

ori   $1, $zero, 0x80
ori   $3, $zero, 0x5
ori   $6, $zero, 0x9

lw    $6, 0($1)
subu  $7, $6, $3
sw    $7, 4($1)

halt

org 0x80
cfw 0x8

# Result should be 3, not 4
