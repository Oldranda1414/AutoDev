class Model:
    def __init__(self, name: str, timeout: int = 5000):
        if not _is_valid_name(name):
            raise ValueError(f"Model {{name}} is not one of the accepted model names")
        print("initialized model")

    def ask(self, message: str) -> str:
        print("asked model")
        return "some answer"

    
def _is_valid_name(model_name):
    return model_name in model_names

model_names = [
            "llama3"
        ]
