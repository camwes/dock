#!/bin/bash
readonly FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
readonly GHOST_DIR=/home/git/ghost

curl -L https://ghost.org/zip/ghost-latest.zip -o ghost.zip
unzip -uo ghost.zip -d $GHOST_DIR
cd $GHOST_DIR
sudo npm install sqlite3 --build-from-source
sudo npm install --production
# Install ghost service
sudo cp $FILE_DIR/ghost.service /etc/init.d/ghost
sudo chmod 0755 /etc/init.d/ghost
sudo chown -R git:git $GHOST_DIR
sudo service ghost start