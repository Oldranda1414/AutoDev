from abc import abstractmethod

class AutoDevError(Exception):
    """Base exception for all AutoDev errors."""

    exit_code: int

    def __init_subclass__(cls, **kwargs):
        super().__init_subclass__(**kwargs)
        if not hasattr(cls, "exit_code"):
            raise TypeError(f"{cls.__name__} must define an exit_code")

    def __init__(self):
        super().__init__(self.build_message())

    @abstractmethod
    def build_message(self) -> tuple[str, ...]:
        """Build the error message. Must be implemented by subclasses."""
        pass

