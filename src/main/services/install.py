from llm.server import start_server, install_model, is_model_installed
from llm.model import model_names
from errors import ModelAlreadyInstalledError, ModelNameError

def install(model_name: str):
    start_server()
    if not model_name in model_names:
        raise ModelNameError
    if is_model_installed(model_name):
        raise ModelAlreadyInstalledError
    install_model(model_name)
