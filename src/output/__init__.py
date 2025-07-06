# TODO implement prettier print, maybe with rich library

_initialized = False
_quiet = False

def init(quiet: bool):
    global _quiet, _initialized
    _quiet = quiet
    _initialized = True

def _require_init():
    if not _initialized:
        raise RuntimeError("Prompt.init() must be called before using this method.")

def cli_print(*message: str):
    _require_init()
    for line in message:
        print(line)

