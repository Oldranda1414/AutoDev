from error.auto_dev import AutoDevError

class ExceededAttemptsError(AutoDevError):
    exit_code = 51

    def __init__(self, model: str, attempts: int):
        self.model = model
        self.attempts = attempts

    def build_message(self) -> tuple[str, ...]:
        return (
            f"Model {self.model} was unable to generate correct nix code in {self.attempts} attempts.",
            "Select another model or improve the provided prompt."
        )
class ModelTimeoutError(AutoDevError):
    exit_code = 52

    def __init__(self, model: str, request_timeout: int):
        self.model = model
        self.request_timeout = request_timeout

    def build_message(self) -> tuple[str, ...]:
        return (
            f"Model {self.model} was unable to generate a response in {self.request_timeout} seconds.",
            "Select another model or improve the provided prompt."
        )

