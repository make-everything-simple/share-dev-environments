#!/bin/bash
#
# Utility commands for iOS Development

#==============================================#
# install iOS tools
#==============================================#
alias install_xcode_cli='xcode-select --install'
alias simulators="xcrun simctl list"
xcode_profiles() {
  open ~/Library/MobileDevice/Provisioning\ Profiles/
}
xcode_clean() {
 echo 'clearn all data in folder Library/Developer/Xcode/DerivedData/'
 rm -rf ~/Library/Developer/Xcode/DerivedData/
}

xcode_tools() {
  beginf
  echo '1. Xcode: install Xcode IDE https://developer.apple.com/xcode/'
  echo '2. Xcode command line tools: allows you to do command line development in macOS $install_xcode_cli'   
  endf
}

xcode_help() {
 beginf
 echo '$ xcode_tools: check required tools for iOS development'
 echo '$ xcode_clean: clean DerivedData folder'
 echo '$ simulators:      list iOS simulators'
 echo '$ xcodebuild:      build Xcode projects and workspaces.'
 echo '$ runOnSimulator $simulator_name: run react-native on a specific simulator'
 echo '$ xcrun:           Run or locate development tools and properties.'
 echo '$ xcode-select:    Manages the active developer directory for Xcode and BSD tools.'
 echo '$ xcode_profiles:   open Provisioning Profiles of xcode'
 endf
}

IS_USE_IOS_ENV=1