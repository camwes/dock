#!/bin/bash
FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
gem=~/.rvm/bin/gem
npm=/usr/bin/npm

function doIt() {
  rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av --no-perms $FILE_DIR/ ~
  source ~/.zshrc
  brew bundle Brewfile
  ./.cask
  sudo npm install -g bower grunt-cli forever coffee-script node-inspector strong-cli
  sudo gem install sass compass ceaser-easing compass-normalize localtunnel
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av --no-perms $FILE_DIR/ ~
    source ~/.zshrc
  fi
  read -p "Do you want to install necessary CLIs with Homebrew? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    brew bundle Brewfile
  fi
  read -p "Do you want to install GUI apps with Cask? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./.cask
  fi
  read -p "Do you want to install Rubygems and Node Modules? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    # install node modules 
    sudo npm cache clean
    sudo npm install -g bower grunt-cli forever coffee-script node-inspector strong-cli
    # install Ruby gems
    sudo gem install sass compass ceaser-easing compass-normalize localtunnel
  fi
fi
unset doIt
