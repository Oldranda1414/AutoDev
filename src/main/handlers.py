from services.configuration import add_config
from services.direnv import add_direnv
from services.install import install
from services.uninstall import uninstall
from services.list import list
from services.output.console import cli_print, PrintType, get_spinner

from errors import AutoDevError, ModelNotInstalledError
from termination import exit_success, handle_exception

def generate_config(project_path: str, model: str, prompt_path: str):
    with get_spinner("Generating config..."):
        try:
            add_config(model, project_path, prompt_path)
        except ModelNotInstalledError:
            cli_print(PrintType.WARNING, f"{model} model is not installed yet.")
            install_model(model)
            generate_config(project_path, model, prompt_path)
        except AutoDevError as exception:
            handle_exception(exception)
    cli_print(PrintType.SUCCESS,
        "Config generated!",
        "Run 'nix develop' in project root to enter development enviroment."
    )
    exit_success()

def generate_direnv(project_path: str):
    try: 
        add_direnv(project_path)
        cli_print(PrintType.SUCCESS,
            ".envrc file created.",
            "Run 'direnv allow' in the project root directory to enable direnv.",
            "Don't know what direnv is? Check it out at https://direnv.net/."
        )
        exit_success()
    except AutoDevError as exception:
        handle_exception(exception)

def install_model(model: str):
    with get_spinner(f"Installing {model} model..."):
        try:
            install(model)
        except AutoDevError as exception:
            handle_exception(exception)
    cli_print(PrintType.SUCCESS, f"{model} model installed.")
    exit_success()

def uninstall_model(model: str):
    with get_spinner(f"Uninstalling {model} model..."):
        try:
            uninstall(model)
        except AutoDevError as exception:
            handle_exception(exception)
    cli_print(PrintType.SUCCESS, f"{model} model uninstalled.")
    exit_success()

def list_models():
    list()
    exit_success()

