#==============================================#
# Make Icon
#==============================================#
mes_icon() {
  echo "
   _   _   _   _     _   _   _   _   _   _  
  / \ / \ / \ / \   / \ / \ / \ / \ / \ / \ 
 ( M ) a ) k ) e ) ( S ) i ) m ) p ) l ) e )
  \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ \_/ 
  "
}

#==============================================#
# Default commands
#==============================================#
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/Cellar:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_51.jdk/Contents/Home
set_java_home() {
  export JAVA_HOME=$1
}

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
alias beginf="echo =============================================="
alias endf="echo =============================================="
alias groupf="echo ======================="
alias install_jdk="open 'https://www.oracle.com/java/technologies/javase-downloads.html'"
alias install_sdkman='curl -s https://get.sdkman.io | bash'
alias install_nvm='brew install nvm'

install_oh_my_zsh() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

base_tools() {
  beginf
  echo 'Information some development tools on MACOS'
  echo '\u2460 JDK (Java SE Development Kit). For Java Developers. Includes a complete JRE plus tools for developing, debugging, and monitoring Java applications'
  echo '\u2461 Homebrew: is a free and open-source software package management system that simplifies the installation of single versions software on Apple macOS operating system and Linux'
  echo '\u2462 SDKMAN (GVM): is a tool for managing parallel versions of multiple Software Development Kits on most Unix based systems'
  echo '\u2463 Node Version Manager (NVM): Simple bash script to manage multiple active node.js versions'
  echo '\u2464 Oh My Zsh: is an open source, community-driven framework for managing your zsh configuration'
  endf
}

base_setup() {
    beginf
    readonly supported_tools='(J) JDK, (S) SDKMAN, (N) Node Version Manager, (O) Oh My Zsh'
    echo "Which tools do you want install $supported_tools?"
    read name
  
    if [ "$(uppercase $name)" = "J" ]; then
        install_jdk
    elif [ "$(uppercase $name)" = "S" ]; then
        install_sdkman
    elif [ "$(uppercase $name)" = "N" ]; then
        install_nvm
    elif [ "$(uppercase $name)" = "O" ]; then
        install_oh_my_zsh
    else
        echo 'Your input must belongs to $supported_tools'
    fi
    endf
}

base_help() {
    beginf
    echo '$ base_tools: check required development tools on macOS'
    echo '$ base_setup: setup required development tools'
    echo '$ pidport [PORT]: get process ids run on specific port'
    echo '$ pidkill [PROCESS_ID]: kill a process base on id'
    echo '$ set_java_home [JDK_HOME]: set your JAVA_HOME if '
    echo '$ show_files: show all filed include hidden files'
    echo '$ hide_files: hide hidden files'
    echo '$ kill_files: kills current Finder processes'
    echo '$ clear_cache: clear cache to take more space'
    echo '$ refresh: apply new environments for current session of terminal'
    echo '$ myip: get my ip address'
    echo '$ capitalize: capitalize a string'
    echo '$ uppercase: uppercase a string'
    echo '$ lowercase: lowercase a string'
    endf
}