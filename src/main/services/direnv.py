from error.file import EnvrcExistsError
from services.output.file import create_file, file_exists

def add_direnv(project_path: str):
    envrc_name = ".envrc"
    envrc_contents = "use flake"
    if file_exists(f"{project_path}/{envrc_name}"):
        raise EnvrcExistsError(project_path)
    create_file(envrc_name, envrc_contents, project_path)
