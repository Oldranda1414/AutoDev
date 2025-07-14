from model import Model
from services.prompt import get_prompt
from .exceptions import PromptPathError, ModelNameError

def generate_config(model_name: str, project_path: str, prompt_path: str) -> str:
    try:
        model = Model(model_name)
    except ValueError as e:
        raise ModelNameError("An error had occurred:") from e
    try:
        prompt = get_prompt(prompt_path, project_path)
    except ValueError as e:
        raise PromptPathError("An error had occurred:") from e
    response = model.ask(prompt)
    return response
