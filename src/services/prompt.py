import os
import json

from errors import PromptPathError, MissingAttributesError, JsonValueTypeError
from file_system import generate_list

DEFAULT_DEPTH = 1
# Tags
PROJECT_TREE_TAG = "<project_tree>"
FSO_NAME_TAG = "<fso_name>"
FSO_CONTENTS_TAG = "<fso_contents>"
# TODO replace this with real default prompt
# Default prompt
DEFAULT_PREFIX_PROMPT = f"""
Some prefix prompt
this is the project tree {PROJECT_TREE_TAG}
"""
DEFAULT_CONCLUSION_PROMPT = f"""
Some conclusion prompt
this is the project tree {PROJECT_TREE_TAG}
"""
DEFAULT_FSO_PROMPT = f"""
Some defatul FSO prompt
this is the name of the file/folder: {FSO_NAME_TAG}.
this is it's contents if it has any: {FSO_CONTENTS_TAG}
"""

def get_prompt(prompt_path: str, project_path: str) -> str:
    depth = DEFAULT_DEPTH
    prompt = _Prompt(DEFAULT_PREFIX_PROMPT, DEFAULT_CONCLUSION_PROMPT, DEFAULT_FSO_PROMPT)
    if prompt_path:
        depth, prompt = _extract_prompt(prompt_path)
    # TODO implement this
    prompt.fso = _generate_fso_prompt(project_path, depth, prompt.fso)
    prompt = _add_project_tree(prompt, project_path)
    print(prompt.build())
    return prompt.build()

def _extract_prompt(prompt_path: str) -> tuple[int, "_Prompt"]:
    extension = prompt_path.split(".")[-1]
    if not extension == "json":
        raise PromptPathError("prompt_path must be a json type file path") 
    if not os.path.exists(prompt_path):
        raise PromptPathError("prompt_path provided must lead to an existing file") 
    with open(prompt_path) as prompt_file:
        custom_prompt: dict[str, str] = json.load(prompt_file)
    depth, prefix, conclusion, fso = _get_prompts(custom_prompt)
    return depth, _Prompt(prefix, conclusion, fso)

def _get_prompts(custom_prompt: dict[str, str]) -> tuple[int, str, str, str]:
    required_keys =  ["depth", "premise", "conclusion", "fsobject"]
    required_types = [int,     str,       str,          str]

    missing = [key for key in required_keys if key not in custom_prompt]
    if missing:
        raise MissingAttributesError(missing)

    prompts = tuple[int, str, str, str]([custom_prompt[key] for key in required_keys])
    for index, required_type in enumerate(required_types):
        if not type(prompts[index]) == required_type:
            raise JsonValueTypeError(f"The key {required_keys[index]} does not have a valid value assigned")
    return prompts
    
def _generate_fso_prompt(project_path: str, depth: int, tagged_fso_prompt: str):
    fso_list = generate_list(project_path, depth)
    fso_prompt = ""
    for fso in fso_list:
        fso_prompt += "\n" + tagged_fso_prompt.replace(FSO_NAME_TAG, fso.name).replace(FSO_CONTENTS_TAG, fso.contents if fso.contents else "")
    return fso_prompt
    # for fso in project_fso:

def _add_project_tree(prompt: "_Prompt", project_path: str):
    # TODO implement this. should replace the tag <project_tree> with project dir tree
    return prompt

class _Prompt:
    def __init__(self, prefix_prompt: str, conclusion_prompt: str, fso_prompt: str):
        self.prefix = prefix_prompt
        self.conclusion = conclusion_prompt
        self.fso = fso_prompt

    def build(self) -> str:
        return self.prefix + "\n" + self.fso + "\n" + self.conclusion

