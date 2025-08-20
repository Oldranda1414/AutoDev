from error.auto_dev import AutoDevError

class ModelNameError(AutoDevError):
    exit_code = 41

    def __init__(self, model: str):
        self.model = model

    def _build_message(self) -> tuple[str, ...]:
        return (
            f"Model name '{self.model}' is not a valid model name.",
            "To see all valid model names run 'just run --list'."
        )
class ModelAlreadyInstalledError(AutoDevError):
    exit_code = 42

    def __init__(self, model: str):
        self.model = model

    def _build_message(self) -> tuple[str, ...]:
        return (
            f"Model {self.model} is already installed.",
            "To see all installed models run 'just run --list'."
        )

class ModelNotInstalledError(AutoDevError):
    exit_code = 43

    def __init__(self, model: str):
        self.model = model

    def _build_message(self) -> tuple[str, ...]:
        return (
            f"Model {self.model} is not installed.",
            "To see all installed models run 'just run --list'."
        )

