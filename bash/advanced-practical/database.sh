#!/bin/bash

# script for creating databases, creating tables, inserting/selecting/deleting data from tables

# example usage:./database.sh create_db example_db
# 				./database.sh create_table example_db persons id name height age
# 				./database.sh insert_data example_db persons 0 Igor 180 36
# 				./database.sh select_data example_db persons

set -e


if [[ ! -e "tables-"$2".txt" ]]; then
	touch "tables-"$2".txt"
fi

TABLES=($(cat "tables-"$2".txt"))
ROW_LEN=8
LINE_LEN=39


function usage_db {
	echo "Usage: "$0" create_db <db-name>"
	exit 150
}

function usage_table {
	echo "Usage: "$0" create_table <db-name> <table-name> <args..>"
	exit 151
}

function usage_insert {
	echo "Usage: "$0" insert_data <db-name> <table-name> <args..>"
	exit 152
}

function usage_delete {
	echo "Usage: "$0" delete_data <db-name> <table-name> <value>"
	exit 153
}

function usage_select {
	echo "Usage: "$0" select_data <db-name> <table-name>"
	exit 154
}

function check_row {
	local row="$1"
	if [[ ${#row} -gt $ROW_LEN ]]; then
		echo "Row length should be maximum $ROW_LEN chars long!"
		exit 150
	fi
}

function check_line {
	local line_len="$1"
	if [[ $line_len -gt $LINE_LEN ]]; then
		echo "Line length should be maximum $LINE_LEN chars long!"
		exit 151
	fi
}

function check_database {
	if [[ -e "$1.txt" ]]; then
		echo "Database $1 already exists!"
		exit 140
	fi
}

function check_existing_table {
	for table in "${TABLES[@]}"; do
		if [[ $table == $1 ]]; then
			echo "Table $table already exists!"
			exit 141
		fi
	done
	TABLES+=("$1")
	echo "${TABLES[@]}" > "tables-"$2".txt"
}

function check_incorrect_table {
	local ind=1 # 0 - good
	for table in "${TABLES[@]}"; do
		if [[ $table == $1 ]]; then
			ind=0
		fi
	done

	if [[ $ind -eq 1 ]]; then
		echo "Cannot write to a table "$1" as it does not exist!"
		exit 190
	fi
}

function create_database {
	check_database $1
	echo "Creating database.."
	touch "$1.txt"
}

function pad_word {
	printf "%-${ROW_LEN}s" "$1" # pad word to the right with spaces if necessary
}

function create_table {
	local arr=("$@")
	local db_name="${arr[1]}"
	local table_name="${arr[2]}"
	check_existing_table "$table_name" "$db_name"
	echo "" >> "$db_name.txt"
	echo -e "TABLE:$table_name" >> "$db_name.txt" 

	local cols=""
	echo -n "** " >> "$db_name.txt"
	for ((i = 3 ; i < "${#arr[@]}" ; i++)); do
		cols+=" $(pad_word "${arr[i]}")"
		#echo -n "${arr[i]} |" >> "$db_name.txt"
	done

	echo -n "${cols}" >> "$db_name.txt"
	echo " **" >> "$db_name.txt"	
}

function insert_data {
	# use sed -i "LINEi\anything" filepath
	local arr=("$@")
	local db_name="${arr[1]}"
	local table_name="${arr[2]}"
	check_incorrect_table $table_name
	local table_line=$(cat "$db_name.txt" | grep -n "TABLE:"$table_name"" | cut -d ":" -f 1)
	local line_len=0
	table_line=$(( table_line + 1 ))

	insert_text="** "
	for ((i=3 ; i < "${#arr[@]}" ; i++)); do
		row=${arr[i]}
		check_row $row
		line_len=$(( line_len + ${#row} ))
		insert_text+=" $(pad_word "${arr[i]}")"
	done
# Create the block of text to insert
	sed -i '' "${table_line}a\\

" "$db_name.txt"

	check_line $line_len

	insert_text+=" **"
	# insert the text after the target line
	sed -i '' "${table_line}a\\
$insert_text" "$db_name.txt"

}

function select_data {
	local arr=("$@")
	local db_name="${arr[1]}"
	local table_name="${arr[2]}"
	
	local start_line=$(grep -n "TABLE:$table_name" $db_name.txt | cut -d ":" -f 1)
	local end_line=$(grep -n "TABLE:" $db_name.txt | grep -A 1 "TABLE:$table_name" | tail -n 1 | cut -d ":" -f 1)
	
	#Case where the table may be last in file
	if [[ $start_line == $end_line ]]; then
		end_line=$(wc -l < $db_name.txt)
	else
		end_line=$(( end_line - 1 ))
	fi
	
	# print the data between start and end line
	sed -n "${start_line}, ${end_line}p" "$db_name.txt"
}

function delete_data {
	
	local arr=("$@")
	local db_name="${arr[1]}"
	local table_name="${arr[2]}"
	
	local condition="${arr[3]}"
	condition="${condition%\"}" # remove the trailing "
	condition="${condition#\"}" # remove the leading "
	local key=$(echo $condition | cut -d "=" -f 1)
	local value=$(echo $condition | cut -d "=" -f 2)

	# find the record in the table
	local start_line=$(grep -n "TABLE:$table_name" "$db_name.txt" | cut -d ":" -f 1)
	local end_line=$(grep -n "TABLE:" $db_name.txt | grep -A 1 "TABLE:$table_name" | tail -n 1 | cut -d ":" -f 1)
	
	if [[ $start_line == $end_line ]]; then
		end_line=$( grep -c '^' "$db_name.txt") # another way of calculating a no of lines in a file
	fi
	
	start_line=$(( start_line + 1 ))
		
	local cols=$(grep -n "$key" "$db_name.txt" | grep "$start_line:" | xargs | cut -d ":" -f 2)
	IFS=' ' read -r -a array <<< "$cols"

	
	# declare the colon in which the value is; if = -1 then colon does not exist 
	col_num=-1

	for ((i=0 ; i < "${#array[@]}"; i++ )); do
		if [[ $key == "${array[i]}" ]] ; then
			col_num=$i
			break
		fi
	done
	
	if [[ $col_num == -1 ]]; then
		echo "Inserted key does not exist in table"
		exit 190
	fi
	# now, for loop to determine which row needs to be deleted and save the line of it; if = -1 then value does not exist
	delete_line=()
	
	for ((i="$start_line" ; i <= "$end_line" ; i++ )); do
		line=$(sed -n "${i},${i}p" "$db_name.txt" | xargs | cut -d " " -f "$(( col_num + 1 ))")
		if [[ $line == $value ]]; then
			delete_line+=($i)
		fi
	done
		
	if [[ "${#delete_line[@]}" == 0 ]]; then
	   echo "Value does not exist in the table."
	   exit 191
   fi

	
	# finally, go through lines and delete them
	for ((i=${#delete_line[@]} -1 ; i >= 0; i-- )); do
		sed -i '' "${delete_line[i]}d" "$db_name.txt"
	done
	
}

if [[ $1 == "create_db" ]]; then
	if [[ "$#" < 2 ]]; then
		usage_db
	fi
	create_database $2


elif [[ $1 == "create_table" ]]; then
	if [[ "$#" < 4 ]]; then
		usage_table
	fi
	create_table $@

elif [[ $1 == "insert_data" ]]; then
	if [[ "$#" < 4 ]]; then # insert_data, db-name, table-name, and at least 1 value
		usage_insert
	fi
	insert_data $@

elif [[ $1 == "select_data" ]]; then
	if [[ "$#" < 3 ]]; then
		usage_select
	fi

	select_data $@

elif [[ $1 == "delete_data" ]]; then
	if [[ "$#" < 4 ]]; then
		usage_delete
	fi

	delete_data $@
fi




