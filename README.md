# AutoDev

This repo contains the project for the exam "Advanced Software Modelling and Design".

The project name is AutoDev.

AutoDev is a command line tool that uses an LLM to generate a dev environment for a given project.

## Project report

The projects report is deployed through [github pages](https://oldranda1414.github.io/AutoDev/).

[mermaid](https://mermaid.js.org/) is used to create graphs.

The script `./docs/bin/update_graphs.sh` generates .png files in `./docs/assets/mermaid/` for each .mmd file in `./docs/assets/src/`.

## Dependencies

AutoDev uses [nix](https://nixos.org/download/) to configure the development environment.

To start the development environment run `nix develop`

### Uv

[Uv](https://github.com/astral-sh/uv) is a modern python build system.

### Mermaid cli

[Mermaid cli](https://github.com/mermaid-js/mermaid-cli) is used to generate png graphs from [mermaid](https://mermaid.js.org/) syntax.

## Usage

The following command will generate the dev environment specification:

<!-- TODO check if the following command is correct -->

```bash
AutoDev path/to/project/root
```

To start the development environment run the following command:

```bash
nix develop
```

