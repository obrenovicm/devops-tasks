import uuid

class User:
    
    def __init__(self, username):
        self.user_id = str(uuid.uuid4())
        self.username = username