#!/bin/bash

source .env

python3 client.py admin delete_pizza --admin_token "$ADMIN_TOKEN" --pizza_id $1
