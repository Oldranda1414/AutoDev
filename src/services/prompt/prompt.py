import os

from file_system import generate_tree

DEFAULT_PREFIX_PROMPT = """
Some prefix prompt
"""
DEFAULT_CONCLUSION_PROMPT = """
Some conclusion prompt
"""
DEFAULT_TAGGED_FSO_PROMPT = """
Some defatul FSO prompt
"""

def get_prompt(prompt_path: str, project_path: str) -> str:
    prefix_prompt = None
    conclusion_prompt = None
    tagged_fso_prompt = None
    if prompt_path:
        prefix_prompt, conclusion_prompt, fso_prompt = _extract_prompt(prompt_path)
    else:
        # TODO implement default prompt
        prefix_prompt = DEFAULT_PREFIX_PROMPT
        conclusion_prompt = DEFAULT_CONCLUSION_PROMPT
        tagged_fso_prompt = DEFAULT_TAGGED_FSO_PROMPT
    # TODO implement this
    prompt = ""
    prompt += prefix_prompt
    prompt += "\r" + _generate_fso_prompt(project_path, tagged_fso_prompt)
    prompt += "\r" + conclusion_prompt
    return prompt

def _extract_prompt(prompt_path: str) -> tuple[str, str, str]:
    # TODO check json contains correct keys
    extension = prompt_path.split(".")[-1]
    if not extension == "json":
        raise ValueError("prompt_path must be a json type file path") 
    if not os.path.exists(prompt_path):
        raise ValueError("prompt_path provided must lead to an existing file") 
    return "place", "holder" ,""

def _generate_fso_prompt(project_path: str, tagged_fso_prompt: str):
    project_fso = generate_tree(project_path)
    return tagged_fso_prompt
    # for fso in project_fso:

