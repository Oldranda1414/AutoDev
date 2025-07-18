import re
import sys

TEST_CATEGORIES = [ "description" ]
MODELS = [ "llama2" ]

def main():
    args = parse_args()
    if not args:
        return
    category, model = args
    print(category, " " , model)

def parse_args() -> tuple[str, str] | None:
    args = sys.argv
    if len(args) == 1:
        return "", ""
    if len(args) == 2:
        category = get_category(args)
        if not category:
            return None
        return category, ""
    if len(args) == 3:
        category = get_category(args)
        if not category:
            return None
        model = get_model(args)
        if not model:
            return None
        return category, model
    else:
        print("tests called with the wrong parameters")
        print_usage()
        return None

def get_category(args: list[str]) -> str | None:
    category = args[1]
    if category not in TEST_CATEGORIES:
        print(f"category {category} is not a valid category")
        print_usage()
        return None
    return category

def get_model(args: list[str]) -> str:
    model = args[2]
    if model not in MODELS:
        print(f"model {model} is not a valid model")
        print_usage()
        return ""
    return model

def print_usage():
    print("Usage:")
    print("      just test [TEST-CATEGORY] [model_name]")
    print("available categories:")
    for category in TEST_CATEGORIES:
        print(f"      {category}")
    print("available models:")
    for model in MODELS:
        print(f"      {model}")


if __name__ == "__main__":
    main()
