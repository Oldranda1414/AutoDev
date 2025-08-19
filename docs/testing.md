---
layout: page
title: Testing
---

The goal of this project is to test the capabilities of LLMs generate dev env configurations.

All tests are located in the `test` directory.

The tests have been separated in various categories.

Tests can be run with the following command (while being in [AutoDev's dev enviroment](./architectural-design.md#Development)):

```sh
just test [TEST-CATEGORY] [MODEL]
```

where:

- `[TEST-CATEGORY]` is the category of the tests to be run.
- `[MODEL]` is the model to run tests for.

If no test category or model is specified all tests are run.

Because of the nature of tests, i.e. running LLMs locally, test runtime can be quite high depending on the hardware used.

## Common strategies

All test will be run with the following strategies:

- Laboratories for the [__Advanced Software Modelling and Design__](https://www.unibo.it/it/studiare/insegnamenti-competenze-trasversali-moocs/insegnamenti/insegnamento/2025/483706) as test projects. These projects are a good testing ground for the abilities of LLMs to generate dev env configurations for non trivial projects.
- All the models made available through AutoDev have been tested for every category and lab.
- A test is considered passed if commands that would be run in the development workflow execute correctly in the development enviroment obtained from the configuration AutoDev generated.

Since the LLM 'temperature' setting can be ambiguous when assessing different LLMs, it is not considered in the test parameters and it is simply ignored. All tested models are used with 'default settings'.

Given the above considerations, for every test category the number of tests being executed:

models * projects * categories = 6 * 8 * 6 = 288

## Projects

TODO fill this up with project names and links

## Categories

For every category, two actual subcategories where created:

- deep: with a depth value of 100
- shallow: with a depth value of 3

All the test prompts are located at `src/test/prompts/`.

The prompt json files are named as follows:

`<category>_<subcategory>.json`

The following test categories where identified.

### Project directory structure

The prompt was completed with the contents of the project directory, as in directory structure and file names.

This prompt configuration is located at `src/test/prompts/directory_structure_deep.json`.

### Project files contents

The prompt was completed with the full contents of the project directory, as in directory structure, file names and contents.

These tests are located at `test/file_contents/`.

### 1-shot prompting

The prompt of the model was aided by the precence of an example of the desired result, as in an example of a functioning flake.nix file that defines the develoment shell for simple project.

The prompt also comprehends the project directory strucure and file contents, so this is one of the most verbose prompts tested.

These tests are located at `test/1_shot`

## Improvements

Initial testing proved the necessity of the following improvements.

### Response cleaning

Even if specifically 'told' to not use triple backtick code block delimiters (```) many models still provided nix code delimited by them. To ensure models that struggle to remove the code block delimiters are not penalized they are 'manually' removed from the generated code.

Some models provide a 'thought block' in the generated code, showing the Chain-of-Tought process employed, even if prompted to remove it. To ensure these models are not penalized they are 'manually' removed from the generated code.

### Flake check

Often LLMs struggle to provide a correct answer on the first attempt, but the 'chat-like' feature of these models can be levereged to enable them to correct their mistakes.

After the nix code is generated, it is parsed and validated using the `nix flake check` command. Eventual errors encountered are provided to the LLM to give it a chance to improve on it's provided code.

A total of 3 attempts are done, by providing the error messate to the model and asking it to fix the errors, before giving up on generating the dev env config and notifing the user.

[Back to index](./index.md) |
[Previous Chapter](./implementation.md) |
[Next Chapter](./conclusion.md) |

