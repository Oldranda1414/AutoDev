---
layout: page
title: Implementation
---

## Source Code Organization

Since python is the language choosen, some decisions should be made in terms of source code organization, as there are varying approches possible when considering python standards.

Given the projects small scope, the barebones module system is used.

A module is define by a python file.

Collection of modules can be created by grouping files in directories.

The `__init__.py` file format was considered, as it can work as an interface between modules, defining what methods are exposed to users of a module, given the limited scope of the project it has been omitted.

Private methods and attributes are simply identified by a starting underscore (`_`).

Although this method is less 'safe' it is preffered for this project.

Whenever the project complexity should increase a refactor of the source code organization could be considered.

## Directory tree rappresentation

The FileSystem class is used to rappresent directory structures.

Since the LLM used must understand the project contents to generate the dev env config, this class is used to rappresent the directory tree of the project.

![File system design](./assets/mermaid/fs_design.png)

## Exceptions

During development the necessity to create custom exception types arose from the necessity of handling various usage errors in the correct manner, ensuring the user was correctly notified of the mistake.

### Initial solution

Initially custom 'per module' exception types where employed.

<!--
generated with https://tree.nathanfriend.com/ 

module_a
    module_a.py
    exceptions.py
module_b.py
-->
```none
.
├── module_a/
│   ├── module_a.py
│   └── exceptions.py
└── module_b.py
```

If `module_b` needed to catch an exception type defined in the `module_a/exceptions.py` file, it would import them accordingly.

This system proved fiddly and unneccessarily verbose when the same exceptions would be catcher by modules with further dependency from the module defining them.

If a `module_c` is introduced, that depends on `module_b` and must catch custom exceptions two possible solutions can be used:


- `module_c` can import the exceptions from `module_a`, creating a maybe undesired dependency between `module_c` and `module_a`
- `module_b` can itself define custom exceptions that can be imported by `module_c`

The second solution is preferabble but if the new exceptions defined in `module_b` are simple copy pastes of the exceptions defined by `module_a` this solutions seems to violate the DRY principle.

### Final solution

Custom exceptions have been defined in their own module, and only the modules that need to throw or catch the exceptions import them.

This allows the modules that catch the exceptions to only depend on the exceptions module and not depend on the modules that actually throw them.

## Error handling

Being AutoDev a command line tool it should help the user in case any error occurs with insightfull errors, ideally hinting at how to fix them.

Being the service modules glorified 'function providers' they should only be responsible of triggering (i.e. throwing) errors. Services should not decide how to comunicate to the user the error has occurred.

Comunicating to the user that an error has occurred and hinting at fixes should be the responsibility of the handlers, as they call the high level services and leverage the output module to comunicate to the user when an operation has been completed successfully, so they should also take care of notifing the user when errors occur.

To ensure that the handlers could catch any type of errors and act accordingly (by notifing the user about the specific error that has occurred), the handlers should be able to catch specific types of errors.

This could be done by using the return type of a service function to also comunicate to the caller if any errors have occurred (e.g. as the [go](https://go.dev/) language standard does).

This solution has been considered rather inelegant and finicky, as multiple layers of error 'returns' would be implemented for every call that involves services using other services.

The solution adopted has been to define custom errors in a dedicated module, `errors.py`.

Although this could be considered bad practice, as standard language errors should be used when possible, this is considered

## LLM Server Module

<!-- TODO explain what it is -->
it is an anti-curruption layer

## Add config to git

[Back to index](./index.md) |
[Previous Chapter](./detailed-design.md) |
[Next Chapter](./testing.md) |
