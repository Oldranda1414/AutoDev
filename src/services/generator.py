from llm.model import ask
from services.prompt import get_prompt

def generate_config(model_name: str, project_path: str, prompt_path: str) -> str:
    prompt = get_prompt(prompt_path, project_path)
    response = ask(model_name, prompt)
    return response
