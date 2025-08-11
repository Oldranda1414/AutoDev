from typing import Optional
from os import scandir
from os.path import basename, isdir

class FileSystemObject:

    def __init__(self, name: str, contents: Optional[str] = None):
        self.name = name
        self.contents = contents
        self.children: list[FileSystemObject] = []
        self.is_dir = not contents

def generate_fso_list(fso_path: str, depth: int) -> list[FileSystemObject]:
    if depth < 1:
        return  []
    return _generate_fso_list(fso_path, depth, [])

def _generate_fso_list(fso_path: str, depth: int, current_list: list[FileSystemObject]) -> list[FileSystemObject]:
    if isdir(fso_path):
        fso = FileSystemObject(basename(fso_path))
        current_list.append(fso)
        if not fso.name == ".git":
            for current in scandir(fso_path):
                if depth > 1:
                    fso.children.append(_generate_fso_list(current.path, depth - 1, current_list))
    else:
        with open(fso_path) as file:
            try:
                contents = file.read()
                current_list.append(FileSystemObject(basename(fso_path), contents))
            except:
                pass
    return current_list

