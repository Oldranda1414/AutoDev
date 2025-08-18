from subprocess import run, PIPE, CompletedProcess
import path

def test(model: str, category: str, space: str) -> CompletedProcess:
    command = run(
        path.TEST_SCRIPT + f" {path.SPACES_PATH}/{space} {model} {path.PROMPTS_PATH}/{category}.json",
        shell=True,
        stdout=PIPE,
        stderr=PIPE,
        text=True
    )
    return command
