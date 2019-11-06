scripts_dir = '/home/ecegrid/a/mg234/ece437/processors/scripts'

replace = False
end_cpu1 = False
with open(scripts_dir + '/system.do') as f:
    for line in f:
        if line == 'add wave -noupdate -color Cyan /system_tb/DUT/CPU/DP0/dpif/halt\n':
            replace = False

        if line == 'add wave -noupdate -divider {CPU 1}\n':
            replace = True

        if replace:
            print(line.replace("DP0", "DP1"), end='')
        else:
            print(line, end='')

