from flask import Flask
from flask import request
from flask import jsonify

from models.order import Order
from models.pizza import Pizza
from models.user import User


app = Flask(__name__)

pizza_menu = [
    Pizza(1, "Capricciosa", 8),
    Pizza(2, "Napolitana", 10),
    Pizza(3, "Quattro staggioni", 12),
    Pizza(4, "Quattro formaggi", 12)
]

orders = []
users = []

# helper funcs
def get_pizza_by_id(id):
    for pizza in pizza_menu:
        if pizza['pizza_id'] == id:
            return pizza
    return None

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
        
    order = Order(user_id=user_id, pizzas=pizzas, quantity=quantity)
    orders.append(order)

    return jsonify({"order_id" : order.order_id, "status" : order.status}), 201

if __name__ == '__main__':
    app.run(debug=True)