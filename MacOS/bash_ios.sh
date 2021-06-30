# Utility commands for iOS Development

#==============================================#
# install iOS tools
#==============================================#
alias install_xcode="open 'https://developer.apple.com/xcode/'"
alias install_xcode_cli='xcode-select --install'
alias simulators='xcrun simctl list'
alias install_pod="open 'https://cocoapods.org/'"
alias install_carthage="open 'https://github.com/Carthage/Carthage#installing-carthage'"
alias spm_install="open 'https://github.com/apple/swift-package-manager'"

ios_profiles() {
  open ~/Library/MobileDevice/Provisioning\ Profiles/
}

ios_clean() {
 echo 'remove all data in folder Library/Developer/Xcode/DerivedData/'
 rm -rf ~/Library/Developer/Xcode/DerivedData/
}

ios_tools() {
  beginf
  echo '\u2460 Xcode: install Xcode IDE https://developer.apple.com/xcode/'
  echo '\u2461 Xcode CLI: allows you to do command line development in macOS'
  echo '\u2462 CocoaPods: is a centralized dependency manager'
  echo '\u2463 Carthage: is a decentralized dependency manager' 
  echo '\u2464 SPM: is a tool for managing distribution of source code back by Apple'
  endf
}

ios_setup() {
  beginf
  echo '$ install_xcode: install Xcode IDE'
  echo '$ install_xcode_cli: install Xcode CLI'
  echo '$ install_pod: install CocoaPods'
  echo '$ install_carthage: install Carthage'
  echo '$ spm_install: install Swift Package Manager'
  endf
}

ios_help() {
 beginf
 echo '$ ios_tools: check required tools for iOS development'
 echo '$ ios_setup: setup required development tools'
 echo '$ ios_clean: clean DerivedData folder'
 echo '$ simulators: list iOS simulators'
 echo '$ xcodebuild: build Xcode projects and workspaces.'
 echo '$ runOnSimulator $simulator_name: run react-native on a specific simulator'
 echo '$ xcrun: run or locate development tools and properties.'
 echo '$ xcode-select: manages the active developer directory for Xcode and BSD tools.'
 echo '$ ios_profiles: open Provisioning Profiles of xcode'
 endf
}