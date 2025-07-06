# TODO implement prettier print, maybe with rich library

_initialized = False
_quiet = False

def init(quiet: bool = False):
    global _quiet, _initialized
    _quiet = quiet
    _initialized = True

def _require_init():
    if not _initialized:
        raise RuntimeError("Prompt.init() must be called before using this method.")

def cli_print(*message: str):
    _require_init()
    if not _quiet:
        for line in message:
            print(line)

# TODO make this different from normal print
def cli_print_error(*message: str):
    _require_init()
    if not _quiet:
        for line in message:
            print(line)

def create_file(name: str, contents: str, path: str):
    complete_path: str
    if path:
        complete_path = path + "/" + name
    else:
        complete_path = name
    with open(complete_path, "x") as f:
        f.write(contents)
