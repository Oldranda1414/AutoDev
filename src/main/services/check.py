from subprocess import run

def check_flake(flake_path: str) -> tuple[bool, str]:
    command = run(
        f"nix flake check {flake_path}",
        shell=True,
        capture_output=True,
        text=True 
    )
    if command.returncode == 0:
        return (True, "")
    else:
        return (False, command.stderr)

