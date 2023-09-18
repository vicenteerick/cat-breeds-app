# Cat Breeds

## Project Setup

### Introduction

In order to configure and build the project, it utilizes various tools that assist in managing the process:
  
  - [Make](https://www.gnu.org/software/make/): Establishes rules for tool installations and build execution.
  - [Brew](https://docs.brew.sh): Manages dependencies and installations of required tools.
  - [Mint](https://github.com/yonaskolb/Mint): Manages that installs and runs Swift command line tool packages.
  - [SwiftLint](https://github.com/realm/SwiftLint): Enforces style guidelines and conventions for Swift code.
  - [Sourcery](https://github.com/krzysztofzablocki/Sourcery): Dynamically creates secret keys in `.swift` files.


### Commands

#### Secret Management

Before building the project, you need to create the file `.env` in the root folder. These file will manage secret keys for the project.

Running `make setup`, `make make config_sourcery` or a Build Phase script will before the build will generate a Swift file with secret keys in the `SharedSource` package using the `Sourcery` library.

To add a new secret key, update the `.env` file described above, the `.sourcery.yml` file, and the `EnvironmentVars.stencil` file in the `SharedSource` package's `Template` folder.

*Note:* All files containing the secret keys, such as `.env`, and the generated file `EnvironmentVars.generated.swift`, are included in the `.gitignore`.
*Note:* Use `.env_template` as guide.

#### Setup Environment and Install Tools

After created `.env` file, set up the environment and install all the tools mentioned above, running:

`make setup`
