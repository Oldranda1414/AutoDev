from typing import Dict
from handlers import generateConfig, generateDirenv
from output import init

def dispatch(args: Dict[str, str]):
    project_path = args["PATH-TO-PROJECT"]
    prompt_path = args["--prompt"]
    quiet = bool(args["--quiet"])
    generate_direnv = args["--direnv"]
    model_name = args["--model"]

    init(quiet)

    generateConfig(project_path, model_name, prompt_path)
    if generate_direnv:
        generateDirenv(project_path)
