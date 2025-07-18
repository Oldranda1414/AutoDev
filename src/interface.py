from typing import List
from docopt import docopt

from dispatcher import dispatch

doc = """AutoDev

Usage:
  autodev [PATH-TO-PROJECT] [-q | --quiet] [-d | --direnv] [-m MODEL-NAME] [-p PROMPT-FILE-PATH]
  autodev -l | --list

Replace autodev with your preferred method to run AutoDev.
If you are in AutoDev's dev env, you can replace 'autodev' with 'just run' 

Generates development environment configuration for a project.

Use `nix develop` to start development environment.

Options:
  PATH-TO-PROJECT                                 Path to the project the dev env is for. [default: ./]
  -h, --help                                      Display help message.
  -q, --quiet                                     Disable prints.
  -d, --direnv                                    Generate .envrc file also.
  -m MODEL-NAME, --model MODEL-NAME               Model to use to generate the config. One of: temp temp temp [default: llama2]
  -l, --list                                      List available and installed models.
  -p PROMPT-FILE-PATH, --prompt PROMPT-FILE-PATH  Custom prompt file path.

"""

def main(args: List[str]):
    parsed_args = docopt(doc, args)
    # Add PATH-TO-PROJECT default manually as docopt seems to not add it automatically
    if not parsed_args["PATH-TO-PROJECT"]:
        parsed_args["PATH-TO-PROJECT"] = "./"
    dispatch(parsed_args)
