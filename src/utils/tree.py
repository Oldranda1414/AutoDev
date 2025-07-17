from directory_tree import DisplayTree

def generate_project_tree(project_path: str, depth: int):
    return DisplayTree(dirPath=project_path, stringRep=True, maxDepth=depth)
