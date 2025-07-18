from subprocess import run
from os.path import isdir, join

from services.generator import generate_config
from services.output import PrintType, cli_print, create_file

def add_config(model: str, project_path: str, prompt_path: str):
    contents = generate_config(model, project_path, prompt_path)
    create_file("flake.nix", contents, project_path)
    if _is_git_repo(project_path):
        cli_print(PrintType.SUCCESS, "Detected that project is in a git repository")
        cli_print(PrintType.SUCCESS, "Adding flake.nix to git repository")
        _add_to_git(project_path)

def _is_git_repo(project_path: str):
    return isdir(join(project_path, ".git"))

def _add_to_git(project_dir: str):
    command = "git add flake.nix"
    run(command, shell=True, cwd=project_dir)

