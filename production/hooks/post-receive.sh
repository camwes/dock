#!/bin/sh
echo "Checkout Updates"
GIT_WORK_TREE=/home/git/production git checkout master -f
echo "start server"
sudo service boilerplate install
sudo service boilerplate start