"""
Jason Uanon
Math 480, Spring 2013

Python & Cython problems, intended to be run on cloud.sagemath.org
and timed with %timeit
"""

from libc.stdlib cimport malloc, free
import time


def timer(f):
    """Auxiliary timer function, to be used with %timeit"""
    start_time = time.time()
    f()
    print "time:", time.time() - start_time, "seconds"

# Sum of squares problem
# Python version
def sum_of_squares(n):
    """Returns the sum of the squares of the positive integers up to n. 
    Assumes that n is a positive integer at most 10000."""
    acc = 0
    for i in range(1, n+1):
        acc += i*i
    return acc

# Cython version
cdef long sum_of_squares_cy(long n):
    cdef long acc = 0
    cdef int i
    for i from 1 <= i <= n:
        acc += i*i
    return acc

def sum_of_squares_cyf(long n):
    return sum_of_squares_cy(n)


# List of all primes up to n 10,000
# Python version
def primes_list(n=10000):
    primes_sieve = [True] * (n+1)
    primes_sieve[0] = False
    primes_sieve[1] = False
    primes_list = []
    for i in range(2, n+1):
        if primes_sieve[i]:
            primes_list.append(i)
            for j in range(i+1, n+1):
                if primes_sieve[j] and j % i == 0:
                    primes_sieve[j] = False
    return primes_list

# Cython version
DEF PrimesLimit = 10000
cdef primes_list_cy():
    cdef int primes_sieve[PrimesLimit]
    cdef int i, j
    primes_sieve[0] = False
    primes_sieve[1] = False
    primes_list = []
    count = 0
    for i from 2 <= i <= PrimesLimit:
        primes_sieve[i] = True
    for i from 2 <= i <= PrimesLimit:
        if primes_sieve[i]:
            primes_list.append(i)
            for j from i+1 <= j <= PrimesLimit:
                if primes_sieve[j] and j % i == 0:
                    primes_sieve[j] = False
    return primes_list

def primes_list_cyf():
    return primes_list_cy()


# Determinant of a 4x4 matrix
# Python version
def deter():
    m = []
    count = 1.0
    for i in range(4):
        m.append([0] * 4)
        for j in range(4):
            m[i][j] = count
            count += 1.0
    return (m[0][0] * (m[1][1] * (m[2][2]*m[3][3] - m[3][2]*m[2][3])
                     - m[1][2] * (m[2][1]*m[3][3] - m[3][1]*m[2][3])
                     + m[1][3] * (m[2][1]*m[3][2] - m[3][1]*m[2][2]))
          - m[0][1] * (m[1][0] * (m[2][2]*m[3][3] - m[3][2]*m[2][3])
                     - m[1][2] * (m[2][0]*m[3][3] - m[3][0]*m[2][3])
                     + m[1][3] * (m[2][0]*m[3][2] - m[3][0]*m[2][2]))
          + m[0][2] * (m[1][0] * (m[2][1]*m[3][3] - m[3][1]*m[2][3])
                     - m[1][1] * (m[2][0]*m[3][3] - m[3][0]*m[2][3])
                     + m[1][3] * (m[2][0]*m[3][1] - m[3][0]*m[2][1]))
          - m[0][3] * (m[1][0] * (m[2][1]*m[3][2] - m[3][1]*m[2][2])
                     - m[1][1] * (m[2][0]*m[3][2] - m[3][0]*m[2][2])
                     + m[1][2] * (m[2][0]*m[3][1] - m[3][0]*m[2][1])))

# Cython version
cdef double deter_cy():
    cdef double **m
    cdef double count, result
    cdef int i, j
    m = <double **>malloc(4*sizeof(double *))
    for i from 0 <= i < 4:
        m[i] = <double *>malloc(4*sizeof(double))
        for j from 0 <= j < 4:
            m[i][j] = count
            count += 1.0
    result =  (m[0][0] * (m[1][1] * (m[2][2]*m[3][3] - m[3][2]*m[2][3])
                       - m[1][2] * (m[2][1]*m[3][3] - m[3][1]*m[2][3])
                       + m[1][3] * (m[2][1]*m[3][2] - m[3][1]*m[2][2]))
            - m[0][1] * (m[1][0] * (m[2][2]*m[3][3] - m[3][2]*m[2][3])
                       - m[1][2] * (m[2][0]*m[3][3] - m[3][0]*m[2][3])
                       + m[1][3] * (m[2][0]*m[3][2] - m[3][0]*m[2][2]))
            + m[0][2] * (m[1][0] * (m[2][1]*m[3][3] - m[3][1]*m[2][3])
                       - m[1][1] * (m[2][0]*m[3][3] - m[3][0]*m[2][3])
                       + m[1][3] * (m[2][0]*m[3][1] - m[3][0]*m[2][1]))
            - m[0][3] * (m[1][0] * (m[2][1]*m[3][2] - m[3][1]*m[2][2])
                       - m[1][1] * (m[2][0]*m[3][2] - m[3][0]*m[2][2])
                       + m[1][2] * (m[2][0]*m[3][1] - m[3][0]*m[2][1])))
    for i from 0 <= i < 4:
        free(m[i])
    free(m)
    return result

def deter_cyf():
    return deter_cy()


# Matrix multiplication
# Python version
def matmul_helper(m, n, i, j):
    """Returns vector product of m's ith row and n's jth column"""
    result = 0.0
    for x in range(4):
        result += m[i][x] * n[x][j]
    return result

def matmul():
    m = []
    count = 1.0
    for i in range(4):
        m.append([0] * 4)
        for j in range(4):
            m[i][j] = count
            count += 1.0
    n = []
    result = []
    for i in range(4):
        result.append([0] * 4)
        n.append([0] * 4)
        for j in range(4):
            n[i][j] = count
            count += 1.0
    for i in range(4):
        for j in range(4):
            result[i][j] = matmul_helper(m, n, i, j)
    return result

# Cython version
cdef double matmul_helper_cy(double **m, double **n, int i, int j):
    """Returns vector product of m's ith row and n's jth column"""
    cdef double result = 0.0
    cdef int x
    for x from 0 <= x < 4:
        result += m[i][x] * n[x][j]
    return result

cdef matmul_cy():
    cdef double **m
    cdef double **n
    cdef double count
    cdef int i, j
    m = <double **>malloc(4*sizeof(double *))
    count = 1.0
    for i from 0 <= i < 4:
        m[i] = <double *>malloc(4*sizeof(double))
        for j from 0 <= j < 4:
            m[i][j] = count
            count += 1.0
    n = <double **>malloc(4*sizeof(double *))
    result = []
    for i from 0 <= i < 4:
        n[i] = <double *>malloc(4*sizeof(double))
        result.append([0] * 4)
        for j from 0 <= j < 4:
            n[i][j] = count
            count += 1.0
    for i from 0 <= i < 4:
        for j from 0 <= j < 4:
            result[i][j] = matmul_helper_cy(m, n, i, j)
    for i from 0 <= i < 4:
        free(m[i])
        free(n[i])
    free(m)
    free(n)
    return result

def matmul_cyf():
    return matmul_cy()

