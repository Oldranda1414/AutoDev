from configuration import add_config
from services import add_direnv, list
from output import cli_print, PrintType

def generate_config(project_path: str, model: str, prompt_path: str):
    try:
        cli_print(PrintType.SUCCESS,
            "Generating config with " + model + " model."
        )
        # TODO add spinner until this is finished
        add_config(model, project_path, prompt_path)
        cli_print(PrintType.SUCCESS,
            "Config generated.",
            "Run 'nix develop' in project root to enter development enviroment."
        )
    except FileExistsError:
        cli_print(PrintType.ERROR,
                  "flake.nix file already present in project root.",
                  "Delete the 'flake.nix' file or backup it then rerun AutoDev."
                  )
    except ValueError:
        cli_print(PrintType.ERROR,
            f"Model name {{model}} is not a valid model name",
            "To see all valid model names run 'ad --list"
        )

def generate_direnv(project_path: str):
    try: 
        add_direnv(project_path)
        cli_print(PrintType.SUCCESS,
            ".envrc file created.",
            "Run 'direnv allow' in the project root directory to enable direnv.",
            "Don't know what direnv is? Check it out at https://direnv.net/."
        )
    except FileExistsError: 
        cli_print(PrintType.ERROR,
            ".envrc file already exists in project root directory.",
            "Add 'use flake' to .envrc file to load development enviroment on directory entry."
        )

def list_models():
    list()

