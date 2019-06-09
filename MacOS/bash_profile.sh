#==============================================#
# Default commands
#==============================================#
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/Cellar:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

#==============================================#
# General commands
#==============================================#
alias showfiles="defaults write com.apple.finder AppleShowAllFiles true"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles false"
alias killfiles="killall Finder"
alias clearcache="sudo purge"

export SCRIPTS=/Applications/Scripts
export COMMAND_LINE_HOME=/Applications/CommandLine
alias refresh="source ~/.bash_profile"
alias myip="ifconfig en0"
capitalize() {
    echo $1 | awk '{print toupper(substr($0, 0, 1)) substr($0, 2)}'
}

uppercase() {
    echo $1 | tr [:lower:] [:upper:]
}

lowercase() {
    echo $1 | tr [:upper:] [:lower:]
}

#==============================================#
# info port, process
#==============================================#
pidport() {
 lsof -n -i4TCP:$1 | grep LISTEN
}
alias pidkill="kill -9 $1"

#==============================================#
# install develement tools
#==============================================#
alias install_sdkman="curl -s https://get.sdkman.io | bash"
alias install_gpg="brew install gnupg gnupg2"
alias install_nvm="brew install nvm"
alias install_gradle="sdk install gradle"

install_oh_my_zsh() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

showInfo() {
  echo '==========================================='
  echo 'Information some development tools on MACOS'
  echo '1. Homebrew: is a free and open-source software package management system that simplifies the installation of single versions software on Apple macOS operating system and Linux'
  echo '2. SDKMAN (GVM): is a tool for managing parallel versions of multiple Software Development Kits on most Unix based systems'
  echo '3. Node Version Manager (NVM): Simple bash script to manage multiple active node.js versions'
  echo '4. GnuPG is a complete and free implementation of the OpenPGP standard. GnuPG allows you to encrypt and sign your data and communications'
  echo '5. Oh My Zsh is an open source, community-driven framework for managing your zsh configuration'
  echo '==========================================='
}

installTools() {
    echo '==========================================='
    echo 'Which tools do you want install (S) SDKMAN,(G) GnuPG key, (N) Node Version Manager, (O) Oh My Zsh?'
    read name
  
    if [ "$(lowercase $name)" = "S" ]; then
        install_sdkman
    elif [ "$(lowercase $name)" = "G" ]; then
        install_gpg
    elif [ "$(lowercase $name)" = "N" ]; then
        install_nvm
    elif [ "$(lowercase $name)" = "O" ]; then
        install_oh_my_zsh
    else
        echo 'please check your input to install'
    fi
    echo '==========================================='
}

#==============================================#
# install android tools
#==============================================#
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_51.jdk/Contents/Home

export ANDROID_HOME=${HOME}/Library/Android/sdk
export ANDROID_SDK_ROOT=${HOME}/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

androidTools() {
  echo '==========================================='
  echo '1. JDK (Java SE Development Kit). For Java Developers. Includes a complete JRE plus tools for developing, debugging, and monitoring Java applications. 
        install: https://docs.oracle.com/cd/E19182-01/820-7851/inst_cli_jdk_javahome_t/'
  echo '2. Android SDK (software development kit) is a set of development tools used to develop applications for Android platform.
        install: https://developer.android.com/studio'
  echo '3. IDE for Android: Android Studio, IntelliJ (Optional)'
  echo '4. Gradle is an open-source build automation tool focused on flexibility and performance. Gradle build scripts are written using a Groovy or Kotlin DSL.
        install: $ install_gradle'
  echo 'Noted: check path of JAVA_HOME (ex: jdk1.8.0_51.jdk) in .bash_profile to make sure we use correctly'
  echo '==========================================='
}

androidCLIs() {
  echo '==========================================='
  echo '$ androidTools: check required tools for Android development'
  echo '$ emulators: show list android emulators'
  echo '$ startEmulator $emulator_name: launch a specific emulator'
  echo '==========================================='
}
alias emulators="emulator -list-avds"
startEmulator() {
  emulator -avd $1
}

#==============================================#
# install iOS tools
#==============================================#
alias install_xcodeCLI='xcode-select --install'
alias simulators="xcrun simctl list"
xcodeProfiles() {
  open ~/Library/MobileDevice/Provisioning\ Profiles/
}
xcodeCleanCache() {
 echo 'clearn all data in folder Library/Developer/Xcode/DerivedData/'
 rm -rf ~/Library/Developer/Xcode/DerivedData/
}

xcodeTools() {
  echo '==========================================='
  echo '1. Xcode: install Xcode IDE https://developer.apple.com/xcode/'
  echo '2. Xcode command line tools: allows you to do command line development in macOS $install_xcodeCLI'   
  echo '==========================================='
}

xcodeCLIs() {
 echo '==========================================='
 echo '$ xcodeTools: check required tools for iOS development'
 echo '$ xcodeCleanCache: clean DerivedData folder'
 echo '$ simulators:      list iOS simulators'
 echo '$ xcodebuild:      build Xcode projects and workspaces.'
 echo '$ runOnSimulator $simulator_name: run react-native on a specific simulator'
 echo '$ xcrun:           Run or locate development tools and properties.'
 echo '$ xcode-select:    Manages the active developer directory for Xcode and BSD tools.'
 echo '$ xcodeProfiles:   open Provisioning Profiles of xcode'
 echo '==========================================='
}

#==============================================#
# install react-native tools
#==============================================#
alias nodesRemote='nvm ls-remote --lts'
alias nodesLocal='nvm ls'
alias nodeInstall='nvm install $1'
alias nodeUse='nvm use $1'
alias rn-debugger='open "rndebugger://set-debugger-loc?host=localhost&port=19001"'
alias install_watchman='brew install watchman'
alias install_expo_cli='npm install -g expo-cli'
alias install_react_native_cli='npm install -g react-native-cli'
alias install_react_native_debugger='brew update && brew cask install react-native-debugger'

reactNativeTools() {
  echo '==========================================='
  echo '1. $ install_nvm: node version manager'
  echo '2. $ nodeInstall [VERSION]: install node with sepecify VERSION $ nodesRemote check avaliable versions on remote'
  echo '3. $ install_expo_cli: install expo cli to develop without setup Android and iOS until call $ expo eject'
  echo '4. $ install_react_native_cli: install React Native CLI required setup Android and iOS'
  echo '5. $ install_watchman: watching changes in the filesystem [Only required for React Native CLI]'
  echo '6. $ xcodeTools: check required tools for iOS development [Only required for React Native CLI]'
  echo '7. $ androidTools: check required tools for Android development [Only required for React Native CLI]'
  echo '8. $ install_react_native_debugger: a standalone app for debugging React Native apps, and includes React Inspector / Redux DevTools '
  echo '==========================================='
}

reactNativeCLIs() {
    echo '==========================================='
    echo '$ nodesLocal: list installed nodes on local'
    echo '$ nodeUse: specify a node version depends on each service/app'
    echo '$ rn-debugger: turn on debug mode'
    echo '$ runOniOS: run the app on default simulator iPhone X'
    echo '$ runOniOSSimulator [NAME]: run the app on a specific simulator'
    echo '$ runOnAndroid: run the app on luanched emulator|device'
    echo '$ runOnAndroidEmulator [NAME]: run the app on a specific emulator'
    echo '$ noted: Android must start emulator before run the app, iOS can start simulator when launching the app automatically'
    echo '==========================================='
}

runOniOSSimulator() {
 react-native run-ios --simulator $1
}

runOniOS() {
 react-native run-ios
}

runOnAndroidEmulator() {
    echo 'After start emulator $1. Please open new shell and call $ runOnAndroid'
    startEmulator $1
}

runOnAndroid() {
    react-native run-android
}

#==============================================#
# SSH key connect without username or password
# Base on PKI: more secure than https
# port defaut: 22 change to 443(web https) when 
# firewalls refuse to allow SSH connections entirely.
#==============================================#
alias sshGen='ssh-keygen -t rsa -b 4096 -C $1'
alias sshKeys='ls -al ~/.ssh'
alias sshEditPassphrase='ssh-keygen -p'
alias checkSum='shasum -a 256 $1'
alias fingerprint='ssh-keygen -E md5 -lf $1'

sshCopy() {
  echo 'copy public key save to paste board of key:' $1
  pbcopy < ~/.ssh/$1.pub
}

sshAddToAgent() {
    echo '==========================================='
    eval "$(ssh-agent -s)"
    ssh-add -K ~/.ssh/$1
    echo '==========================================='
}

sshCLIs() {
    echo '==========================================='
    echo '$ sshGen [email]: generate a new ssh key rsa 4096-bit'
    echo '$ sshKeys: show list of ssh keys existed in your machine'
    echo '$ sshAddToAgent [KEY_NAME]: add KEY_NAME to sh-agent and store your passphrase in the keychain'
    echo '$ sshCopy [KEY_NAME]: copy public key to add to github. Profile -> Settings -> SSH and GPG keys -> add new & paste content'
    echo '$ sshEditPassphrase: adding or changing a passphrase'
    echo '$ checkSum [KEY_NAME]: get checksum of sshkey'
    echo '$ fingerprint [KEY_NAME]: get Fingerprint of a private|public key'
    echo '==========================================='
}

#==============================================#
# gpg keys to sign commit, tag...
#==============================================#
alias gpgKeys='gpg --list-secret-keys --keyid-format LONG'
alias gpgGen='gpg --full-generate-key'
alias gpgGenOld='gpg --default-new-key-algo rsa4096 --gen-key'
alias gpgAddToGlobal='git config --global user.signingkey $1 && git config --global commit.gpgsign true'
alias gpgAddToLocal='git config --local user.signingkey $1 && git config --local commit.gpgsign true'
alias gpgPublicKey='gpg --armor --export GPG key $1'
alias gpgSignCommit='GIT_TRACE=1 git commit -S -m $1'
alias gpgGrantPermissionUser='sudo chown -R $1 ~$1/.gnupg'
alias gpgCheckSign='sudo echo "Is commit message signed?" | gpg --clearsign'
alias gpgIsEnable='git config -l | grep gpg'

gpgEdit() {
  echo '==========================================='
  gpg --edit-key GPG key $1
  echo '$ gpg> adduid: to add the user ID details'
  echo '==========================================='
}

gpgUpdatePath() {
  echo '==========================================='
  test -r ~/.bash_profile && echo 'export GPG_TTY=$(tty)' >> ~/.bash_profile
  echo 'export GPG_TTY=$(tty)' >> ~/.profile
  echo '==========================================='
}

gpgTroubleShoot() {
  echo '==========================================='
  echo '$ gpgSignCommit [message]: sign commit with trace the error'
  echo '$ gpgGrantPermissionUser [user]: allow user can run the gpg command'
  echo '$ gpgCheckSign: check wether sign or not'
  echo '$ export GPG_TTY=$(tty): if we saw the error Inappropriate ioctl for device'
  echo '$ gpgIsEnable: check to know whether enable sign or not'
  echo '==========================================='
}

gpgCLIs() {
  echo '==========================================='
  echo '$ gpgGen:  generate new GPG keys (gpg version > 2.1.17) else $ gpgGenOld'
  echo '$ gpgKeys: list GPG keys for which you have both a public and private key'
  echo '$ gpgEdit: associating an email with your GPG key'
  echo '$ gpgPublicKey [KEY_ID]: get public key to add to github or receiver to verify signing'
  echo '$ gpgUpdatePath: update environment on shell to use GPG key'
  echo '$ gpgAddToGlobal [KEY_ID]: add KEY_ID to sign on config global of git'
  echo '$ gpgAddToLocal [KEY_ID]: add KEY_ID to sign on config local of git'
  echo '$ gpgTroubleShoot: show related issue on gpg when signing often is permission'
  echo '==========================================='
}

#==============================================#
# Trigger other scripts run to activate tools
#==============================================#
###-tns-completion-start-###
if [ -f $HOME/.tnsrc ]; then 
    source $HOME/.tnsrc 
fi
###-tns-completion-end-###
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"