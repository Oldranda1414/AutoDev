from errors import ModelNameError, ModelNotInstalledError
from llm.server import is_model_installed, uninstall_model
from llm.model import model_names

def uninstall(model_name: str):
    if not model_name in model_names:
        raise ModelNameError(model_name)
    if not is_model_installed(model_name):
        raise ModelNotInstalledError(model_name)
    uninstall_model(model_name)
