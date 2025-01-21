import os
import sys
from collections import defaultdict

if __name__ == "__main__":
    
    filename = sys.argv[1]

    agents = defaultdict(int)

    with open(filename, 'r') as f:
        
        line = f.readline()
        while line:

            tmp = line.split('"Mozilla/')
            if len(tmp) > 1: # invalid format, cannot process
                agents[tmp[1]] += 1

            line = f.readline()

    print(f"Number of unique user agents : {len(agents.keys())}")
    
    for key, value in agents.items():
        print(f"Number of requests of agent {key} : {value}")
    # TODO : number of requests per each agent

