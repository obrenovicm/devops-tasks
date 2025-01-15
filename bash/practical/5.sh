#!/bin/bash

# -v -> replace lowercase with uppercase and vice versa
# -s <A_WORD> <B_WORD> --> replace <A_WORD> with <B_WORD> in text
# -r --> reverse text lines
# -l --> convert all the text to lower case
# -u --> convert all the text to upper case
# should work with -i <input_file> and -o <output_file>
#

usage() {
	echo "Usage: ./script -i <input-file> -o <output-file> [vsrlu]?"
}

if [[ $# -le 4 ]]; then
	usage
fi


while getopts "i:o:vs:rlu" opt; do
	case $opt in
		v)
			result=$(echo "$input" | tr '[:upper:][:lower:]' '[:lower:][:upper:]')
			echo "$result" > "$output"
			;;
		s)
			a_word="$OPTARG"
			b_word="${!OPTIND}"
			OPTIND=$(( OPTIND + 1 ))
			
			result=$(sed "s/${a_word}/${b_word}/g" "$infile")
			echo "$result" > "$output"
			;;
		r)
			result=$(echo "$input" | nl | sort -r | cut -f 2-)
			echo "$result" > "$output"
			;;
		l)
			result=$(echo "$input" | tr '[:upper:]' '[:lower:]')
			echo "$result" > "$output"
			;;
		u)
			result=$(echo "$input" | tr '[:lower:]' '[:upper:]')
			echo "$result" > "$output"
			;;
		i)
			infile=$OPTARG
			input=$( cat $OPTARG)
			;;
		o)
			output=$OPTARG
			;;
		\?)
			echo "Invalid argument passed!"
			usage
			;;

	esac
done

