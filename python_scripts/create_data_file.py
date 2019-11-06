print("org 0x0000\n")

for i in range(1, 16):
    print('cfw 0x', end='')
    for j in range(0, 8):
        print(hex(i)[-1], end='')
    print()