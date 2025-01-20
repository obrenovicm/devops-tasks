import os
import sys

if __name__ == "__main__":
    
    file_name = sys.argv[1]
    tmp = file_name.split(".")
    if len(tmp) < 2:
        raise Exception("Extension not found!")
    else:
        print(f'File extension : {tmp[1]}')
