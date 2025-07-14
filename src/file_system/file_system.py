from typing import Optional

class FileSystemObject:

    def __init__(self, name: str, contents: str, parent: Optional["FileSystemObject"] = None):
        self.name = name
        self.contents = contents
        self.parent = parent
        self.children: list[FileSystemObject] = []
        self.is_dir = not contents

def generate_tree(path: str) -> FileSystemObject:
    return FileSystemObject(path, "")
