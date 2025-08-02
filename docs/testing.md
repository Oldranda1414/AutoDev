---
layout: page
title: Testing
---

The goal of this project is to test the capabilities of LLMs generate dev env configurations.

All tests are located in the `test` directory.

The tests have been separated in various categories.

Tests can be run with the following command (while being in [AutoDev's dev enviroment](./architectural-design.md#Development)):

```sh
just test TEST-CATEGORY
```

where `TEST-CATEGORY` rappresents the category of the tests to be run.

If no test category is specified all tests are run.

Because of the nature of tests, i.e. running LLMs locally, test runtime can be quite high depending on the hardware used.

Every test ran saves it's results to `test/<category>/results`, where `category` is the category of the tests.

## Common strategies

All test will be run with the following strategies:

- Laboratories for the [__Advanced Software Modelling and Design__](https://www.unibo.it/it/studiare/insegnamenti-competenze-trasversali-moocs/insegnamenti/insegnamento/2025/483706) as test projects. These projects are a good testing ground for the abilities of LLMs to generate dev env configurations for non trivial projects.
- All tests are being run multiple times in a Monte Carlo Simulation style to extrapolate success rates of various tests. This is necessary due to the stochastic nature of LLMs.
- All the models made available through AutoDev have been tested for every category and lab.
- A test is considered passed if commands that would be run in the development workflow execute correctly in the development enviroment obtained from the configuration AutoDev generated.

Since the LLM 'temperature' setting can be ambiguous when assessing different LLMs, it is not considered in the test parameters and it is simply ignored. All tested models are used with 'default settings'.

Given the above considerations, for every test category the number of tests being executed:

projects number * simulations number * models number = 

<!-- TODO write here how many tests have been run in the end. Consider if this number should be calculated this way, or if the number of simulations should be removed from equation -->

<!-- 10 labs -->


## Categories

The following test categories where identified.

### Project directory structure

The prompt was completed with the contents of the project directory, as in directory structure and file names.

These tests are located at `test/directory_structure/`.

### Project files contents

The prompt was completed with the full contents of the project directory, as in directory structure, file names and contents.

These tests are located at `test/file_contents/`.

### 1-shot prompting

The prompt of the model was aided by the precence of an example of the desired result, as in an example of a functioning flake.nix file that defines the develoment shell for simple project.

The prompt also comprehends the project directory strucure and file contents, so this is one of the most verbose prompts tested.

These tests are located at `test/1_shot`

### Test files provided

The prompt is composed by the contents of the `test.sh` files used to determine if the dev env works as expected.

This method takes into consideration projects where end-to-end tests might be already been written, hoping that they are helpfull in generating the dev env config.

<!-- TODO checkout this for prompt engeneering: https://www.promptingguide.ai/ -->

[Back to index](./index.md) |
[Previous Chapter](./implementation.md) |
[Next Chapter](./conclusion.md) |

