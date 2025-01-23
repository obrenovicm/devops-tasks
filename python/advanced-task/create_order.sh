#!/bin/bash

python3 client.py customer create_order --pizza_ids "2,3" --quantities "1,2" --user_id 2
python3 client.py customer create_order --pizza_ids "1,3" --quantities "1,1" --user_id 5

