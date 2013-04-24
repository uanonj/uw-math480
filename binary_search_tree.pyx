"""
binary_search_tree.py
Jason Uanon

Input:
    A set of frequencies p_1, ..., p_n of binary search tree
    keys such that:
        - p_1 + ... + p_n = 1.0
        - p_i corresponds to the frequency of the i'th key
          where the keys 1, ..., n are in sorted order

Output:
    The minimum possible average search time of a binary search
    tree among all possible configurations with those keys, 
    defined as:
        - (p_1*d_1) + ... + (p_n*d_1)
          where d_i is the depth of the i'th node

(See also: Introduction to Algorithms (Cormen et al) pp. 397)
"""

import math
import sys
import time
from libc.stdlib cimport malloc, free

cdef double subset_sum(double *p, int i, int j):
    """Returns the sum of the elements of p from 
       i to j (inclusive)"""
    cdef double acc
    cdef int index
    acc = 0.0
    for index from i <= index <= j:
        acc += p[index-1]
    return acc

cdef double get_or_zero(double **A, int i, int j):
    """Returns the element at A[i][j], or 0 if i <= j"""
    if i <= j:
        return A[i][j]
    else:
        return 0

cdef void solve_binary_tree(double *p, int n):
    """Solves and prints the binary search tree problem
       using the frequencies in p, of length n"""
    cdef double **A
    cdef double m, ssum
    cdef int i, s, j, r
    A = <double **>malloc((n+1)*sizeof(double *))
    for i from 0 <= i <= n:
        A[i] = <double *>malloc((n+1)*sizeof(double))
    for s from 1 <= s <= n: # 1 ... n: All sizes of sequences
        for i from 1 <= i <= n-s+1: # 1 ... n-s+1: All starting points of sequences
            j = i + s - 1
            m = get_or_zero(A, i+1, j)
            for r from i+1 <= r <= j: # i ... j: All possible choices for the root
                m = min(m, get_or_zero(A, i, r-1) + get_or_zero(A, r+1, j))
            ssum = subset_sum(p, i, j)
            A[i][j] = m + ssum
    print A[1][n]
    for i from 0 <= i <= n:
        free(A[i])
    free(A)

def main():
    start_time = time.time()
    cdef int n, i
    cdef double *p
    n = 100
    p = <double *>malloc(n*sizeof(double))
    for i from 0 <= i < n:
        p[i] = 0.01
    solve_binary_tree(p, n)
    free(p)
    print "time:", time.time() - start_time, "seconds"

if __name__ == '__main__':
    main()
