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

```mermaid
---
title: Interface Design
---
classDiagram
    class Interface {
        \_\_main\_\_()
    }

    class docopt {
        <<package>>
    }

    Interface ..> docopt
    Interface ..> Dispatcher
```

### Dispatcher

Similar to a router in a web application, the Dispatcher calls the correct handlers with correct arguments depending on argments passed through the cli.

```mermaid
---
title: Dispatcher Design
---
classDiagram
    class Dispatcher {
        dispatch(args: Dict[str, str])
    }

    Dispatcher ..> Handlers
```

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

    ConfigGeneratorHandler  ..> Services
    DirenvGeneratorHandler  ..> Services
```

### Services

The services define business logic for AutoDev's functionalities.

```mermaid
---
title: Services Design
---
classDiagram

    class Configuration {
        addConfig(model: str = None, project_path: str = "./.", prompt_path: str = None) 
%% pseudo code: 
%%     def addConfig(model, project_path, prompt_path):
%%         contents = Generator.generateConfig(model, project_path, prompt_path)
%%         Output.createFile("flake.nix", contents)
    }

    class Direnv {
        addDirenv(project_path: str = "./.")
    }

    class Generator {
        generateConfig(model_name: str, project_path: str = "./.", prompt_path: str = None) -> str
%% pseudo code: 
%%     def generateConfig(model_name, project_path, prompt_path):
%%         model = Model(model)
%%         message = Prompt.getPrompt(project_path, prompt_path)
%%         return model.ask(message)
    }

    class Model {
        __init__(name: str, timeout: int = 5000) -> Model
        ask(message: str) -> str
    }

    class Prompt {
        getPrompt(project_path: str = "./.", prompt_path: str = None) -> str
    }

    class Output {
        init(quiet: bool = false)
        createFile(name: str, contents: str, path: str = "./.")
        print(message: str)
    }

    class Reader {
        readFile(path: str) -> str
        readDir(path: str = "./.") -> FileSystemNode
    }

    Direnv ..> Output
    Configuration ..> Output
    Configuration ..> Generator
    Generator ..> Model
    Generator ..> Prompt
    Prompt ..> Reader
```

#### Prompt

<!-- TODO add how custom prompt parsing works -->

#### Model

The Model module is a wrapper around the [litellm](https://github.com/BerriAI/litellm) package.

This wrapper serves as an anti-corruption layer, ensuring if the underlying package would change only the Model module would have to be changed.

Also the Model interface only exposes the needed methods for AutoDev, hiding additional functionalities the underlying package provides.

```mermaid
classDiagram

    class Model {
        __init__(name: str, timeout: int = 5000) -> Model
        ask(message: str) -> str
    }

    class litellm {
        <<package>>
    }

    Model ..> litellm
```

#### Output

The Output service is reponsible for the outputs of the project.

The Output service must be initialized before use. The initialization is necessary to specify if the output should be quiet for this run.

For terminal based outputs the [rich](https://github.com/Textualize/rich) package.

For file creation the os python built package is used.

```mermaid
classDiagram
    class Output {
        init(quiet: bool = false)
        createFile(name: str, contents: str, path: str = "./.")
        print(message: str)
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
