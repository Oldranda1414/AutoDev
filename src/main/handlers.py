from services.configuration import add_config
from services.direnv import add_direnv
from services.install import install
from services.uninstall import uninstall
from services.list import list
from services.output.console import cli_print, PrintType, get_spinner, print_model_name_error
from errors import ExeededAttemptsError, JsonValueTypeError, ModelAlreadyInstalledError, ModelNotInstalledError, OllamaNotInstalledError, PromptPathError, ModelNameError, MissingAttributesError, ModelNotInstalledError
from termination import exit_success, exit_failure, ErrorType

# TODO handle timeout error litellm.Timeout
# TODO translate all errors to new way

def generate_config(project_path: str, model: str, prompt_path: str):
    try:
        with get_spinner("Generating config..."):
            add_config(model, project_path, prompt_path)
        cli_print(PrintType.SUCCESS,
            "Config generated!",
            "Run 'nix develop' in project root to enter development enviroment."
        )
        exit_success()
    except ModelNotInstalledError:
        cli_print(PrintType.SUCCESS,
            f"{model} model is not installed yet."
        )
        install_model(model)
        generate_config(project_path, model, prompt_path)
    except FileExistsError:
        exit_failure(ErrorType.FLAKE_EXIST, project_path, model, prompt_path)
    except ModelNameError:
        print_model_name_error(model)
    except PromptPathError:
        exit_failure(ErrorType.INVALID_PROMPT_PATH, project_path, model, prompt_path)
    except MissingAttributesError:
        exit_failure(ErrorType.MISSING_ATTRIBUTES, project_path, model, prompt_path)
    except JsonValueTypeError:
        exit_failure(ErrorType.INCORRECT_JSON_VALUES, project_path, model, prompt_path)
    except OllamaNotInstalledError:
        exit_failure(ErrorType.OLLAMA_NOT_INSTALLED, project_path, model, prompt_path)
    except ExeededAttemptsError:
        exit_failure(ErrorType.EXEEDED_ATTEMPTS, project_path, model, prompt_path)

def generate_direnv(project_path: str):
    try: 
        add_direnv(project_path)
        cli_print(PrintType.SUCCESS,
            ".envrc file created.",
            "Run 'direnv allow' in the project root directory to enable direnv.",
            "Don't know what direnv is? Check it out at https://direnv.net/."
        )
        exit_success()
    except FileExistsError: 
        exit_failure(ErrorType.ENVRC_EXIST, project_path=project_path)

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

