import os
import sys

if __name__ == "__main__":
    
    duplicates = []
    l = []
    for i in range(1,len(sys.argv)):
        if sys.argv[i] in l:
            duplicates.append(sys.argv[i])
        else:
            l.append(sys.argv[i])

    duplicates = tuple(duplicates)

    print(f'Tuple : {duplicates}')
    print(f'Max element in the list : {max(l)}')
    print(f'Min element in the list : {min(l)}')
        
