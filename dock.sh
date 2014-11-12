#!/bin/bash
readonly ScriptVersion="0.2"
readonly PROGDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
readonly PROGNAME=$(basename "$0")
readonly ARGS=( "$@" )

echo "       __           __  
  ____/ /___  _____/ /__
 / __  / __ \/ ___/ //_/
/ /_/ / /_/ / /__/ ,<   
\__,_/\____/\___/_/|_|  
                        "
[[ $# -eq 0 ]] && {
    # no arguments
    echo "Usage: ./$PROGNAME {deploy|prod|loc|version|micro|s3}"
    exit 1;
}
function deploy(){
    "$PROGDIR"/lib/bin/deploy.sh "$2" "$3" "$4"
}
function prodInstall(){
    "$PROGDIR"/lib/bin/prod.sh
}
function devInstall() {
    "$PROGDIR"/lib/bin/dev.sh
}
function launchMicro() {
    "$PROGDIR"/lib/bin/micro.sh
}
function syncS3() {
    "$PROGDIR"/lib/bin/s3.sh
}
case "$1" in
    -d|--dev|dev       )     devInstall "${ARGS[@]}" ;;
    -g|--deploy|deploy )     deploy "${ARGS[@]}" ;;
    -p|--prod|prod     )     prodInstall ;;
    -m|--micro|micro   )     launchMicro "${ARGS[@]}" ;;
    -s|--s3|s3         )     syncS3 "${ARGS[@]}" ;;
    -v|--version       )
        echo "Dependencies Versions:"
        nginx -v
        unzip -v
        node --version
        ruby --version
        mosh --version
        tig --version
        htop --version
        tree --version
        emacs --version
        git --version
        ntpd --version
        bundle show
        npm ls -g --depth=0
        varnishlog
        exit 1;
        ;;
esac
unset prodInstall
unset devInstall
unset launchMicro
unset deploy
unset syncS3
exit 0
