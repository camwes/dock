#! /bin/sh
# /etc/init.d/ohm
NAME=Ohm
SITEROOT=/home/git/public/production
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
    $grunt prod
    $forever start boilerplate.js -p
    ;;
  stop)
    echo "Stopping script $NAME"
    cd $SITEROOT
    $forever stop boilerplate.js -p

    ;;
  reload)
    echo "Compiling $NAME"
    cd $SITEROOT
    $grunt prod
    $forever restart boilerplate.js -p

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
    echo "Usage: /etc/init.d/ohm {start|stop|list|reload|install}"
    exit 1
    ;;
esac

exit 0
