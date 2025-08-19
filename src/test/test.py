from subprocess import run, PIPE, CompletedProcess
from path import TEST_SCRIPT, SPACES_PATH, PROMPTS_PATH

def execute_test(model: str, category: str, space: str) -> CompletedProcess:
    command = run(
        TEST_SCRIPT + f" {SPACES_PATH}/{space} {model} {PROMPTS_PATH}/{category}.json",
        shell=True,
        stdout=PIPE,
        stderr=PIPE,
        text=True
    )
    return command
