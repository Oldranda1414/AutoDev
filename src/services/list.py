from output import cli_print
from model import model_names

def list():
    # TODO make this print better
    cli_print("printing model names")
    for name in model_names:
        cli_print(f"name {name}")
