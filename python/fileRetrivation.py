import glob
import os
import time
from robot.api.deco import keyword
import pathlib
import shutil



@keyword
def get_all_files_from_path(path, literal):
    # paths = sorted(Path(path).iterdir(), key=os.path.getmtime)
    # files = os.listdir(path)
    
    files = [file for file in os.listdir(path) if (file.lower().endswith('.jpg') and file.upper().startswith(str(literal))) ]
    files.sort(key=lambda f : int(f.split('_')[1]))
    # toRemove = []
    # for file in files :
    #     # temp = file.split(".")
    #     # if len(temp) == 1 or  temp[-1] != "jpg" or temp[0][0].lower() != f"{literal}":
    #     if int(file[0]) == int(literal):
    #         toRemove.append(file)
    # for file in toRemove:
    #     files.remove(file)

    return files

# print(get_all_files_from_path("C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\P2PTestTemplate",4))

@keyword
def move_dir(path, literal):
    toMove = 'C:\\WATS\\Screenshot\\WATS\\' + path.split('\\')[-1]
    if not os.path.isdir(toMove):
        pathlib.Path(toMove).mkdir(parents=True, exist_ok=True)
    files = [file for file in os.listdir(path) if (file.lower().endswith('.jpg') and file.upper().startswith(str(literal))) ]
    files.sort(key=lambda f : int(f.split('_')[1]))
    for file in files:
        shutil.copy2(path + '\\' + file, toMove)
        
