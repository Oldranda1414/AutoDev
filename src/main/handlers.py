from services.configuration import add_config, ATTEMPTS
from services.direnv import add_direnv
from services.install import install
from services.uninstall import uninstall
from services.list import list
from services.output.console import cli_print, PrintType, get_spinner, print_model_name_error
from errors import ExeededAttemptsError, JsonValueTypeError, ModelAlreadyInstalledError, ModelNotInstalledError, OllamaNotInstalledError, PromptPathError, ModelNameError, MissingAttributesError, ModelNotInstalledError

# TODO handle timeout error litellm.Timeout

def generate_config(project_path: str, model: str, prompt_path: str):
    try:
        with get_spinner("Generating config..."):
            add_config(model, project_path, prompt_path)
        cli_print(PrintType.SUCCESS,
            "Config generated!",
            "Run 'nix develop' in project root to enter development enviroment."
        )
    except FileExistsError:
        cli_print(PrintType.ERROR,
            "flake.nix file already present in project root.",
            "Delete the 'flake.nix' file or backup it then rerun AutoDev."
        )
    except ModelNameError:
        print_model_name_error(model)
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
    except ExeededAttemptsError:
        cli_print(PrintType.ERROR,
            f"Model {model} is unable to generate correct nix code in {ATTEMPTS} attempts.",
            "Select another model or improve the provided prompt."
        )
    except ModelNotInstalledError:
        cli_print(PrintType.SUCCESS,
            f"{model} model is not installed yet."
        )
        install_model(model)
        generate_config(project_path, model, prompt_path)

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

def install_model(model: str):
    with get_spinner(f"Installing {model} model..."):
        try:
            install(model)
            cli_print(PrintType.SUCCESS,
                f"{model} model installed."
            )
        except ModelNameError:
            print_model_name_error(model)
        except ModelAlreadyInstalledError:
            cli_print(PrintType.ERROR,
                f"{model} model is already installed.",
                "To see all installed models run 'autodev --list'."
            )

def uninstall_model(model: str):
    with get_spinner(f"Uninstalling {model} model..."):
        try:
            uninstall(model)
            cli_print(PrintType.SUCCESS,
                f"{model} model uninstalled."
            )
        except ModelNameError:
            print_model_name_error(model)
        except ModelNotInstalledError:
            cli_print(PrintType.ERROR,
                f"{model} model is not installed.",
                "To see all installed models run 'autodev --list'."
            )

def list_models():
    list()

