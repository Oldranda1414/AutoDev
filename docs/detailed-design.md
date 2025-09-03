---
layout: page
title: Detailed Design
---

## Language

Python is the de-facto standard language for Machine Learning and LLM APIs.

Python also has a good cli interface generator in the [docopt package](https://github.com/jazzband/docopt-ng).

Python is a simple and easy to use language, often used to create simple proof-of-work prototypes.

Since the project has a rather small scope, it's goals are to test and prototype the concept and given the good available libraries python is the chosen language for this project.

## Modules

### Interface

The [docopt](https://github.com/jazzband/docopt-ng) package is used to define the arguments accepted by AutoDev.

The Interface module calls the dispatch function exposed by the Dispatcher with the parced cli arguments provided by the user as arguments.

![Interface Design](./assets/mermaid/interface_design.png)

### Dispatcher

Similar to a router in a web application, the Dispatcher calls the correct handlers with correct arguments depending on argments passed through the cli.

![Dispatcher Design](./assets/mermaid/dispatcher_design.png)

### Handlers

The handlers expose the high level functionalities of AutoDev.

They call services to execute the actual business logic.

![Handlers Design](./assets/mermaid/handlers_design.png)

### Services

The services define business logic for AutoDev's functionalities.

![Services Design](./assets/mermaid/services_design.png)

#### Prompt

The prompt is generated from a json file specification.

The json file must have the following structure:

```json
{
    "depth": <depth_level>,
    "premise": <premise_prompt>,
    "conclusion": <conclusion_prompt>,
    "fsobject": <file_system_object_prompt>
}
```

##### \<depth_level\> 

`<depth_level>` is the max depth level that should be reached when traversing the directory tree.

The value of `<depth_level>` must be an integer.

If `<depth_level>` is set to 0 then the project directory contents will not be considered when creating the prompt. Only the premise will compse the used prompt.

If `<depth_level>` is set to a value greater than 0 then the project directory will be traversed up to the depth indicated by the value of `<depth_level>`, and the directories and files encountered during traversal will be used to generate the prompt.

##### \<premise_prompt\>

`<premise_prompt>` is the first part of the prompt to be passed to the LLM model.

The value of `<premise_prompt>` must be a string.

The value of `<premise_prompt>` is used to generate the first part of the prompt passed to the LLM.

The value of `<premise_prompt>` is expected to contain some information about the task being requested, as in the request to generate a dev env configuration using the nix language.

##### \<conclusion_prompt\>

`<conclusion_prompt>` is the final part of the prompt to be passed to the LLM model.

The value of `<conclusion_prompt>` must be a string.

The value of `<conclusion_prompt>` is used to generate the last part of the prompt passed to the LLM.

The value of `<conclusion_prompt>` is expected to contain some information about how to output the configuration, as in specifing that no text should be generated apart from the actuall nix code to be placed in the flake.nix file.

##### \<file_system_object_prompt\>

`<file_system_object_prompt>` is the prompt to be passed for every file system object visited.

The value of `<file_system_object_prompt>` must be a string.

For every directory or file traversed, as per the `<depth_level>` value, the value of `<file_system_object_prompt>` will be repeated.

In the value of `<file_system_object_prompt>` the following tags will be filled according to the file system object being considered:

- `<fso_name>`: will be replaced with the file system object's name
- `<fso_contents>`: will be replaced with the file system object's fso_contents

In the case of directories `<fso_contents>` will contain the files filled

##### Tags

If present in the values of `<premise_prompt>` or/and `<conclusion_prompt>` the following tags will be replaced as follows:

- `<project_tree>`: will be replaced with a project directory tree rappresenation, up to the depth specified in <depth_level>

If present in the value of `<file_system_object_prompt>` the following tags will be replaced as follows, according to the file system object being considered at that point:

- `<fso_name>`: will be replaced with the file system object's name
- `<fso_contents>`: will be replaced with the file system object's fso_contents

In the case of directories `<fso_contents>` will be replaced by the names of the files and directories contained in the considered directory.

In the case of files `<fso_contents>` will contain the considered file contents.

##### Default prompt

The default prompt style used by AutoDev is the following:

```json
{
  "depth" : 3,
  "premise" : "Generate the contents of a flake.nix file that defines the development environment for the following project.\nThe development enviroment should be started with 'nix develop'.\n\nThis is an example of a flake.nix file\n```\n{\n  description = \"Dev environment for AutoDev project\";\n\n  inputs = {\n    nixpkgs.url = \"github:nixos/nixpkgs/nixos-25.05\";\n  };\n\n  outputs = { self , nixpkgs ,... }: let\n    system = \"x86_64-linux\";\n  in {\n    devShells.\"${system}\".default = let\n      pkgs = import nixpkgs {\n        inherit system;\n      };\n    in pkgs.mkShell {\n      packages = with pkgs; [\n        # used to run LLMs locally\n        ollama\n        # modern python package manager\n        uv\n        # cli to turn mmd files into mermaid graph pngs\n        mermaid-cli\n        # modern command runner\n        just\n      ];\n    };\n  };\n}\n\nThis is the project tree:\n\n<project_tree>\n \nThe following are the project directory contents:\n",
  "conclusion" : "Generate only the contents of the flake.nix file, nothing more.\nI want to copy your answer directly into the file and have it working, so don't tell me anything more, please.\nDo not encapsulate the answer with ``` and don't add any final comments.\nOnly output working nix code.",
  "fsobject" : "this is the name of the file/folder: <fso_name>.\nthese are it's contents if it is a file:\n```\n<fso_contents>\n```\n"
}

```

This default prompt style was selected by using the best performing prompt style from the [test](./testing.md) portion of this project.

The prompt provides an example nix flake implementation while keeping the depth low to ensure the LLM does not suffer from recency bias whith large projects.

#### Model

The Model module is a wrapper around the [litellm](https://github.com/BerriAI/litellm) package.

This wrapper serves as an anti-corruption layer, ensuring if the underlying package would change only the Model module would have to be changed.

Also the Model interface only exposes the needed methods for AutoDev, hiding additional functionalities the underlying package provides.

![Model Design](./assets/mermaid/model_design.png)

#### Output

The Output service is reponsible for the outputs of the project.

The Output service must be initialized before use. The initialization is necessary to specify if the output should be quiet for this run.

For terminal based outputs the [rich](https://github.com/Textualize/rich) package.

For file creation the os python built package is used.

![Output Design](./assets/mermaid/output_design.png)

[Back to index](./index.md) |
[Previous Chapter](./architectural-design.md) |
[Next Chapter](./implementation.md) |
