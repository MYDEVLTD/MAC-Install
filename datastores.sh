#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Install data stores
brew install mysql

mysql.server start 


mysql -uroot << 'EOF'
SET PASSWORD FOR root@localhost = "secret";FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE user='root' AND host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE user='';
FLUSH PRIVILEGES;
EOF

brew install postgresql
brew tap mongodb/brew
brew install mongodb-community@5.0
brew services start mongodb-community

brew install redis
brew services start redis
brew install elasticsearch

# Install mysql workbench
brew install wget
wget https://gist.githubusercontent.com/jonjack/84e24ed5f44e452e629cfe01cf472267/raw/987362b8bd554b49ecc136213321d5f27c89efb0/mysqlworkbench-8.0.25.rb
brew install --cask mysqlworkbench-8.0.25.rb

brew install --cask dbeaver-community
brew install --cask nosqlbooster-for-mongodb


# Remove outdated versions from the cellar.
brew cleanup
