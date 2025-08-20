from abc import abstractmethod
from os.path import abspath


ErrorMessageBuilder = tuple[str, ...]

class AutoDevError(Exception):
    """Base exception for all AutoDev errors."""

    exit_code: int
    message_builder: ErrorMessageBuilder

    def __init__(self):
        super().__init__(self._build_message())

    @abstractmethod
    def _build_message(self) -> ErrorMessageBuilder:
        """Build the error message. Must be implemented by subclasses."""
        pass

class OllamaNotInstalledError(AutoDevError):
    exit_code = 11

    def __init__(self):
        super().__init__()

    def _build_message(self) -> ErrorMessageBuilder:
        return (
            "Ollama does not seem to be installed on the system.",
            "Run 'nix develop' to enter development shell and install ollama temporarily or visit https://ollama.com/ to checkout how to install ollama permanently on your system."
        )

# File already exists errors
class FlakeExistsError(AutoDevError):
    exit_code = 21

    def __init__(self, project_path: str):
        self.project_path=project_path

    def _build_message(self) -> ErrorMessageBuilder:
        return (
            f"flake.nix file already present in project root '{abspath(self.project_path)}'.",
            "Remove or backup the existing 'flake.nix' file and try again."
        )
class EnvrcExistsError(AutoDevError):
    exit_code = 22

    def __init__(self, project_path: str):
        self.project_path = project_path

    def _build_message(self) -> ErrorMessageBuilder:
        return (
            f".envrc file already exists in project root '{abspath(self.project_path)}'.",
            "Add 'use flake' to .envrc file to load development environment on directory entry."
        )
# Custom prompt errors
class PromptPathError(AutoDevError):
    exit_code = 31

    def __init__(self, prompt_path: str):
        self.prompt_path = prompt_path

    def _build_message(self) -> ErrorMessageBuilder:
        return (
            f"Prompt path '{abspath(self.prompt_path)}' is not a valid prompt path.",
            "Provide a path of an existing json file."
        )
class MissingAttributesError(AutoDevError):
    exit_code = 32

    def __init__(self, prompt_path: str):
        self.prompt_path = prompt_path

    def _build_message(self) -> ErrorMessageBuilder:
        return (
            f"Prompt file at '{abspath(self.prompt_path)}' does not define complete prompt definition",
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
class JsonValueTypeError(AutoDevError):
    exit_code = 33

    def __init__(self, prompt_path: str):
        self.prompt_path = prompt_path

    def _build_message(self) -> ErrorMessageBuilder:
        return (
            f"Prompt file at '{abspath(self.prompt_path)}' does not define correct values",
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
# Model errors
class ModelNameError(AutoDevError):
    exit_code = 41

    def __init__(self, model: str):
        self.model = model

    def _build_message(self) -> ErrorMessageBuilder:
        return (
            f"Model name '{self.model}' is not a valid model name.",
            "To see all valid model names run 'just run --list'."
        )
class ModelAlreadyInstalledError(AutoDevError):
    exit_code = 42

    def __init__(self, model: str):
        self.model = model

    def _build_message(self) -> ErrorMessageBuilder:
        return (
            f"Model {self.model} is already installed.",
            "To see all installed models run 'just run --list'."
        )

class ModelNotInstalledError(AutoDevError):
    exit_code = 43

    def __init__(self, model: str):
        self.model = model

    def _build_message(self) -> ErrorMessageBuilder:
        return (
            f"Model {self.model} is not installed.",
            "To see all installed models run 'just run --list'."
        )
# Generation errors
class ExceededAttemptsError(AutoDevError):
    exit_code = 51

    def __init__(self, model: str, attempts: int):
        self.model = model
        self.attempts = attempts

    def _build_message(self) -> ErrorMessageBuilder:
        return (
            f"Model {self.model} was unable to generate correct nix code in {self.attempts} attempts.",
            "Select another model or improve the provided prompt."
        )
class ModelTimeoutError(AutoDevError):
    exit_code = 52

    def __init__(self, model: str, request_timeout: int):
        self.model = model
        self.request_timeout = request_timeout

    def _build_message(self) -> ErrorMessageBuilder:
        return (
            f"Model {self.model} was unable to generate a response in {self.request_timeout} seconds.",
            "Select another model or improve the provided prompt."
        )

