#!/bin/bash
#------------------
# Install Nginx
#------------------
# Installation from source:
wget http://nginx.org/download/nginx-1.4.3.tar.gz
# --------------------------
# tar xvzf (.tgz or tar.gz)
# tar xvjf (.tbz or .tar.bz2)
# tar xvf (.tar)
# --------------------------
sudo tar xvf nginx-1.4.3.tar.gz
cd nginx-1.4.3
sudo ./configure --prefix=/opt/nginx
sudo make
sudo make install
sudo ln -s /sbin/nginx /usr/sbin
cd -
# use nginx=development for latest development version
# sudo apt-add-repository ppa:nginx/stable
# sudo apt-get update
# sudo apt-get install -y nginx
#-------------------
# Install Varnish via https://www.varnish-cache.org/installation/ubuntu
#-------------------
curl http://repo.varnish-cache.org/debian/GPG-key.txt | sudo apt-key add -
echo "deb http://repo.varnish-cache.org/ubuntu/ precise varnish-3.0" | sudo tee -a /etc/apt/sources.list 
sudo apt-get update
sudo apt-get install -y --force-yes varnish
