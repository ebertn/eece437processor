# BEQ    $rs,$rt,label PC <= (R[rs] == R[rt]) ? npc+BranchAddr : npc
# BNE    $rs,$rt,label PC <= (R[rs] != R[rt]) ? npc+BranchAddr : npc

org 0x0000

ori $1, $0, 1
ori $2, $0, 2

beq $1, $2, test3

test1:
bne $1, $2, test2
halt

test2:
ori $3, $0, 10

test3:
halt


