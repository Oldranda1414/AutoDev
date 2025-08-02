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
            if depth > 0:
                fso.children.append(generate_tree(current.path, depth - 1))
        return fso
    else:
        with open(fso_path) as file:
            contents = file.read()
        return FileSystemObject(basename(fso_path), contents)

def generate_list(fso_path: str, depth: int) -> list[FileSystemObject]:
    if isdir(fso_path):
        fso = FileSystemObject(basename(fso_path))
        l: list[FileSystemObject] = [ fso ]
        for current in scandir(fso_path):
            if depth > 0:
                fso.children.append(_generate_list(current.path, depth - 1, l))
        return l
    else:
        with open(fso_path) as file:
            contents = file.read()
        return [ FileSystemObject(basename(fso_path), contents) ]

def _generate_list(fso_path: str, depth: int, current_list: list[FileSystemObject]) -> list[FileSystemObject]:
    if isdir(fso_path):
        fso = FileSystemObject(basename(fso_path))
        current_list.append(fso)
        for current in scandir(fso_path):
            if depth > 0:
                fso.children.append(_generate_list(current.path, depth - 1, current_list))
    else:
        with open(fso_path) as file:
            contents = file.read()
            current_list.append(FileSystemObject(basename(fso_path), contents))
    return current_list

