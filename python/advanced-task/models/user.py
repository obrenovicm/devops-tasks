
class User:
    
    def __init__(self, user_id, username):
        self.user_id = user_id
        self.username = username

    
    def get_user_id(self):
        return self.user_id