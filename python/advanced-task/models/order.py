import uuid

class Order:

    def __init__(self, user_id, pizzas, quantity):
        self.order_id = str(uuid.uuid4())
        self.user_id = user_id
        self.pizzas = pizzas # list of pizza ids.
        self.quantity = quantity
        self.status = "pending" # default status
