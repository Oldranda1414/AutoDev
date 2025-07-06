from typing import Dict
from handlers import generateConfig, generateDirenv

def dispatch(args: Dict[str, str]):
    project_path = args["PATH-TO-PROJECT"]
    prompt_path = args["--prompt"]
    quiet = bool(args["--quiet"])
    generate_direnv = args["--direnv"]
    model_name = args["--model"]

    generateConfig(project_path, model_name, prompt_path, quiet)
    if generate_direnv:
        generateDirenv(project_path, quiet)
