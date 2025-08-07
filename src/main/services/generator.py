from llm.model import Model
from services.prompt import get_prompt

def generate_config(model: Model, project_path: str, prompt_path: str) -> str:
    prompt = get_prompt(prompt_path, project_path)
    response = model.ask(prompt)
    return response

