import uuid

class Pizza():
    def __init__(self, id, name, price):
        self.pizza_id = id
        self.name = name
        self.price = price

    def to_dict(self):
        return  {
            'pizza_id' : self.pizza_id,
            'name' : self.name,
            'price' : self.price
        }