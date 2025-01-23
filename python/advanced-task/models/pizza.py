
class Pizza():

    def __init__(self, id, name, price):
        self.pizza_id = id
        self.name = name
        self.price = price

    def get_pizza_id(self):
        return self.pizza_id
    
    def pizza_name(self):
        return self.name
    
    def pizza_price(self):
        return self.price

    def to_dict(self):
        return  {
            'pizza_id' : self.pizza_id,
            'name' : self.name,
            'price' : self.price
        }