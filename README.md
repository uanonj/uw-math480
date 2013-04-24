For this Cython improvement of binary_search_tree.py, I've modified the program so that the input is hard-coded to have 100 keys of equal weight (0.01) for convenience. The rest of the algorithm has been left unchanged, and the pure-Python version can be tested by running  

```
$ python binarch_search_tree_original.py  
5.8  
time: 1.34639596939 seconds
```

The Cython version can be found in binary_search_tree.pyx. A sample execution is as follows:

```
$ python setup.py build_ext --inplace
$ python
>>> import binary_search_tree
>>> binary_search_tree.main()
5.8
time: 0.00189709663391 seconds
```

On average, the compiled Cython code runs over 650 times faster for 100 binary tree nodes.
