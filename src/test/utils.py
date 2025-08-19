from datetime import datetime
from path import SPACES_PATH, RESULTS_FILE, result_path
from file import add_line_to_file, move_and_rename, file_exists

def now() -> str:
    return datetime.today().strftime('%Y-%m-%d %H:%M:%S')

def save_result(category: str, model: str, space: str, result: bool):
    update_results(f"--{now()}-- category {category} model {model} space {space} : {result}")
    move_and_rename(f"{SPACES_PATH}/{space}/flake.nix", result_path(space, model, category), "file was not generated")

def is_done(space: str, model: str, category: str) -> bool:
    return file_exists(result_path(space, model, category))

def update_results(*contents: str):
    for line in contents:
        add_line_to_file(RESULTS_FILE, line)


