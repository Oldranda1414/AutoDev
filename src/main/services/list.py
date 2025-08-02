from services.output.console import print_table
from llm.model import model_names
from llm.server import is_model_installed, start_server
from utils.table import Table

TRUE_ITEM = "[bold green] Yes [/bold green]"
FALSE_ITEM = "[bold red] No [/bold red]"

def list():
    start_server()
    table = Table(["Model", "Installed"])
    for model_name in model_names:
        installed = TRUE_ITEM if is_model_installed(model_name) else FALSE_ITEM
        table.add_row([model_name, installed])
    print_table(table)

