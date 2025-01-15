#!/bin/bash

# function declaration - start
set -e

function processInput {
		# $1 - operator, $2 - array
		local arr=("$@")
		local x="${arr[0]}"
		local y="${arr[1]}"
		local res=$(( $x $OPERATOR $y ))
		local n="${#arr[@]}"

		for ((i = 2; i < n ; i++)); do
				res=$(( $res $OPERATOR ${arr[i]} ))
		done

		echo "Final result : $res"
}

function usage {
	echo "Usage : ./script -o <operator> -n <num-seq> (-d)? "
	exit 1
}

if [[ $# < 5 ]]; then
	usage
fi


OPERATOR=""

while getopts "o:n:d" opt; do
	
		case $opt in
			o)
				OPERATOR="$OPTARG"
				;;
			n)
				array+=("$OPTARG")
				while [ "$OPTIND" -le "$#" ] && [ "${!OPTIND:0:1}" != "-" ]; do
						array+=("${!OPTIND}")
						OPTIND="$(expr $OPTIND \+ 1)"
					done
				processInput "${array[@]}"
				;;
		d)
				user=`whoami`
				echo "User : $user"
				echo "Numbers : "${array[@]}""
				echo "Operation : $OPERATOR"
				echo "Script : $0"
				;;
		\?)
				echo "invalid argument passed"
				;;

		esac
done




