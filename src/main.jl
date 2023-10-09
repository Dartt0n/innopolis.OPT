using optimathation

# c = [3.0; 2.0; 1.0; 5.0]
# A = [7.0 3.0 4.0 1.0
#     2.0 1.0 1.0 5.0
#     1.0 4.0 5.0 2.0]
# b = [7.0; 3.0; 8.0]

# table = optimathation.simplex(c, A, b)
# display(table)

c = [3.0; 2.0]
A = [1.0 2.0
    2.0 3.0
    3.0 1.0]
b = [18.0; 42.0; 24.0]

table = optimathation.simplex(c, A, b)
display(table)