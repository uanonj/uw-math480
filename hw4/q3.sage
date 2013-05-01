# target decimal expansion to 17 decimal places
num_target = 0.13869616280169693
tolerance = 10^(-17)

for i in range(10^7, 10^8):
    for j in range(i/10, 3*i/20):
        if abs((j/i) - num_target) < tolerance:
            print "Possibility:", j, i
print "Done."