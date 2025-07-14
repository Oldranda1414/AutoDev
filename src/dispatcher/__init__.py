from typing import Dict
from handlers import generate_config, generate_direnv, list_models
from services.output import init

def dispatch(args: Dict[str, str]):
    project_path = args["PATH-TO-PROJECT"]
    prompt_path = args["--prompt"]
    quiet = bool(args["--quiet"])
    direnv = args["--direnv"]
    model_name = args["--model"]
    list_mode = args["--list"]

    if list_mode:
        init()
        list_models()
    else:
        init(quiet)
        generate_config(project_path, model_name, prompt_path)
        if direnv:
            generate_direnv(project_path)
