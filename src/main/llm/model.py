from litellm import completion
from litellm.exceptions import Timeout

from errors import ModelNameError, ModelNotInstalledError, ModelTimeoutError

from llm.server import get_api_base, get_server_model_name, is_model_installed 
from llm.server import start as start_server

COT_START_TAG = "<think>"
COT_END_TAG = "</think>"
REQUEST_TIMEOUT = 3600

class Model:
    
    def __init__(self, model_name: str):
        if not _is_valid_name(model_name):
            raise ModelNameError(model_name)
        if not is_model_installed(model_name):
            raise ModelNotInstalledError(model_name)

        self.model_name = model_name
        self.chat_history: list[dict[str, str]] = [
            {"role": "system", "content": "You are a helpful assistant."}
        ]

    def ask(self, message: str) -> str:
        start_server()
        self.chat_history.append({ "content": message,"role": "user"})
        try:
            response = completion(
                        model = get_server_model_name(self.model_name),
                        messages = self.chat_history,
                        api_base = get_api_base(),
                        request_timeout = REQUEST_TIMEOUT
            )
            self.chat_history.append({ "content": response,"role": "assistant"})
            cleaned_response = _clean_response(response.choices[0].message.content)
            return cleaned_response
        except Timeout:
            raise ModelTimeoutError(self.model_name, REQUEST_TIMEOUT)

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

model_names = [
            "llama3",
            "qwen3",
            "smollm2",
            "phi4-mini",
            "deepseek-r1",
            "mistral"
        ]
