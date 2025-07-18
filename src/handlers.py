from services.configuration import add_config
from services.direnv import add_direnv
from services.list import list
from services.output import cli_print, PrintType, get_spinner
from errors import JsonValueTypeError, OllamaNotInstalledError, PromptPathError, ModelNameError, MissingAttributesError

def generate_config(project_path: str, model: str, prompt_path: str):
    try:
        cli_print(PrintType.SUCCESS,
            "Generating config with " + model + " model."
        )
        with get_spinner("generating config"):
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
    except ModelNameError:
        cli_print(PrintType.ERROR,
            f"Model name {{model}} is not a valid model name.",
            "To see all valid model names run 'just run --list'."
        )
    except PromptPathError:
        cli_print(PrintType.ERROR,
            f"Prompt path {prompt_path} is not a valid prompt path.",
            "Provide a path of an existing json file."
        )
    except MissingAttributesError:
        cli_print(PrintType.ERROR,
            f"{prompt_path} does not define complete prompt definition",
            "The json file must contain the following keys"
            """
                {
                    "depth": <depth_level>,
                    "premise": <premise_prompt>,
                    "conclusion": <conclusion_prompt>,
                    "fsobject": <file_system_object_prompt>
                }
            """
        )
    except JsonValueTypeError:
        cli_print(PrintType.ERROR,
            f"{prompt_path} does not define correct values",
            "The json file must contain the following keys with indicated values"
            """
                {
                    "depth": <integer>,
                    "premise": <string>,
                    "conclusion": <string>,
                    "fsobject": <string>
                }
            """
        )
    except OllamaNotInstalledError:
        cli_print(PrintType.ERROR,
            f"Ollama does not seem to be installed on the system.",
            "Run 'nix develop' to enter development shell and install ollama temporarily",
            "or visit https://ollama.com/ to checkout how to install ollama permanently on your system."
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

