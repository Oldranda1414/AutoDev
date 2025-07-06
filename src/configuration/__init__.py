from generator import generate_config
from output import create_file

def add_config(model: str, project_path: str, prompt_path: str):
    contents = generate_config(model, project_path, prompt_path)
    create_file("flake.nix", contents, project_path)
