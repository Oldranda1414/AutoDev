import os

def get_prompt(prompt_path: str, project_path: str) -> str:
    if prompt_path:
        extension = prompt_path.split(".")[-1]
        if not extension == "json":
            raise ValueError("prompt_path must be a json type file path") 
        if not os.path.exists(prompt_path):
            raise ValueError("prompt_path provided must lead to an existing file") 
    # TODO implement this
    return "example prompt"
