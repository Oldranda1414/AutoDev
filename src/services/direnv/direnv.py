from services.output import create_file

def add_direnv(project_path: str):
    envrc_name = ".envrc"
    envrc_contents = "use flake"

    create_file(envrc_name, envrc_contents, project_path)
