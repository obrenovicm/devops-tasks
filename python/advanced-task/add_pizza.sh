#!/bin/bash

source .env
python3 client.py admin add_pizza --pizza_id 10 --name "Carbonara" --price 20 --admin_token "$ADMIN_TOKEN"
python3 client.py admin add_pizza --pizza_id 11 --name "Street pasta" --price 15 --admin_token "$ADMIN_TOKEN"
