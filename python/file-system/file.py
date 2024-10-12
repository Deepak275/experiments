import os
class File:
    def __init__(self, path):
        self.path = path
    
    def write(self, data):
        with open(self.path, 'w') as f:
            f.write(data)
    
    def read(self):
        with open(self.path, 'r') as f:
            return f.read()