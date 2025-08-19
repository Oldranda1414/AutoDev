import sys
from enum import Enum
from services.configuration import ATTEMPTS

from services.output.console import cli_print, PrintType

class ErrorType(Enum):
    FLAKE_EXIST = 1
    INVALID_PROMPT_PATH = 2
    MISSING_ATTRIBUTES = 3
    INCORRECT_JSON_VALUES = 4
    OLLAMA_NOT_INSTALLED = 5
    EXEEDED_ATTEMPTS = 6
    ENVRC_EXIST = 7

def exit_success():
    sys.exit(0)

def exit_failure(type: ErrorType, project_path: str="", model: str="", prompt_path: str=""):
    message: tuple[str, ...] = ()
    if type == ErrorType.FLAKE_EXIST:
        message = (
            "flake.nix file already present in project root.",
            "Delete the 'flake.nix' file or backup it then rerun AutoDev."
        )
    elif type == ErrorType.INVALID_PROMPT_PATH:
        message = (
            f"Prompt path {prompt_path} is not a valid prompt path.",
            "Provide a path of an existing json file."
        )
    elif type == ErrorType.MISSING_ATTRIBUTES:
        message = (
            f"{prompt_path} does not define complete prompt definition",
            "The json file must contain the following keys",
            """
                {
                    "depth": <depth_level>,
                    "premise": <premise_prompt>,
                    "conclusion": <conclusion_prompt>,
                    "fsobject": <file_system_object_prompt>
                }
            """
        )
    elif type == ErrorType.INCORRECT_JSON_VALUES:
        message = (
            f"{prompt_path} does not define correct values",
            "The json file must contain the following keys with indicated values",
            """
                {
                    "depth": <integer>,
                    "premise": <string>,
                    "conclusion": <string>,
                    "fsobject": <string>
                }
            """
        )
    elif type == ErrorType.OLLAMA_NOT_INSTALLED:
        message = (
            f"Ollama does not seem to be installed on the system.",
            "Run 'nix develop' to enter development shell and install ollama temporarily",
            "or visit https://ollama.com/ to checkout how to install ollama permanently on your system."
        )
    elif type == ErrorType.EXEEDED_ATTEMPTS:
        message = (
            f"Model {model} is unable to generate correct nix code in {ATTEMPTS} attempts.",
            "Select another model or improve the provided prompt."
        )
    elif type == ErrorType.ENVRC_EXIST:
        message = (
            ".envrc file already exists in project root directory.",
            "Add 'use flake' to .envrc file to load development enviroment on directory entry."
        )

    cli_print(PrintType.ERROR, *message)
    sys.exit(int(type.value))
