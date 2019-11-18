import subprocess

def print_offset(input_str, offset):
    for line in input_str:
        if offset != 0:
            print('\t' * (offset-1) + '|\t' + line)
        else:
            print(line)

process = subprocess.Popen(['sim', '-m', '-t'],
                           stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE)
stdout, stderr = process.communicate()

stdout = stdout.decode('utf-8').splitlines()

instr_start = 0
for i, line in enumerate(stdout):
    if "Starting simulation..." in line:
        instr_start = i + 7
        break

instr_end = 0
for i, line in enumerate(stdout):
    if "Done simulating..." in line:
        instr_end = i + 2
        break

# print(stdout[instr_end])

CORE_NUM_INDEX = 14

blocks = []
block_start = instr_start
block_end = 0
for i, line in enumerate(stdout[instr_start:instr_end], start=instr_start):
    if line == '':
        block_end = i + 1
        blocks.append(stdout[block_start:block_end-1])
        block_start = block_end

OFFSET_AMOUNT = 7

print_offset(stdout[:instr_start], 0)

for block in blocks:
    if block[0][CORE_NUM_INDEX] == '2':
        print_offset(block, OFFSET_AMOUNT)
    else:
        print_offset(block, 0)

    print()

print_offset(stdout[instr_end:], 0)
