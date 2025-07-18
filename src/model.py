from litellm import completion
from llm_server import start_llmserver, is_llmserver_running, get_api_base, get_server_model_name

from errors import ModelNameError

class Model:
    def __init__(self, name: str, timeout: int = 5000):
        if not _is_valid_name(name):
            raise ModelNameError(f"Model {name} is not one of the accepted model names")
        if not is_llmserver_running():
            start_llmserver()
        self.name = name
        self.server_model_name = get_server_model_name(name)
        print(is_llmserver_running())
        # print(_testing())
        # TODO implement this model initialization (using litellm)

    def ask(self, message: str) -> str:
        # TODO implement this
        # print("model was asked: \n" + message)
        return "model was asked: " + message

    def _testing(self):
        api_base = get_api_base()
        response = completion(
                    model=self.server_model_name,
                    messages = [{ "content": "Hello, how are you?","role": "user"}],
                    api_base=api_base
        )
        return response

def _is_valid_name(model_name):
    return model_name in model_names

# TODO add model names here
model_names = [
            "llama2"
        ]
