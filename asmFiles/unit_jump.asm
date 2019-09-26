# J      label         PC <= JumpAddr
# JAL    label         R[31] <= npc; PC <= JumpAddr
# JR     $rs           PC <= R[rs]

j test1
ori $1, $0, 1

test1:

jal test2
ori $2, $0, 2
halt

test2:

jr $31

