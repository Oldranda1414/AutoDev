---
layout: page
title: Detailed Design
---

## Language

Python is the de-facto standard language for Machine Learning and LLM APIs.

Python also has a good cli interface generator in the [docopt package](https://github.com/jazzband/docopt-ng).

Python is a simple and easy to use language, often used to create simple working prototypes.

Since the project has a rather small scope, it's goals are to test and prototype the concept and for the good available libraries python is the chosen language for this project.

# Modules

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

The json file must have the following structure

<!-- TODO add json prompt structure -->

```json

```

The default prompt style used by AutoDev is the following:
<!-- TODO add default style -->

```json

```

This default prompt style was selected by using the best performing prompt style from the [test](./testing.md) portion of this project.

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
