#!/bin/bash
FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Install homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
# Install brew cask
brew tap phinze/cask
brew install brew-cask
# Bootstrap the command line
./$FILE_DIR/dotfiles/bootstrap.sh -f
# This script will:
#   1. Copy dotfiles to home dir (dotfiles)
#   2. install command line apps using brew (dotfiles/Brewfile)
#   3. install gui apps upsing brew casks (dotfiles/.cask)
#   4. install ruby gems and node modules
