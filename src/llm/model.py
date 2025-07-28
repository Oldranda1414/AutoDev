from litellm import completion

from errors import ModelNameError, ModelNotInstalledError

from llm.server import get_api_base, get_server_model_name
from llm.server import start_server, is_server_running
from llm.server import is_model_installed

def ask(model_name: str, message: str) -> str:
    if not _is_valid_name(model_name):
        raise ModelNameError(f"Model {model_name} is not one of the accepted model names")
    if not is_server_running():
        start_server()
    if not is_model_installed(model_name):
        raise ModelNotInstalledError(f"{model_name} is not installed")
    messages = [{ "content": message,"role": "user"}]
    response = completion(
                model = get_server_model_name(model_name),
                messages = messages,
                api_base = get_api_base()
    )
    return response.choices[0].message.content

def _is_valid_name(model_name):
    return model_name in model_names

# TODO add model names here
model_names = [
            "llama3",
            "qwen3"
        ]
