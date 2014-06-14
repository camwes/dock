#!/bin/sh
echo "Checkout Updates"
GIT_WORK_TREE=/home/git/public/production git checkout master -f
echo "start server"
sudo service ohm install
sudo service ohm start