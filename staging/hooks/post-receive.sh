#!/bin/sh
echo "Checkout Updates"
GIT_WORK_TREE=/home/git/public/staging git checkout staging -f
echo "start server"
sudo service ohmstage install
sudo service ohmstage start