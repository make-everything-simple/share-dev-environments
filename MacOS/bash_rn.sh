# Utility commands for React Native Development.

#==============================================#
# install react-native tools
#==============================================#
alias nodes_remote='nvm ls-remote --lts'
alias nodes_local='nvm ls'
alias node_use="nvm use $1"
alias install_node="nvm install $1"
alias install_watchman='brew install watchman'
alias install_expo_cli='npm install -g expo-cli'
alias install_react_native_cli='npm install -g react-native-cli'
alias install_reactotron="open 'https://github.com/infinitered/reactotron/blob/master/docs/installing.md'"

rn_tools() {
  beginf
  echo '\u2460 Node: is an open-source, cross-platform, back-end JavaScript runtime environment that runs on the V8 engine and executes JavaScript code outside a web browser'
  echo '\u2461 nvm: is a version manager for node.js, designed to be installed per-user, and invoked per-shell'
  echo '\u2462 npx: is an npm package runner that can execute any package that you want from the npm registry without even installing that package'
  echo "\u2463 Expo: is a framework and a platform for universal React applications, a set of tools and services 
        that help you develop, build, deploy, and quickly iterate on iOS, Android, and web apps from the same codebase"
  echo '\u2464 React Native CLI: is a set of commands help you interact with the react native'
  echo "\u2465 Watchman: is a tool by Facebook for watching changes in the filesystem. It is highly recommended you install it for better performance"
  echo "\u2466 XCode: is Apple's integrated development environment (IDE) for macOS, used to develop software for macOS, iOS, iPadOS, watchOS, and tvOS."
  echo "\u2467 Android Studio: is the official integrated development environment (IDE) for Google's Android operating system"
  echo "\u2468 Reactotron: is an open-source desktop app that allows you to inspect Redux or MobX-State-Tree application state as well as view custom logs"
  endf
}

rn_setup() {
  beginf
  echo '$ install_nvm: node version manager'
  echo '$ install_node [VERSION]: install node with sepecify VERSION $ nodes_remote check avaliable versions on remote'
  echo '$ install_expo_cli: install expo cli to develop without setup Android and iOS until call $ expo eject'
  echo '$ install_react_native_cli: install React Native CLI required setup Android and iOS'
  echo '$ install_watchman: watching changes in the filesystem [Only required for React Native CLI]'
  echo '$ ios_tools: check required tools for iOS development [Only required for React Native CLI]'
  echo '$ android_tools: check required tools for Android development [Only required for React Native CLI]'
  echo '$ install_reactotron: a standalone app allows you to inspect Redux or MobX-State-Tree application state as well as view custom logs'
  endf
}

rn_help() {
    beginf
    echo '$ rn_tools: check required tools for React Native development'
    echo '$ rn_setup: setup required development tools'
    echo '$ nodes_local: list installed nodes on local'
    echo '$ node_use: specify a node version depends on each service/app'
    echo '$ rn_ios: run the app on default simulator iPhone X'
    echo '$ rn_ios_on_simulator [NAME]: run the app on a specific simulator'
    echo '$ rn_android: run the app on luanched emulator|device'
    echo '$ rn_android_on_emulator [NAME]: run the app on a specific emulator'
    echo 'Note: Android must start emulator before run the app, iOS can start simulator when launching the app automatically'
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
    echo "After start emulator $1. Please open new shell and call: rn_android"
    endf
    startEmulator $1
}

rn_android() {
    react-native run-android
}