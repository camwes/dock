#!/bin/bash
# FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#------------------
# Install Node Stable
#------------------
sudo apt-get install -y python-software-properties python g++ make
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs
# https://npmjs.org/ cache clean just in case
sudo npm cache clean
# install global modules Grunt, Forever, Bower, Coffee, Node-Inspector
sudo npm install -g bower grunt-cli forever coffee-script node-inspector strong-supervisor
