from enum import Enum
from contextlib import nullcontext

from rich.console import Console
from rich.table import Table as RichTable

from utils.table import Table

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

def get_spinner(message: str):
    _require_init()
    if _quiet:
        return nullcontext()
    return _console.status(f"[bold green] {message} [/bold green]")

def print_table(table: Table):

    rich_table = RichTable(show_header=True, header_style="bold magenta")
    for header in table.headers:
        rich_table.add_column(header)
    for row in table.rows:
        rich_table.add_row(
            *row
        )

    _console.print(rich_table)

def print_model_name_error(model: str):
    cli_print(PrintType.ERROR,
        f"Model name '{model}' is not a valid model name.",
        "To see all valid model names run 'autodev --list'."
    )

