---
layout: page
title: Testing
---

The goal of this project is to test the capabilities of LLMs generate dev env configurations.

All tests are located in the `test` directory.

The tests have been separated in various categories.

Tests can be run with the following command (while being in [AutoDev's dev enviroment](./architectural-design.md#development)):

```sh
just test [TEST-CATEGORY] [MODEL]
```

where:

- `[TEST-CATEGORY]` is the category of the tests to be run.
- `[MODEL]` is the model to run tests for.

If no test category or model is specified all tests are run.

Because of the nature of tests, i.e. running LLMs locally, test runtime can be quite high depending on the hardware used.

Since AutoDev has a timeout of 1 hour when generating the LLM's response, bigger models might be unable to generate code in time, depending on the hardware used.

## Common strategies

All test will be run with the following strategies:

- Laboratories for the [__Advanced Software Modelling and Design__](https://www.unibo.it/it/studiare/insegnamenti-competenze-trasversali-moocs/insegnamenti/insegnamento/2025/483706) as test projects. These projects are a good testing ground for the abilities of LLMs to generate dev env configurations for non trivial projects.
- All the models made available through AutoDev have been tested for every category and lab.
- A test is considered passed if commands that would be run in the development workflow execute correctly in the development enviroment obtained from the configuration AutoDev generated.

Since the LLM 'temperature' setting can be ambiguous when assessing different LLMs, it is not considered in the test parameters and it is simply ignored. All tested models are used with 'default settings'.

Since the projects can be considered separete 'test enviroments' or simply 'test spaces' the term 'space' is used when referring to the local, as in the AutoDev repo, copy of the project used in testing.

Given the above considerations, for every test category the number of tests being executed:

models * categories * spaces  = 6 * 6 * 8 = 288

## Models

The following is a list of the LLMs tested with links to their page on [Ollama](https://ollama.com/):

- [llama3](https://ollama.com/library/llama3)
- [qwen3](https://ollama.com/library/qwen3)
- [smollm2](https://ollama.com/library/smollm2)
- [phi4-mini](https://ollama.com/library/phi4-mini)
- [deepseek-r1](https://ollama.com/library/deepseek-r1)
- [mistral](https://ollama.com/library/mistral)

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

This prompt configurations are located at `src/test/prompts/directory_structure_{deep,shallow}.json`.

### Project files contents

The prompt was completed with the full contents of the project directory, as in directory structure, file names and contents.

This prompt configurations are located at `src/test/prompts/file_contents_{deep,shallow}.json`.

### 1-shot prompting

The prompt of the model was aided by the precence of an example of the desired result, as in an example of a functioning flake.nix file that defines the develoment shell for simple project.

The prompt also comprehends the project directory strucure and file contents, so this is one of the most verbose prompts tested.

This prompt configurations are located at `src/test/prompts/1_shot_{deep,shallow}.json`.

## Spaces

All spaces are taken from the __Advanced Software Modelling and Design__ course labs, appart from the 'basic' space, which is a hello world [Julia](http://julialang.org/) project that is meant to serve as a simple baseline.

The following are the test spaces' names, with links to the publicly availabe github repo they where copied from.

- [acceptance_testing](https://github.com/mviroli/asmd23-public-01-atdd)
- [advanced_programming](https://github.com/mviroli/asmd24-public-04-advanced-programming)
- basic (no link provided)
- [integration_testing](https://github.com/mviroli/asmd24-public-02-testing)
- [llm_advanced]()
- [llm_intro](https://github.com/cric96/asmd24-public-03-llm-intro-code)
- [models](https://github.com/mviroli/asmd24-public-models)
- [scafi](https://github.com/mviroli/asmd24-public-scafi)

All spaces are located at `src/test/space/<space_name>`, where <space_name> is the name of a space listed above.

All spaces' directories also include a `test.sh` file that is used to determine wheather the generated development enviroment is correct.

## Improvements

Initial testing proved the necessity of the following improvements.

### Response cleaning

Even if specifically 'told' to not use triple backtick code block delimiters (```) many models still provided nix code delimited by them. To ensure models that struggle to remove the code block delimiters are not penalized they are 'manually' removed from the generated code.

Some models provide a 'thought block' in the generated code, showing the Chain-of-Tought process employed, even if prompted to remove it. To ensure these models are not penalized they are 'manually' removed from the generated code.

### Flake check

Often LLMs struggle to provide a correct answer on the first attempt, but the 'chat-like' feature of these models can be levereged to enable them to correct their mistakes.

After the nix code is generated, it is parsed and validated using the `nix flake check` command. Eventual errors encountered are provided to the LLM to give it a chance to improve on it's provided code.

A total of 3 attempts are done, by providing the error messate to the model and asking it to fix the errors, before giving up on generating the dev env config and notifing the user.

### Test file removal

In initial tests runs the precence of the `test.sh` file seemd to unnaturally boost model performance. Although in real projects some test's might be present, they are usually less telling of cli the tools necessary for the project than a bash script with details on how the project would be run.

Even considering many projects have instructions on how to deploy or run the software, providing the `test.sh` file was deemed too good of a hint to really test the capabilities of the LLMs, so in the final test set the `test.sh` file was temporarily removed from the project to better simulate a real case scenario.

## Results

Only 8 tests ended with a positive result:

- 3 with 1_shot_deep (2 for llama3, 1 for qwen3)
- 5 with 1_shot_shallow (3 for llama3, 1 for qwen3, 1 for smallm2)

For the 1_shot_shallow prompt style the positively ended tests do not comprehend the 'basic' test space, which should be the easieast, suggesting that more simulations should be done to ensure the models are not able to complete the tests if given multiple attempts.

Of the 280 failing tests:

- For 209 tests the model was unable to generate correct nix code in 3 attempts <!-- in `src/test/results/logs/` executed the command `rg -o "code 51" | wc -l`, with ripgrep installed -->
- For 62 tests the model was unable to generate a response within the time limit of 3600 seconds (1 hour) <!-- in `src/test/results/logs/` executed the command `rg -o "code 51" | wc -l`, with ripgrep installed -->
- For 9 tests an unexpected error occurred

deepseek-r1 was always unable to generate a response within the time limit, which means that the avalable hardware was unable to use the model

Other models where sometimes unable to generate a response in time, especially when the prompt was particularly large.

Considering this and the fact that shallow prompt provided better results overall, with deep prompts probably suffering from recency bias, it seems that for large project a low depth value should be choosen.

Since all models failed to generate correct nix code when not prompted with an example it seems that models are still not able to generate '[nix flake](https://nixos.wiki/wiki/Flakes)' code at the moment. This is not unexpected as flakes are still considered an experimental feature of nix and they have been introduced recently, being introduced in 2021.

### Storage

Test results have been saved in various formats:

- `test/results/results.txt` contains every single run with the boolean result and timestamp
- `test/results/logs` contains the log files for every day of testing, showing why failed tests failed by saving stdout and stderr from the simulations
- `test/results/flakes` contains the generated flakes for every simulation, even for cases when incorrect nix code was generated, providing insight in the type of nix code errors made by the LLMs

[Back to index](./index.md) |
[Previous Chapter](./implementation.md) |
[Next Chapter](./conclusion.md) |

