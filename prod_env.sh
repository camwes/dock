##!/bin/bash
FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
###################
# Create Git User
###################
sudo adduser --disabled-password --gecos "" git
sudo usermod -a -G sudo git
# Configure Time Zone 
sudo dpkg-reconfigure tzdata
sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get upgrade --show-upgraded
###################
# Install
###################
sudo apt-get install -y emacs htop tree git tig wget tmux rubygems unzip ntp fail2ban zsh
# Install hub for git
git clone https://github.com/github/hub.git
cd hub
sudo rake install prefix=/usr/local
cd -
# Install Mosh
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:keithw/mosh
sudo apt-get update
sudo apt-get install -y mosh
# Set clock/restart cron
ntpdate && hwclock –w
sudo service cron stop
sudo service cron start
# Install Rubygems
sudo gem install sass compass ceaser-easing compass-normalize bundle
###################
# SSH Key
###################
sudo ssh-keygen
sudo cat /root/.ssh/id_rsa.pub
###################
# Git Deployment
###################
# g) GIT:             location of git repository
# w) WORK_TREE:       location of working tree
# d) SCRIPTS_DIR:     location of hooks and scripts
# u) USERNAME:        username of repository owner
# r) REPOSITORY:      name of the repository being added
# n) SERVICE_NAME:    name of the service to be created
# b) BRANCH:          branch to be checked out
# Production:
sudo ./deploy.sh -u ohmlabs -r boilerplate -g /home/git/production.git -w /home/git/public/production -b master -d production -n ohm
# Staging:
sudo ./deploy.sh -u ohmlabs -r boilerplate -g /home/git/staging.git -w /home/git/public/staging -b master -d staging -n ohmstage
# Change Permissions for git user
sudo chown -R git:git /home/git/production.git/
sudo chown -R git:git /home/git/staging.git/
sudo chown -R git:git /home/git/public/
sudo chmod 0440 $FILE_DIR/stack/gitsudoer
sudo cp $FILE_DIR/stack/gitsudoer /etc/sudoers.d/
###################
# Stack
###################
sudo ./stack/core.sh
###################
# TODO: Firewall
###################
# sudo cp -i $FILE_DIR/stack/iptables.firewall.rules /etc/iptables.firewall.rules
# sudo iptables-restore < /etc/iptables.firewall.rules
# sudo cp -i $FILE_DIR/stack/firewall /etc/network/if-pre-up.d/firewall
###################
# Fail2Ban
###################
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
###################
# Sync Dotfiles
###################
# change the default shell for git user
sudo chsh -s /usr/bin/zsh git
# change permissions on the home dir
sudo chmod a+rx /home/git
# move the AWS authorized key to the git account
sudo mkdir -p /home/git/.ssh/
sudo cp -i /home/ubuntu/.ssh/authorized_keys /home/git/.ssh/authorized_keys
sudo chown git:git /home/git/.ssh/authorized_keys
# sync dotfiles
sudo rsync --exclude ".git/"  --exclude ".osx"  --exclude "Brewfile"  --exclude ".cask" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av --no-perms $FILE_DIR/dotfiles/ /home/git
sudo source /home/git/.zshrc
echo "Successfully Installed the following:"
node -v
npm ls -g --depth=0
ruby -v
gem list
nginx -v
htop -v
mosh -v
tig -v
tree --version
emacs --version
git --version
ntpd --version
unzip -v
varnishlog
