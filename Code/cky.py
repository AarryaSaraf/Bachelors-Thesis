def printer(arr):
    width = max(len(str(element)) for row in arr for element in row)
    for row in arr:
        for element in row:
            print(str(element).rjust(width), end=" ")
        print()
    print()
    
def cyk(grammar, start_symbol, string):
    n = len(string)
    table = [[set() for _ in range(n)] for _ in range(n)]
    printer(table)
    # Fill in the base cases of the CYK table
    for i in range(n):
        for rule in grammar:
            if string[i] in grammar[rule]:
                table[i][i].add(rule)
    printer(table)
    # Fill in the rest of the CYK table
    for length in range(1, n):
        printer(table)
        for i in range(n - length):
            j = i + length
            for k in range(i, j):
                for rule in grammar:
                    for rule1 in table[i][k]:
                        for rule2 in table[k+1][j]:
                            if rule1 + rule2 in grammar[rule]:
                                table[i][j].add(rule)
    # Check if the start symbol is in the top-right corner of the table
    return start_symbol in table[0][n - 1]


# Example usage:
grammar = {
    'S': {'AB', 'AC', 'AD', 'ED'},
    'A': {'('},
    'B': {')'},
    'C': {'AC'},
    'D': {'CA'},
    'E': {'BA'}
}

start_symbol = 'S'

string = '()'

if cyk(grammar, start_symbol, string):
    print("TRUE")
else:
    print("FALSE")
