from subprocess import run

class CheckResult:
    def __init__(self, outcome: bool, error: str):
        self.outcome = outcome
        self.error = error

def check_flake(flake_path: str) -> CheckResult:
    command = run(
        f"nix flake check {flake_path}",
        shell=True,
        capture_output=True,
        text=True 
    )
    if command.returncode == 0:
        return CheckResult(True, "")
    else:
        print(f"flake check resulted in error {command.stderr}")
        return CheckResult(False, command.stderr)

