---
layout: page
title: Detailed Design
---

## Language

Python is the de-facto standard language for Machine Learning and LLM APIs.

Python also has a good cli interface generator in the [docopt package](https://github.com/jazzband/docopt-ng).

For these reasons python is the chosen language for this project.

## Modules

- Interface: responsible for defining command api and related command parsing, similar to a View in MVC architecture;
- Dispatcher: responsible for linking the command arguments to the correct execution of handler functions;
- Handlers: responsible for handling high level command operations;
- Services: responsible for defining business logic common to multiple handlers;
- Generator: responsible for generating dev env config;
- Prompt: responsible for defining prompt formats to be passed to LLMs;
- Model: responsible for wrapping the LLM service;
- Output: responsible for generating output, be it in file or cli print format.

### Interface

### Dispatcher

### Handlers

### Services

### Generator

### Prompt

### Model

### Output


[Back to index](./index.md) |
[Previous Chapter](./architectural-design.md) |
[Next Chapter](./implementation.md) |
