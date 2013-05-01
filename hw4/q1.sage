# Conjecture: x^2 + a*x + b is prime whenever a and b are
# coprime and b is odd.

def f(a, b, x):
    return x*x + a*x + b

def print_primes(a, b):
    for i in range(200):
        n = f(a, b, i)
        if is_prime(n):
            print n

print_primes(10, 3)
print "-----"
print_primes(3, 5)
print "-----"
print_primes(324654, 11)
print "-----"
print_primes(3, 10)
