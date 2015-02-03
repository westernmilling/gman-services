#!/bin/bash

set -e

#echo "Add user"
#echo "gman" | passwd gman --stdin
#sudo adduser gman sudo

echo "Updates packages."
sudo apt-get update -y

echo "Installs packages."
sudo apt-get install build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev nodejs -y

echo "Installs ImageMagick for image processing"
sudo apt-get install imagemagick --fix-missing -y

echo "Installs RVM (Ruby Version Manager) for handling Ruby installation"
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable

# Load RVM into a shell session *as a function*
if [[ -s "~/.rvm/scripts/rvm" ]] ; then

  # First try to load from a user install
  source "~/.rvm/scripts/rvm"

elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then

  # Then try to load from a root install
  source "/usr/local/rvm/scripts/rvm"

else

  echo "ERROR: An RVM installation was not found.\n"

fi

echo "Installs Java 7 from source"
sudo apt-get install -y openjdk-7-jdk
export JAVA_HOME=`readlink -f /usr/bin/java | sed "s:bin/java::"`
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java" 1062

#echo "Installs JRuby from source"
## https://github.com/jruby/jruby/blob/master/BUILDING.md
#sudo apt-get install -y  maven
##sudo apt-get install oracle-java7-set-default
#java -version
##git clone https://github.com/jruby/jruby.git
#cd jruby; mvn install
#ant
#cd ..
##Potential symlink

echo "Installs JRuby from rvm"
rvm install jruby-1.7.16.1
rvm use jruby-1.7.16.1 --default
rvm alias create default jruby-1.7.16.1
rvm default

gem install bundler --no-rdoc --no-ri
gem install rails --no-rdoc --no-ri

echo -e "\n- - - - - -\n"
echo -e "Now we are going to print info to check that everything is done:\n"

# brew in ubuntu?
# echo -n "Should be brew 0.8 or higher:       brew "
# brew -v

echo -n "Should be sqlite 3.7.3 or higher: sqlite "
sqlite3 --version
echo -n "Should be java 7:                        "
java -version
echo -n "Should be jruby-1.7.16.1:                "
ruby -v
echo -n "Should be Rails 3.2.2 or higher:         "
rails -v
echo -e "\n- - - - - -\n"

debconf-set-selections <<< 'mysql-server mysql-server/root_password password gman'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password gman'
apt-get update
apt-get install -y -f mysql-server

