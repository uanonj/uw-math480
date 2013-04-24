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
import time
import sys

def subset_sum(p, i, j):
    """Returns the sum of the elements of p from 
       i to j (inclusive)"""
    acc = 0
    for index in range(i, j+1):
        acc += p[index-1]
    return acc

def get_or_zero(A, i, j):
    """Returns the element at A[i][j], or 0 if i <= j"""
    if i <= j:
        return A[i][j]
    else:
        return 0

def solve_binary_tree(p, n):
    """Solves and prints the binary search tree problem
       using the frequencies in p, of length n"""
    A = list()
    for i in range(n+2):
        A.append([0] * (n+1))
    for s in range(1, n+1): # 1 ... n: All sizes of sequences
        for i in range(1, n-s+2): # 1 ... n-s+1: All starting points of sequences
            j = i + s - 1
            m = list()
            for r in range(i, j+1): # i ... j: All possible choices for the root
                m.append(get_or_zero(A, i, r-1) + get_or_zero(A, r+1, j) + subset_sum(p, i, j))
            A[i][j] = min(m)
    print A[1][n]

def main():
    start_time = time.time()
    n = len(sys.argv) - 1
    if n < 1:
        print "Usage: python binary_search_trees.py [binary tree weights]"
        return None
    else:
        p = list()
        for i in range(1, n+1):
            p.append(float(sys.argv[i]))
        solve_binary_tree(p, n)
        print "time:", time.time() - start_time, "seconds"

if __name__ == '__main__':
    main()
