# Share Development Environments
Align development mode among machines

## OS supports
- MacOS
  - Shell Style Guide: https://google.github.io/styleguide/shell.xml
  - bash_profile.sh: variable environments
  - setup.sh: script to setup and align development mode automatically
- Window: TBD

## How to setup
- MacOS
  - Download the setup script: curl -O https://raw.githubusercontent.com/make-everything-simple/share-dev-environments/master/MacOS/setup.sh
  - Grant permission to the script: chmod +x ./setup.sh
  - Execute the script: ./setup.sh
- Window: TBD

## Know issues
- This script can override existed variable environments on your machine although it aligns development mode.
