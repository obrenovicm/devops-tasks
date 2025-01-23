from flask import Flask
from flask import request
from flask import jsonify
from flask_httpauth import HTTPTokenAuth

from models.order import Order
from models.pizza import Pizza
from models.user import User

import os
from dotenv import load_dotenv
import random

app = Flask(__name__)
auth = HTTPTokenAuth(scheme='Bearer')

pizza_menu = [
    Pizza(1, "Capricciosa", 8),
    Pizza(2, "Napolitana", 10),
    Pizza(3, "Quattro staggioni", 12),
    Pizza(4, "Quattro formaggi", 12)
]

load_dotenv()
admin_token = os.getenv("ADMIN_TOKEN")


orders = []
users = []
statuses = ["ready_to_be_delivered", "not_ready_to_be_delivered"]

# helper funcs
def get_pizza_by_id(id):
    for pizza in pizza_menu:
        if pizza.get_pizza_id() == id:
            return pizza
    return None

def get_pizza_price(id):
    for pizza in pizza_menu:
        if pizza.get_pizza_id() == id:
            return pizza.pizza_price()
    return 0

def get_order_by_id(id):
    for order in orders:
        if order.get_id() == id:
            return order
        
    return None


@auth.verify_token
def verify_token(token):
    return token if token == admin_token else None


@app.route('/')
def welcome_page():
    return "hello!"



@app.route('/menu', methods=['GET'])
def list_menu():
    return jsonify([pizza.to_dict() for pizza in pizza_menu])

@app.route('/order', methods=['POST'])
def create_order():

    data = request.json
    user_id = data['user_id']
    pizzas = data['pizzas'] # list of pizza ids to order
    quantity = data['quantity']

    for pizza_id in pizzas:
        if not get_pizza_by_id(pizza_id):
            return jsonify({"error" : f"Pizza with ID {pizza_id} does not exist in the menu."})
    
    order_id = len(orders) + 1

    total_price = 0
    for i in range(len(quantity)):
        total_price += quantity[i] * get_pizza_price(pizzas[i])

    status = random.choice(statuses)

    order = Order(order_id=order_id, user_id=user_id, pizzas=pizzas, quantity=quantity, status=status)
    order.set_price(total_price)
    orders.append(order)

    return jsonify(order.to_dict()), 201

@app.route('/order/<int:order_id>', methods=['GET'])
def check_order_status(order_id):
    
    order = get_order_by_id(order_id)
    if not order:
        return jsonify({"error" : f"Order with id {order_id} does not exist!"})
    
    return jsonify({"order_status" : order.get_status()})

@app.route('/admin/order/<int:order_id>', methods=['DELETE'])
@auth.login_required
def delete_order_admin(order_id):

    order = get_order_by_id(order_id)

    try:
        orders.remove(order)
    except ValueError:
        return jsonify({"error" : "Order not found in the list, cannot remove."}), 400
    
    return jsonify({"msg" : "Successfully removed order from the list."}), 200


@app.route('/order/<int:order_id>', methods=['DELETE'])
def cancel_order(order_id):

    order = get_order_by_id(order_id)
    if not order:
        return jsonify({"error" : f"Order with id {order_id} does not exist!"})
    
    if order.get_status() == "ready_to_be_delivered":
        return jsonify({"error" : f"Not deleting this order {order_id} since it's ready to be delivered"})
    
    try:
        orders.remove(order)

    except ValueError:
        return jsonify({"error" : "Order not found in the list, cannot delete."}), 400

    
    return jsonify({"msg" : f"Successfully deleted order {order_id}"}), 200


# admin functions
@app.route('/menu', methods=['POST'])
@auth.login_required
def add_pizza():

    data = request.json
    pizza_id = data['pizza_id']
    name = data['name']
    price = data['price']

    pizza = Pizza(id=pizza_id, name=name, price=price)

    if pizza is None:
        return jsonify({"error" : "Unable to create pizza"}), 404
    
    pizza_menu.append(pizza)
    
    return jsonify({"msg" : "successfully added pizza to menu. "}, 201)

@app.route('/menu/<int:pizza_id>', methods=['DELETE'])
@auth.login_required
def delete_pizza(pizza_id):

    pizza = get_pizza_by_id(pizza_id)

    try:
        pizza_menu.remove(pizza)
    except ValueError:
        return jsonify({"error" : "pizza unsuccessfully removed"}), 401
    
    return jsonify({"msg" : "successfully removed pizza from menu."}), 200



if __name__ == '__main__':
    app.run(debug=True)