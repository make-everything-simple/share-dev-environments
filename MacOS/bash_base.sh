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
alias show_files='defaults write com.apple.finder AppleShowAllFiles true'
alias hide_files='defaults write com.apple.finder AppleShowAllFiles false'
alias kill_files='killall Finder'
alias clear_cache='sudo purge'

export SCRIPTS=/Applications/Scripts
export COMMAND_LINE_HOME=/Applications/CommandLine
alias refresh='source ~/.bash_profile'
alias myip='ifconfig en0'
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
alias beginf='echo ==========================================='
alias endf='echo ==========================================='
alias install_sdkman='curl -s https://get.sdkman.io | bash'
alias install_nvm='brew install nvm'
alias install_gradle='sdk install gradle'

install_oh_my_zsh() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

base_tools() {
  beginf
  echo 'Information some development tools on MACOS'
  echo '1. Homebrew: is a free and open-source software package management system that simplifies the installation of single versions software on Apple macOS operating system and Linux'
  echo '2. SDKMAN (GVM): is a tool for managing parallel versions of multiple Software Development Kits on most Unix based systems'
  echo '3. Node Version Manager (NVM): Simple bash script to manage multiple active node.js versions'
  echo '4. Oh My Zsh: is an open source, community-driven framework for managing your zsh configuration'
  endf
}

base_help() {
    beginf
    readonly supported_tools='(S) SDKMAN, (N) Node Version Manager, (O) Oh My Zsh'
    echo "Which tools do you want install $supported_tools?"
    read name
  
    if [ "$(uppercase $name)" = "S" ]; then
        install_sdkman
    elif [ "$(uppercase $name)" = "N" ]; then
        install_nvm
    elif [ "$(uppercase $name)" = "O" ]; then
        install_oh_my_zsh
    else
        echo 'Your input must be $supported_tools'
    fi
    endf
}