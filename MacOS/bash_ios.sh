#!/bin/bash
#
# Utility commands for iOS Development

#==============================================#
# install iOS tools
#==============================================#
alias install_xcode_cli='xcode-select --install'
alias simulators='xcrun simctl list'
ios_profiles() {
  open ~/Library/MobileDevice/Provisioning\ Profiles/
}
ios_clean() {
 echo 'clearn all data in folder Library/Developer/Xcode/DerivedData/'
 rm -rf ~/Library/Developer/Xcode/DerivedData/
}

ios_tools() {
  beginf
  echo '1. Xcode: install Xcode IDE https://developer.apple.com/xcode/'
  echo '2. Xcode CLI: allows you to do command line development in macOS'   
  endf
}

ios_help() {
 beginf
 echo '$ ios_tools: check required tools for iOS development'
 echo '$ install_xcode_cli: install xcode command line tool'
 echo '$ ios_clean: clean DerivedData folder'
 echo '$ simulators:      list iOS simulators'
 echo '$ xcodebuild:      build Xcode projects and workspaces.'
 echo '$ runOnSimulator $simulator_name: run react-native on a specific simulator'
 echo '$ xcrun:           Run or locate development tools and properties.'
 echo '$ xcode-select:    Manages the active developer directory for Xcode and BSD tools.'
 echo '$ ios_profiles:   open Provisioning Profiles of xcode'
 endf
}