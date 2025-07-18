from requests import get

LLM_SERVER_ENDPOINT = "http://localhost:11434/api/tags"

def is_llmserver_running() -> bool:
    try:
        get(LLM_SERVER_ENDPOINT)
        return True
    except:
        return False

def start_llmserver():
    pass
