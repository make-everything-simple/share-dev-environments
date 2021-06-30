# Share Development Environments
Align development environment among machines | developers.
- Reduce time for setting up the environment when we change to a new machine 🚀
- Standardize commands for the development team 🙌
- Talk the same language in commands for team members 🙆
- Contribute to help your brain quick remember and prevent bad memory 🙏 

## Supported modules
- Common variable environments, required tools for macOS
- Common commands for Android
- Common commands for iOS
- Common commands for React Native
- Common commands for Public Key Infrastructure
  - Common commands for SSH (Secure Shell)
  - Common commands for GPG (GNU Privacy Guard) sign your commit or message
- Common commands for MongoDB


## OS support
- macOS only

## How to setup
- Download the setup run script: ``` curl -O https://raw.githubusercontent.com/make-everything-simple/share-dev-environments/master/MacOS/setup ```
- Grant the execute permission to the script: ``` chmod +x ./setup ```
- Execute the script: ``` ./setup ```
- `Note`: This script needs the admin permission to execute

## How to use
- Each module support two basic commands
  - `module_help`: overview utility supported commands on this module
  - `module_tools`: overview common tools on this module

| Module        | Help         | Tools           |
| ------------- |:------------:| :---------------:|
| Base          |  `base_help` |  `base_tools`   |
| Android       |`android_help`| `android_tools` |
| iOS           |  `ios_help`  |   `ios_tools`   |
| React Native  |  `rn_help`   |   `rn_tools`    |
| Public Key Infrastructures | `pki_help` |    `pki_tools` |
| MongoDB       | `mongo_help` | `mongo_tools`   |
- ```$ simple ```: entry command for all supported commands

## Contributors
- Follow Style Guide: [Shell](https://google.github.io/styleguide/shell.xml)