#!/bin/bash
#------------------
# Install Nginx
#------------------
# Installation from source:
readonly NGINX_DIR=/opt/nginx
sudo apt-get install -y libpcre3-dev
sudo apt-get install -y libpcre3
sudo apt-get install -y zlib1g-dev
sudo apt-get install -y zlib1g

# wget http://nginx.org/download/nginx-1.4.3.tar.gz
# --------------------------
# tar xvzf (.tgz or tar.gz)
# tar xvjf (.tbz or .tar.bz2)
# tar xvf (.tar)
# --------------------------
# sudo tar xvf nginx-1.4.3.tar.gz
# mv nginx-1.4.3 ${NGINX_DIR} && cd ${NGINX_DIR}
# sudo ./configure --prefix="$NGINX_DIR"
# sudo make
# sudo make install
# sudo ln -s "$NGINX_DIR"/sbin/nginx /usr/sbin
# cd -
# use nginx=development for latest development version
# sudo apt-add-repository ppa:nginx/stable
# sudo apt-get update
sudo apt-get install -y nginx
#-------------------
# Install Varnish via https://www.varnish-cache.org/installation/ubuntu
#-------------------
curl http://repo.varnish-cache.org/debian/GPG-key.txt | sudo apt-key add -
echo "deb http://repo.varnish-cache.org/ubuntu/ precise varnish-3.0" | sudo tee -a /etc/apt/sources.list 
sudo apt-get update
sudo apt-get install -y --force-yes varnish
