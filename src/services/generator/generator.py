from model import Model
from services.prompt import get_prompt
from errors import PromptPathError, ModelNameError

def generate_config(model_name: str, project_path: str, prompt_path: str) -> str:
    try:
        model = Model(model_name)
    except ValueError as e:
        raise ModelNameError("An error had occurred:") from e
    prompt = get_prompt(prompt_path, project_path)
    response = model.ask(prompt)
    return response
