# AutoDev

This repo contains the project for the exam "Advanced Software Modelling and Design".

The project name is AutoDev.

AutoDev is a command line tool that uses an LLM to generate a dev environment for a given project.

Documentation is deployed through [github pages](https://oldranda1414.github.io/AutoDev/)

## Installation

TODO

## Dependencies

AutoDev uses [nix](https://nixos.org/download/) to configure the development environment.

## Usage

The following command will generate the dev environment specification

```bash
ad path/to/project/root
```

To start the development environment run the following command

```bash
nix develop
```

