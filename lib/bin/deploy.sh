#!/bin/bash
readonly ScriptVersion="0.2"
readonly PROGDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
readonly HOMEDIR="$HOME"
readonly PROGNAME=$(basename "$0")
readonly LOG_FILE=$PROGDIR/../../logs/deploy.error.log
readonly DOTFILES=$PROGDIR/../dotfiles
readonly PATCHES=$PROGDIR/../patches
readonly INSTALL_DIR=$PROGDIR/../install
readonly CONFIG_DIR=$PROGDIR/../config
readonly ARGS=( "$@" )
readonly GITDIR=/home/git
readonly NGINX_DIR=/etc/nginx
readonly g=/usr/bin/git
exec 3>&1 1>>"${LOG_FILE}" 2>&1;

function command_exists () {
    type "$1" &> /dev/null ;
}
[[ $# -eq 0 ]] && {
    # no arguments
    echo -e "\ndeploy: Usage: PROGNAME your_repo {u|user|r|repo|b|branch|n|name}" 1>&3;
    exit 1
}
#-------------------
# Git Deployment
#-------------------
# u) USERNAME:        username of repository owner
# r) REPOSITORY:      name of the repository being added
# b) BRANCH:          branch to be checked out
#
options=":n:r:u:b:"
while getopts $options opt
do
  case $opt in
      n ) readonly service_name="${OPTARG}";;
      r ) readonly repository="${OPTARG}";;
      u ) readonly username="${OPTARG}";;
      b ) readonly branch="${OPTARG}";;
     \?) echo "Invalid option: -$OPTARG" 1>&3;;
      :) echo "Option -$OPTARG requires an argument." 1>&3;;
  esac
done

readonly git=$GITDIR/$service_name.git
readonly work_tree=$GITDIR/public/$service_name
readonly scripts_dir=$PROGDIR/../../apps/$service_name

function sshKeys() {
    read -n 1
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        #-------------------
        # SSH Key
        #-------------------
        sudo ssh-keygen 1>&3;
        sudo cat /root/.ssh/id_rsa.pub | tee /dev/fd/3;
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo -e "\ndeploy: Skipping ssh-keygen"  | tee /dev/fd/3;
    fi
}
function initBare() {
  read -n 1
  if [[ $REPLY =~ ^[Yy]$ ]]; then
      #-------------------
      # Git Repository Setup
      #-------------------
      sudo mkdir -p "$git" && cd "$git"
      sudo "$g" --bare init | tee /dev/fd/3;
  elif [[ $REPLY =~ ^[Nn]$ ]]; then
      echo -e "\ndeploy: Deployment Cancelled!" | tee /dev/fd/3;
      exit 1;
  fi
}
function gitAuth(){
    read -n 1
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "\ndeploy: Proceeding with Deploy Key" | tee /dev/fd/3;
        deployKey
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        echo -e "\ndeploy: Proceeding with HTTPS authentication... not advised" | tee /dev/fd/3;
        httpsAuth
    fi
}
function deployKey() {
    sudo "$g" --bare fetch git@github.com:"$username"/"$repository".git "$branch:$branch" | tee /dev/fd/3;
    provision
}
function httpsAuth() {
    sudo "$g" --bare fetch https://github.com/"$username"/"$repository".git "$branch:$branch" | tee /dev/fd/3;
    provision
}
function provision() {
    sudo cp "$scripts_dir"/hooks/pre-receive.sh "$git"/hooks/pre-receive
    sudo cp "$scripts_dir"/hooks/post-receive.sh "$git"/hooks/post-receive
    sudo chmod +x "$git"/hooks/pre-receive
    sudo chmod +x "$git"/hooks/post-receive
    sudo cp "$scripts_dir"/service.sh /etc/init.d/"$service_name"
    sudo chmod 0755 /etc/init.d/"$service_name"
    sudo mkdir -p "$work_tree"
    # Backup existing configs
    sudo mv "$NGINX_DIR"/sites-enabled "$NGINX_DIR"/sites-enabled.backup
    sudo mkdir -p "$NGINX_DIR"/sites-enabled
    # Copy new nginx.config  and site-available
    sudo cp "$scripts_dir/sites-available/$service_name" "$NGINX_DIR/sites-enabled/$service_name"
    sudo nginx -s stop
    sudo nginx -t | tee /dev/fd/3;
    sudo nginx
    sudo chown -R git:git "$GITDIR"
}
function cmdLine() {
    # SSH Keys
    echo -e "\ndeploy: Generate SSH Key?" 1>&3;
    sshKeys
    # Git Repo
    echo -e "\ndeploy: Init Bare Git repo?" 1>&3;
    initBare
    # Git Authentication
    echo -e "\ndeploy: Deploy key? [Y/N] (visit: https://github.com/$username/$repository/settings/keys)" 1>&3;
    gitAuth
}

echo -e "Working tree will be: $work_tree on branch $branch" 1>&3;
echo -e "Installing service $service_name, a git deployment for: github.com/$username/$repository" 1>&3;
echo -e "Sripts and Hooks are in: $scripts_dir" 1>&3;
echo -e "Git Directory: $git" 1>&3;
cmdLine "${ARGS[@]}"

unset httpsAuth
unset deployKey
unset initBare
unset provision
unset cmdLine
unset sshKeys
unset command_exists
unset main
exit 0