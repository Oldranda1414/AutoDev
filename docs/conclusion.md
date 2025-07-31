---
layout: page
title: Conclusion
---

## Future work

### Further testing

Although the projects used are a good sample of non trivial projects, as a dataset they do lack in variety, being mainly centered on scala language projects. Other projects could be added to the dataset to test for other languages and tech stacks.

### Remote models

As of now AutoDev installs models locally.

This means that a local download of every model is necessary before every first use.

Also the dev env config generation is done locally so it can take a lot of time.

A feature could be implemented to enable users to actually use remote models instead of local models for the dev env config generation.

### Packaging

As of now the project is run using the uv python build system and it is intended to be used through the just tool.

Ideally the project could be turned into a pip package (uv actually provides a way to easily do this at [https://docs.astral.sh/uv/guides/package/]) so that it could be installed globally (e.g. with `pip install AutoDev`)

[Back to index](./index.md) |
[Previous Chapter](./testing.md) |
