# shellcheck shell=bash
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
export PATH="/usr/local/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_51.jdk/Contents/Home
set_java_home() {
  export JAVA_HOME=$1
}

export SHARE_DEV_HOME=$HOME/.share-dev-environments

#==============================================#
# General commands
#==============================================#
alias show_files='defaults write com.apple.finder AppleShowAllFiles true'
alias hide_files='defaults write com.apple.finder AppleShowAllFiles false'
alias kill_files='killall Finder'
alias clear_cache='sudo purge'

alias refresh='source ~/.bash_profile'
alias myip='ifconfig en0'
capitalize() {
    echo "$1 | awk '{print toupper(substr($0, 0, 1)) substr($0, 2)}'"
}

uppercase() {
    echo "$1 | tr [:lower:] [:upper:]"
}

lowercase() {
    echo "$1 | tr [:upper:] [:lower:]"
}

###############################################################################
# Convert a string to array via splitting string by custom delimiter.
# Globals:
#   None
# Arguments:
#   source Value of string input as array
#   delimiter separate character each item in source value as array format
###############################################################################
convert_to_array() {
  local delimiter=${2:=,}
  echo $1 | tr "$delimiter" " "
}

###############################################################################
# Read a parameter until it has the value.
# Globals:
#   None
# Arguments:
#   None
###############################################################################
read_parameter() {
  while true; do
    local parameter
    read parameter
    if [[ -n "${parameter}" ]]; then
      break
    fi
  done

  echo $parameter
}

###############################################################################
# Register a module with the system to provide more ultility commands.
# Globals:
#   None
# Arguments:
#   src_file name of file of your module to copy at current directory
#   des_file name of file to register with system at target directory
###############################################################################
base_register() {
    local SHARE_DIR_NAME=.share-dev-environments
    mv $PWD/$1 $HOME/$SHARE_DIR_NAME/$2
    echo "test -r ~/$SHARE_DIR_NAME/$2 && source ~/$SHARE_DIR_NAME/$2" >> ~/$SHARE_DIR_NAME/bash_active_dev

}

###############################################################################
# Create symbolic links for the immediate child folders in a source folder.
# Globals:
#   None
# Arguments:
#   source_folder folder containing the child folders to link
#   destination_folder folder where the symbolic links are created
###############################################################################
create_symbolic_links() {
  local source_folder=${1:-}
  local destination_folder=${2:-}

  if [[ -z "${source_folder}" || -z "${destination_folder}" ]]; then
    echo "Usage: create_symbolic_links [SOURCE_FOLDER] [DESTINATION_FOLDER]" >&2
    return 1
  fi

  if [[ ! -d "${source_folder}" ]]; then
    echo "Source folder does not exist: ${source_folder}" >&2
    return 1
  fi

  source_folder=$(cd "${source_folder}" && pwd -P) || return 1
  mkdir -p "${destination_folder}" || return 1
  destination_folder=$(cd "${destination_folder}" && pwd -P) || return 1

  local child_folder
  local link_path
  for child_folder in "${source_folder}"/*/; do
    [[ -d "${child_folder}" ]] || continue
    link_path="${destination_folder}/$(basename "${child_folder%/}")"
    ln -sfn "${child_folder%/}" "${link_path}" || return 1
  done
}

#==============================================#
# info port, process
#==============================================#
pidport() {
 #shellcheck disable=2312
 lsof -n -i4TCP:"$1" | grep LISTEN
}
alias pidkill="kill -9"

#==============================================#
# install development tools
#==============================================#
alias beginf="echo =============================================="
alias endf="echo =============================================="
alias groupf="echo ======================="
alias remind_refresh="echo To take effect. Reload the environment by executing command 👉 $ refresh 👈"
alias install_jdk="open 'https://www.oracle.com/java/technologies/javase-downloads.html'"
alias install_sdkman='curl -s https://get.sdkman.io | bash'
alias install_nvm='brew install nvm'

# Display large message as group
group() {
  echo ''
  echo '#=============================================================================='
  echo "# $1"
  echo '#=============================================================================='
}

# Display small message as sub-group
group_s() {
  echo "-----------------------"
  echo "$1"
  echo "-----------------------"
}

install_oh_my_zsh() {
  # shellcheck disable=SC2312
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
    echo "Which tools do you want install ${supported_tools}?"
    read -r name
  
    # 1. Convert to uppercase once an d store the exit code safely
    upper_name=$(uppercase "${name}")

    # 2. Run the conditional checks against the variable
    if [[ "${upper_name}" = "J" ]]; then
      install_jdk
    elif [[ "${upper_name}" = "S" ]]; then
        install_sdkman
    elif [[ "${upper_name}" = "N" ]]; then
        install_nvm
    elif [[ "${upper_name}" = "O" ]]; then
        install_oh_my_zsh
    else
        echo "Your input must belongs to ${supported_tools}"
    fi
    endf
}

base_help() {
    beginf
    echo '$ base_tools: check required development tools on macOS'
    echo '$ base_register: register your reusable function from your custom module'
    echo '$ create_symbolic_links [SOURCE_FOLDER] [DESTINATION_FOLDER]: link child folders from source to destination'
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
    echo '$ convert_to_array: split a string to array by delimiter'
    echo '$ read_parameter: read a parameter until it has the value'
    endf
}