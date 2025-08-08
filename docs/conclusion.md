---
layout: page
title: Conclusion
---

## Future work

### Further testing

Although the projects used are a good sample of non trivial projects, as a dataset they do lack in variety, being mainly centered on scala language projects. Other projects could be added to the dataset to test for other languages and tech stacks.

Also when in the tests where the file contents where provided in the prompt, a `test.sh` file was always listed, containing the actual test commands that would be run to test the generated dev env config. The presence of such explicit testing files might have helped AutoDev's generation and in real applications they might not be present. Further testing could be done by not providing these files through the prompt and see if the generation quality diminishes.

### Improve prompt customization

Some nice features to add would be:

- The possibility of defining different prompts for folder and file listings, maybe by adding two tags specific to the file system object type.
- The possiblity of blacklisting certain folders or files, so as to not 

### Remote models

As of now AutoDev installs models locally.

This means that a local download of every model is necessary before every first use.

Also the dev env config generation is done locally so it can take a lot of time.

A feature could be implemented to enable users to actually use remote models instead of local models for the dev env config generation.

### Packaging

As of now the project is run using the uv python build system and it is intended to be used through the just tool.

Ideally the project could be turned into a pip package (uv actually provides a way to easily do this at [https://docs.astral.sh/uv/guides/package/]) so that it could be installed globally (e.g. with `pip install AutoDev`).

[Back to index](./index.md) |
[Previous Chapter](./testing.md) |
