---
layout: page
title: Introduction
---

AutoDev is a 'development enviroment configration' generation tool.

AutoDev poses to exploit Large Language Models (LLMs) to let users generate [Nix](https://nixos.org/) configuration files by simply passing the path to a project, as so:

`autodev /path/to/project`

AutoDev generates a `flake.nix` file containing the configuration of the development enviroment for the given project.

The enviroment can be accessed running the following command:

`nix develop`

The user will now be in a temporary development shell set up specifically for that project.

Once the user has stopped working on the project, they can exit the development shell running the following command:

`exit`

And all the project specific tools will no longer be available.

## Motivation

The setup of the development enviroment (dev env) is a problem faced often in CS projects.

It is ideal that any developer working on a team should use the same dev env, as in the set of tools that are needed to work on that project.

As with any repetitive action, automation is to be desired.

The [Nix package manager](https://nixos.org/) enables to define, using the nix functional programming language, the characteristics of a development enviroment, such as what tools should be installed and much more, being the Nix language turing complete.

Thanks to the reproduciblility enabled by the Nix ecosystem any developer running the dev env for a given project can be assured that it is identical (in tools, versions, ecc.) to the dev enviroment of any other team member.

Also thanks to the Nix ecosystem these project specific tools are tied to the temporary project specific dev env and once the user exits it, these tools do not pollute the user enviroment or any other project enviroments.

Despite the power of Nix defined development enviroments, writing such configuration files is often an annoying hurdle.

AutoDev looks to solve this problem by leveraging the capacity of LLMs to understand natural language.

[Back to index](./index.md) |
[Next Chapter](./requirements.md)
