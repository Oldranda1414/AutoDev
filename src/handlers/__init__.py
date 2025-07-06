from services import add_direnv
from output import cli_print, cli_print_error

def generateConfig(project_path: str, model: str, prompt_path: str):
    print("generate config called")

def generateDirenv(project_path: str):
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
