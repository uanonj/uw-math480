binary_search_tree: binary_search_tree.c
	gcc -o binary_search_tree -I /usr/include/python2.7 binary_search_tree.c -lpthread -lm -lutil -ldl
