from llm.server import install_model, is_model_installed
from llm.model import model_names
from error.model import ModelAlreadyInstalledError, ModelNameError

def install(model_name: str):
    if not model_name in model_names:
        raise ModelNameError(model_name)
    if is_model_installed(model_name):
        raise ModelAlreadyInstalledError(model_name)
    install_model(model_name)
