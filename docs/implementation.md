---
layout: page
title: Implementation
---

## Source Code Organization

Since python is the language choosen, some decisions should be made in terms of source code organization, as there are varying approches possible when considering python standards.

Although the project is of small scope, python module system is used to improve source code organization.

The `__init__.py` file for every module provides only the interface of the module, by importing what should be exposed to the module user.

The actual module code is stored in a python file named after the module itself.

Additional organization can be provided by creating submodules or additional python files, all referred by the python file named after the module itself.

The following is an example of a module named 'example' with a submodule named 'submodule':

<!-- 
generated with https://tree.nathanfriend.com/ 

example
  submodule
    __init__.py
    submodule.py
  __init__.py
  example.py
  utils.py
-->

```none
example/
├── submodule/
│   ├── __init__.py
│   └── submodule.py
├── __init__.py
├── example.py
└── utils.py
```

Collections of modules in an outer module that does not provide functionaties itself should omit the presence of the `__init__.py` file, as it is useless.

## Directory tree rappresentation

The FileSystem class is used to rappresent directory structures.

Since the LLM used must understand the project contents to generate the dev env config, this class is used to rappresent the directory tree of the project.

![File system design](./assets/mermaid/fs_design.png)

## Exceptions

During development the necessity to create custom exception types arose from the necessity of handling various usage errors in the correct manner, ensuring the user was correctly notified of the mistake.

### Initial solution

Initially custom 'per module' exception types where employed.

<!-- generated with https://tree.nathanfriend.com/ -->
```none


```

### Final solution

[Back to index](./index.md) |
[Previous Chapter](./detailed-design.md) |
[Next Chapter](./testing.md) |
