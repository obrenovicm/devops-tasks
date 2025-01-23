
class Order:

    def __init__(self, order_id, user_id, pizzas, quantity, status):
        self.order_id = order_id
        self.user_id = user_id
        self.pizzas = pizzas # list of pizza ids.
        self.quantity = quantity # list of quantities for each pizza.
        self.status = status # default status.
        self.total_price = 0

    def set_price(self, price):
        self.total_price = price

    def get_id(self):
        return self.order_id
    
    def get_status(self):
        return self.status

    def to_dict(self):
        return {
            "order_id" : self.order_id,
            "user_id" : self.user_id,
            "pizzas" : self.pizzas,
            "quanity" : self.quantity,
            "status" : self.status,
            "total_price" : self.total_price
        }