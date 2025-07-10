from output import PrintType, cli_print
from model import model_names

def list():
    # TODO make this print better
    cli_print(PrintType.SUCCESS, "printing model names")
    for name in model_names:
        cli_print(PrintType.SUCCESS, f"name {name}")
