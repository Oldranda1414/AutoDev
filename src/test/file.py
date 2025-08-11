import shutil
import os

def move_and_rename(src_path: str, dest_path: str, fallback_contents: str):
    os.makedirs(os.path.dirname(dest_path), exist_ok=True)
    try:
        shutil.move(src_path, dest_path)
    except FileNotFoundError:
        with open(dest_path, "x", encoding="utf-8") as f:
            f.write(fallback_contents)   
