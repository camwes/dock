#!/bin/bash
FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
git=/usr/bin/git
while getopts w:u:r:n:g:b:d: option
do
        case "${option}"
        in
                w) WORK_TREE=${OPTARG};;
                u) USERNAME=${OPTARG};;
                r) REPOSITORY=${OPTARG};;
                n) SERVICE_NAME=${OPTARG};;
                g) GIT=${OPTARG};;
                b) BRANCH=${OPTARG};;
                d) SCRIPTS_DIR=${OPTARG};;
        esac
done
function setUp() {
  sudo cp -i $FILE_DIR/$SCRIPTS_DIR/hooks/pre-receive.sh $GIT/hooks/pre-receive
  sudo cp -i $FILE_DIR/$SCRIPTS_DIR/hooks/post-receive.sh $GIT/hooks/post-receive
  sudo chmod +x $GIT/hooks/pre-receive
  sudo chmod +x $GIT/hooks/post-receive
  sudo cp -i $FILE_DIR/$SCRIPTS_DIR/service.sh /etc/init.d/$SERVICE_NAME
  sudo chmod 0755 /etc/init.d/$SERVICE_NAME
  sudo mkdir -p $WORK_TREE
}
echo "Working tree will be: $WORK_TREE on branch $BRANCH"
echo "Installing service $SERVICE_NAME, a git deployment for: github.com/"$USERNAME/$REPOSITORY
echo "Sripts and Hooks are in: $FILE_DIR/$SCRIPTS_DIR"
echo "Git Directory: $GIT"
sudo mkdir -p $GIT && cd $GIT
$git --bare init
read -p "Will you be using a deploy key? [Y/N] (visit: https://github.com/$USERNAME/$REPOSITORY/settings/keys)" -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  git --bare fetch git@github.com:$USERNAME/$REPOSITORY.git $BRANCH:$BRANCH
  setUp
elif [[ $REPLY =~ ^[Nn]$ ]]; then
  echo "Proceeding with HTTPS authentication... not advised"
  git --bare fetch https://github.com/$USERNAME/$REPOSITORY.git $BRANCH:$BRANCH
  setUp
fi
unset setUp