# Create a shared directory first
readonly SHARE_DIR_NAME=.share-dev-environments
readonly SHARE_DEV_HOME=$HOME/$SHARE_DIR_NAME
test ! -d $SHARE_DEV_HOME && mkdir $SHARE_DEV_HOME

# Inject script to activate shared environment into .bash_profile at the first time
test -r $SHARE_DEV_HOME/bash_active_dev && readonly is_existed=true
if [[ -z "${is_existed}" ]]; then 
 echo 'File not found'
 touch $SHARE_DEV_HOME/bash_active_dev
 test -r ~/.bash_profile && echo "source ~/$SHARE_DIR_NAME/bash_active_dev" >> ~/.bash_profile
fi

# Default start modules include when installing (must be call at the begining)
desf() {      
    echo '\n=============================================================================='
    echo ".........Installing module: $1"
    echo '=============================================================================='
}
readonly REMOTE_LINK_MODULES='https://raw.githubusercontent.com/make-everything-simple/share-dev-environments/master/MacOS'
curl -o $SHARE_DEV_HOME/bash_base $REMOTE_LINK_MODULES/bash_base.sh
echo "test -r ~/$SHARE_DIR_NAME/bash_base && source ~/$SHARE_DIR_NAME/bash_base" > $SHARE_DEV_HOME/bash_active_dev

# Custom modules that user want to install
lowercase() {
    echo $1 | tr [:upper:] [:lower:]
}

readonly SUPPORTED_MODULES='(a) Android,(i) iOS, (p) Public key infrastructure includes ssh and gpg, (rn) React Native'
echo "Which modules do you want to install: $SUPPORTED_MODULES?"
read -p "Exmple input a,i for Android and iOS or leave empty for all: " modules
modules=${modules:-a,i,p,rn}
modules_lowercase="$(lowercase $modules)"

if [[ "${modules_lowercase}" = *"p"* ]]; then
  desf "pki (Public Key Infrastructure)"
  curl -o $SHARE_DEV_HOME/bash_pki $REMOTE_LINK_MODULES/bash_pki.sh
  echo "test -r ~/$SHARE_DIR_NAME/bash_pki && source ~/$SHARE_DIR_NAME/bash_pki" >> $SHARE_DEV_HOME/bash_active_dev
fi

if [[ "${modules_lowercase}" = *"a"* ]]; then
  desf "android (Android)"
  curl -o $SHARE_DEV_HOME/bash_android $REMOTE_LINK_MODULES/bash_android.sh
  echo "test -r ~/$SHARE_DIR_NAME/bash_android && source ~/$SHARE_DIR_NAME/bash_android" >> $SHARE_DEV_HOME/bash_active_dev
fi

if [[ "${modules_lowercase}" = *"i"* ]]; then
  desf "ios (iOS)"
  curl -o $SHARE_DEV_HOME/bash_ios $REMOTE_LINK_MODULES/bash_ios.sh
  echo "test -r ~/$SHARE_DIR_NAME/bash_ios && source ~/$SHARE_DIR_NAME/bash_ios" >> $SHARE_DEV_HOME/bash_active_dev
fi

if [[ "${modules_lowercase}" = *"rn"* ]]; then
  desf "rn (React Native)"
  curl -o $SHARE_DEV_HOME/bash_react_native $REMOTE_LINK_MODULES/bash_react_native.sh
  echo "test -r ~/$SHARE_DIR_NAME/bash_react_native && source ~/$SHARE_DIR_NAME/bash_react_native" >> $SHARE_DEV_HOME/bash_active_dev
fi

# Default end modules include when installing (must be call at the end)
curl -o $SHARE_DEV_HOME/bash_end $REMOTE_LINK_MODULES/bash_end.sh
echo "test -r ~/$SHARE_DIR_NAME/bash_end && source ~/$SHARE_DIR_NAME/bash_end" >> $SHARE_DEV_HOME/bash_active_dev

# Quick overview structure
main() {
    echo '\n=================================(^_^)========================================'
    echo 'Each module has the same template'
    echo '[MODULE_NAME]_tools: overview tools on this modules'
    echo '[MODULE_NAME]_help: overview utility supported commands on this modules'
    echo 'Congratulation: You installed successfully. Thanks and enjoy your work!\n'
    echo "||==========================================================================||"
    echo '||Noted: must refresh environment, run the command $ source ~/.bash_profile ||'
    echo "||==========================================================================||"
}
main