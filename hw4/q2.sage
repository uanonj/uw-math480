n = 15
data = []
for p in prime_range(10^7):
    data.append(Mod(p, n))
    
stats.IntList(data).plot_histogram()

# The data appears to be evenly/symmetrically distributed
# around the 7.
# Conjecture: the results are evenly distributed, symetrically,
# around n / 2.


n = 45
data = []
for p in prime_range(10^7):
    data.append(Mod(p, n))
    
stats.IntList(data).plot_histogram()

n = 108
data = []
for p in prime_range(10^7):
    data.append(Mod(p, n))
    
stats.IntList(data).plot_histogram()

