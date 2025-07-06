from typing import Dict

def dispatch(args: Dict[str, str]):
    print("dispatcher called")
    print("received following args", args)
