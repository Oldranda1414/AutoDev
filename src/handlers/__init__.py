from configuration import add_config
from services import add_direnv
from output import cli_print, cli_print_error

def generate_config(project_path: str, model: str, prompt_path: str):
    try:
        cli_print("Generating config with " + model + " model.")
        # TODO add spinner until this is finished
        add_config(model, project_path, prompt_path)
        cli_print(
            "Config generated",
            "Run 'nix develop' to enter development enviroment."
        )
    except FileExistsError:
        cli_print_error("flake.nix file already present in project root.")
        cli_print_error("Delete the 'flake.nix' file or backup it then rerun Auto Dev.")
    except:
        cli_print_error("something went wrong")

def generate_direnv(project_path: str):
    try: 
        add_direnv(project_path)
        cli_print(
            ".envrc file created.",
            "Run 'direnv allow' in the project root directory to enable direnv.",
            "Don't know what direnv is? Check it out at https://direnv.net/."
        )
    except FileExistsError: 
        cli_print_error(
            ".envrc file already exists in project root directory.",
            "Add 'use flake' to .envrc file to load development enviroment on directory entry."
        )

def list_models():
    cli_print("called list models")

