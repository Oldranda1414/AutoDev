from requests import get
from time import sleep
from subprocess import Popen, DEVNULL, TimeoutExpired
import atexit

from errors import OllamaNotInstalledError

API_BASE = "http://localhost:11434"
CHECK_COMMAND = ["ollama"]
START_COMMAND = ["ollama","serve"]

ollama_process = None

def is_server_running() -> bool:
    try:
        get(API_BASE)
        return True
    except:
        return False

def start_server():
    global ollama_process
    try:
        ollama_process = Popen(
            START_COMMAND,
            stdout=DEVNULL,
            stderr=DEVNULL
        )
    except FileNotFoundError:
        raise OllamaNotInstalledError("Ollama does not seem to be installed on the system")
    atexit.register(stop_llmserver)

    while not is_server_running():
        sleep(0.5)

def stop_llmserver():
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
