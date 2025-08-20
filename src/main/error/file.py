from error.auto_dev import AutoDevError
from os.path import abspath

class FlakeExistsError(AutoDevError):
    exit_code = 21

    def __init__(self, project_path: str):
        self.project_path=project_path

    def _build_message(self) -> tuple[str, ...]:
        return (
            f"flake.nix file already present in project root '{abspath(self.project_path)}'.",
            "Remove or backup the existing 'flake.nix' file and try again."
        )
class EnvrcExistsError(AutoDevError):
    exit_code = 22

    def __init__(self, project_path: str):
        self.project_path = project_path

    def _build_message(self) -> tuple[str, ...]:
        return (
            f".envrc file already exists in project root '{abspath(self.project_path)}'.",
            "Add 'use flake' to .envrc file to load development environment on directory entry."
        )

