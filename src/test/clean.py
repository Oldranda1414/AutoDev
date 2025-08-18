from path import SPACES_PATH
from list.spaces import SPACES
from file import remove_file, remove_dir
from subprocess import run, DEVNULL

def clean():
    for space in SPACES:
        remove_dir(f"{SPACES_PATH}/{space}/.git")
        run(
            ["git", "restore", f"{SPACES_PATH}/{space}/test.sh"],
            stdout=DEVNULL,
            stderr=DEVNULL
        )
        remove_file(f"{SPACES_PATH}/{space}/flake.nix")
    remove_file(f"{SPACES_PATH}/test.sh")
