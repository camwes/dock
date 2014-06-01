#!/bin/bash
#------------------
# Install Nginx
#------------------
# Installation from source:
# wget http://nginx.org/download/nginx-1.4.3.tar.gz
# --------------------------
# tar xvzf (.tgz or tar.gz)
# tar xvjf (.tbz or .tar.bz2)
# tar xvf (.tar)
# --------------------------
# sudo tar xvf nginx-1.4.3.tar.gz
# cd nginx-1.4.3
# sudo ./configure
# sudo make
# sudo make install
# sudo ln -s /sbin/nginx /usr/sbin
sudo add-apt-repository ppa:nginx/stable  # use nginx=development for latest development version
sudo apt-get update
sudo apt-get install -y nginx
