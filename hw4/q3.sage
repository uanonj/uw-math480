# target decimal expansion to 17 decimal places
num_target = 0.13869616280169693
tolerance = 10^(-18)

for i in range(10^6, 10^7):
    for j in range(10^6, 3*i/20):
        if abs((j/i) - num_target) < tolerance:
            print "Possibility:", j, i
print "Done."
