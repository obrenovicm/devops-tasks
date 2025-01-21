
if __name__ == '__main__':

    string = input("Enter the string:")
    count = {}

    for c in string:
        if c not in count:
            count[c] = 1
        
        else:
            count[c] += 1

    print(count)