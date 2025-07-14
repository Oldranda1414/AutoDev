class Model:
    def __init__(self, name: str, timeout: int = 5000):
        if not _is_valid_name(name):
            # TODO change this to raise ModelNameError and remove its raising in higher dependency 
            raise ValueError(f"Model {{name}} is not one of the accepted model names")
        # TODO implement this model initialization (using litellm)

    def ask(self, message: str) -> str:
        # TODO implement this
        return "model was asked: " + message

    
def _is_valid_name(model_name):
    return model_name in model_names

# TODO add model names here
model_names = [
            "llama3"
        ]
