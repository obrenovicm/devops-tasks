import argparse
import requests
import sys

server_url = "http://127.0.0.1:5000"

def send_req(endpoint, method, data=None, admin_token=None):
    url = f'{server_url}{endpoint}'
    headers = {}

    if admin_token:
        headers = {
            "Authorization" : f"Bearer {admin_token}"
        }
    
    if method == "GET":
        res = requests.get(url=url, headers=headers)
    elif method == "POST":
        res = requests.post(url=url, headers=headers, json=data)
    elif method == "DELETE":
        res = requests.delete(url=url, headers=headers)

    if res.status_code == 401:
        print("Unauthorized : Invalid admin token.")
        sys.exit(1)
    else:
        print(res.json())
        


def list_menu():
    send_req("/menu", method="GET")

def create_order(pizzas, quantities, user_id):
    
    payload = {
        "pizzas" : [int(pizza_id) for pizza_id in pizzas.split(",")],
        "quantity" : [int(q) for q in quantities.split(",")],
        "user_id" : user_id
    }
    send_req("/order", method="POST", data=payload)

def check_order_status(order_id):

    send_req(f"/order/{order_id}", method="GET")


def cancel_order(order_id):

    send_req(f"/order/{order_id}", method="DELETE")

def add_pizza(pizza_id, name, price,admin_token):

    payload = {
        "pizza_id" : pizza_id,
        "name" : name,
        "price" : price
    }

    send_req("/menu", method="POST", data=payload, admin_token=admin_token)


def delete_pizza(pizza_id, admin_token):

    send_req(f"/menu/{pizza_id}", method="DELETE", admin_token=admin_token)


def delete_order_admin(order_id, admin_token):

    send_req(f"/admin/order/{order_id}",method="DELETE", admin_token=admin_token)


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description="Pizza Ordering command line interface")

    parser.add_argument("role", choices=["customer", "admin"], help="Specify the role")
    parser.add_argument("request", choices=["list_menu", "create_order", "check_order_status", "cancel_order", "add_pizza", "delete_pizza", "delete_order_admin"], help="Request to send")

    parser.add_argument("--pizza_ids", type=str, help="Pizza IDs for creating order")
    parser.add_argument("--quantities", type=str, help="Quantities for creating_order")
    parser.add_argument("--user_id", type=int, help="User ID for creating_order")
    parser.add_argument("--order_id", type=int, help="Order ID for check_order_status OR to delete it in admin mode.")

    # admin args
    parser.add_argument("--pizza_id", type=int, help="Pizza ID for adding it to the menu")
    parser.add_argument("--name", type=str, help="Pizza name for add_pizza")
    parser.add_argument("--price", type=int, help="Pizza price for add_pizza")
    parser.add_argument("--admin_token", type=str, help="Admin token for authentication", required=False)

    args = parser.parse_args()
    

    if args.role == "customer":
        if args.request == "list_menu":
            list_menu()

        elif args.request == "create_order":
            if not args.pizza_ids:
                print("Pizza ID is required for creating an order")
                sys.exit(1)
            if not args.quantities:
                print("Quantity needed for creating an order")
                sys.exit(1)
            if not args.user_id:
                print("User ID needed for creating an order")
                sys.exit(1)

            create_order(args.pizza_ids, args.quantities, args.user_id)

        elif args.request == "check_order_status":
            if not args.order_id:
                print("Order ID needed for checking the status")
                sys.exit(1)
            
            check_order_status(args.order_id)

        elif args.request == "cancel_order":
            if not args.order_id:
                print("Order ID needed for canceling.")
                sys.exit(1)

            cancel_order(args.order_id)

    # admin functions
    elif args.role == "admin":
        if not args.admin_token:
            print("Admin token required for admin functions")
            sys.exit(1)

        if args.request == "add_pizza":

            if not args.name or not args.price or not args.pizza_id:
                print("Pizza information needed for adding it to the menu!")
                sys.exit(1)

            add_pizza(args.name, args.price, args.pizza_id, args.admin_token)

        elif args.request == "delete_pizza":

            if not args.pizza_id:
                print("Pizza ID is required for deleting it.")
                sys.exit(1)

            delete_pizza(args.pizza_id, args.admin_token)

        elif args.request == "delete_order_admin":

            if not args.order_id:
                print("Order ID required for deleting")
                sys.exit(1)

            delete_order_admin(args.order_id, args.admin_token)