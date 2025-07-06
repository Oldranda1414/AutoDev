from services import add_direnv
from output import cli_print

def generateConfig(project_path: str, model: str, prompt_path: str):
    print("generate config called")

def generateDirenv(project_path: str):
    add_direnv(project_path)
    cli_print(
        ".envrc file created.",
        "Run 'direnv allow' to enable direnv for this project",
        "Don't know what direnv is? Check it out at https://direnv.net/"
    )
