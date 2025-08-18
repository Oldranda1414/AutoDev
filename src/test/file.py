import shutil
import os

def move_and_rename(src_path: str, dest_path: str, fallback_contents: str):
    os.makedirs(os.path.dirname(dest_path), exist_ok=True)
    try:
        shutil.move(src_path, dest_path)
    except FileNotFoundError:
        with open(dest_path, "x", encoding="utf-8") as f:
            f.write(fallback_contents)   

def add_line_to_file(file_path: str, additional_contents: str):
    # Ensure the added line ends with a newline
    if not additional_contents.endswith("\n"):
        additional_contents += "\n"
    
    # Open in append mode so we don't overwrite
    with open(file_path, "a", encoding="utf-8") as f:
        f.write(additional_contents)

def file_exists(path: str) -> bool:
    return os.path.exists(path)

def remove_dir(path: str):
    shutil.rmtree(path, ignore_errors=True)

def remove_file(path: str):
    if os.path.exists(path):
        os.remove(path)
