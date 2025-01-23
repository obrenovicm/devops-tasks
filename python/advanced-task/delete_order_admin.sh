#!/bin/bash

source .env

python3 client.py admin delete_order_admin --admin_token "$ADMIN_TOKEN" --order_id $1
