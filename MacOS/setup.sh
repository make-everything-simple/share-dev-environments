curl -O https://raw.githubusercontent.com/make-everything-simple/share-dev-environments/master/MacOS/bash_profile.sh
mv bash_profile.sh $HOME/.bash_profile_development
test -r ~/.bash_profile && echo 'test -r ~/.bash_profile_development && source ~/.bash_profile_development' >> ~/.bash_profile
source ~/.bash_profile