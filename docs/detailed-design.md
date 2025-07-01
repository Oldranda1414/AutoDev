---
layout: page
title: Detailed Design
---

## Language

Python is the de-facto standard language for Machine Learning and LLM APIs.

Python also has a good cli interface generator in the [docopt package](https://github.com/jazzband/docopt-ng).

For these reasons python is the chosen language for this project.

## Modules

### Interface

The [docopt](https://github.com/jazzband/docopt-ng) package is used to define the arguments accepted by AutoDev.

The Interface module simply calls the dispatch function exposed by the Dispatcher with the cli arguments provided by the user as arguments.

### Dispatcher

Similar to a router in a web application, the Dispatcher calls the correct handlers with correct arguments depending on argments passed through the cli.

### Handlers

The handlers expose the high level functionalities of AutoDev.

They call services to execute the actual business logic.

```mermaid
---
title: Handlers Design
---
classDiagram
    class ConfigGeneratorHandler {
        generateConfig(project_path: str = "./.", model: str = None, prompt_path: str = None, quiet: bool = false)
    }

    class DirenvGeneratorHandler {
        generateDirenv(project_path: str = "./.")
    }
```

### Services

The services define business logic for AutoDev's functionalities.

```mermaid
---
title: Services Design
---
classDiagram

    class ConfigurationGenerator {
        generateConfig(project_path: str = "./.", model: str = None, prompt_path: str = None, quiet: bool = false)
    }

    class DirenvGenerator {
        generateDirenv(project_path: str = "./.")
    }

    class Prompt {
        getPrompt(project_path: str = "./.")
    }

    class Output {
        createFile(name: str, contents: str, path: str = "./.")
    }

    class Reader {
        readFile(path: str) -> str
        readDir(path: str = "./.") -> FileSystemNode
    }

    DirenvGenerator ..> Output
    ConfigGenerator ..> Output
```

#### Generator

#### Prompt

#### Model

The Model module is a wrapper around the [litellm](https://github.com/BerriAI/litellm) package.

This wrapper serves as an anti-corruption layer, ensuring if the underlying package would change only the Model module would have to be changed.

Also the Model interface only exposes the needed methods for AutoDev, hiding additional functionalities the underlying package provides.

#### Output

The output service is reponsible for the outputs of the project.

For terminal based outputs the [rich](https://github.com/Textualize/rich) package.

For file creation the os python built package is used.

```mermaid
classDiagram
    class Output {
        generateDirenv(project_path: str = "./.")
    }

    class os {
        <<builtin package>>
    }

    class rich {
        <<package>>
    }

    Output ..> os
    Output ..> rich
```

[Back to index](./index.md) |
[Previous Chapter](./architectural-design.md) |
[Next Chapter](./implementation.md) |
