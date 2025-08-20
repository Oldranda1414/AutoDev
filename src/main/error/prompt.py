from error.auto_dev import AutoDevError
from os.path import abspath

class PromptPathError(AutoDevError):
    exit_code = 31

    def __init__(self, prompt_path: str):
        self.prompt_path = prompt_path

    def _build_message(self) -> tuple[str, ...]:
        return (
            f"Prompt path '{abspath(self.prompt_path)}' is not a valid prompt path.",
            "Provide a path of an existing json file."
        )
class MissingAttributesError(AutoDevError):
    exit_code = 32

    def __init__(self, prompt_path: str):
        self.prompt_path = prompt_path

    def _build_message(self) -> tuple[str, ...]:
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

    def _build_message(self) -> tuple[str, ...]:
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

