# Create a shared directory first
SHARE_DIR_NAME=.share-dev-environments
SHARE_DEV_HOME=$HOME/$SHARE_DIR_NAME
mkdir $SHARE_DEV_HOME

# Download environment files for each platform and move to shared directory
curl -o $SHARE_DEV_HOME/bash_base https://raw.githubusercontent.com/make-everything-simple/share-dev-environments/master/MacOS/bash_base.sh
curl -o $SHARE_DEV_HOME/bash_pki https://raw.githubusercontent.com/make-everything-simple/share-dev-environments/master/MacOS/bash_pki.sh
curl -o $SHARE_DEV_HOME/bash_android https://raw.githubusercontent.com/make-everything-simple/share-dev-environments/master/MacOS/bash_android.sh
curl -o $SHARE_DEV_HOME/bash_ios https://raw.githubusercontent.com/make-everything-simple/share-dev-environments/master/MacOS/bash_ios.sh
curl -o $SHARE_DEV_HOME/bash_react_native https://raw.githubusercontent.com/make-everything-simple/share-dev-environments/master/MacOS/bash_react_native.sh
curl -o $SHARE_DEV_HOME/bash_end https://raw.githubusercontent.com/make-everything-simple/share-dev-environments/master/MacOS/bash_end.sh
curl -o $SHARE_DEV_HOME/bash_active_dev https://raw.githubusercontent.com/make-everything-simple/share-dev-environments/master/MacOS/bash_active_dev.sh

# Inject script to activate shared environment into .bash_profile as entry file of bash
test -r ~/.bash_profile && test -r ~/$SHARE_DIR_NAME/bash_active_dev && echo "source ~/$SHARE_DIR_NAME/bash_active_dev" >> ~/.bash_profile

# Refresh bash's environment to show the result
source ~/.bash_profile