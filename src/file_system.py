from typing import Optional
from os import scandir
from os.path import basename, isdir

class FileSystemObject:

    def __init__(self, name: str, contents: Optional[str] = None):
        self.name = name
        self.contents = contents
        self.children: list[FileSystemObject] = []
        self.is_dir = not contents

def generate_tree(fso_path: str, depth: int) -> FileSystemObject:
    if isdir(fso_path):
        fso = FileSystemObject(basename(fso_path))
        for current in scandir(fso_path):
            print(current.name)
            if depth > 0:
                fso.children.append(generate_tree(current.path, depth - 1))
        return fso
    else:
        with open(fso_path) as file:
            contents = file.read()
        return FileSystemObject(basename(fso_path), contents)
