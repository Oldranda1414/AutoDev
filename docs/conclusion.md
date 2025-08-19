---
layout: page
title: Conclusion
---

## Future work

### Further testing

Although the projects used are a good sample of non trivial projects, as a dataset they do lack in variety, being mainly centered on sbt (scala/java) projects. Other projects could be added to the dataset to test for other languages and tech stacks.

Also when in the tests where the file contents where provided in the prompt, a `test.sh` file was always listed, containing the actual test commands that would be run to test the generated dev env config. The presence of such explicit testing files might have helped AutoDev's generation and in real applications they might not be present. Further testing could be done by not providing these files through the prompt and see if the generation quality diminishes.

The idea of providing the models multiple attempts to generate working code was implemented late in development. For this reason data about how many attempts where necessary to for every test conditions to generate correct code was not recorded. It might be interesting to repeat the test and collecting data on attempt numbers as this could be a good insight in model performances.

### Improve prompt customization

The prompt customization functionality is very simple and it might be expanded on to provide customization options to the user.

Some nice features to add would be:

- The possibility of defining different prompts for folder and file listings, maybe by adding two tags specific to the file system object type.
- The possiblity of blacklisting certain folders or files, so as to not 
- The possiblity of providing a value for the number of 'attempts' the model should be given to generate valid nix code, before giving up.

### Remote models

As of now AutoDev installs models locally.

This means that a local download of every model is necessary before every first use.

Also the dev env config generation is done locally so it can take a lot of time.

A feature could be implemented to enable users to actually use remote models instead of local models for the dev env config generation.

### Packaging

As of now the project is run using the uv python build system and it is intended to be used through the just tool.

Ideally the project could be turned into a pip package (uv actually provides a way to easily do this at [https://docs.astral.sh/uv/guides/package/]) so that it could be installed globally (e.g. with `pip install AutoDev`).

## Retrospective

This project was very fun to develop. The usage of nix defined development enviroments to develop the project itself felt very 'meta', which felt in the line with the course's themes.

Working with python, while trying to impose a good typing and directory structure discipline has been a mixed experience. Although a good programmer is able to 'work' with any language, focusing on the abstract problem solving aspects of programming, it is appearent that trying to adapt a language to the users expectation can be very time consuming. Even though the result might be satisfing, a programmer is better off with choosing the right 'tool for the job' and adapt to it's conventions as much as possible, instead of trying to take only the 'good' parts of the language and attempt to modify the rest to suit the user's programming style.

In this project in particolar the choice of the python language seemd foregone because of it's use in most AI projects. I thought that adding typing to the language would eliminate the frustrations conected to it's 'scripting nature', but alas some frustration anyway arised and most of the time I found myself embracing the dynamic typing when deemed possible. The same goes for many other python conventions.

During the tail end of the project the design decisions started to feel a bit restrictive as many assumptions made at design time proved to be slightly incorrect. If the project had been far from finished, when these problems had arisen, a redesign would have been considered. Alas since the project was deemed to be close to completion and since the self imposed soft deadline was approaching the necessary redesign has not been executed. This approach proved to be origin of minor frustrations when the mistakes in the design where made obvious, but I believe it to have been a good example of unideal software development occurrences that happen way too often in real projects.

[Back to index](./index.md) |
[Previous Chapter](./testing.md) |
