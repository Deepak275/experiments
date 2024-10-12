import os
from file import *
from directory import *

class FileSystem:
    def __init__(self, root):
        self.root = Directory(root)
    
    def create_file(self, path):
        file = File(path)
        file.write('')
    
    def create_directory(self, path):
        directory = Directory(path)
        directory.create()
    
    def list_files(self, path):
        directory = Directory(path)
        return directory.list_files()
    
    def insert_file(self, file_path, data):
        directory_path = os.path.dirname(file_path)
        directory = Directory(directory_path)
        directory.create()
        file = File(file_path)
        file.write(data)
    
    def view_dir(self, path):
        print(f"Listing contents of directory: {path}")
        files = self.list_files(path)
        for file_path in files:
            print(file_path)

if __name__ == '__main__':
    fs = FileSystem('.')
    file_path = './myfile.txt'
    data = 'Hello, world!'
    fs.insert_file(file_path, data)
    fs.view_dir('.')
    # Listing contents of directory: /path/to/root/directory
    # /path/to/root/directory/myfile.txt



     