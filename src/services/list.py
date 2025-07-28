from services.output import PrintType, cli_print
from llm.model import model_names
from llm.server import is_model_installed, start_server

def list():
    # TODO make this print better
    start_server()
    cli_print(PrintType.SUCCESS, "printing model names")
    for name in model_names:
        cli_print(PrintType.SUCCESS, f"name {name}, installed {is_model_installed(name)}")
