# Share Development Environments
Align development mode among machines

## OS supports
- MacOS
  - Shell Style Guide: [Google](https://google.github.io/styleguide/shell.xml)
  - Structure
    - bash_base: common variable environments, required tools
    - bash_end: active required tools must at the end of script
    - bash_android: utility commands and required tools for Android
    - bash_ios: utility commands and required tools for iOS
    - bash_react_native: utility commands and required tools for React Native
    - bash_pki: utility commands and required tools support for Public Key Infrastructure
    - setup: script to set up and align development mode automatically
- Window: TBD

## How to setup
- MacOS
  - Download the setup script: curl -O https://raw.githubusercontent.com/make-everything-simple/share-dev-environments/master/MacOS/setup.sh
  - Grant permission to the script: chmod +x ./setup.sh
  - Execute the script: ./setup.sh
- Window: TBD

## How to use
- $ simple: Run the command for hint

## Know issues
- This script can override existed variable environments on your machine although it aligns development mode.
