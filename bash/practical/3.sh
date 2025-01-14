#!/bin/bash

# script that demonstrates FizzBuzz problem

for num in {1..100}; do
				if [ $(( `expr $num % 15` )) -eq 0 ]; then
								echo "$num : FizzBuzz"
				elif [ $(( `expr $num % 3` )) -eq 0 ]; then
								echo "$num : Fizz"
				elif [ $(( `expr $num % 5` )) -eq 0 ]; then
								echo "$num : Buzz"
				fi
done


