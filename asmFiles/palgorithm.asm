#----------------------------------------------------------
# First Processor
#----------------------------------------------------------
  org   0x0000              # first processor p0
  ori   $sp, $zero, 0x3ffc  # stack

  jal   producer              # go to program
  halt

lock:
aquire:
  push $ra
  ll    $t0, 0($a0)         # load lock location
  or $s6, $0, $a0
  ori $t0, $0, seed
  lw $t1, 0($t0)
  or $a0, $t1, $0

  jal crc32

  ori $t0, $0, seed
  sw $v0, 0($t0)
  or $a0, $s6, $0
  sc    $v0, 0($a0)      # if sc failed retry

pop $ra
  jr    $ra

lock2:
aquire2:
  ll    $t0, 0($a1)         # load lock location
  or $t0, $s4, $0
  sc    $t0, 0($a1)
  beq   $t0, $0, lock       # if sc failed retry
  jr    $ra

unlock1:
  sw    $0, 0($a0)
  jr    $ra

producer:
  push  $ra                 # save return address
  ori $s1, $0,256  #loop control variables
  ori $s2, $0, 0
  ori $t0, $0, buffer_size
  lw $s3,0($t0)
  ori $a0, $0, buffer       #address of the start of the buffer
  ori $s4, $0, 0

  loop:
    jal lock
    addi $s2, $s2, 1
    addi $s4, $s4, 1
 	addi $a0,$a0,4
    bne $s4, $s3, part2

	ori $s4, $0, 0
    ori $a0, $0, 0
    ori $a0, $0, buffer
	
  part2:
    ori $a1, $0, buffer_index
    jal lock2

    bne $s1, $s2,loop
  
  ori $s4, $0, 1
  ori $a1, $0, buffer_full
  jal lock2
  pop   $ra                 # get return address
  jr    $ra                 # return to caller

crc32:
  lui $t1, 0x04C1
  ori $t1, $t1, 0x1DB7
  or $t2, $0, $0
  ori $t3, $0, 32

l1:
  slt $t4, $t2, $t3
  beq $t4, $zero, l2

  ori $t5, $0, 31
  srlv $t4, $t5, $a0
  ori $t5, $0, 1
  sllv $a0, $t5, $a0
  beq $t4, $0, l3
  xor $a0, $a0, $t1
l3:
  addiu $t2, $t2, 1
  j l1
l2:
  or $v0, $a0, $0
  jr $ra
 
#----------------------------------------------------------
# Second Processor
#----------------------------------------------------------
  org   0x200               # second processor p1
  ori   $sp, $zero, 0x7ffc  # stack


jal   consumer           # go to program

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

#-divide(N=$a0,D=$a1) returns (Q=$v0,R=$v1)--------
divide:               # setup frame
  push  $ra           # saved return address
  push  $a0           # saved register
  push  $a1           # saved register
  or    $v0, $0, $0   # Quotient v0=0
  or    $v1, $0, $a0  # Remainder t2=N=a0
  beq   $0, $a1, divrtn # test zero D
  slt   $t0, $a1, $0  # test neg D
  bne   $t0, $0, divdneg
  slt   $t0, $a0, $0  # test neg N
  bne   $t0, $0, divnneg
divloop:
  slt   $t0, $v1, $a1 # while R >= D
  bne   $t0, $0, divrtn
  addiu $v0, $v0, 1   # Q = Q + 1
  subu  $v1, $v1, $a1 # R = R - D
  j     divloop
divnneg:
  subu  $a0, $0, $a0  # negate N
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
  beq   $v1, $0, divrtn
  addiu $v0, $v0, -1  # return -Q-1
  j     divrtn
divdneg:
  subu  $a0, $0, $a1  # negate D
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
divrtn:
  pop $a1
  pop $a0
  pop $ra
  jr  $ra
#-divide--------------------------------------------#
check:
	ori $t0,$0, 1
	lw $t1, 0($s0)
    beq $t0, $t1, end
    bne $t0, $t1, aquire3

lock3:
aquire3:
  push $ra
  ll    $t0, 0($a0)
  beq $t0, $0, lock3
  ori $t1, $0, 0
  ori $t2, $0, 1
  beq $s4, $t1, first
  beq $s4, $t2, second

  pop $ra
  jr    $ra
  
  first:
	or $s4, $t2, $0
    or $s5, $t0, $0
    ori $t0, $0, 0
    sc $t0, 0($a0)
    beq   $t0, $0, first
    pop $ra
    jr    $ra

  second:
	ori $t2, $0, 2
	or $s4, $t2, $0
    or $s6, $t0, $0
    ori $t0, $0, 0
    sc $t0, 0($a0)
    beq   $t0, $0, second
    pop $ra
    jr    $ra

consumer:
  push  $ra
  ori $s1, $0,256  #loop control variables
  ori $s2, $0, 0
  ori $t0, $0, buffer_size
  lw $s3,0($t0)
  ori $a0, $0, buffer       #address of the start of the buffer
  ori $a1, $0, 0
  ori $t0, $0, 4
  add $a0, $a0, $t0

  
loop2:

	jal lock3
	addi $s2, $s2, 1
	ori $t0,$0, 2
    bne $s4, $t0, next
    or $a2, $a0, $0
    or $a3, $a1, $0
	

	#Max
    ori $t0, $0, max_val
    lw $s7, 0($t0)
	ori $t0, $0, 0x0000FFFF
    and $s5, $s5, $t0
 	and $s6, $s6, $t0
	
    or $a0, $s5, $0
	or $a1, $s6, $0
	jal max
    or $a0, $v0, $0
	or $a1, $s7, $0
	jal max	
	ori $t0, $0, max_val
    sw $v0, 0($t0)

	#Min
	ori $t0, $0, min_val
    lw $s7, 0($t0)
    ori $t0, $0, 0x0000FFFF
    and $s5, $s5, $t0
 	and $s6, $s6, $t0
	
	or $a0, $s5, $0
	or $a1, $s6, $0
 
	jal min
	ori $t0, $0, 0x0000FFFF
 	and $s7, $s7, $t0
    or $a0, $s7, $0
	or $a1, $v0, $0
	jal min

	ori $t0, $0, min_val
	sc $v0, 0($t0)
	or $a0, $a2, $0
    or $a1, $a3, $0
	


    #Add to total
	ori $t0, $0, 0x0000FFFF
    ori $t1, $0, total
    lw $t2, 0($t1)
    and $t3, $s5, $t0
  	and $t4, $s6, $t0
	add $t0, $t3, $t4
	add $t1, $t0, $t2
 	ori $t3, $0, total
	sw $t1, 0($t3)

	ori $s4, $0, 0
	ori $s5, $0, 0
	ori $s6, $0, 0
	ori $v0, $0, 0

   next:
	addi $a1, $a1, 1
 	addi $a0,$a0,4
	bne $a1, $s3, stuff

	ori $a1, $0, 0
    ori $a0, $0, 0
    ori $a0, $0, buffer
	stuff:
  	 bne $s1, $s2,loop2
  
end:
	ori $t0, $0, total
    lw $t1, 0($t0)
    ori $t2, $0, 8
	srlv $t1, $t2, $t1

	sw $t1, 0($t0)
	
	#ori $a0, $t1, 0
    #ori $a1, $0, 0xFF
	#jal divide
    #ori $t0, $0, average
	
    pop   $ra                 # get return address
    jr    $ra                 # return to caller


org 0xF000
buffer_full:
  cfw 0x00000000
seed:
  cfw 0x0000ABCD
buffer:
  cfw 0x00000000
  cfw 0x00000000
  cfw 0x00000000
  cfw 0x00000000
  cfw 0x00000000
  cfw 0x00000000
  cfw 0x00000000
  cfw 0x00000000
  cfw 0x00000000
  cfw 0x00000000
buffer_index:
  cfw 0x0
buffer_size:
  cfw 0xA
num_of_entries:
  cfw 0x00FF
min_val:
  cfw 0x00000FFF
max_val:
  cfw 0x00000000
total:
  cfw 0x00000000
average:
  cfw 0x00000000
