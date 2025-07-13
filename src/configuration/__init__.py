from generator import generate_config
from output import create_file
from generator.exceptions import PromptPathError as PE, ModelNameError as ME
from .exceptions import PromptPathError, ModelNameError

def add_config(model: str, project_path: str, prompt_path: str):
    try:
        contents = generate_config(model, project_path, prompt_path)
    except PE as e:
        raise PromptPathError from e
    except ME as e:
        raise ModelNameError from e
    create_file("flake.nix", contents, project_path)
