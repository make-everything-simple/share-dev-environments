# Utility commands for Public Key Infrastructures.

#==============================================#
# Introduction protocols use with PKI
#==============================================#
alias check_sum="shasum -a 256 $1"

pki_tools() {
  beginf
  echo '\u2460 SSH(Secure Socket Shell): is a cryptographic network protocol for operating network services securely over an unsecured network. Typical applications include remote command-line login and remote command execution'
  echo '\u2461 GPG (GNU Privacy Guard): is a complete and free implementation of the OpenPGP standard. GnuPG allows you to encrypt and sign your data and communications'
  endf
}

pki_help() {
  beginf
  echo '$ pki_tools: list supported tools in this module'
  echo '$ ssh_help: list all ultility commands supporting for SSH (Secure Shell)'
  echo '$ gpg_help: list all ultility commands supporting for GPG (GNU Privacy Guard)'
  echo '$ check_sum [KEY_NAME]: get check_sum of a key'
  endf
}

#==============================================#
# SSH key connect without username or password
# Base on PKI: more secure than https
# port defaut: 22 change to 443(web https) when 
# firewalls refuse to allow SSH connections entirely.
#==============================================#
alias ssh_gen="ssh-keygen -t rsa -b 4096 -C $1"
alias ssh_keys='ls -al ~/.ssh'
alias ssh_edit_passprase='ssh-keygen -p'
alias ssh_fingerprint="ssh-keygen -E md5 -lf $1"
alias ssh_about="open 'https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/about-ssh'"

#######################################
# Copy public key of a SSH Key to register with Git server.
# Globals:
#   None
# Arguments:
#   KEY_NAME is the file name without extension of your public key
# Outputs:
#   Copy value to the Clipboard
ssh_copy() {
  echo 'copy public key save to paste board of key:' $1
  pbcopy < ~/.ssh/$1.pub
}

#######################################
# Add a new SSH key to the ssh-agent to manage your keys.
# Globals:
#   None
# Arguments:
#   KEY_NAME is the file name of your private key
# Outputs:
#   none
ssh_add_to_agent() {
    beginf
    eval "$(ssh-agent -s)"
    ssh-add -K ~/.ssh/$1
    endf
}

ssh_help() {
    beginf
    echo '$ ssh_gen [email]: generate a new ssh key rsa 4096-bit'
    echo '$ ssh_keys: show list of ssh keys existed in your machine'
    echo '$ ssh_add_to_agent [KEY_NAME]: add KEY_NAME to sh-agent and store your passphrase in the keychain'
    echo '$ ssh_copy [KEY_NAME]: copy public key to add to github. Profile -> Settings -> SSH and GPG keys -> add new & paste content'
    echo '$ ssh_edit_passprase: adding or changing a passphrase'
    echo '$ ssh_fingerprint [KEY_NAME]: get Fingerprint of a private|public key'
    echo '$ ssh_about: get more information about ssh'
    endf
}

#==============================================#
# gpg keys to sign commit, tag...
#==============================================#
alias gpg_keys='gpg --list-secret-keys --keyid-format LONG'
alias gpg_gen='gpg --full-generate-key'
alias gpg_gen_old='gpg --default-new-key-algo rsa4096 --gen-key'
alias gpg_public_key="gpg --armor --export $1"
alias gpg_sign_commit="GIT_TRACE=1 git commit -S -m $1"
alias gpg_grant_permission="sudo chown -R $1 ~$1/.gnupg"
alias gpg_check_sign='sudo echo "Is commit message signed?" | gpg --clearsign'
alias gpg_is_enable='git config -l | grep gpg'
alias gpg_install="brew install gnupg gnupg2"
alias gpg_about="open 'https://docs.github.com/en/github/authenticating-to-github/managing-commit-signature-verification/about-commit-signature-verification'"

#######################################
# Enable GPG signing key for a specific project.
# Globals:
#   None
# Arguments:
#   SEC_KEY_ID is GPG key ID to specify a private key
# Outputs:
#   Add new key to git config local .git/config
gpg_add_to_local() {
  beginf
  git config --local user.signingkey $1
  git config --local commit.gpgsign true
  endf
}

#######################################
# Enable GPG signing key for all projects.
# Globals:
#   None
# Arguments:
#   SEC_KEY_ID is GPG key ID to specify a private key
# Outputs:
#   Add new key to git config global $HOME/.gitconfig
gpg_add_to_global() {
  beginf
  git config --global user.signingkey $1
  git config --global commit.gpgsign true
  endf
}

#######################################
# Add the user ID in detail for a GPG key.
# Globals:
#   None
# Arguments:
#   SEC_KEY_ID is GPG key ID to specify a private key
gpg_edit() {
  beginf
  gpg --edit-key $1
  echo '$ gpg> adduid: to add the user ID details'
  endf
}

gpg_update_path() {
  beginf
  test -r ~/.bash_profile && echo 'export GPG_TTY=$(tty)' >> ~/.bash_profile
  echo 'export GPG_TTY=$(tty)' >> ~/.profile
  endf
}

gpg_trouble_shoot() {
  beginf
  echo '$ gpg_sign_commit [message]: sign commit with trace the error'
  echo '$ gpg_grant_permission [user]: allow user can run the gpg command'
  echo '$ gpg_check_sign: check wether sign or not'
  echo '$ gpg_update_path: if we saw the error Inappropriate ioctl for device'
  echo '$ gpg_is_enable: check to know whether enable sign or not'
  endf
}

gpg_help() {
  beginf
  echo '$ gpg_install: install GnuPG tool'
  echo '$ gpg_gen:  generate new GPG keys (gpg version > 2.1.17) else $ gpg_gen_old'
  echo '$ gpg_keys: list GPG keys for which you have both a public and private key'
  echo '$ gpg_edit [SEC_KEY_ID]: associating an email with your GPG key'
  echo '$ gpg_public_key [SEC_KEY_ID]: get public key to add to github or receiver to verify signing'
  echo '$ gpg_update_path: update environment on shell to use GPG key'
  echo '$ gpg_add_to_global [SEC_KEY_ID]: add SEC_KEY_ID to sign on config global of git'
  echo '$ gpg_add_to_local [SEC_KEY_ID]: add SEC_KEY_ID to sign on config local of git'
  echo '$ gpg_trouble_shoot: show related issue on gpg when signing often is permission'
  echo '$ gpg_about: get more information commit signature verification wit GPG'
  endf
}

export GPG_TTY=$(tty)
