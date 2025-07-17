from model import Model
from services.prompt import get_prompt

def generate_config(model_name: str, project_path: str, prompt_path: str) -> str:
    model = Model(model_name)
    prompt = get_prompt(prompt_path, project_path)
    response = model.ask(prompt)
    return response
