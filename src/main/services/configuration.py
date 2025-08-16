from subprocess import run
from os.path import isdir, join

from llm.model import Model
from services.check import check_flake
from services.generator import generate_config
from services.output.console import PrintType, cli_print
from services.output.file import create_file, write_file
from errors import ExeededAttemptsError

ATTEMPTS = 3

def add_config(model_name: str, project_path: str, prompt_path: str):
    model = Model(model_name)
    contents = generate_config(model, project_path, prompt_path)
    create_file("flake.nix", contents, project_path)
    if _is_git_repo(project_path):
        cli_print(PrintType.SUCCESS, "Detected that project is in a git repository")
        cli_print(PrintType.SUCCESS, "Adding flake.nix to git repository")
        _add_to_git(project_path)
    check_result = check_flake(project_path)
    current_attempts = 0
    while not check_result.outcome:
        if current_attempts == ATTEMPTS:
            raise ExeededAttemptsError(f"After {ATTEMPTS} attempts the model was unable to generate working nix code")
        new_contents = model.ask(_get_fix_prompt(check_result.error))
        write_file("flake.nix", new_contents, project_path)
        check_result = check_flake(project_path)
        current_attempts = current_attempts + 1

def _is_git_repo(project_path: str):
    return isdir(join(project_path, ".git"))

def _add_to_git(project_dir: str):
    command = "git add flake.nix"
    run(command, shell=True, cwd=project_dir)

def _get_fix_prompt(error: str) -> str:
    return f"""
By running `nix flake check` the following error has occurred:

{error}

Update the code provided to solve this error
"""

