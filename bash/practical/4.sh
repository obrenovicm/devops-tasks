#!/bin/bash

# script that demonstrates caesar cipher

usage() {
	echo "Usage : ./script -s <shift-value> -i <input-file> -o <output-file>"
}

if [[ $# < 6 ]]; then
	usage
fi


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

						;;
				i)
						input=$(cat $OPTARG)
						;;
				o)
						solution=$(cat $OPTARG)
						;;
				\?)
						echo "invalid argument passed"
						;;
				esac
		done

a_to="${array[shift]}"
z_to="${array[$(( shift - 1 ))]}"



output=`echo "$input" | tr "A-Z" "${a_to}-ZA-${z_to}"`

if [[ $output == $solution ]]; then
	echo "Encryption successful"
else
	echo "Something went wrong :/"
fi

