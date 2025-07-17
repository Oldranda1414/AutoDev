from litellm import completion

from errors import ModelNameError

class Model:
    def __init__(self, name: str, timeout: int = 5000):
        if not _is_valid_name(name):
            raise ModelNameError(f"Model {{name}} is not one of the accepted model names")
        # TODO implement this model initialization (using litellm)
        print(_testing())

    def ask(self, message: str) -> str:
        # TODO implement this
        # print("model was asked: \n" + message)
        return "model was asked: " + message

def _testing():
    response = completion(
                model="ollama/llama2",
                messages = [{ "content": "Hello, how are you?","role": "user"}],
                api_base="http://localhost:11434"
    )
    return response

    
def _is_valid_name(model_name):
    return model_name in model_names

# TODO add model names here
model_names = [
            "llama3"
        ]
