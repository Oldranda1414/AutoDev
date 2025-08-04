from litellm import completion

from errors import ModelNameError, ModelNotInstalledError

from llm.server import get_api_base, get_server_model_name
from llm.server import start_server
from llm.server import is_model_installed

COT_START_TAG = "<think>"
COT_END_TAG = "</think>"

class Model:
    
    def __init__(self, model_name: str):
        if not _is_valid_name(model_name):
            raise ModelNameError(f"Model {model_name} is not one of the accepted model names")
        start_server()
        # TODO remove this start server, make it be done in llm.server
        if not is_model_installed(model_name):
            raise ModelNotInstalledError(f"{model_name} is not installed")

        self.model_name = model_name
        self.chat_history: list[dict[str, str]] = [
            {"role": "system", "content": "You are a helpful assistant."}
        ]

    def ask(self, message: str) -> str:
        self.chat_history.append({ "content": message,"role": "user"})
        response = completion(
                    model = get_server_model_name(self.model_name),
                    messages = self.chat_history,
                    api_base = get_api_base()
        )
        self.chat_history.append({ "content": response,"role": "assistant"})
        cleaned_response = _clean_response(response.choices[0].message.content)
        return cleaned_response

def _is_valid_name(model_name):
    return model_name in model_names

def _clean_response(response: str):
    r = _remove_quotes(response)
    r = _remove_cot(r)
    return r

def _remove_quotes(response: str):
    return response.replace("```", "")

def _remove_cot(response: str):
    """
    Remove Chain-of-Thought from the model response

    Parameters:
    response (str): The model response

    Returns:
    str: The cleaned model response
    """
    start_cot_index = response.find(COT_START_TAG)
    end_cot_index = response.find(COT_END_TAG) + len(COT_END_TAG)
    if start_cot_index == -1 or end_cot_index == -1:
        return response
    return response[:start_cot_index] + response[end_cot_index:]

# TODO add model names here
model_names = [
            "llama3",
            "qwen3",
            "smollm2",
            "phi4-mini",
            "deepseek-r1",
            "mistral"
        ]
