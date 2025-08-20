import sys
from services.output.console import cli_print, PrintType
from errors import AutoDevError

def exit_success():
    sys.exit(0)

def handle_exception(exc: AutoDevError):
    message = exc._build_message()
    cli_print(PrintType.ERROR, *message)
    sys.exit(exc.exit_code)

