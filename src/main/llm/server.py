from requests import get
from time import sleep
from subprocess import Popen, run
from subprocess import DEVNULL, TimeoutExpired
import atexit

from errors import OllamaNotInstalledError, ModelNotInstalledError

API_BASE = "http://localhost:11434"
START_COMMAND = ["ollama","serve"]
LIST_COMMAND = "ollama list"

ollama_process = None

def is_server_running() -> bool:
    try:
        get(API_BASE)
        return True
    except:
        return False

def start_server():
    if not is_server_running():
        global ollama_process
        try:
            ollama_process = Popen(
                START_COMMAND,
                stdout=DEVNULL,
                stderr=DEVNULL
            )
        except FileNotFoundError:
            raise OllamaNotInstalledError("Ollama does not seem to be installed on the system")
        atexit.register(_stop_server)

        while not is_server_running():
            sleep(0.5)

def _stop_server():
    global ollama_process
    if ollama_process and ollama_process.poll() is None:
        ollama_process.terminate()
        try:
            ollama_process.wait(timeout=5)
        except TimeoutExpired:
            ollama_process.kill()

def get_api_base() -> str:
    return API_BASE

def get_server_model_name(name: str) -> str:
    return f"ollama/{name}"

def is_model_installed(model_name: str) -> bool:
    command = run(
        LIST_COMMAND + f" | grep {model_name}",
        shell=True,
        stdout=DEVNULL,
        stderr=DEVNULL
    )
    return command.returncode == 0

def install_model(model_name: str):
    run(
        ["ollama", "pull", model_name],
        stdout=DEVNULL,
        stderr=DEVNULL
    )

def uninstall_model(model_name: str):
    if not is_model_installed(model_name):
        raise ModelNotInstalledError(f"{model_name} model is not installed") 
    run(
        ["ollama", "rm", model_name],
        stdout=DEVNULL,
        stderr=DEVNULL
    )

