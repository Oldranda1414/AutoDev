import os
import json

from error.prompt import PromptPathError, MissingAttributesError, JsonValueTypeError
from file_system import generate_fso_list
from utils.tree import generate_project_tree

DEFAULT_DEPTH = 1
# Tags
PROJECT_TREE_TAG = "<project_tree>"
FSO_NAME_TAG = "<fso_name>"
FSO_CONTENTS_TAG = "<fso_contents>"
# TODO replace this with real default prompt
# Default prompt
DEFAULT_PREFIX_PROMPT = f"""
Generate the contents of a flake.nix file that defines the development environment for the following project.
The development enviroment should be started with 'nix develop'.

This is an example of a flake.nix file

```
{{
  description = "Dev environment for AutoDev project";

  inputs = {{
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  }};

  outputs = {{ self , nixpkgs ,... }}: let
    system = "x86_64-linux";
  in {{
    devShells."${{system}}".default = let
      pkgs = import nixpkgs {{
        inherit system;
      }};
    in pkgs.mkShell {{
      packages = with pkgs; [
        # used to run LLMs locally
        ollama
        # modern python package manager
        uv
        # cli to turn mmd files into mermaid graph pngs
        mermaid-cli
        # modern command runner
        just
      ];
    }};
  }};
}}
```

This is the project tree: 

{PROJECT_TREE_TAG}

The following are the project directory contents:
"""
DEFAULT_CONCLUSION_PROMPT = f"""
Generate only the contents of the flake.nix file, nothing more.
I want to copy your answer directly into the file and have it working, so don't tell me anything more, please.
Do not encapsulate the answer with ``` and don't add any final comments.
Only output working nix code.
"""
DEFAULT_FSO_PROMPT = f"""
this is the name of the file/folder: {FSO_NAME_TAG}.
these are it's contents if it is a file: 
```

{FSO_CONTENTS_TAG}

```
"""

def get_prompt(prompt_path: str, project_path: str) -> str:
    depth = DEFAULT_DEPTH
    prompt = _Prompt(DEFAULT_PREFIX_PROMPT, DEFAULT_CONCLUSION_PROMPT, DEFAULT_FSO_PROMPT)
    if prompt_path:
        depth, prompt = _extract_prompt(prompt_path)
    prompt.fso = _generate_fso_prompt(project_path, depth, prompt.fso)
    prompt = _add_project_tree(prompt, project_path, depth)
    return prompt.build()

def _extract_prompt(prompt_path: str) -> tuple[int, "_Prompt"]:
    extension = prompt_path.split(".")[-1]
    if not extension == "json":
        raise PromptPathError(prompt_path) 
    if not os.path.exists(prompt_path):
        raise PromptPathError(prompt_path) 
    with open(prompt_path) as prompt_file:
        custom_prompt: dict[str, str] = json.load(prompt_file)
    depth, prefix, conclusion, fso = _get_prompts(custom_prompt, prompt_path)
    return depth, _Prompt(prefix, conclusion, fso)

def _get_prompts(custom_prompt: dict[str, str], prompt_path: str) -> tuple[int, str, str, str]:
    required_keys =  ["depth", "premise", "conclusion", "fsobject"]
    required_types = [int,     str,       str,          str]

    missing = [key for key in required_keys if key not in custom_prompt]
    if missing:
        raise MissingAttributesError(prompt_path)

    prompts = tuple[int, str, str, str]([custom_prompt[key] for key in required_keys])
    for index, required_type in enumerate(required_types):
        if not type(prompts[index]) == required_type:
            raise JsonValueTypeError(prompt_path)
    return prompts
    
def _generate_fso_prompt(project_path: str, depth: int, tagged_fso_prompt: str):
    fso_list = generate_fso_list(project_path, depth)
    fso_prompt = ""
    for fso in fso_list:
        fso_prompt += "\n" + tagged_fso_prompt.replace(FSO_NAME_TAG, fso.name).replace(FSO_CONTENTS_TAG, fso.contents if fso.contents else "")
    return fso_prompt

def _add_project_tree(prompt: "_Prompt", project_path: str, depth):
    tree = generate_project_tree(project_path, depth)
    attributes = [ "prefix", "conclusion" ]
    for attribute in attributes:
        value: str = getattr(prompt, attribute)
        setattr(prompt, attribute, value.replace(PROJECT_TREE_TAG, tree))
    return prompt

class _Prompt:
    def __init__(self, prefix_prompt: str, conclusion_prompt: str, fso_prompt: str):
        self.prefix = prefix_prompt
        self.conclusion = conclusion_prompt
        self.fso = fso_prompt

    def build(self) -> str:
        return self.prefix + "\n" + self.fso + "\n" + self.conclusion

