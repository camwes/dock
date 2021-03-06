#!/bin/bash
# Dock Production Deploy
# ./dock -p
# real    13m45.709s
# user    5m26.168s
# sys     1m57.199s
readonly ScriptVersion="0.2"
readonly PROGDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
readonly HOMEDIR="$HOME"
readonly PROGNAME=$(basename "$0")
readonly LOG_FILE=$PROGDIR/../../logs/prod.error.log
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
function upgradeApt() {
    # update and upgrade
    sudo apt-get update 1>&3;
    sudo apt-get upgrade -y --show-upgraded 1>&3;
}
function gitAcct() {
    #-------------------
    # Git User
    #-------------------
    sudo adduser --disabled-password --gecos "" git | tee /dev/fd/3;
    sudo usermod -a -G sudo git 1>&3;
    # copy the AWS authorized key to the git account
    sudo mkdir -p "$GITDIR"/.ssh/
    sudo cp ~/.ssh/authorized_keys "$GITDIR"/.ssh/authorized_keys | tee /dev/fd/3;
    sudo chmod a+rx "$GITDIR"/.ssh/authorized_keys
    sudo chown git:git "$GITDIR"/.ssh/authorized_keys
    # Configure Permissions
    sudo chmod a+rx "$GITDIR"
    sudo chown -R git:git "$GITDIR"
    # add to sudoers
    sudo chmod 0440 "$PATCHES"/gitsudoer
    sudo cp "$PATCHES"/gitsudoer /etc/sudoers.d/
    # Configure Time Zone
    sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
}
function installStack() {
    # Install Apps via apt-get
    sudo apt-get install -y git 1>&3;
    sudo apt-get install -y fail2ban
    sudo apt-get install -y wget
    sudo apt-get install -y curl
    sudo apt-get install -y zsh
    sudo apt-get install -y tmux
    sudo apt-get install -y emacs23
    sudo apt-get install -y tig
    sudo apt-get install -y tree
    sudo apt-get install -y htop
    sudo apt-get install -y unzip
    sudo apt-get install -y rubygems-integration    
    # Install Bundler if necessary
    if command_exists bundle; then
        echo -e "\nprod: Bundler Installed... continuing" 1>&3;
    else
        sudo gem install bundler | tee /dev/fd/3;
    fi
    # Install Rubygems via bundler
    bundle install | tee /dev/fd/3;
    #-------------------
    # Install Nginx
    #-------------------
    if command_exists nginx; then
        echo -e "\nprod: Nginx Installed... continuing" 1>&3;
    else
        echo -e "\nprod: Installing Nginx..." 1>&3;
        sudo "$INSTALL_DIR"/nginx.sh 1>&3;
    fi
    #------------------
    # Install Node Stable
    #------------------
    if command_exists node; then
        echo -e "\nprod: Node Installed... continuing" 1>&3;
    else
        echo -e "\nprod: Installing Node..." 1>&3;
        sudo "$INSTALL_DIR"/node.sh 1>&3;
    fi
    #-------------------
    # Install Mosh
    #-------------------
    if command_exists mosh; then
        echo -e "\nprod: Mosh Installed... continuing" 1>&3;
    else
        echo -e "\nprod: Installing Mosh..." 1>&3;
        sudo apt-get install -y python-software-properties
        sudo add-apt-repository -y ppa:keithw/mosh
        sudo apt-get update 1>&3;
        sudo apt-get install -y mosh | tee /dev/fd/3;
    fi
}
function provisionStack() {
    # Backup existing configs
    sudo mv "$NGINX_DIR"/nginx.conf "$NGINX_DIR"/nginx.conf.backup 1>&3;
    sudo mkdir -p ${NGINX_DIR}/logs 1>&3;
    sudo cp /etc/varnish/default.vcl /etc/varnish/default.vcl.old 1>&3;
    sudo cp /etc/default/varnish /etc/default/varnish.old 1>&3;
    # Set clock/restart cron
    sudo apt-get install -y ntp
    ntpdate && hwclock –w 1>&3;
    sudo service cron stop 1>&3;
    sudo service cron start 1>&3;
    # change the default shell to zsh
    sudo chsh -s /usr/bin/zsh git 1>&3;
    #-------------------
    # Dotfiles
    #-------------------
    sudo rsync  --exclude ".osx" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av --no-perms "$DOTFILES"/ "$GITDIR" | tee /dev/fd/3;
    #-------------------
    # Configure Nginx
    #-------------------
    sudo cp "$CONFIG_DIR"/nginx.conf "$NGINX_DIR"/nginx.conf 1>&3;
    sudo nginx -t | tee /dev/fd/3;
    #-------------------
    # Configure Varnish
    #-------------------
    sudo patch /etc/default/varnish < "$PATCHES"/varnish.diff 1>&3;
    sudo patch /etc/varnish/default.vcl < "$PATCHES"/default.vcl.diff 1>&3;
    #-------------------
    # TODO: Firewall
    #-------------------
    # sudo cp -i $PROGDIR/lib/iptables.firewall.rules /etc/iptables.firewall.rules
    # sudo iptables-restore < /etc/iptables.firewall.rules
    # sudo cp -i $PROGDIR/lib/firewall /etc/network/if-pre-up.d/firewall
    # Fail2Ban
    sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local 1>&3;
    # Stop Varnish and Nginx
    sudo chown -R git:git "$GITDIR"
    sudo nginx -s stop 
    sudo service varnish stop
}
# Run Functions
upgradeApt
gitAcct
installStack
provisionStack
# Start Stack
sudo nginx
sudo service varnish start

unset command_exists
unset upgradeApt
unset gitAcct
unset installStack
unset provisionStack
exit 0
