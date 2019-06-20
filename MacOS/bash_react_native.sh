#!/bin/bash
#
# Utility commands for React Native Development.

#==============================================#
# install react-native tools
#==============================================#
alias rn_debugger='open "rndebugger://set-debugger-loc?host=localhost&port=19001"'
alias nodes_remote='nvm ls-remote --lts'
alias nodes_local='nvm ls'
alias node_use='nvm use $1'
alias install_node='nvm install $1'
alias install_watchman='brew install watchman'
alias install_expo_cli='npm install -g expo-cli'
alias install_react_native_cli='npm install -g react-native-cli'
alias install_react_native_debugger='brew update && brew cask install react-native-debugger'

rn_tools() {
  beginf
  echo '1. $ install_nvm: node version manager'
  echo '2. $ install_node [VERSION]: install node with sepecify VERSION $ nodes_remote check avaliable versions on remote'
  echo '3. $ install_expo_cli: install expo cli to develop without setup Android and iOS until call $ expo eject'
  echo '4. $ install_react_native_cli: install React Native CLI required setup Android and iOS'
  echo '5. $ install_watchman: watching changes in the filesystem [Only required for React Native CLI]'
  echo '6. $ xcodeTools: check required tools for iOS development [Only required for React Native CLI]'
  echo '7. $ androidTools: check required tools for Android development [Only required for React Native CLI]'
  echo '8. $ install_react_native_debugger: a standalone app for debugging React Native apps, and includes React Inspector / Redux DevTools '
  endf
}

rn_help() {
    beginf
    echo '$ nodes_local: list installed nodes on local'
    echo '$ node_use: specify a node version depends on each service/app'
    echo '$ rn_debugger: turn on debug mode'
    echo '$ rn_ios: run the app on default simulator iPhone X'
    echo '$ rn_ios_on_simulator [NAME]: run the app on a specific simulator'
    echo '$ rn_android: run the app on luanched emulator|device'
    echo '$ rn_android_on_emulator [NAME]: run the app on a specific emulator'
    echo '$ noted: Android must start emulator before run the app, iOS can start simulator when launching the app automatically'
    endf
}

rn_ios_on_simulator() {
 react-native run-ios --simulator $1
}

rn_ios() {
 react-native run-ios
}

rn_android_on_emulator() {
    beginf
    echo 'After start emulator $1. Please open new shell and call $ rn_android'
    endf
    startEmulator $1
}

rn_android() {
    react-native run-android
}

IS_USE_REACT_NATIVE_ENV=1