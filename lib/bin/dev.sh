#!/bin/bash
readonly ScriptVersion="0.2"
readonly PROGDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
readonly HOMEDIR="$HOME"
readonly PROGNAME=$(basename "$0")
readonly LOG_FILE=$PROGDIR/../../logs/dev.error.log
readonly DOTFILES=$PROGDIR/../dotfiles
readonly PATCHES=$PROGDIR/../patches
readonly INSTALL_DIR=$PROGDIR/../install
readonly CONFIG_DIR=$PROGDIR/../config
readonly ARGS=( "$@" )
readonly GITDIR=/home/git
readonly NGINX_DIR=/etc/nginx
readonly g=/usr/bin/git
readonly gem=/usr/bin/gem
readonly brew=/usr/local/bin/brew
readonly npm=/usr/local/bin/npm

exec 3>&1 1>>"${LOG_FILE}" 2>&1;
    
function command_exists () {
    type "$1" &> /dev/null ;
}
function install_homebrew () {
    echo -e "\nInstalling Homebrew" 1>&3;
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" | tee /dev/fd/3;
    $brew tap phinze/homebrew-cask 1>&3;
    $brew install brew-cask 1>&3;
    $brew tap homebrew/versions 1>&3;
    $brew tap homebrew/dupes 1>&3;
    $brew tap caskroom/fonts 1>&3;
    $brew tap caskroom/versions 1>&3;
    $brew tap josegonzalez/homebrew-php 1>&3;
}
function sync_dotfiles () {
  # Sync Dotfiles
  rsync --exclude ".DS_Store" --exclude "README.md" --exclude "*#" --exclude "*~" --exclude ".emacs.d/elpa/*" -av --no-perms $DOTFILES/ ~ 1>&3;
}
function gem_install () {
    sudo $gem update --system 1>&3;
    $gem update 1>&3;
    sudo $gem install bundler 1>&3;
    bundle install | tee /dev/fd/3;
}
function npm_install () {
    # install node modules
    $npm cache clean 1>&3;
    $npm update $npm -g 1>&3;
    $npm update -g 1>&3;
    
    function installGlobal() {
      # TODO: improve this to work all 
      if command_exists "${@}"; then
          echo -e "${@}:" $("${@}" "--version") 1>&3;
      else
          $npm install -g "${@}" | tee /dev/fd/3;
      fi
    }
    installGlobal bower
    installGlobal forever
    installGlobal node-inspector
    installGlobal ohm
    installGlobal grunt-cli
    installGlobal coffee-script
    $npm ls -g --depth=0 1>&3;
}
function main () {
  echo -e "\nPreparing to sync Dotfiles..."  1>&3;
  echo -e "\nThis may overwrite existing files in your home directory." 1>&3;
  sync_dotfiles
  # OS X Software Updates
  sudo softwareupdate -i -a 1>&3;
  if command_exists brew ; then
      echo -e "\nBrew Installed, continuing" 1>&3;
  else
      install_homebrew
  fi
  echo -e " \nInstalling apps and bins via Homebrew" 1>&3;
  "${PROGDIR}"/brew.sh 1>&3;
  echo -e "\nInstalling RubyGems" 1>&3;
  gem_install
  echo -e "\nInstalling Node Modules" 1>&3;
  npm_install
}

main
unset command_exists
unset install_homebrew
unset sync_dotfiles
unset gem_install
unset npm_install
unset main
exit 0
