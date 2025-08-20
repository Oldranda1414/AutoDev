from abc import abstractmethod

class AutoDevError(Exception):
    """Base exception for all AutoDev errors."""

    exit_code: int
    message_builder: tuple[str, ...]

    def __init__(self):
        super().__init__(self._build_message())

    @abstractmethod
    def _build_message(self) -> tuple[str, ...]:
        """Build the error message. Must be implemented by subclasses."""
        pass

