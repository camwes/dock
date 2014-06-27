#! /bin/sh
# /etc/init.d/ohm
NAME=ohm
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
    $forever start ohm.js -p
    ;;
  stop)
    echo "Stopping script $NAME"
    cd $SITEROOT
    $forever stop ohm.js -p

    ;;
  reload)
    echo "Compiling $NAME"
    cd $SITEROOT
    $grunt prod
    $forever restart ohm.js -p

    ;;
  install)
    echo "Beginning Installation for script $NAME"
    cd $SITEROOT
    sudo $npm cache clean
    sudo $npm install
    sudo $bower install --allow-root
    # patch Socket.io per https://github.com/audreyt/socket.io/commit/a5b52431ea4be22a1864e10a6d629180685bbb71
    # sudo patch $SITEROOT/node_modules/socket.io/lib/manager.js < /home/ubuntu/environment/stack/socketio.patch
    cd $SITEROOT/ghost
    sudo $npm install --production

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
