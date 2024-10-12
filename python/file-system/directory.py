import os

class Directory:
  def __init__(self, path):
    self.path = path
  
  def create(self):
    os.makedirs(self.path, exist_ok=True)
  
  def list_files(self):
    files = []
    for dirpath, dirnames, filenames in os.walk(self.path):
      for filename in filenames:
        files.append(os.path.join(dirpath, filename))
    return files
