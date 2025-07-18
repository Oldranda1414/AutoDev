from requests import get
from time import sleep
from subprocess import Popen, DEVNULL, TimeoutExpired
import atexit

API_BASE = "http://localhost:11434"
START_COMMAND = ["ollama","serve"]

ollama_process = None

def is_llmserver_running() -> bool:
    try:
        get(API_BASE)
        return True
    except:
        return False

def start_llmserver():
    global ollama_process
    ollama_process = Popen(
        START_COMMAND,
        stdout=DEVNULL,
        stderr=DEVNULL
    )
    atexit.register(stop_llmserver)

    while not is_llmserver_running():
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

