import sys

from categories import CATEGORIES
from models import MODELS
from utils import run_tests

def main():
    args = parse_args()
    category, model = args
    run_tests(category, model)

def parse_args() -> tuple[str | None, str | None] :
    args = sys.argv
    if len(args) == 1:
        return None, None
    if len(args) == 2:
        category = get_category(args)
        return category, None
    if len(args) == 3:
        category = get_category(args)
        model = get_model(args)
        return category, model
    else:
        print("tests called with the wrong parameters")
        print_usage()
    return None, None

def get_category(args: list[str]) -> str:
    category = args[1]
    if category not in CATEGORIES:
        print(f"category {category} is not a valid category")
        print_usage()
    return category

def get_model(args: list[str]) -> str:
    model = args[2]
    if model not in MODELS:
        print(f"model {model} is not a valid model")
        print_usage()
    return model

def print_usage():
    print("Usage:")
    print("      just test [TEST-CATEGORY] [model_name]")
    print("available categories:")
    for category in CATEGORIES:
        print(f"      {category}")
    print("available models:")
    for model in MODELS:
        print(f"      {model}")
    sys.exit()

if __name__ == "__main__":
    main()
