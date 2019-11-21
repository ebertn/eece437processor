# registers a0-1,v0,t0
# a0 = a
# a1 = b
# v0 = result

org 0x0000
	
	ori $s4, $0, 0x00000001
	ori $s5, $0, 0x00000010
	ori $t0, $0, min_val
    lw $s7, 0($t0)
    or $a0, $s5, $0
	or $a1, $s6, $0
	jal min
    or $a0, $s7, $0
	or $a1, $v0, $0
	jal min
	ori $t0, $0, min_val
	sw $v0, 0($t0)
	or $a0, $a2, $0
    or $a1, $a3, $0
	halt
#-max (a0=a,a1=b) returns v0=max(a,b)--------------
max:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a0, $a1
  beq   $t0, $0, maxrtn
  or    $v0, $0, $a1
maxrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------

#-min (a0=a,a1=b) returns v0=min(a,b)--------------
min:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a1, $a0
  beq   $t0, $0, minrtn
  or    $v0, $0, $a1
minrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------


org 0x0FF0
min_val:
	cfw 0xFFF0FFFF
