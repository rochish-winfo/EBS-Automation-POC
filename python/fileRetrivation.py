import os 
from robot.api.deco import keyword

@keyword
def get_all_files_from_path(path):
    return os.listdir(path)