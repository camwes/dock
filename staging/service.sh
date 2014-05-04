#! /bin/sh
# /etc/init.d/ohmstage
NAME=ohmstage
SITEROOT=/home/git/public/staging
#############
# TODO: set these variables based on successful version outputs and warn if any dependency is missing
#############
GHOST=/home/git/ghost
grunt=/usr/bin/grunt
gem=/usr/bin/gem
forever=/usr/bin/forever
npm=/usr/bin/npm
bower=/usr/bin/bower

export PATH=$PATH:/usr/bin/

case "$1" in
  start)
    echo "Starting $NAME"
    cd $SITEROOT
    pwd
    $grunt
    $forever start ohm.js
    ;;
  stop)
    echo "Stopping script $NAME"
    cd $SITEROOT
    $forever stop ohm.js
    ;;
  reload)
    echo "Compiling $NAME"
    cd $SITEROOT
    $grunt
    $forever restart ohm.js

    ;;
  install)
    echo "Beginning Installation for script $NAME"
    cd $SITEROOT
    sudo $npm cache clean
    sudo $npm install
    # patch $SITEROOT/node_modules/socket.io/lib/ < $SITEROOT/server/stack/socketio.patch
    sudo $bower install --allow-root
    # slc strongops

    ;;
  list)
    echo "List"
    $forever list
    ;;
  *)
    echo "Usage: /etc/init.d/ohmstage {start|stop|list|reload|install}"
    exit 1
    ;;
esac

exit 0
