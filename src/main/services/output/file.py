def create_file(name: str, contents: str, path: str):
    complete_path: str
    if path:
        complete_path = path + "/" + name
    else:
        complete_path = name
    with open(complete_path, "x") as f:
        f.write(contents)

def write_file(name: str, contents: str, path: str):
    complete_path: str
    if path:
        complete_path = path + "/" + name
    else:
        complete_path = name
    with open(complete_path, "w") as f:
        f.write(contents)

