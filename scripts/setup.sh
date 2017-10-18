#!/usr/bin/env bash
set -e -o pipefail

# updates the reddit conf from an update file
function update_reddit_conf() {
  pushd src/reddit/r2
  mv development.ini development.old.ini
  python updateini.py development.old.ini $1.update > development.ini
  sudo reddit-restart
  popd
}

# setup a reddit extension
function setup_reddit_ext() {
  DIR=$1
  if [[ -d $DIR ]] ;
  then
    pushd $DIR
    python setup.py build
    sudo python setup.py develop --no-deps
    popd
  else
    echo "$DIR doesn't exist"
  fi
}

setup_reddit_ext src/refresh_token

update_reddit_conf "development"
