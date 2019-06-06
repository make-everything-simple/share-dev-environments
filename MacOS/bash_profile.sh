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

function install_oh_my_zsh() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function showInfo() {
  echo '==========================================='
  echo 'Information some development tools on MACOS'
  echo '1. Homebrew: is a free and open-source software package management system that simplifies the installation of single versions software on Apple macOS operating system and Linux'
  echo '2. SDKMAN (GVM): is a tool for managing parallel versions of multiple Software Development Kits on most Unix based systems'
  echo '3. Node Version Manager (NVM): Simple bash script to manage multiple active node.js versions'
  echo '4. GnuPG is a complete and free implementation of the OpenPGP standard. GnuPG allows you to encrypt and sign your data and communications'
  echo '5. Oh My Zsh is an open source, community-driven framework for managing your zsh configuration'
  echo '==========================================='
}

function installTools() {
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

function androidTools() {
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
  echo 'show list android emulators: $ emulators'
  echo 'launch a specific emulator :  $startEmulator $emulator_name'
}
alias emulators="emulator -list-avds"
startEmulator() {
  emulator -avd $1
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