from services import add_direnv

def generateConfig(project_path: str, model: str, prompt_path: str, quiet: bool):
    print("generate config called")

def generateDirenv(project_path: str, quiet: bool):
    add_direnv(project_path)
    if not quiet:
        print(".envrc file created.")
        print("Run 'direnv allow' to enable direnv for this project")
        print("Don't know what direnv is? Check it out at https://direnv.net/")
