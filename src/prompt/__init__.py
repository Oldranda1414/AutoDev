def get_prompt(prompt_path: str, project_path: str) -> str:
    extension = prompt_path.split(".")[-1]
    if not extension == "json":
        raise ValueError("prompt_path must be a json type file path") 
    # TODO implement this
    return "example prompt"
