# Cat Breeds

## Project Setup

### Introduction

To configure and build the project, several tools are employed to streamline the process:

- [Make](https://www.gnu.org/software/make/): Manages tool installations and facilitates build execution.
- [Brew](https://docs.brew.sh): Manages dependencies and tool installations.
- [Mint](https://github.com/yonaskolb/Mint): Installs and runs Swift command-line tool packages.
- [SwiftLint](https://github.com/realm/SwiftLint): Enforces Swift code style guidelines and conventions.
- [Sourcery](https://github.com/krzysztofzablocki/Sourcery): Dynamically generates secret keys in `.swift` files.

### Commands

#### Environment Setup and Tool Installation

Before building the project, manually create the `.env` file in the root folder. This file will manage secret keys for the project.

**Important:** Use `.env_template` as a guide.

After creating the `.env` file, set up the environment and install all the aforementioned tools by running:

```shell
make setup
```


### Secret Management

To safeguard sensitive data, configure the `.env` file locally, ensuring that sensitive information is not pushed to the repository.

Running `make setup`, `make config_sourcery`, or a Build Phase script before building the project will generate a Swift file with secret keys in the `SharedSource` package using the `Sourcery` library, based on the `.env` file you've created.

To add a new secret key, update the `.env` file as described above, modify the `.sourcery.yml` file, and adjust the `EnvironmentVars.stencil` file in the `SharedSource` package's `Template` folder.

*Important:* All files containing secret keys, such as `.env`, and the generated file `EnvironmentVars.generated.swift`, are included in the `.gitignore`.

