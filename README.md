binary_search_tree.py
Jason Uanon

This program computes the minimum average search time
of a binary search tree with given key frequencies.

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

Examples:
    Input: 0.33, 0.20, 0.07, 0.25, 0.15
    Output: 2.02
