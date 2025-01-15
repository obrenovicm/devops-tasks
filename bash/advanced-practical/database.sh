#!/bin/bash

# script for creating databases, creating tables, inserting/selecting/deleting data from tables

# example usage:./database.sh create_db example_db
# 				./database.sh create_table example_db persons id name height age
# 				./database.sh insert_data example_db persons 0 Igor 180 36
# 				./database.sh select_data example_db persons

set -e

if [[ -e "tables.txt" ]]; then
	touch "tables.txt"
fi

TABLES=($(cat "tables.txt"))

function check_database {
	if [[ -e "$1.txt" ]]; then
		echo "Database $1 already exists!"
		exit 140
	fi
}

function check_table {
	for table in "${TABLES[@]}"; do
		if [[ $table == $1 ]]; then
			echo "Table $table already exists!"
			exit 141
		fi
	done
	TABLES+=("$1")
	echo "${TABLES[@]}" > "tables.txt"
}

function create_database {
	check_database $1
	echo "Creating database.."
	touch "$1.txt"
}

function create_table {
	local arr=("$@")
	local db_name="${arr[1]}"
	local table_name="${arr[2]}"
	check_table "$table_name"
	echo -e "TABLE:\t$table_name" >> "$db_name.txt" 
	echo "-------------------------------" >> "$db_name.txt"

	local cols=()
	echo -n "|" >> "$db_name.txt"
	for ((i = 3 ; i < "${#arr[@]}" ; i++)); do
		cols+="${arr[i]}"
		echo -n "${arr[i]} |" >> "$db_name.txt"
	done
	echo "" >> "$db_name.txt"	
}

function insert_data {
	# use sed -i "LINEi\anything" filepath
	local arr=("$@")
	local db_name="${arr[1]}"
	local table_name="${arr[2]}"
	# find the line number of the table and insert data below it TODO	
}

if [[ $1 == "create_db" ]]; then
	create_database $2

elif [[ $1 == "create_table" ]]; then
	create_table $@

elif [[ $1 == "insert_data" ]]; then
	insert_data $@

fi




