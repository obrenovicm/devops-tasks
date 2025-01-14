#!/bin/bash

# script that demonstrates caesar cipher

for letter in {A..Z}; do
		array+=($letter)		
done

while getopts "s:i:o:" opt; do
		case $opt in
				s)
						shift=$OPTARG
						if [ $shift -le 0 ]; then
								shift=$(( shift + 26 ))
						fi

						echo "shift value : $shift"
						;;
				i)
						echo "input file passed : $OPTARG"
						input=$(cat $OPTARG)
						echo "text that needs to be encrypted : $input"
						;;
				o)
						echo "output file passed: $OPTARG"
						solution=$(cat $OPTARG)
						;;
				\?)
						echo "invalid argument passed"
						;;
				esac
		done

a_to="${array[shift]}"
z_to="${array[$(( shift - 1 ))]}"

echo "A translates to : $a_to"
echo "Z translates to : $z_to"


output=`echo "$input" | tr "A-Z" "${a_to}-ZA-${z_to}"`
echo "$output"
