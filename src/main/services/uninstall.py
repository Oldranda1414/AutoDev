from errors import ModelNameError, ModelNotInstalledError
from llm.server import is_model_installed, uninstall_model, start_server
from llm.model import model_names

def uninstall(model_name: str):
    start_server()
    if not model_name in model_names:
        raise ModelNameError
    if not is_model_installed(model_name):
        raise ModelNotInstalledError
    start_server()
    uninstall_model(model_name)
