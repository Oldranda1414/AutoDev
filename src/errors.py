class PromptPathError(ValueError): pass
class ModelNameError(ValueError): pass
class MissingAttributesError(Exception):
    def __init__(self, missing_keys):
        keys = ", ".join(missing_keys)
        super().__init__(f"Missing required JSON keys: {keys}")
        self.missing_keys = missing_keys
class JsonValueTypeError(ValueError): pass
class OllamaNotInstalledError(ValueError): pass

