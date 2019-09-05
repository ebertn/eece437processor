# BEQ    $rs,$rt,label PC <= (R[rs] == R[rt]) ? npc+BranchAddr : npc
# BNE    $rs,$rt,label PC <= (R[rs] != R[rt]) ? npc+BranchAddr : npc

org 0x0000

ori $1, $0, 5
ori $2, $0, 5

beq $1, $2, test1

test1:
bne $1, $2, test2
halt

test2:
ori $3, $0, 10

halt


