from typing import Dict
from handlers import generate_config, generate_direnv, install_model, list_models, uninstall_model
from services.output import init

def dispatch(args: Dict[str, str]):
    project_path = args["PATH-TO-PROJECT"]
    prompt_path = args["--prompt"]
    quiet = bool(args["--quiet"])
    direnv = args["--direnv"]
    model_name = args["--model"]

    list_mode = args["--list"]
    install_mode = args["--install"]
    uninstall_mode = args["--uninstall"]

    if list_mode:
        init()
        list_models()
    elif install_mode:
        init(quiet)
        install_model(install_mode)
    elif uninstall_mode:
        init(quiet)
        uninstall_model(uninstall_mode)
    else:
        init(quiet)
        generate_config(project_path, model_name, prompt_path)
        if direnv:
            generate_direnv(project_path)
