from rich.console import Console
from enum import Enum

_initialized = False
_quiet = False
_console: Console = None

class PrintType(Enum):
    SUCCESS = 1
    ERROR = 2

def init(quiet: bool = False):
    global _quiet, _initialized, _console
    _quiet = quiet
    _initialized = True
    _console = Console()

def _require_init():
    if not _initialized:
        raise RuntimeError("Prompt.init() must be called before using this method.")

def cli_print(print_type: PrintType, *message: str):
    _require_init()
    if not _quiet:
        for line in message:
            if print_type == PrintType.SUCCESS:
                _console.print(f"[bold green] {line} [/bold green]")
            elif print_type == PrintType.ERROR:
                _console.print(f"[bold red] {line} [/bold red]")

def create_file(name: str, contents: str, path: str):
    complete_path: str
    if path:
        complete_path = path + "/" + name
    else:
        complete_path = name
    with open(complete_path, "x") as f:
        f.write(contents)

def get_spinner(message: str):
    return _console.status(f"[bold green] {message} [/bold green]")
