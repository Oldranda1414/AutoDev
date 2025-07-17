import os
import json
from errors import PromptPathError, MissingAttributesError, JsonValueTypeError

from file_system import generate_tree

DEFAULT_DEPTH = 1
DEFAULT_PREFIX_PROMPT = """
Some prefix prompt
"""
DEFAULT_CONCLUSION_PROMPT = """
Some conclusion prompt
"""
DEFAULT_TAGGED_FSO_PROMPT = """
Some defatul FSO prompt
this is the name of the file/folder: <fso_name>.
this is it's contents if it has any: <fso_contents>
"""

def get_prompt(prompt_path: str, project_path: str) -> str:
    prefix_prompt = None
    conclusion_prompt = None
    tagged_fso_prompt = None
    if prompt_path:
        depth, prefix_prompt, conclusion_prompt, tagged_fso_prompt = _extract_prompt(prompt_path)
    else:
        # TODO implement default prompt
        depth = DEFAULT_DEPTH
        prefix_prompt = DEFAULT_PREFIX_PROMPT
        conclusion_prompt = DEFAULT_CONCLUSION_PROMPT
        tagged_fso_prompt = DEFAULT_TAGGED_FSO_PROMPT
    # TODO implement this
    prompt = ""
    prompt += prefix_prompt
    prompt += "\r" + _generate_fso_prompt(project_path, depth, tagged_fso_prompt)
    prompt += "\r" + conclusion_prompt
    return prompt

def _extract_prompt(prompt_path: str) -> tuple[int, str, str, str]:
    extension = prompt_path.split(".")[-1]
    if not extension == "json":
        raise PromptPathError("prompt_path must be a json type file path") 
    if not os.path.exists(prompt_path):
        raise PromptPathError("prompt_path provided must lead to an existing file") 
    with open(prompt_path) as prompt_file:
        custom_prompt: dict[str, str] = json.load(prompt_file)
    return _get_prompts(custom_prompt)

def _get_prompts(custom_prompt: dict[str, str]) -> tuple[int, str, str, str]:
    required_keys =  ["depth", "premise", "conclusion", "fsobject"]
    required_types = [int,     str,       str,          str]

    missing = [key for key in required_keys if key not in custom_prompt]
    if missing:
        raise MissingAttributesError(missing)

    prompts = tuple[int, str, str, str]([custom_prompt[key] for key in required_keys])
    for index, required_type in enumerate(required_types):
        if not type(prompts[index]) == required_type:
            raise JsonValueTypeError()
    return prompts
    
def _generate_fso_prompt(project_path: str, depth: int, tagged_fso_prompt: str):
    project_root = generate_tree(project_path, depth)
    return tagged_fso_prompt
    # for fso in project_fso:

