import os
# from typing import Tuple

DEFAULT_PREFIX_PROMPT = """
Some prefix prompt
"""
DEFAULT_CONCLUSION_PROMPT = """
Some conclusion prompt
"""
DEFAULT_FSO_PROMPT = """
Some defatul FSO prompt
"""

def get_prompt(prompt_path: str, project_path: str) -> str:
    prefix_prompt = None
    conclusion_prompt = None
    fso_prompt = None
    if prompt_path:
        prefix_prompt, conclusion_prompt, fso_prompt = _extract_prompt(prompt_path)
    else:
        # TODO implement default prompt
        prefix_prompt = DEFAULT_PREFIX_PROMPT
        conclusion_prompt = DEFAULT_CONCLUSION_PROMPT
        fso_prompt = DEFAULT_FSO_PROMPT
    # TODO implement this
    return "example prompt"

def _extract_prompt(prompt_path: str) -> tuple[str, str, str]:
    extension = prompt_path.split(".")[-1]
    if not extension == "json":
        raise ValueError("prompt_path must be a json type file path") 
    if not os.path.exists(prompt_path):
        raise ValueError("prompt_path provided must lead to an existing file") 
    return "place", "holder" ,""
