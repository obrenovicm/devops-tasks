#!/bin/bash

# script that calculates fibonnaci sequence

F0=0
F1=1

function fib () {
	
	local n=$1
	if [[ n -eq 0 ]]; then
		echo $F0
		return

	elif [[ n -eq 1 ]]; then
		echo $F1
		return
	fi

	local result=$(( $( fib $(( n-1 ))) + $( fib $(( n-2 )))  ))
	echo $result
}

echo "Fibonnaci of $1 is: $(fib "$1")"
